package com.fuao.harness.platform;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

/**
 * One machine account per device (red-team R-01).
 *
 * <p>A shared service account for all terminals would mean: one lost machine can impersonate
 * all of them, and revoking one device revokes all of them. Every device gets its own account,
 * bound to its own terminal, and it may only speak for that terminal.
 */
class DeviceAccountIT extends PlatformTestBase {

    private static final String AGENT_KEY = "agent:leon:ops:device";

    private String agentId;

    @BeforeEach
    void setup() {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);
        agentId = seedAgent(AGENT_KEY, AGENT_OWNER_EMPLOYEE_ID, 96, 2);
    }

    private MockHttpServletRequestBuilder createAccount(String asClient, String asSecret, String body) {
        MockHttpServletRequestBuilder request = post("/api/harness/principal")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAs(asClient, asSecret, "POST", "/api/harness/principal", request, body);
        return request;
    }

    @Test
    void aHumanCreatesADeviceAccountAndTheSecretIsShownOnce() throws Exception {
        String body = body(Map.of("agentKey", AGENT_KEY));
        String response = mvc.perform(createAccount(HUMAN_CLIENT, HUMAN_SECRET, body))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.clientId").isNotEmpty())
                .andExpect(jsonPath("$.secret").isNotEmpty())
                .andExpect(jsonPath("$.agentId").value(agentId))
                .andReturn().getResponse().getContentAsString();

        String clientId = String.valueOf(parse(response).get("clientId"));

        // The platform keeps the hash, not the secret.
        Integer stored = jdbc.sql("SELECT COUNT(*) FROM harness_principal "
                        + "WHERE client_id = :id AND secret_hash = :hash AND secret_hash <> :secret")
                .param("id", clientId)
                .param("hash", com.fuao.harness.platform.security.HmacSigner
                        .deriveKey(String.valueOf(parse(response).get("secret"))))
                .param("secret", String.valueOf(parse(response).get("secret")))
                .query(Integer.class).single();
        assertEquals(1, stored.intValue(), "the secret is stored hashed, never in the clear");
    }

    @Test
    void aMachineAccountCannotCreateADeviceAccount() throws Exception {
        String body = body(Map.of("agentKey", AGENT_KEY));
        mvc.perform(createAccount(SERVICE_CLIENT, SERVICE_SECRET, body))
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"));
    }

    @Test
    void aDeviceAccountMayOnlySpeakForItsOwnTerminal() throws Exception {
        String body = body(Map.of("agentKey", AGENT_KEY));
        String response = mvc.perform(createAccount(HUMAN_CLIENT, HUMAN_SECRET, body))
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String clientId = String.valueOf(parse(response).get("clientId"));
        String secret = String.valueOf(parse(response).get("secret"));

        // Register a device with that account: it gets bound to the terminal it registered.
        String hello = body(Map.of(
                "deviceId", "device-account-it",
                "os", "linux",
                "agentVersion", "0.1.0"));
        MockHttpServletRequestBuilder helloRequest = post("/api/harness/terminal/hello")
                .contentType(MediaType.APPLICATION_JSON)
                .content(hello);
        signAs(clientId, secret, "POST", "/api/harness/terminal/hello", helloRequest, hello);
        String helloResponse = mvc.perform(helloRequest).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String terminalId = String.valueOf(parse(helloResponse).get("terminalId"));

        // Its own grant: fine.
        MockHttpServletRequestBuilder own = get("/api/harness/terminal/" + terminalId + "/grant");
        signAs(clientId, secret, "GET", "/api/harness/terminal/" + terminalId + "/grant", own, "");
        mvc.perform(own).andExpect(status().isOk());

        // Somebody else's terminal: refused.
        MockHttpServletRequestBuilder other = get("/api/harness/terminal/"
                + "01a17c25-3d41-7000-a0ca-b9995d681a32" + "/grant");
        signAs(clientId, secret, "GET", "/api/harness/terminal/"
                + "01a17c25-3d41-7000-a0ca-b9995d681a32" + "/grant", other, "");
        mvc.perform(other)
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("NOT_YOUR_TERMINAL"));
    }

    @Test
    void aDeviceAccountIsBoundToTheTerminalItRegisteredWith() throws Exception {
        String body = body(Map.of("agentKey", AGENT_KEY));
        String response = mvc.perform(createAccount(HUMAN_CLIENT, HUMAN_SECRET, body))
                .andReturn().getResponse().getContentAsString();
        String clientId = String.valueOf(parse(response).get("clientId"));
        String secret = String.valueOf(parse(response).get("secret"));

        String hello = body(Map.of(
                "deviceId", "device-account-bind",
                "os", "linux",
                "agentVersion", "0.1.0"));
        MockHttpServletRequestBuilder helloRequest = post("/api/harness/terminal/hello")
                .contentType(MediaType.APPLICATION_JSON)
                .content(hello);
        signAs(clientId, secret, "POST", "/api/harness/terminal/hello", helloRequest, hello);
        String helloResponse = mvc.perform(helloRequest).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String terminalId = String.valueOf(parse(helloResponse).get("terminalId"));

        String bound = jdbc.sql("SELECT terminal_id FROM harness_principal WHERE client_id = :id")
                .param("id", clientId).query(String.class).single();
        assertEquals(terminalId, bound, "the account is bound to the terminal it registered with");
    }

    @Test
    void aDeviceAccountCannotReachTheAuditOrTheAgents() throws Exception {
        String body = body(Map.of("agentKey", AGENT_KEY));
        String response = mvc.perform(createAccount(HUMAN_CLIENT, HUMAN_SECRET, body))
                .andReturn().getResponse().getContentAsString();
        String clientId = String.valueOf(parse(response).get("clientId"));
        String secret = String.valueOf(parse(response).get("secret"));

        MockHttpServletRequestBuilder audit = get("/api/harness/audit");
        signAs(clientId, secret, "GET", "/api/harness/audit", audit, "");
        mvc.perform(audit)
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("SCOPE_NOT_ALLOWED"));
    }

    private static void assertEquals(Object actual, Object expected, String message) {
        if (!String.valueOf(actual).equals(String.valueOf(expected))) {
            throw new AssertionError(message + ": expected " + expected + " but was " + actual);
        }
    }
}
