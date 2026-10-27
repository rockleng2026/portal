package com.fuao.harness.platform;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
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
 * The model configuration of a terminal (V10).
 *
 * <p>Two properties matter more than the feature itself: the API key is <b>write-only</b>, and
 * it is <b>encrypted at rest</b>. A configuration that hands the key back to anyone who asks is
 * not a configuration, it is a key in a table with extra steps.
 */
class ModelConfigIT extends PlatformTestBase {

    private String terminalId;

    @BeforeEach
    void principals() throws Exception {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);

        // A real terminal, so the endpoint that hands out the key has something to find.
        String hello = body(Map.of("deviceId", "device-model-" + java.util.UUID.randomUUID(),
                "os", "linux", "agentVersion", "0.1.0"));
        MockHttpServletRequestBuilder request = post("/api/harness/terminal/hello")
                .contentType(MediaType.APPLICATION_JSON)
                .content(hello);
        signAsService("POST", "/api/harness/terminal/hello", request, hello);
        String response = mvc.perform(request).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        terminalId = String.valueOf(parse(response).get("terminalId"));
    }

    @Test
    void aHumanSetsTheModelAndTheKeyIsNeverReadBack() throws Exception {
        String body = body(Map.of(
                "scope", "terminal",
                "scopeId", terminalId,
                "provider", "anthropic",
                "modelName", "claude-sonnet-4-5",
                "apiKey", "sk-ant-secret-value"));
        MockHttpServletRequestBuilder request = post("/api/harness/model-config")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/model-config", request, body);

        mvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.keyConfigured").value(true));

        // Reading the configuration back tells you THAT a key is set, never the key.
        MockHttpServletRequestBuilder list = get("/api/harness/model-config");
        signAsHuman("GET", "/api/harness/model-config", list, "");
        String response = mvc.perform(list).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        if (response.contains("sk-ant-secret-value")) {
            throw new AssertionError("the api key must never be readable over the api");
        }
    }

    @Test
    void theKeyIsEncryptedInTheTable() throws Exception {
        String body = body(Map.of(
                "scope", "terminal",
                "scopeId", terminalId,
                "provider", "anthropic",
                "modelName", "claude-sonnet-4-5",
                "apiKey", "sk-ant-secret-value"));
        MockHttpServletRequestBuilder request = post("/api/harness/model-config")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/model-config", request, body);
        mvc.perform(request).andExpect(status().isOk());

        String cipher = jdbc.sql("SELECT api_key_cipher FROM harness_model_config "
                        + "WHERE scope = 'terminal' AND scope_id = :id")
                .param("id", terminalId).query(String.class).single();
        if (cipher.contains("sk-ant-secret-value")) {
            throw new AssertionError("the api key must not sit in the table in the clear");
        }
    }

    @Test
    void aMachineAccountCannotConfigureTheModel() throws Exception {
        String body = body(Map.of(
                "scope", "terminal",
                "scopeId", terminalId,
                "provider", "anthropic",
                "modelName", "claude-sonnet-4-5",
                "apiKey", "sk-ant-secret-value"));
        MockHttpServletRequestBuilder request = post("/api/harness/model-config")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/model-config", request, body);

        mvc.perform(request)
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"));
    }

    @Test
    void theTerminalGetsItsOwnConfigurationWithTheKey() throws Exception {
        String body = body(Map.of(
                "scope", "terminal",
                "scopeId", terminalId,
                "provider", "anthropic",
                "modelName", "claude-sonnet-4-5",
                "apiKey", "sk-ant-secret-value"));
        MockHttpServletRequestBuilder request = post("/api/harness/model-config")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/model-config", request, body);
        mvc.perform(request).andExpect(status().isOk());

        // The terminal asks for its own configuration - it needs the key to call the provider.
        MockHttpServletRequestBuilder mine = get("/api/harness/terminal/" + terminalId + "/model");
        signAsService("GET", "/api/harness/terminal/" + terminalId + "/model", mine, "");
        mvc.perform(mine)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.provider").value("anthropic"))
                .andExpect(jsonPath("$.modelName").value("claude-sonnet-4-5"))
                .andExpect(jsonPath("$.apiKey").value("sk-ant-secret-value"));
    }

    @Test
    void aTerminalWithoutAConfigurationGetsNothing() throws Exception {
        MockHttpServletRequestBuilder mine = get("/api/harness/terminal/" + terminalId + "/model");
        signAsService("GET", "/api/harness/terminal/" + terminalId + "/model", mine, "");
        mvc.perform(mine)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.provider").value(""))
                .andExpect(jsonPath("$.apiKey").value(""));
    }

    @Test
    void theConfigurationCanBeRemoved() throws Exception {
        String body = body(Map.of(
                "scope", "terminal",
                "scopeId", terminalId,
                "provider", "anthropic",
                "modelName", "claude-sonnet-4-5",
                "apiKey", "sk-ant-secret-value"));
        MockHttpServletRequestBuilder request = post("/api/harness/model-config")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/model-config", request, body);
        mvc.perform(request).andExpect(status().isOk());

        MockHttpServletRequestBuilder remove = delete("/api/harness/model-config?scope=terminal&scopeId="
                + terminalId);
        signAsHuman("DELETE", "/api/harness/model-config?scope=terminal&scopeId=" + terminalId, remove, "");
        mvc.perform(remove).andExpect(status().isOk()).andExpect(jsonPath("$.deleted").value(true));

        Integer left = jdbc.sql("SELECT COUNT(*) FROM harness_model_config WHERE scope_id = :id")
                .param("id", terminalId).query(Integer.class).single();
        assertEquals(0, left.intValue(), "the configuration is gone");
    }

    private static void assertEquals(int actual, int expected, String message) {
        if (actual != expected) {
            throw new AssertionError(message + ": expected " + expected + " but was " + actual);
        }
    }
}
