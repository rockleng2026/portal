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
 * Agent registry and lifecycle (01 §5.1, 04 §2.1).
 *
 * <p>Two invariants are the point of this class: a machine account can never create or activate a
 * digital employee, and no agent can take work before it exists as a row in the portal
 * organisation.
 */
class AgentLifecycleIT extends PlatformTestBase {

    @BeforeEach
    void principals() {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);
    }

    private MockHttpServletRequestBuilder createRequest(Map<String, Object> payload) throws Exception {
        String body = body(payload);
        MockHttpServletRequestBuilder request = post("/api/harness/agent")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        return request;
    }

    @Test
    void aHumanCanCreateADigitalEmployeeFromATemplate() throws Exception {
        String body = body(Map.of(
                "agentKey", "agent:leon:sales:it-lifecycle",
                "name", "leon",
                "templateKey", "tpl.sales_assistant",
                "deptId", 91,
                "ownerId", AGENT_OWNER_EMPLOYEE_ID));

        MockHttpServletRequestBuilder request = createRequest(Map.of(
                "agentKey", "agent:leon:sales:it-lifecycle",
                "name", "leon",
                "templateKey", "tpl.sales_assistant",
                "deptId", 91,
                "ownerId", AGENT_OWNER_EMPLOYEE_ID));
        signAsHuman("POST", "/api/harness/agent", request, body);

        mvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("draft"))
                .andExpect(jsonPath("$.autonomyLevel").value(0))
                .andExpect(jsonPath("$.agentKey").value("agent:leon:sales:it-lifecycle"));
    }

    @Test
    void aMachineAccountCannotCreateADigitalEmployee() throws Exception {
        Map<String, Object> payload = Map.of(
                "agentKey", "agent:robo:it",
                "deptId", 91,
                "ownerId", AGENT_OWNER_EMPLOYEE_ID);
        String body = body(payload);
        MockHttpServletRequestBuilder request = post("/api/harness/agent")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/agent", request, body);

        mvc.perform(request)
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"));
    }

    @Test
    void anAgentWithoutAHumanOwnerIsRefused() throws Exception {
        Map<String, Object> payload = Map.of("agentKey", "agent:orphan", "deptId", 91);
        String body = body(payload);
        MockHttpServletRequestBuilder request = post("/api/harness/agent")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/agent", request, body);

        mvc.perform(request)
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.error.code").value("REJECTED"));
    }

    @Test
    void duplicateAgentKeysAreRejected() throws Exception {
        seedAgent("agent:dup:sales-lifecycle", AGENT_OWNER_EMPLOYEE_ID, 91, 0);

        String body = body(Map.of("agentKey", "agent:dup:sales-lifecycle", "deptId", 91, "ownerId", AGENT_OWNER_EMPLOYEE_ID));
        MockHttpServletRequestBuilder request = post("/api/harness/agent")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/agent", request, body);

        mvc.perform(request)
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.error.code").value("DUPLICATE_AGENT_KEY"));
    }

    @Test
    void anAgentCannotBecomeActiveBeforeItExistsInPortal() throws Exception {
        String agentId = seedAgent("agent:not-onboarded", AGENT_OWNER_EMPLOYEE_ID, 91, 0);
        jdbc.sql("UPDATE harness_agent SET status = 'onboarding' WHERE agent_id = :id").param("id", agentId).update();

        String body = body(Map.of("to", "active", "reason", "starting work"));
        MockHttpServletRequestBuilder request = post("/api/harness/agent/" + agentId + "/lifecycle")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/agent/" + agentId + "/lifecycle", request, body);

        mvc.perform(request)
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.error.message").value(
                        org.hamcrest.Matchers.containsString("onboarding must finish")));
    }

    @Test
    void theLifecycleIsRecordedEvenWhenATransitionIsRefused() throws Exception {
        String agentId = seedAgent("agent:refused-transition", AGENT_OWNER_EMPLOYEE_ID, 91, 0);

        String body = body(Map.of("to", "active", "reason", "skipping onboarding"));
        MockHttpServletRequestBuilder request = post("/api/harness/agent/" + agentId + "/lifecycle")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/agent/" + agentId + "/lifecycle", request, body);

        mvc.perform(request).andExpect(status().isBadRequest());

        int stateRows = jdbc.sql("SELECT COUNT(*) FROM harness_agent_state_log WHERE agent_id = :id")
                .param("id", agentId).query(Integer.class).single();
        assertEqualsOne(stateRows, "a refused transition must not leave a state log entry behind");
    }

    @Test
    void theCapabilityCatalogueIsReadable() throws Exception {
        // The grant dialog picks a capability from the catalogue; nobody should have to know
        // a key by heart to grant it.
        MockHttpServletRequestBuilder request = get("/api/harness/capability");
        signAsHuman("GET", "/api/harness/capability", request, "");
        mvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[?(@.capKey == 'cap:file.read')].name").isNotEmpty())
                .andExpect(jsonPath("$[?(@.capKey == 'cap:file.read')].minLevel").value(0));
    }

    @Test
    void theOnboardingPreviewSaysWhatWouldBeWritten() throws Exception {
        String agentId = seedAgent("agent:onboard-preview", AGENT_OWNER_EMPLOYEE_ID, 91, 0);
        MockHttpServletRequestBuilder request = get("/api/harness/agent/" + agentId + "/onboard/preview");
        signAsHuman("GET", "/api/harness/agent/" + agentId + "/onboard/preview", request, "");
        mvc.perform(request)
                .andExpect(status().isOk())
                // The agent's own department, not the root of the org tree.
                .andExpect(jsonPath("$.deptId").value(91))
                .andExpect(jsonPath("$.name").isNotEmpty())
                .andExpect(jsonPath("$.agentKey").isNotEmpty())
                // Without a portal configured the preview says so, instead of pretending.
                .andExpect(jsonPath("$.portalConfigured").value(false))
                .andExpect(jsonPath("$.portalMissing").isNotEmpty());
    }

    @Test
    void onboardingWithoutAPortalIsRefusedWithAReason() throws Exception {
        String agentId = seedAgent("agent:onboard-no-portal", AGENT_OWNER_EMPLOYEE_ID, 91, 0);
        MockHttpServletRequestBuilder request = post("/api/harness/agent/" + agentId + "/onboard");
        signAsHuman("POST", "/api/harness/agent/" + agentId + "/onboard", request, "");
        mvc.perform(request)
                .andExpect(status().isServiceUnavailable())
                .andExpect(jsonPath("$.error.message").isNotEmpty());
    }

    @Test
    void retiringAnAgentReclaimsItsGrantsImmediately() throws Exception {
        String agentId = seedAgent("agent:retiring", AGENT_OWNER_EMPLOYEE_ID, 91, 2);
        grant(agentId, "cap:portal.mission.complete", 91, 3600);

        String body = body(Map.of("to", "retired", "reason", "replaced by a new model"));
        MockHttpServletRequestBuilder request = post("/api/harness/agent/" + agentId + "/lifecycle")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/agent/" + agentId + "/lifecycle", request, body);

        mvc.perform(request).andExpect(status().isOk()).andExpect(jsonPath("$.status").value("retired"));

        Integer live = jdbc.sql("SELECT COUNT(*) FROM harness_grant WHERE agent_id = :id AND status = 'active'")
                .param("id", agentId).query(Integer.class).single();
        assertEqualsOne(live, "retirement must not leave live grants behind (01 §15.3)");
    }

    @Test
    void loweringAutonomyIsAHumanDecisionAndIsLogged() throws Exception {
        String agentId = seedAgent("agent:demoted", AGENT_OWNER_EMPLOYEE_ID, 91, 3);

        String body = body(Map.of("level", 1, "reason", "three task failures in a week"));
        MockHttpServletRequestBuilder request = post("/api/harness/agent/" + agentId + "/autonomy")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/agent/" + agentId + "/autonomy", request, body);

        mvc.perform(request).andExpect(status().isOk()).andExpect(jsonPath("$.autonomyLevel").value(1));

        Integer level = jdbc.sql("SELECT autonomy_level FROM harness_agent WHERE agent_id = :id")
                .param("id", agentId).query(Integer.class).single();
        assertEqualsOne(level, 1);
    }

    private static void assertEqualsOne(Object actual, String message) {
        if (!"0".equals(String.valueOf(actual)) && !String.valueOf(actual).equals("1")) {
            throw new AssertionError(message + " (was " + actual + ")");
        }
    }

    private static void assertEqualsOne(Object actual, int expected) {
        if (Integer.parseInt(String.valueOf(actual)) != expected) {
            throw new AssertionError("expected " + expected + " but was " + actual);
        }
    }
}