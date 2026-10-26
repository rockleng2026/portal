package com.fuao.harness.platform;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fuao.harness.platform.security.HmacSigner;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Map;
import java.util.UUID;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

/**
 * The HMAC front door (03 §9). These tests are the negative space of the identity baseline: what
 * has to be refused before any business logic runs at all.
 */
class AuthIT extends PlatformTestBase {

    @BeforeEach
    void principals() {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);
    }

    @Test
    void rejectsAnUnsignedRequest() throws Exception {
        mvc.perform(get("/api/harness/template"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void rejectsASignatureFromTheWrongSecret() throws Exception {
        String timestamp = String.valueOf(Instant.now().getEpochSecond());
        String nonce = UUID.randomUUID().toString();

        mvc.perform(get("/api/harness/template")
                        .header("X-Harness-Client", SERVICE_CLIENT)
                        .header("X-Harness-Timestamp", timestamp)
                        .header("X-Harness-Nonce", nonce)
                        .header("X-Harness-Signature", HmacSigner.sign(HmacSigner.deriveKey("wrong-secret"), "GET",
                                "/api/harness/template", timestamp, nonce, new byte[0])))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error.code").value("BAD_SIGNATURE"));
    }

    @Test
    void rejectsAnUnknownClient() throws Exception {
        String timestamp = String.valueOf(Instant.now().getEpochSecond());
        String nonce = UUID.randomUUID().toString();

        mvc.perform(get("/api/harness/template")
                        .header("X-Harness-Client", "nobody")
                        .header("X-Harness-Timestamp", timestamp)
                        .header("X-Harness-Nonce", nonce)
                        .header("X-Harness-Signature", HmacSigner.sign(HmacSigner.deriveKey(SERVICE_SECRET), "GET",
                                "/api/harness/template", timestamp, nonce, new byte[0])))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error.code").value("UNKNOWN_CLIENT"));
    }

    @Test
    void rejectsAStaleTimestamp() throws Exception {
        String stale = String.valueOf(Instant.now().getEpochSecond() - 4000);
        String nonce = UUID.randomUUID().toString();

        mvc.perform(get("/api/harness/template")
                        .header("X-Harness-Client", SERVICE_CLIENT)
                        .header("X-Harness-Timestamp", stale)
                        .header("X-Harness-Nonce", nonce)
                        .header("X-Harness-Signature", HmacSigner.sign(HmacSigner.deriveKey(SERVICE_SECRET), "GET",
                                "/api/harness/template", stale, nonce, new byte[0])))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error.code").value("CLOCK_SKEW"));
    }

    @Test
    void rejectsAReplayedNonce() throws Exception {
        String timestamp = String.valueOf(Instant.now().getEpochSecond());
        String nonce = UUID.randomUUID().toString();
        String signature = HmacSigner.sign(HmacSigner.deriveKey(SERVICE_SECRET), "GET", "/api/harness/template", timestamp, nonce,
                new byte[0]);

        mvc.perform(get("/api/harness/template")
                        .header("X-Harness-Client", SERVICE_CLIENT)
                        .header("X-Harness-Timestamp", timestamp)
                        .header("X-Harness-Nonce", nonce)
                        .header("X-Harness-Signature", signature))
                .andExpect(status().isOk());

        mvc.perform(get("/api/harness/template")
                        .header("X-Harness-Client", SERVICE_CLIENT)
                        .header("X-Harness-Timestamp", timestamp)
                        .header("X-Harness-Nonce", nonce)
                        .header("X-Harness-Signature", signature))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error.code").value("NONCE_REPLAY"));
    }

    @Test
    void rejectsATamperedBody() throws Exception {
        String body = body(Map.of("source", "im", "eventType", "group.at", "businessKey", "msg:1"));
        String timestamp = String.valueOf(Instant.now().getEpochSecond());
        String nonce = UUID.randomUUID().toString();
        String signature = HmacSigner.sign(HmacSigner.deriveKey(SERVICE_SECRET), "POST", "/api/harness/event", timestamp, nonce,
                body.getBytes(StandardCharsets.UTF_8));

        String tampered = body.replace("\"msg:1\"", "\"msg:999\"");

        mvc.perform(post("/api/harness/event")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(tampered)
                        .header("X-Harness-Client", SERVICE_CLIENT)
                        .header("X-Harness-Timestamp", timestamp)
                        .header("X-Harness-Nonce", nonce)
                        .header("X-Harness-Signature", signature))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error.code").value("BAD_SIGNATURE"));
    }

    @Test
    void rejectsADisabledPrincipal() throws Exception {
        createPrincipal("harness-disabled", SERVICE_SECRET, "service", null);
        jdbc.sql("UPDATE harness_principal SET status = 'disabled' WHERE client_id = 'harness-disabled'").update();

        MockHttpServletRequestBuilder request = get("/api/harness/template");
        signAs("harness-disabled", SERVICE_SECRET, "GET", "/api/harness/template", request, "");

        mvc.perform(request)
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("PRINCIPAL_DISABLED"));
    }

    @Test
    void acceptsAValidSignature() throws Exception {
        MockHttpServletRequestBuilder request = get("/api/harness/template");
        signAsService("GET", "/api/harness/template", request, "");

        mvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    @Test
    void doesNotFilterItsOwnHealthEndpoint() throws Exception {
        mvc.perform(get("/actuator/health")).andExpect(status().isOk());
    }
}