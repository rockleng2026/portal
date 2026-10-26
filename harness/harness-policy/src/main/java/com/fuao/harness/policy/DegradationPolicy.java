package com.fuao.harness.policy;

/**
 * Automatic degradation: the safety valve of the self-evolution loop (01 §14.4).
 *
 * <p>The deliberately counter-intuitive part is that <em>losing autonomy is the default failure
 * response</em>. Every threshold below moves an agent down, none moves it up. Promotion to a
 * higher level is always an explicit human decision with a date attached.
 */
public final class DegradationPolicy {

    /** Rolling window used by every rate below (01 §14.4: 7 days). */
    public static final int WINDOW_DAYS = 7;

    public record Metrics(
            int windowDays,
            int approvalRejections,
            int approvalsDecided,
            int tasksFailed,
            int tasksCompleted,
            int circuitBreakerTrips,
            int humanCorrectionsInLastTask,
            double dailyBudgetRatio,
            boolean pausedByOperator) {
    }

    public enum Action {
        KEEP,
        DEMOTE_ONE_LEVEL,
        FORCE_L0,
        HALT_AND_ESCALATE
    }

    public record Verdict(Action action, AutonomyLevel resultingLevel, String reasonCode, String reason) {
    }

    private DegradationPolicy() {
    }

    public static Verdict evaluate(Metrics m, AutonomyLevel current) {
        if (m.pausedByOperator()) {
            return new Verdict(Action.FORCE_L0, AutonomyLevel.L0, "OPERATOR_PAUSED",
                    "an operator paused this agent");
        }
        // A circuit breaker trip is not a metric, it is an incident: go straight to the floor.
        if (m.circuitBreakerTrips() > 0) {
            return new Verdict(Action.FORCE_L0, AutonomyLevel.L0, "CIRCUIT_BREAKER",
                    m.circuitBreakerTrips() + " circuit breaker trip(s): autonomous execution is off until a human reviews");
        }
        if (m.windowDays() < WINDOW_DAYS) {
            // Not enough evidence to demote on rate grounds; keep watching rather than guessing.
            return new Verdict(Action.KEEP, current, "INSUFFICIENT_HISTORY",
                    m.windowDays() + "/" + WINDOW_DAYS + " days of history - rates not evaluated yet");
        }

        double rejectionRate = rate(m.approvalRejections(), m.approvalsDecided());
        if (rejectionRate > 0.30) {
            return new Verdict(Action.DEMOTE_ONE_LEVEL, current.demote(), "APPROVAL_REJECTION_RATE",
                    String.format("%.0f%% of approvals were rejected over %d days (>30%%), was %s",
                            rejectionRate * 100, m.windowDays(), current));
        }

        double failureRate = rate(m.tasksFailed(), m.tasksCompleted() + m.tasksFailed());
        if (failureRate > 0.15) {
            return new Verdict(Action.DEMOTE_ONE_LEVEL, current.demote(), "TASK_FAILURE_RATE",
                    String.format("%.0f%% task failure rate over %d days (>15%%), was %s",
                            failureRate * 100, m.windowDays(), current));
        }

        if (m.humanCorrectionsInLastTask() >= 3) {
            return new Verdict(Action.FORCE_L0, AutonomyLevel.L0, "REPEATED_HUMAN_CORRECTION",
                    m.humanCorrectionsInLastTask() + " corrections on one task: pause and file an experience candidate");
        }

        if (m.dailyBudgetRatio() > 1.20) {
            return new Verdict(Action.DEMOTE_ONE_LEVEL, current.demote(), "BUDGET_OVERSPEND",
                    String.format("daily spend is %.0f%% of budget (>120%%), falling back to the local model",
                            m.dailyBudgetRatio() * 100));
        }

        return new Verdict(Action.KEEP, current, "WITHIN_THRESHOLDS",
                String.format("rejections %.0f%%, failures %.0f%%, spend %.0f%% of budget",
                        rejectionRate * 100, failureRate * 100, m.dailyBudgetRatio() * 100));
    }

    private static double rate(int numerator, int denominator) {
        return denominator == 0 ? 0d : (double) numerator / denominator;
    }

    /**
     * Kill-switch conditions that stop autonomous execution outright (04 §8.2).
     * Distinct from degradation: these are incident actions, not gradual trust loss.
     */
    public static boolean shouldHalt(int consecutiveFailedFixes) {
        return consecutiveFailedFixes >= 3;
    }

    /** Whether a fix has to go through shadow comparison before it may touch production (ADR-006). */
    public static boolean requiresShadowRun(CapabilityDescriptor cap) {
        return cap.sideEffect().mutates() && cap.riskClass() != null
                && (cap.riskClass().compareTo("R2") >= 0 || !cap.reversible());
    }
}