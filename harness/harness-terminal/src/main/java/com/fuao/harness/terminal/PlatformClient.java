package com.fuao.harness.terminal;

import com.fuao.harness.protocol.json.Json;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.time.Duration;
import java.time.Instant;
import java.util.Map;
import java.util.UUID;

/**
 * The terminal's client for the harness platform (03 §9).
 *
 * <p>Everything the terminal says is signed with the device's HMAC secret, in exactly the form
 * the platform expects: {@code METHOD\nPATH\nTIMESTAMP\nNONCE\nhex(sha256(body))}. The terminal
 * never holds a portal password and never talks to a portal database - it has no way to (01 §2.3).
 *
 * <p>The signing scheme has to be byte-identical to the platform's
 * {@code com.fuao.harness.platform.security.HmacSigner}; the cross-system check in
 * {@code harness/tools/verify-portal-interop.sh} is what keeps the two honest.
 */
public final class PlatformClient {

    public static final String HEADER_CLIENT = "X-Harness-Client";
    public static final String HEADER_TIMESTAMP = "X-Harness-Timestamp";
    public static final String HEADER_NONCE = "X-Harness-Nonce";
    public static final String HEADER_SIGNATURE = "X-Harness-Signature";

    private final URI baseUri;
    private final String clientId;
    private final byte[] hmacKey;
    private final HttpClient http;
    private final Duration timeout;

    public PlatformClient(URI baseUri, String clientId, byte[] hmacKey, Duration timeout) {
        this.baseUri = baseUri;
        this.clientId = clientId;
        this.hmacKey = hmacKey.clone();
        this.timeout = timeout == null ? Duration.ofSeconds(30) : timeout;
        this.http = HttpClient.newBuilder()
                .connectTimeout(this.timeout)
                .followRedirects(HttpClient.Redirect.NEVER)
                .build();
    }

    /** The key derivation the platform uses: the HMAC key is the hex of sha256(secret). */
    public static byte[] deriveKey(String secret) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            return com.fuao.harness.protocol.Digests.hex(digest.digest(secret.getBytes(StandardCharsets.UTF_8)))
                    .getBytes(StandardCharsets.US_ASCII);
        } catch (Exception e) {
            throw new IllegalStateException("SHA-256 unavailable", e);
        }
    }

    public static String sign(byte[] key, String method, String path, String timestamp, String nonce,
                              byte[] body) {
        String canonical = method + "\n" + path + "\n" + timestamp + "\n" + nonce + "\n"
                + com.fuao.harness.protocol.Digests.sha256Hex(body == null ? new byte[0] : body);
        return com.fuao.harness.protocol.Digests.hex(
                com.fuao.harness.protocol.Digests.hmacSha256(key,
                        canonical.getBytes(StandardCharsets.UTF_8)));
    }

    public record HelloResponse(String terminalId, String status, String bindingCode, int bindingCodeTtlSeconds) {
    }

    public record BindResponse(String terminalId, String agentId, String bindType, String status) {
    }

    public record HeartbeatResponse(String terminalId, String status, String lastHeartbeat) {
    }

    /** Registers the device and asks for a binding code (03 §3.5). */
    public HelloResponse hello(Map<String, Object> device) throws IOException, InterruptedException {
        Map<String, Object> body = Map.of(
                "deviceId", String.valueOf(device.get("deviceId")),
                "os", String.valueOf(device.getOrDefault("os", "unknown")),
                "osVersion", String.valueOf(device.getOrDefault("osVersion", "")),
                "hostname", String.valueOf(device.getOrDefault("hostname", "")),
                "agentVersion", String.valueOf(device.getOrDefault("agentVersion", "0.1.0")),
                "capabilities", device.getOrDefault("capabilities", Map.of()));
        Map<String, Object> parsed = post("/api/harness/terminal/hello", body);
        return new HelloResponse(
                string(parsed, "terminalId"),
                string(parsed, "status"),
                string(parsed, "bindingCode"),
                parsed.get("bindingCodeTtlSeconds") instanceof Number n ? n.intValue() : 0);
    }

    /** Redeems the binding code (03 §3.5). */
    public BindResponse bind(String bindingCode, String agentKey, Integer portalEmployeeId)
            throws IOException, InterruptedException {
        Map<String, Object> body = new java.util.LinkedHashMap<>();
        body.put("bindingCode", bindingCode);
        if (agentKey != null && !agentKey.isBlank()) {
            body.put("agentKey", agentKey);
        }
        if (portalEmployeeId != null) {
            body.put("portalEmployeeId", portalEmployeeId);
        }
        Map<String, Object> parsed = post("/api/harness/terminal/bind", body);
        return new BindResponse(
                string(parsed, "terminalId"),
                string(parsed, "agentId"),
                string(parsed, "bindType"),
                string(parsed, "status"));
    }

    /**
     * One heartbeat.
     *
     * @return the platform's answer, or a response whose status is {@code revoked} when the
     *         platform refused the device - the terminal then wipes its authority
     */
    public HeartbeatResponse heartbeat(String terminalId) throws IOException, InterruptedException {
        Map<String, Object> parsed = post("/api/harness/terminal/" + terminalId + "/heartbeat", Map.of());
        return new HeartbeatResponse(
                string(parsed, "terminalId"),
                string(parsed, "status"),
                string(parsed, "lastHeartbeat"));
    }

    /** Asks the platform to revoke this terminal (a human does this in the console; the
     *  terminal may request it for itself when it detects a compromise). */
    public void revoke(String terminalId, String reason) throws IOException, InterruptedException {
        post("/api/harness/terminal/" + terminalId + "/revoke", Map.of("reason", reason == null ? "" : reason));
    }

    /**
     * Asks the platform what this terminal may do.
     *
     * <p>The platform holds the grants, so the platform is the only place that can answer.
     * The shell fetches the answer and hands it to the agent that runs on the same machine -
     * there is no second copy of the authority to drift.
     */
    public Map<String, Object> grant(String terminalId) throws IOException, InterruptedException {
        String path = "/api/harness/terminal/" + terminalId + "/grant";
        String timestamp = String.valueOf(Instant.now().getEpochSecond());
        String nonce = UUID.randomUUID().toString();
        HttpRequest request = HttpRequest.newBuilder(baseUri.resolve(path))
                .header(HEADER_CLIENT, clientId)
                .header(HEADER_TIMESTAMP, timestamp)
                .header(HEADER_NONCE, nonce)
                .header(HEADER_SIGNATURE, sign(hmacKey, "GET", path, timestamp, nonce, null))
                .timeout(timeout)
                .GET()
                .build();
        HttpResponse<String> response = http.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() == 403 || response.statusCode() == 410) {
            throw new IOException("the platform refused the grant for terminal " + terminalId
                    + " (HTTP " + response.statusCode() + "): the device is revoked or disabled");
        }
        if (response.statusCode() / 100 != 2) {
            throw new IOException("the platform refused the grant for terminal " + terminalId
                    + ": HTTP " + response.statusCode() + " " + response.body());
        }
        Object parsed = Json.parse(response.body());
        if (parsed instanceof Map<?, ?> m) {
            @SuppressWarnings("unchecked")
            Map<String, Object> typed = (Map<String, Object>) m;
            return typed;
        }
        return Map.of();
    }

    private Map<String, Object> post(String path, Map<String, Object> payload)
            throws IOException, InterruptedException {
        byte[] body = Json.canonicalBytes(payload);
        String timestamp = String.valueOf(Instant.now().getEpochSecond());
        String nonce = UUID.randomUUID().toString();
        HttpRequest request = HttpRequest.newBuilder(baseUri.resolve(path))
                .header("Content-Type", "application/json")
                .header(HEADER_CLIENT, clientId)
                .header(HEADER_TIMESTAMP, timestamp)
                .header(HEADER_NONCE, nonce)
                .header(HEADER_SIGNATURE, sign(hmacKey, "POST", path, timestamp, nonce, body))
                .timeout(timeout)
                .POST(HttpRequest.BodyPublishers.ofByteArray(body))
                .build();
        HttpResponse<String> response = http.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() == 410 || response.statusCode() == 403) {
            // Revoked or disabled: the caller must stop acting.
            return Map.of("status", "revoked");
        }
        if (response.statusCode() / 100 != 2) {
            throw new IOException("platform refused " + path + ": HTTP " + response.statusCode()
                    + " " + response.body());
        }
        Object parsed = Json.parse(response.body());
        if (parsed instanceof Map<?, ?> m) {
            @SuppressWarnings("unchecked")
            Map<String, Object> typed = (Map<String, Object>) m;
            return typed;
        }
        return Map.of();
    }

    private static String string(Map<String, Object> map, String key) {
        Object value = map.get(key);
        return value == null ? "" : String.valueOf(value);
    }
}
