package com.fuao.harness.platform.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fuao.harness.platform.config.HarnessProperties;
import com.fuao.harness.platform.security.ClientAuthenticator;
import com.fuao.harness.platform.security.HmacSigner;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.time.Duration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * The portal this platform hires its digital employees into.
 *
 * <p>The portal has its own employee table, and a digital employee that is not in it does not
 * exist for the people who work there - no org tree, no directory, no task pickers. So somebody
 * has to write the row, and the platform is the only party that knows what the digital employee
 * is called, which department it belongs to and which agent key it carries.
 *
 * <p>The portal authenticates machine callers with an HMAC signature (03 §9) - the same
 * contract the platform itself speaks, so this client signs the same way the console's
 * JavaScript does: the path without the query string, the body hashed, and the key derived
 * from the shared secret.
 *
 * <p>Nothing here is optional: with no portal configured, onboarding is refused with a
 * message that says what is missing, rather than asking the operator for an employee id
 * that exists nowhere.
 */
@Service
public class PortalClient {

    private static final Logger log = LoggerFactory.getLogger(PortalClient.class);
    private static final SecureRandom RANDOM = new SecureRandom();

    private static final ObjectMapper JSON = new ObjectMapper();

    private final HarnessProperties properties;
    private final HttpClient http;

    public PortalClient(HarnessProperties properties) {
        this.properties = properties;
        this.http = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
    }

    /** Whether a portal is configured at all. */
    public boolean configured() {
        HarnessProperties.Portal portal = properties.portal();
        return portal != null && portal.baseUrl() != null && !portal.baseUrl().isBlank()
                && portal.secret() != null && !portal.secret().isBlank();
    }

    /** What is missing, in words an operator can act on. */
    public String missingConfiguration() {
        HarnessProperties.Portal portal = properties.portal();
        if (portal == null || portal.baseUrl() == null || portal.baseUrl().isBlank()) {
            return "平台没有配置 portal 地址（harness.portal.base-url / HARNESS_PORTAL_BASE_URL）";
        }
        if (portal.secret() == null || portal.secret().isBlank()) {
            return "平台没有配置 portal 的共享密钥（harness.portal.secret / HARNESS_PORTAL_SECRET）";
        }
        return "";
    }

    /**
     * Creates the digital employee in the portal.
     *
     * @param command the fields that are written into the portal's employee and user rows
     * @return the portal's answer: the employee id, the user id, and whether it was created
     * @throws PortalRefusedException when the portal says no, or cannot be reached
     */
    public Map<String, Object> onboard(OnboardCommand command) {
        if (!configured()) {
            throw new PortalRefusedException("NOT_CONFIGURED", missingConfiguration());
        }
        HarnessProperties.Portal portal = properties.portal();
        String path = "/api/harness/agent/onboard.do";
        String body = json(command);

        long timestamp = System.currentTimeMillis() / 1000L;
        String nonce = nonce();
        String key = HmacSigner.deriveKey(portal.secret());
        String signature = HmacSigner.sign(key, "POST", path, String.valueOf(timestamp), nonce,
                body.getBytes(StandardCharsets.UTF_8));

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(trimTrailingSlash(portal.baseUrl()) + path))
                .timeout(Duration.ofSeconds(30))
                .header("Content-Type", "application/json;charset=UTF-8")
                .header(ClientAuthenticator.HEADER_CLIENT, portal.clientId())
                .header(ClientAuthenticator.HEADER_TIMESTAMP, String.valueOf(timestamp))
                .header(ClientAuthenticator.HEADER_NONCE, nonce)
                .header(ClientAuthenticator.HEADER_SIGNATURE, signature)
                .POST(HttpRequest.BodyPublishers.ofString(body, StandardCharsets.UTF_8))
                .build();
        try {
            HttpResponse<String> response = http.send(request, HttpResponse.BodyHandlers.ofString());
            String text = response.body() == null ? "" : response.body();
            if (response.statusCode() >= 400) {
                throw new PortalRefusedException("PORTAL_REFUSED",
                        "portal 拒绝了入职请求（HTTP " + response.statusCode() + "）：" + text);
            }
            return parse(text);
        } catch (PortalRefusedException e) {
            throw e;
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new PortalRefusedException("PORTAL_UNREACHABLE", "调用 portal 时被中断");
        } catch (Exception e) {
            throw new PortalRefusedException("PORTAL_UNREACHABLE",
                    "连不上 portal：" + e.getMessage());
        }
    }

    /**
     * Asks the portal what hiring this digital employee would write.
     *
     * <p>The employee number is the portal's to decide - it owns the department codes and the
     * sequence - so the platform asks rather than guesses. A preview that differs from the
     * write is worse than no preview.
     */
    public Map<String, Object> preview(OnboardCommand command) {
        if (!configured()) {
            throw new PortalRefusedException("NOT_CONFIGURED", missingConfiguration());
        }
        HarnessProperties.Portal portal = properties.portal();
        String path = "/api/harness/agent/onboard-preview.do";
        String body = json(command);

        long timestamp = System.currentTimeMillis() / 1000L;
        String nonce = nonce();
        String key = HmacSigner.deriveKey(portal.secret());
        String signature = HmacSigner.sign(key, "POST", path, String.valueOf(timestamp), nonce,
                body.getBytes(StandardCharsets.UTF_8));

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(trimTrailingSlash(portal.baseUrl()) + path))
                .timeout(Duration.ofSeconds(20))
                .header("Content-Type", "application/json;charset=UTF-8")
                .header(ClientAuthenticator.HEADER_CLIENT, portal.clientId())
                .header(ClientAuthenticator.HEADER_TIMESTAMP, String.valueOf(timestamp))
                .header(ClientAuthenticator.HEADER_NONCE, nonce)
                .header(ClientAuthenticator.HEADER_SIGNATURE, signature)
                .POST(HttpRequest.BodyPublishers.ofString(body, StandardCharsets.UTF_8))
                .build();
        try {
            HttpResponse<String> response = http.send(request, HttpResponse.BodyHandlers.ofString());
            String text = response.body() == null ? "" : response.body();
            if (response.statusCode() >= 400) {
                throw new PortalRefusedException("PORTAL_REFUSED",
                        "portal 拒绝了预览请求（HTTP " + response.statusCode() + "）：" + text);
            }
            return parse(text);
        } catch (PortalRefusedException e) {
            throw e;
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new PortalRefusedException("PORTAL_UNREACHABLE", "调用 portal 时被中断");
        } catch (Exception e) {
            throw new PortalRefusedException("PORTAL_UNREACHABLE", "连不上 portal：" + e.getMessage());
        }
    }

    /** What the platform is going to write into the portal. */
    public record OnboardCommand(String agentKey, String name, int deptId, Integer workpositionId,
                                 Integer groupId, Integer roleId, String loginName) {
    }

    /** The portal refused, or could not be reached. */
    public static class PortalRefusedException extends RuntimeException {
        private final String code;

        public PortalRefusedException(String code, String message) {
            super(message);
            this.code = code;
        }

        public String code() {
            return code;
        }
    }

    private static String trimTrailingSlash(String value) {
        String result = value;
        while (result.endsWith("/")) {
            result = result.substring(0, result.length() - 1);
        }
        return result;
    }

    private static String nonce() {
        byte[] bytes = new byte[16];
        RANDOM.nextBytes(bytes);
        StringBuilder text = new StringBuilder();
        for (byte b : bytes) {
            text.append(String.format("%02x", b));
        }
        return text.toString();
    }

    /** The command as JSON - the portal reads form parameters, but it accepts JSON too. */
    private static String json(OnboardCommand command) {
        Map<String, Object> values = new LinkedHashMap<>();
        values.put("agentKey", command.agentKey());
        values.put("name", command.name());
        values.put("deptId", command.deptId());
        values.put("workpositionId", command.workpositionId() == null ? 0 : command.workpositionId());
        values.put("groupId", command.groupId() == null ? 0 : command.groupId());
        values.put("roleId", command.roleId() == null ? 0 : command.roleId());
        values.put("loginName", command.loginName() == null || command.loginName().isBlank()
                ? command.agentKey() : command.loginName());
        try {
            return JSON.writeValueAsString(values);
        } catch (Exception e) {
            throw new PortalRefusedException("BAD_COMMAND", "拼装入职参数失败：" + e.getMessage());
        }
    }

    /** The portal's answer. It answers with a JSON object, sometimes wrapped in a field. */
    private static Map<String, Object> parse(String text) {
        try {
            Map<String, Object> map = JSON.readValue(text, new TypeReference<Map<String, Object>>() {
            });
            Object payload = map.get("payload");
            if (payload instanceof Map) {
                @SuppressWarnings("unchecked")
                Map<String, Object> inner = (Map<String, Object>) payload;
                return inner;
            }
            return map;
        } catch (Exception e) {
            log.warn("the portal's answer is not JSON: {}", text);
        }
        return Map.of();
    }

    /** The employee id the portal reported, if it reported one. */
    public static Optional<Integer> employeeId(Map<String, Object> answer) {
        Object value = answer.get("employeeId");
        if (value instanceof Number number) {
            return Optional.of(number.intValue());
        }
        if (value instanceof String text) {
            try {
                return Optional.of(Integer.parseInt(text.trim()));
            } catch (NumberFormatException e) {
                return Optional.empty();
            }
        }
        return Optional.empty();
    }

    /** The user id the portal reported, if it reported one. */
    public static Optional<Integer> userId(Map<String, Object> answer) {
        Object value = answer.get("userId");
        if (value instanceof Number number) {
            return Optional.of(number.intValue());
        }
        if (value instanceof String text) {
            try {
                return Optional.of(Integer.parseInt(text.trim()));
            } catch (NumberFormatException e) {
                return Optional.empty();
            }
        }
        return Optional.empty();
    }
}
