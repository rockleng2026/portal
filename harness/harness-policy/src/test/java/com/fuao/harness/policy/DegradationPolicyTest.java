package com.fuao.harness.policy;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class DegradationPolicyTest {

    private DegradationPolicy.Metrics healthy() {
        return new DegradationPolicy.Metrics(30, 2, 20, 2, 100, 0, 0, 0.5, false);
    }

    @Test
    void aHealthyAgentKeepsItsLevel() {
        DegradationPolicy.Verdict v = DegradationPolicy.evaluate(healthy(), AutonomyLevel.L3);
        assertEquals(DegradationPolicy.Action.KEEP, v.action());
        assertEquals(AutonomyLevel.L3, v.resultingLevel());
    }

    @Test
    void highRejectionRateDemotesOneLevel() {
        DegradationPolicy.Metrics m = new DegradationPolicy.Metrics(30, 9, 20, 0, 50, 0, 0, 0.5, false);
        DegradationPolicy.Verdict v = DegradationPolicy.evaluate(m, AutonomyLevel.L3);

        assertEquals(DegradationPolicy.Action.DEMOTE_ONE_LEVEL, v.action());
        assertEquals(AutonomyLevel.L2, v.resultingLevel());
        assertEquals("APPROVAL_REJECTION_RATE", v.reasonCode());
    }

    @Test
    void highFailureRateDemotesOneLevel() {
        DegradationPolicy.Metrics m = new DegradationPolicy.Metrics(30, 0, 0, 20, 100, 0, 0, 0.5, false);
        DegradationPolicy.Verdict v = DegradationPolicy.evaluate(m, AutonomyLevel.L2);

        assertEquals(DegradationPolicy.Action.DEMOTE_ONE_LEVEL, v.action());
        assertEquals("TASK_FAILURE_RATE", v.reasonCode());
    }

    @Test
    void aCircuitBreakerTripGoesStraightToTheFloor() {
        DegradationPolicy.Metrics m = new DegradationPolicy.Metrics(30, 0, 0, 0, 50, 1, 0, 0.5, false);
        DegradationPolicy.Verdict v = DegradationPolicy.evaluate(m, AutonomyLevel.L3);

        assertEquals(DegradationPolicy.Action.FORCE_L0, v.action());
        assertEquals(AutonomyLevel.L0, v.resultingLevel());
    }

    @Test
    void threeHumanCorrectionsOnOneTaskPauseTheAgent() {
        DegradationPolicy.Metrics m = new DegradationPolicy.Metrics(30, 0, 0, 0, 50, 0, 3, 0.5, false);
        assertEquals("REPEATED_HUMAN_CORRECTION",
                DegradationPolicy.evaluate(m, AutonomyLevel.L2).reasonCode());
    }

    @Test
    void overspendingDemotesInsteadOfSilentlyContinuing() {
        DegradationPolicy.Metrics m = new DegradationPolicy.Metrics(30, 0, 0, 0, 50, 0, 0, 1.25, false);
        assertEquals("BUDGET_OVERSPEND", DegradationPolicy.evaluate(m, AutonomyLevel.L3).reasonCode());
    }

    @Test
    void aNewAgentIsNotJudgedBeforeItHasHistory() {
        DegradationPolicy.Metrics m = new DegradationPolicy.Metrics(2, 0, 0, 5, 0, 0, 0, 0.5, false);
        DegradationPolicy.Verdict v = DegradationPolicy.evaluate(m, AutonomyLevel.L2);

        assertEquals(DegradationPolicy.Action.KEEP, v.action());
        assertEquals("INSUFFICIENT_HISTORY", v.reasonCode());
    }

    @Test
    void demotionIsFlooredAtL0AndNeverPromotes() {
        assertEquals(AutonomyLevel.L0, AutonomyLevel.L0.demote());
        DegradationPolicy.Metrics m = new DegradationPolicy.Metrics(30, 9, 20, 0, 10, 0, 0, 0.5, false);
        assertEquals(AutonomyLevel.L0, DegradationPolicy.evaluate(m, AutonomyLevel.L0).resultingLevel());
    }

    @Test
    void threeConsecutiveFailedFixesHaltAutonomousRepair() {
        assertTrue(DegradationPolicy.shouldHalt(2) == false);
        assertTrue(DegradationPolicy.shouldHalt(3));
    }

    @Test
    void anythingTouchingProductionGoesThroughShadowComparisonFirst() {
        assertTrue(DegradationPolicy.requiresShadowRun(
                new CapabilityDescriptor("c", "cap:cdn.restart", "cli",
                        CapabilityDescriptor.SideEffect.EXEC, false, 1, false, 3, "R3", false,
                        CapabilityDescriptor.ApprovalPolicy.HUMAN, 1000, CapabilityDescriptor.Status.ACTIVE)));
        assertFalse(DegradationPolicy.requiresShadowRun(CapabilityDescriptor.readOnly("c", "cap:log.read")));
    }
}