package com.fuao.harness.platform.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fuao.harness.platform.config.HarnessProperties;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * The platform's own model client.
 *
 * <p>The terminal agent talks to the model from the machine; the platform needs its own client
 * for the brain - the conversation an operator has with the platform about the platform. It
 * speaks the same OpenAI-compatible contract (03 §7), so the same gateway serves both:
 * a base url ("http://host:30000/v1") and the path is added here.
 *
 * <p>Tools are passed the way the OpenAI API expects them, and the answer comes back either
 * as text or as tool calls. A reasoning model puts its thinking in {@code reasoning_content};
 * it is not the answer, but hiding it makes a slow answer look like a broken one.
 */
@Service
public class ModelClient {

    private static final Logger log = LoggerFactory.getLogger(ModelClient.class);
    private static final ObjectMapper JSON = new ObjectMapper();

    private final HttpClient http;

    public ModelClient() {
        this.http = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
    }

    /** The chat completions url of an OpenAI-compatible gateway. */
    public static String chatCompletionsUrl(String base) {
        String trimmed = base == null ? "" : base.trim();
        while (trimmed.endsWith("/")) {
            trimmed = trimmed.substring(0, trimmed.length() - 1);
        }
        if (trimmed.isEmpty()) {
            return "https://api.openai.com/v1/chat/completions";
        }
        if (trimmed.endsWith("/chat/completions")) {
            return trimmed;
        }
        return trimmed + "/chat/completions";
    }

    /**
     * One turn of a conversation.
     *
     * @param text   what the model said (empty when it only asked for tools)
     * @param calls  the tools it wants to run
     */
    public record Turn(String text, List<ToolCall> calls) {

        public boolean wantsTools() {
            return calls != null && !calls.isEmpty();
        }
    }

    /** One tool the model wants to run. */
    public record ToolCall(String id, String name, Map<String, Object> arguments) {
    }

    /**
     * Asks the model for the next turn.
     *
     * @param model      provider, model name, base url and key
     * @param messages   the conversation so far, each a map with role and content
     * @param tools      the tool catalogue in the platform's own shape (name, description,
     *                   input_schema); it is translated into the OpenAI shape here
     */
    public Turn nextTurn(ModelConfigService.TerminalModelConfig model, List<Map<String, Object>> messages,
                         List<Map<String, Object>> tools) {
        String url = chatCompletionsUrl(model.baseUrl());
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("model", model.modelName());
        List<Map<String, Object>> turns = new ArrayList<>();
        for (Map<String, Object> message : messages) {
            Map<String, Object> turn = new LinkedHashMap<>();
            turn.put("role", message.get("role"));
            turn.put("content", message.get("content") == null ? "" : message.get("content"));
            turns.add(turn);
        }
        body.put("messages", turns);
        body.put("max_tokens", 4096);
        body.put("temperature", 0.2);

        if (tools != null && !tools.isEmpty()) {
            List<Map<String, Object>> payload = new ArrayList<>();
            for (Map<String, Object> tool : tools) {
                Map<String, Object> function = new LinkedHashMap<>();
                function.put("name", tool.get("name"));
                function.put("description", tool.get("description"));
                function.put("parameters", tool.getOrDefault("input_schema", Map.of()));
                Map<String, Object> entry = new LinkedHashMap<>();
                entry.put("type", "function");
                entry.put("function", function);
                payload.add(entry);
            }
            body.put("tools", payload);
        }

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .timeout(Duration.ofMinutes(10))
                .header("Content-Type", "application/json;charset=UTF-8")
                .header("Authorization", "Bearer " + model.apiKey())
                .POST(HttpRequest.BodyPublishers.ofString(write(body), StandardCharsets.UTF_8))
                .build();
        try {
            HttpResponse<String> response = http.send(request, HttpResponse.BodyHandlers.ofString());
            String text = response.body() == null ? "" : response.body();
            if (response.statusCode() >= 400) {
                throw new ModelUnavailable("the model answered HTTP " + response.statusCode() + ": "
                        + text.substring(0, Math.min(text.length(), 400)));
            }
            return parseTurn(text);
        } catch (ModelUnavailable e) {
            throw e;
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new ModelUnavailable("the model request was interrupted");
        } catch (Exception e) {
            throw new ModelUnavailable("the model is not reachable: " + e.getMessage());
        }
    }

    /** The model's answer: text, tool calls, or both. */
    public static Turn parseTurn(String body) {
        try {
            Map<String, Object> parsed = JSON.readValue(body, new TypeReference<Map<String, Object>>() {
            });
            List<?> choices = parsed.get("choices") instanceof List<?> list ? list : List.of();
            if (choices.isEmpty()) {
                return new Turn("", List.of());
            }
            Object first = choices.get(0);
            if (!(first instanceof Map<?, ?> choice)) {
                return new Turn("", List.of());
            }
            Object message = choice.get("message");
            if (!(message instanceof Map<?, ?> map)) {
                return new Turn("", List.of());
            }
            String text = map.get("content") instanceof String content ? content : "";
            Object reasoning = map.get("reasoning_content");
            if ((text == null || text.isEmpty()) && reasoning instanceof String thought && !thought.isEmpty()) {
                text = thought;
            }
            List<ToolCall> calls = new ArrayList<>();
            if (map.get("tool_calls") instanceof List<?> list) {
                for (Object entry : list) {
                    if (!(entry instanceof Map<?, ?> call)) {
                        continue;
                    }
                    String id = call.get("id") instanceof String value ? value : "";
                    Object function = call.get("function");
                    if (!(function instanceof Map<?, ?> fn)) {
                        continue;
                    }
                    String name = fn.get("name") instanceof String value ? value : "";
                    Map<String, Object> arguments = new LinkedHashMap<>();
                    if (fn.get("arguments") instanceof String raw && !raw.isBlank()) {
                        arguments.putAll(JSON.readValue(raw, new TypeReference<Map<String, Object>>() {
                        }));
                    }
                    calls.add(new ToolCall(id, name, arguments));
                }
            }
            return new Turn(text == null ? "" : text, calls);
        } catch (Exception e) {
            throw new ModelUnavailable("the model's answer is not readable: " + e.getMessage());
        }
    }

    private static String write(Object value) {
        try {
            return JSON.writeValueAsString(value);
        } catch (Exception e) {
            throw new ModelUnavailable("the request cannot be written: " + e.getMessage());
        }
    }

    /** The model is not reachable, or answered something unusable. */
    public static class ModelUnavailable extends RuntimeException {
        public ModelUnavailable(String message) {
            super(message);
        }
    }
}
