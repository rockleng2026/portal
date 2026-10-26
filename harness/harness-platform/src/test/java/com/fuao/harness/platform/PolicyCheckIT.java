package com.fuao.harness.platform;

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
 * The end-to-end path that matters most: an agent asks to do something, and the answer comes from
 * {@code capability ∩ scope ∩ TTL} rather than from the caller's opinion of what it may do
 * (01 §5.2, 01 §0 P2).
 */
class PolicyCheckIT extends PlatformTestBase {

    private static final String AGENT = "agent:leon:sales:sh001";
    private static final int DEPT = 91;

    private String agentId;

    @BeforeEach
    void setup() {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);
        agentId = seedAgent(AGENT, AGENT_OWNER_EMPLOYEE_ID, DEPT, 2);
    }

    private MockHttpServletRequestBuilder check(Map<String, Object> payload) throws Exception {
        String body = body(payload);
        MockHttpServletRequestBuilder request = post("/api/harness/policy/check")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/policy/check", request, body);
        return request;
    }

    private Map<String, Object> basePayload() {
        return Map.of(
                "agentId", agentId,
                "capKey", "cap:portal.mission.complete",
                "scope", Map.of("deptIds", Set.of(DEPT)),
                "contentTrust", "trusted");
    }

    @Test
    void allowsAGroundedLowRiskWrite() throws Exception {
        grant(agentId, "cap:portal.mission.complete", DEPT, 3600);

        mvc.perform(check(basePayload()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("allow"))
                .andExpect(jsonPath("$.reasonCode").value("GRANT_MATCHES"))
                .andExpect(jsonPath("$.effectivePermission.capKey").value("cap:portal.mission.complete"));
    }

    @Test
    void deniesWhenThereIsNoGrantAtAll() throws Exception {
        mvc.perform(check(basePayload()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("deny"))
                .andExpect(jsonPath("$.reasonCode").value("GRANT_MISSING"));
    }

    @Test
    void deniesAnExpiredGrantWithoutAnybodyNoticing() throws Exception {
        grant(agentId, "cap:portal.mission.complete", DEPT, -5);

        mvc.perform(check(basePayload()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("deny"))
                .andExpect(jsonPath("$.reasonCode").value("GRANT_MISSING"))
                .andExpect(jsonPath("$.reason").value(org.hamcrest.Matchers.containsString("expired")));
    }

    @Test
    void deniesWhenTheGrantDoesNotReachTheTargetDepartment() throws Exception {
        grant(agentId, "cap:portal.mission.complete", 7, 3600);

        mvc.perform(check(basePayload()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("deny"))
                .andExpect(jsonPath("$.reasonCode").value("SCOPE_NOT_COVERED"));
    }

    @Test
    void anAgentAtL0MayOnlyObserve() throws Exception {
        jdbc.sql("UPDATE harness_agent SET autonomy_level = 0 WHERE agent_id = :id")
                .param("id", agentId).update();
        grant(agentId, "cap:portal.mission.complete", DEPT, 3600);

        mvc.perform(check(basePayload()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("deny"))
                .andExpect(jsonPath("$.reasonCode").value("AUTONOMY_TOO_LOW"));
    }

    @Test
    void untrustedArgumentsWithoutASourceReferenceAreRefused() throws Exception {
        grant(agentId, "cap:portal.mission.complete", DEPT, 3600);
        Map<String, Object> payload = new java.util.HashMap<>(basePayload());
        payload.put("contentTrust", "untrusted");
        payload.put("sourceRefs", Set.of());

        mvc.perform(check(payload))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("deny"))
                .andExpect(jsonPath("$.reasonCode").value("UNTRUSTED_CONTENT_WITHOUT_REF"));
    }

    @Test
    void untrustedArgumentsAreAcceptedWhenTheyCiteTheirSource() throws Exception {
        grant(agentId, "cap:portal.mission.complete", DEPT, 3600);
        Map<String, Object> payload = new java.util.HashMap<>(basePayload());
        payload.put("contentTrust", "untrusted");
        payload.put("sourceRefs", Set.of("portal:message:88213"));

        mvc.perform(check(payload))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("allow"));
    }

    @Test
    void anIrreversibleCapabilityNeverRunsAutonomouslyAndOpensAnApproval() throws Exception {
        jdbc.sql("UPDATE harness_agent SET autonomy_level = 4 WHERE agent_id = :id")
                .param("id", agentId).update();
        grant(agentId, "cap:db.ddl", DEPT, 3600);

        Map<String, Object> payload = new java.util.HashMap<>(basePayload());
        payload.put("capKey", "cap:db.ddl");

        mvc.perform(check(payload))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("require_approval"))
                .andExpect(jsonPath("$.approvalId").isNotEmpty());

        Integer pending = jdbc.sql("SELECT COUNT(*) FROM harness_approval WHERE agent_id = :id "
                        + "AND status = 'pending' AND requested_cap = 'cap:db.ddl'")
                .param("id", agentId).query(Integer.class).single();
        if (pending == null || pending != 1) {
            throw new AssertionError("expected exactly one pending approval, found " + pending);
        }

        String rollback = jdbc.sql("SELECT rollback_plan FROM harness_approval WHERE agent_id = :id")
                .param("id", agentId).query(String.class).single();
        if (rollback == null || !rollback.contains("irreversible")) {
            throw new AssertionError("an approval for an irreversible action must say so in its rollback plan");
        }
    }

    @Test
    void revokingAGrantStopsTheAgentOnTheNextCheck() throws Exception {
        String grantId = grant(agentId, "cap:portal.mission.complete", DEPT, 3600);
        mvc.perform(check(basePayload())).andExpect(jsonPath("$.outcome").value("allow"));

        String body = body(Map.of("reason", "position changed"));
        MockHttpServletRequestBuilder revoke = post("/api/harness/grant/" + grantId + "/revoke")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/grant/" + grantId + "/revoke", revoke, body);
        mvc.perform(revoke).andExpect(status().isOk());

        mvc.perform(check(basePayload()))
                .andExpect(jsonPath("$.outcome").value("deny"))
                .andExpect(jsonPath("$.reasonCode").value("GRANT_MISSING"));
    }

    @Test
    void aGrantLongerThanTheCeilingIsRefusedAtIssueTime() throws Exception {
        String body = body(Map.of(
                "agentId", agentId,
                "capKey", "cap:portal.mission.complete",
                "scope", Map.of("deptIds", Set.of(DEPT)),
                "ttlSeconds", 172800,
                "reason", "make it permanent for now"));
        MockHttpServletRequestBuilder request = post("/api/harness/grant")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsHuman("POST", "/api/harness/grant", request, body);

        mvc.perform(request)
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.error.message").value(
                        org.hamcrest.Matchers.containsString("ceiling")));
    }

    @Test
    void everyDecisionIsAuditedIncludingTheDenials() throws Exception {
        mvc.perform(check(basePayload())).andExpect(jsonPath("$.outcome").value("deny"));

        Integer denials = jdbc.sql("SELECT COUNT(*) FROM harness_audit WHERE op = 'policy.deny' "
                        + "AND object_id = 'cap:portal.mission.complete'")
                .query(Integer.class).single();
        if (denials == null || denials < 1) {
            throw new AssertionError("a denial must be audited");
        }
    }
}