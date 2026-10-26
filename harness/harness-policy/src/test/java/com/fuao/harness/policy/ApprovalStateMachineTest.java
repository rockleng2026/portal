package com.fuao.harness.policy;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Instant;
import org.junit.jupiter.api.Test;

class ApprovalStateMachineTest {

    private static final Instant NOW = Instant.parse("2026-10-22T10:00:00Z");

    private ApprovalStateMachine.Request request(int ownerEmployeeId) {
        return new ApprovalStateMachine.Request(
                "appr:1", "agent-a", "agent:leon:sales:sh001", ownerEmployeeId,
                "cap:cdn.restart", Scope.ofDept(91), 3600, "R3", 5,
                "restart via shadow diff", "the node is dropping 5xx", NOW, NOW.plusSeconds(3600),
                PolicyDecision.ApproverScope.SYSTEM_ADMIN);
    }

    @Test
    void anAiCannotDecideEvenWhenTheSignatureIsPerfect() {
        ApprovalStateMachine.IllegalTransitionException e = assertThrows(
                ApprovalStateMachine.IllegalTransitionException.class,
                () -> ApprovalStateMachine.decide(request(100), ApprovalStateMachine.State.PENDING,
                        ApprovalStateMachine.State.APPROVED, ActorRef.agent("0198f0c2-aaaa"), "looks fine", NOW));
        assertTrue(e.getMessage().contains("natural human"));
    }

    @Test
    void theOwnersManagerStillCannotApproveForThem() {
        ApprovalStateMachine.IllegalTransitionException e = assertThrows(
                ApprovalStateMachine.IllegalTransitionException.class,
                () -> ApprovalStateMachine.decide(request(100), ApprovalStateMachine.State.PENDING,
                        ApprovalStateMachine.State.APPROVED, ActorRef.human(100), "ok", NOW));
        assertTrue(e.getMessage().contains("own escalation"));
    }

    @Test
    void anIndependentHumanCanApprove() {
        ApprovalStateMachine.Verdict v = ApprovalStateMachine.decide(request(100),
                ApprovalStateMachine.State.PENDING, ApprovalStateMachine.State.APPROVED,
                ActorRef.human(200), "reviewed the shadow diff", NOW);

        assertEquals(ApprovalStateMachine.State.APPROVED, v.state());
        assertEquals("200", v.humanApproverEmployeeId());
    }

    @Test
    void rejectionIsRecordedWithTheReviewersReason() {
        ApprovalStateMachine.Verdict v = ApprovalStateMachine.decide(request(100),
                ApprovalStateMachine.State.PENDING, ApprovalStateMachine.State.REJECTED,
                ActorRef.human(200), "no change window tonight", NOW);

        assertEquals(ApprovalStateMachine.State.REJECTED, v.state());
        assertEquals("no change window tonight", v.note());
    }

    @Test
    void aLateDecisionCannotReviveAnExpiredApproval() {
        ApprovalStateMachine.Request req = new ApprovalStateMachine.Request(
                "appr:1", "agent-a", "agent:leon", 100, "cap:x", Scope.ofDept(91), 60, "R3", 1,
                "n/a", "n/a", NOW.minusSeconds(3600), NOW.minusSeconds(60),
                PolicyDecision.ApproverScope.SYSTEM_ADMIN);

        ApprovalStateMachine.Verdict v = ApprovalStateMachine.decide(req, ApprovalStateMachine.State.PENDING,
                ApprovalStateMachine.State.APPROVED, ActorRef.human(200), "still fine", NOW);

        assertEquals(ApprovalStateMachine.State.EXPIRED, v.state());
    }

    @Test
    void aDecisionCannotBeTakenTwice() {
        assertThrows(ApprovalStateMachine.IllegalTransitionException.class,
                () -> ApprovalStateMachine.decide(request(100), ApprovalStateMachine.State.APPROVED,
                        ApprovalStateMachine.State.REJECTED, ActorRef.human(200), "changed my mind", NOW));
    }

    @Test
    void oneApprovalBuysExactlyOneExecution() {
        ApprovalStateMachine.Verdict approved = ApprovalStateMachine.decide(request(100),
                ApprovalStateMachine.State.PENDING, ApprovalStateMachine.State.APPROVED, ActorRef.human(200), "", NOW);
        ApprovalStateMachine.Verdict spent = ApprovalStateMachine.consume(approved, NOW.plusSeconds(10));
        assertEquals(ApprovalStateMachine.State.USED, spent.state());

        // The service persists the returned verdict; a replay arrives with the *stored* row,
        // which is already USED, and must be refused rather than executing a second time.
        assertThrows(ApprovalStateMachine.IllegalTransitionException.class,
                () -> ApprovalStateMachine.consume(spent, NOW.plusSeconds(20)),
                "replaying a consumed approval must fail");
    }

    @Test
    void l4NeedsTwoDifferentHumansNeitherOfThemTheOwner() {
        ApprovalStateMachine.Request req = request(100);

        assertThrows(ApprovalStateMachine.IllegalTransitionException.class,
                () -> ApprovalStateMachine.assertDualApprovalComplete(req,
                        ApprovalStateMachine.decide(req, ApprovalStateMachine.State.PENDING,
                                ApprovalStateMachine.State.APPROVED, ActorRef.human(200), "", NOW),
                        ApprovalStateMachine.decide(req, ApprovalStateMachine.State.PENDING,
                                ApprovalStateMachine.State.APPROVED, ActorRef.human(200), "", NOW)),
                "the same person twice is not two approvals");

        ApprovalStateMachine.assertDualApprovalComplete(req,
                ApprovalStateMachine.decide(req, ApprovalStateMachine.State.PENDING,
                        ApprovalStateMachine.State.APPROVED, ActorRef.human(200), "", NOW),
                ApprovalStateMachine.decide(req, ApprovalStateMachine.State.PENDING,
                        ApprovalStateMachine.State.APPROVED, ActorRef.human(300), "", NOW));
    }

    @Test
    void legalTransitionsAreExplicit() {
        assertEquals(java.util.Set.of(ApprovalStateMachine.State.APPROVED, ApprovalStateMachine.State.REJECTED,
                        ApprovalStateMachine.State.EXPIRED),
                ApprovalStateMachine.nextStates(ApprovalStateMachine.State.PENDING));
        assertTrue(ApprovalStateMachine.nextStates(ApprovalStateMachine.State.REJECTED).isEmpty());
        assertFalse(ApprovalStateMachine.State.REJECTED.isTerminal() == false);
    }
}