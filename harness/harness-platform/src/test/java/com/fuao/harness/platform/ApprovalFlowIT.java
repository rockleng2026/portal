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
 * The escalation path end to end (01 §6.2, red-team R-02).
 *
 * <p>An L4 request opens an approval; the interesting part is who is allowed to close it.
 */
class ApprovalFlowIT extends PlatformTestBase {

    private static final String OTHER_HUMAN_CLIENT = "harness-test-admin";
    private static final String OTHER_HUMAN_SECRET = "third-test-secret-0123456789";
    private static final int OTHER_EMPLOYEE_ID = 9002;
    private static final int AGENT_OWNER = 7007;

    private String agentId;

    @BeforeEach
    void setup() {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);
        createPrincipal(OTHER_HUMAN_CLIENT, OTHER_HUMAN_SECRET, "human", OTHER_EMPLOYEE_ID, "system_admin", null);
        agentId = seedAgent("agent:leon:ops:approval", AGENT_OWNER, 92, 4);
        grant(agentId, "cap:db.ddl", 92, 3600);
    }

    private String openEscalation() throws Exception {
        String body = body(Map.of(
                "agentId", agentId,
                "capKey", "cap:db.ddl",
                "contentTrust", "trusted",
                "scope", Map.of("deptIds", Set.of(92))));
        MockHttpServletRequestBuilder request = post("/api/harness/policy/check")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/policy/check", request, body);

        String response = mvc.perform(request).andExpect(status().isOk())
                .andExpect(jsonPath("$.outcome").value("require_approval"))
                .andReturn().getResponse().getContentAsString();
        return String.valueOf(parse(response).get("approvalId"));
    }

    private MockHttpServletRequestBuilder decide(String clientId, String secret, String approvalId,
                                                 String decision, String note) throws Exception {
        String body = body(Map.of("decision", decision, "note", note));
        MockHttpServletRequestBuilder request = post("/api/harness/approval/" + approvalId + "/decide")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAs(clientId, secret, "POST", "/api/harness/approval/" + approvalId + "/decide", request, body);
        return request;
    }

    @Test
    void anIrreversibleEscalationNeedsTwoDifferentHumans() throws Exception {
        // cap:db.ddl is R4 and irreversible, so one signature is not an approval
        // (01 §5.3: "双人审批"; red-team R-02).
        String approvalId = openEscalation();

        mvc.perform(decide(HUMAN_CLIENT, HUMAN_SECRET, approvalId, "approved", "first signature"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.state").value("pending"));

        assertEquals("pending", jdbc.sql("SELECT status FROM harness_approval WHERE approval_id = :id")
                .param("id", approvalId).query(String.class).single(),
                "one signature must not approve an irreversible escalation");

        mvc.perform(decide(OTHER_HUMAN_CLIENT, OTHER_HUMAN_SECRET, approvalId, "approved", "second signature"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.state").value("approved"));

        assertEquals("approved", jdbc.sql("SELECT status FROM harness_approval WHERE approval_id = :id")
                .param("id", approvalId).query(String.class).single());
        assertEquals(2, jdbc.sql("SELECT COUNT(DISTINCT employee_id) FROM harness_approval_signoff "
                        + "WHERE approval_id = :id")
                .param("id", approvalId).query(Integer.class).single(),
                "both signatures must be on record");
    }

    @Test
    void theSameHumanCannotSignTwiceForAnIrreversibleEscalation() throws Exception {
        String approvalId = openEscalation();

        mvc.perform(decide(HUMAN_CLIENT, HUMAN_SECRET, approvalId, "approved", "first")).andExpect(status().isOk());
        mvc.perform(decide(HUMAN_CLIENT, HUMAN_SECRET, approvalId, "approved", "again")).andExpect(status().isOk());

        assertEquals("pending", jdbc.sql("SELECT status FROM harness_approval WHERE approval_id = :id")
                .param("id", approvalId).query(String.class).single(),
                "the same person is not two approvers");
    }

    @Test
    void theAgentsOwnManagerCannotApproveIt() throws Exception {
        String approvalId = openEscalation();

        // The agent's owner is employee 7007; give them a console principal for this test.
        createPrincipal("harness-test-owner", OWNER_SECRET, "human", AGENT_OWNER, "system_admin", null);

        mvc.perform(decide("harness-test-owner", OWNER_SECRET, approvalId, "approved", "trust me"))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.error.code").value("ILLEGAL_APPROVAL_TRANSITION"))
                .andExpect(jsonPath("$.error.message").value(
                        org.hamcrest.Matchers.containsString("own escalation")));
    }

    @Test
    void aMachineAccountCannotDecideEvenWithAValidSignature() throws Exception {
        String approvalId = openEscalation();

        mvc.perform(decide(SERVICE_CLIENT, SERVICE_SECRET, approvalId, "approved", "self-approved"))
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"))
                .andExpect(jsonPath("$.error.message").value(
                        org.hamcrest.Matchers.containsString("AI must not authorise itself")));
    }

    @Test
    void anApprovalCannotBeDecidedTwice() throws Exception {
        String approvalId = openEscalation();

        // Two independent signatures close an irreversible escalation.
        mvc.perform(decide(HUMAN_CLIENT, HUMAN_SECRET, approvalId, "approved", "ok")).andExpect(status().isOk());
        mvc.perform(decide(OTHER_HUMAN_CLIENT, OTHER_HUMAN_SECRET, approvalId, "approved", "also ok"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.state").value("approved"));

        mvc.perform(decide(HUMAN_CLIENT, HUMAN_SECRET, approvalId, "rejected", "changed my mind"))
                .andExpect(status().isConflict());
    }

    @Test
    void rejectionKeepsTheReviewersReason() throws Exception {
        String approvalId = openEscalation();

        mvc.perform(decide(HUMAN_CLIENT, HUMAN_SECRET, approvalId, "rejected", "no change window tonight"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.state").value("rejected"));

        String note = jdbc.sql("SELECT decision_note FROM harness_approval WHERE approval_id = :id")
                .param("id", approvalId).query(String.class).single();
        assertEquals(note, "no change window tonight",
                "a rejection without a reason is exactly what the design forbids (01 §6.2)");
    }

    @Test
    void anApprovalIsNeverGrantedToTheRequestingAgent() throws Exception {
        String approvalId = openEscalation();

        String agentId2 = jdbc.sql("SELECT agent_id FROM harness_approval WHERE approval_id = :id")
                .param("id", approvalId).query(String.class).single();
        assertEquals(agentId2, agentId, "the approval must be attached to the agent that asked");
    }

    private static final String OWNER_SECRET = "owner-test-secret-0123456789";

    private static void assertEquals(String actual, String expected, String message) {
        if (!actual.equals(expected)) {
            throw new AssertionError(message + ": expected '" + expected + "' but was '" + actual + "'");
        }
    }

    private static void assertEquals(String actual, String expected) {
        assertEquals(actual, expected, "values differ");
    }

    private static void assertEquals(int actual, int expected, String message) {
        if (actual != expected) {
            throw new AssertionError(message + ": expected '" + expected + "' but was '" + actual + "'");
        }
    }
}