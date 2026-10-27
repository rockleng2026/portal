package com.fuao.harness.platform;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Map;
import java.util.Set;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

/**
 * Terminal binding and revocation (03 §3.5, 04 §2.2 A0-5) plus the kill switch (04 §8.2).
 */
class TerminalAndKillSwitchIT extends PlatformTestBase {

    private static final String AGENT_KEY = "agent:leon:support:terminal";

    @BeforeEach
    void setup() {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);
        seedAgent(AGENT_KEY, AGENT_OWNER_EMPLOYEE_ID, 93, 2);
    }

    private String hello(String deviceId) throws Exception {
        String body = body(Map.of(
                "deviceId", deviceId,
                "os", "linux",
                "osVersion", "Ubuntu 22.04",
                "hostname", "workstation-7",
                "agentVersion", "0.1.0",
                "capabilities", Map.of("cap:file.read", true)));
        MockHttpServletRequestBuilder request = post("/api/harness/terminal/hello")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/terminal/hello", request, body);

        String response = mvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.bindingCode").isNotEmpty())
                .andReturn().getResponse().getContentAsString();
        Map<String, Object> parsed = parse(response);
        return String.valueOf(parsed.get("bindingCode"));
    }

    private MockHttpServletRequestBuilder humanPost(String path, Object payload) throws Exception {
        String body = body(payload);
        MockHttpServletRequestBuilder request = post(path)
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", path, request, body);
        return request;
    }

    @Test
    void aTerminalThatComesBackGoesGreenAgain() throws Exception {
        // The heartbeat is the proof that the machine is there. A terminal that was marked
        // offline because it stopped heartbeating has to be able to come back (A0-6:
        // "恢复 → 自动回绿") - otherwise it stays degraded forever.
        String code = hello("device-sha-comeback");
        MockHttpServletRequestBuilder bind = humanPost("/api/harness/terminal/bind",
                Map.of("bindingCode", code, "agentKey", AGENT_KEY));
        String bindResponse = mvc.perform(bind).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String terminalId = String.valueOf(parse(bindResponse).get("terminalId"));

        // The degradation job marks a silent terminal offline.
        jdbc.sql("UPDATE harness_terminal SET status = 'offline' WHERE terminal_id = :id")
                .param("id", terminalId).update();

        MockHttpServletRequestBuilder beat = post("/api/harness/terminal/" + terminalId + "/heartbeat");
        signAsService("POST", "/api/harness/terminal/" + terminalId + "/heartbeat", beat, "");
        mvc.perform(beat).andExpect(status().isOk());

        String status = jdbc.sql("SELECT status FROM harness_terminal WHERE terminal_id = :id")
                .param("id", terminalId).query(String.class).single();
        assertEquals("online", status, "a terminal that heartbeats again is online again");
    }

    @Test
    void theGrantTellsTheDeviceWhatItMayDo() throws Exception {
        // The platform holds the grants, so the platform is the only place that can answer.
        // The shell asks it and the agent on the same machine reads the answer.
        String agentId = jdbc.sql("SELECT agent_id FROM harness_agent WHERE agent_key = :key")
                .param("key", AGENT_KEY).query(String.class).single();
        grant(agentId, "cap:portal.mission.complete", 93, 3600);

        String code = hello("device-sha-grant");
        MockHttpServletRequestBuilder bind = humanPost("/api/harness/terminal/bind",
                Map.of("bindingCode", code, "agentKey", AGENT_KEY));
        String bindResponse = mvc.perform(bind).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String terminalId = String.valueOf(parse(bindResponse).get("terminalId"));

        MockHttpServletRequestBuilder request = get("/api/harness/terminal/" + terminalId + "/grant");
        signAsService("GET", "/api/harness/terminal/" + terminalId + "/grant", request, "");
        mvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.terminalId").value(terminalId))
                .andExpect(jsonPath("$.agentId").value(agentId))
                .andExpect(jsonPath("$.autonomyLevel").value("2"))
                .andExpect(jsonPath("$.capabilities").isArray());
    }

    @Test
    void aRevokedTerminalGetsNoGrantAtAll() throws Exception {
        String code = hello("device-sha-revoked-grant");
        MockHttpServletRequestBuilder bind = humanPost("/api/harness/terminal/bind",
                Map.of("bindingCode", code, "agentKey", AGENT_KEY));
        String bindResponse = mvc.perform(bind).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String terminalId = String.valueOf(parse(bindResponse).get("terminalId"));

        mvc.perform(humanPost("/api/harness/terminal/" + terminalId + "/revoke", Map.of("reason", "lost")))
                .andExpect(status().isOk());

        MockHttpServletRequestBuilder request = get("/api/harness/terminal/" + terminalId + "/grant");
        signAsService("GET", "/api/harness/terminal/" + terminalId + "/grant", request, "");
        mvc.perform(request).andExpect(status().isGone());
    }

    @Test
    void aDeviceRegistersAndGetsAOneTimeBindingCode() throws Exception {
        String code = hello("device-sha-abc123");

        assertTrue(code != null && code.length() == 6, "expected a 6-digit binding code, got " + code);

        Integer terminals = jdbc.sql("SELECT COUNT(*) FROM harness_terminal WHERE device_id = :d")
                .param("d", "device-sha-abc123").query(Integer.class).single();
        assertTrue(terminals == 1, "hello must register exactly one terminal row");
    }

    @Test
    void aBindingCodeWorksOnceAndOnlyOnce() throws Exception {
        String code = hello("device-sha-once");

        mvc.perform(humanPost("/api/harness/terminal/bind", Map.of("bindingCode", code, "agentKey", AGENT_KEY)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.bindType").value("agent"));

        mvc.perform(humanPost("/api/harness/terminal/bind", Map.of("bindingCode", code, "agentKey", AGENT_KEY)))
                .andExpect(status().isBadRequest());
    }

    @Test
    void aWrongBindingCodeIsRefused() throws Exception {
        mvc.perform(humanPost("/api/harness/terminal/bind", Map.of("bindingCode", "000000", "agentKey", AGENT_KEY)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.error.message").value(
                        org.hamcrest.Matchers.containsString("unknown or expired")));
    }

    @Test
    void aMachineCannotBindADeviceToAnAccount() throws Exception {
        String code = hello("device-sha-machinebind");
        String body = body(Map.of("bindingCode", code, "agentKey", AGENT_KEY));
        MockHttpServletRequestBuilder request = post("/api/harness/terminal/bind")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/terminal/bind", request, body);

        mvc.perform(request).andExpect(status().isForbidden());
    }

    @Test
    void aRevokedTerminalLosesAccessImmediately() throws Exception {
        String code = hello("device-sha-revoke");
        String bindBody = body(Map.of("bindingCode", code, "agentKey", AGENT_KEY));
        MockHttpServletRequestBuilder bind = post("/api/harness/terminal/bind")
                .contentType(MediaType.APPLICATION_JSON)
                .content(bindBody);
        signAsHuman("POST", "/api/harness/terminal/bind", bind, bindBody);
        String response = mvc.perform(bind).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String terminalId = String.valueOf(parse(response).get("terminalId"));

        mvc.perform(humanPost("/api/harness/terminal/" + terminalId + "/revoke", Map.of("reason", "device lost")))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("revoked"));

        MockHttpServletRequestBuilder heartbeat = post("/api/harness/terminal/" + terminalId + "/heartbeat");
        signAsService("POST", "/api/harness/terminal/" + terminalId + "/heartbeat", heartbeat, "");

        mvc.perform(heartbeat)
                .andExpect(status().isGone())
                .andExpect(jsonPath("$.error.code").value("TERMINAL_REVOKED"));
    }

    @Test
    void aGlobalKillSwitchStopsEveryAgentImmediately() throws Exception {
        String agentId = seedAgent("agent:leon:sales:killswitch", AGENT_OWNER_EMPLOYEE_ID, 94, 2);
        grant(agentId, "cap:portal.mission.complete", 94, 3600);

        String checkBody = body(Map.of(
                "agentId", agentId,
                "capKey", "cap:portal.mission.complete",
                "contentTrust", "trusted",
                "scope", Map.of("deptIds", Set.of(94))));
        MockHttpServletRequestBuilder allowed = post("/api/harness/policy/check")
                .contentType(MediaType.APPLICATION_JSON)
                .content(checkBody);
        signAsService("POST", "/api/harness/policy/check", allowed, checkBody);
        mvc.perform(allowed).andExpect(jsonPath("$.outcome").value("allow"));

        mvc.perform(humanPost("/api/harness/killswitch",
                        Map.of("scope", "global", "scopeId", "*", "effect", "halt", "reason", "incident 4417")))
                .andExpect(status().isOk());

        MockHttpServletRequestBuilder blocked = post("/api/harness/policy/check")
                .contentType(MediaType.APPLICATION_JSON)
                .content(checkBody);
        signAsService("POST", "/api/harness/policy/check", blocked, checkBody);
        mvc.perform(blocked)
                .andExpect(jsonPath("$.outcome").value("deny"))
                .andExpect(jsonPath("$.reasonCode").value("KILL_SWITCH_HALT"));

        jdbc.sql("UPDATE harness_killswitch SET active = 0, released_by = 'human:1', released_at = NOW() "
                + "WHERE scope = 'global'").update();
    }

    @Test
    void aKillSwitchNeedsAReasonAndAHuman() throws Exception {
        MockHttpServletRequestBuilder noReason = post("/api/harness/killswitch")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body(Map.of("scope", "agent", "scopeId", "x", "reason", "  ")));
        signAsHuman("POST", "/api/harness/killswitch", noReason, body(Map.of("scope", "agent", "scopeId", "x", "reason", "  ")));
        mvc.perform(noReason).andExpect(status().isBadRequest());

        String payload = body(Map.of("scope", "agent", "scopeId", "x", "reason", "suspicious behaviour"));
        MockHttpServletRequestBuilder byMachine = post("/api/harness/killswitch")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsService("POST", "/api/harness/killswitch", byMachine, payload);
        mvc.perform(byMachine).andExpect(status().isForbidden());
    }

    private static void assertTrue(boolean condition, String message) {
        if (!condition) {
            throw new AssertionError(message);
        }
    }
}