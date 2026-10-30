package com.fuao.harness.platform;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fuao.harness.platform.service.BrainService;
import com.fuao.harness.platform.service.ModelClient;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

/**
 * The platform's brain: the conversation an operator has with the platform about the platform.
 *
 * <p>Without a model configured it must say so plainly - a brain that answers from nothing
 * would be worse than no brain at all.
 */
class BrainIT extends PlatformTestBase {

    @BeforeEach
    void setup() {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);
        seedAgent("agent:brain-subject", AGENT_OWNER_EMPLOYEE_ID, 91, 2);
    }

    private MockHttpServletRequestBuilder humanPost(String path, String body) throws Exception {
        MockHttpServletRequestBuilder request = post(path)
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", path, request, body);
        return request;
    }

    @Test
    void aBrainWithoutAModelSaysSo() throws Exception {
        String body = "{\"message\":\"有几台终端在线？\"}";
        MockHttpServletRequestBuilder request = humanPost("/api/harness/brain/chat", body);
        mvc.perform(request)
                .andExpect(status().isServiceUnavailable())
                .andExpect(jsonPath("$.error.code").value("BRAIN_NOT_CONFIGURED"))
                .andExpect(jsonPath("$.error.message").isNotEmpty());
    }

    @Test
    void aMachineAccountCannotTalkToTheBrain() throws Exception {
        String body = "{\"message\":\"有几台终端在线？\"}";
        MockHttpServletRequestBuilder request = post("/api/harness/brain/chat")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/brain/chat", request, body);
        mvc.perform(request)
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"));
    }

    @Test
    void theSessionListIsEmptyAtTheStartAndForgetsOnRequest() throws Exception {
        MockHttpServletRequestBuilder list = get("/api/harness/brain/sessions");
        signAsHuman("GET", "/api/harness/brain/sessions", list, "");
        mvc.perform(list)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());

        MockHttpServletRequestBuilder forget = delete("/api/harness/brain/sessions/does-not-exist");
        signAsHuman("DELETE", "/api/harness/brain/sessions/does-not-exist", forget, "");
        mvc.perform(forget)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.forgotten").value(false));
    }

    @Test
    void theModelAnswerIsParsedIntoTextAndToolCalls() {
        // The turn the model returns: an answer, and a tool it wants to run.
        String json = """
                {"choices":[{"message":{"content":"我查一下",
                  "tool_calls":[{"id":"call_1","type":"function",
                    "function":{"name":"list_terminals","arguments":"{\\"limit\\":10}"}}]}}]}
                """;
        ModelClient.Turn turn = ModelClient.parseTurn(json);
        assertEquals("我查一下", turn.text());
        assertTrue(turn.wantsTools());
        assertEquals("list_terminals", turn.calls().get(0).name());
        assertEquals(10, turn.calls().get(0).arguments().get("limit"));
    }

    @Test
    void aThinkingModelStillHasAnAnswer() {
        // Some gateways put the thinking in their own field. Hiding it makes a slow answer
        // look like a broken one.
        String json = "{\"choices\":[{\"message\":{\"reasoning_content\":\"让我想想\",\"content\":\"\"}}]}";
        ModelClient.Turn turn = ModelClient.parseTurn(json);
        assertEquals("让我想想", turn.text());
        assertTrue(!turn.wantsTools());
    }

    @Test
    void everyToolTheBrainHasIsReadOnly() {
        // The brain observes and advises. A tool that changes something would put the
        // authority of a natural human behind a model's whim - so every tool is a read.
        for (Map<String, Object> tool : BrainService.toolCatalogue()) {
            String name = String.valueOf(tool.get("name"));
            assertTrue(name.startsWith("list_") || name.startsWith("get_"),
                    "the brain must not have a tool that changes anything: " + name);
        }
    }
}
