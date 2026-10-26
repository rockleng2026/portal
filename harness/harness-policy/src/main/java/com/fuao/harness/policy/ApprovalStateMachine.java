package com.fuao.harness.policy;

import java.time.Instant;
import java.util.Map;
import java.util.Set;

/**
 * Approval lifecycle for privilege escalation (01 §6.2, 03 §2.3, red-team R-02).
 *
 * <p>Two invariants are enforced here and nowhere else, because they are the ones that keep
 * "the AI authorised itself" structurally impossible:
 * <ol>
 *   <li>only a natural human may decide - {@code decided_by} must be {@code human:*};</li>
 *   <li>the decider must not be in the requester's family - the requester's
 *       {@code ownerEmployeeId} may not approve their own agent's escalation.</li>
 * </ol>
 * Both are checked on every transition, so no caller can skip them by writing the table
 * directly with the wrong status.
 */
public final class ApprovalStateMachine {

    public enum State {
        PENDING,
        APPROVED,
        REJECTED,
        EXPIRED,
        USED;

        public String wire() {
            return name().toLowerCase(java.util.Locale.ROOT);
        }

        public static State fromWire(String s) {
            return State.valueOf(s.trim().toUpperCase(java.util.Locale.ROOT));
        }

        public boolean isTerminal() {
            return this != PENDING;
        }
    }

    /** What the approver is asked to sign: the request plus the context needed to judge it. */
    public record Request(
            String approvalId,
            String agentId,
            String agentKey,
            /** portal.employee.id of the agent's human owner - the requester's family. */
            int ownerEmployeeId,
            String requestedCapKey,
            Scope scope,
            int ttlSeconds,
            String riskClass,
            int blastRadius,
            String rollbackPlan,
            String justification,
            Instant createdAt,
            Instant expiresAt,
            PolicyDecision.ApproverScope approverScope) {
    }

    /** A decision on an approval. */
    public record Verdict(String approvalId, State state, ActorRef decidedBy, String note, Instant decidedAt,
                          String humanApproverEmployeeId) {
    }

    /** Raised instead of returning a value: an illegal transition is a bug or an attack. */
    public static final class IllegalTransitionException extends RuntimeException {
        public IllegalTransitionException(String message) {
            super(message);
        }
    }

    private ApprovalStateMachine() {
    }

    /** Legal transitions. Everything else is refused. */
    private static final Map<State, Set<State>> TRANSITIONS = Map.of(
            State.PENDING, Set.of(State.APPROVED, State.REJECTED, State.EXPIRED),
            State.APPROVED, Set.of(State.USED, State.EXPIRED),
            State.REJECTED, Set.of(),
            State.EXPIRED, Set.of(),
            State.USED, Set.of());

    public static Set<State> nextStates(State from) {
        return TRANSITIONS.getOrDefault(from, Set.of());
    }

    /**
     * Validates and returns the next state.
     *
     * @param desired either {@link State#APPROVED} or {@link State#REJECTED}
     * @throws IllegalTransitionException when the transition is illegal, the decider is not a
     *         human, or the decider is the requester's own family. Callers must let this
     *         propagate and roll back - never catch it and treat the approval as decided.
     */
    public static Verdict decide(Request request, State current, State desired,
                                 ActorRef decidedBy, String note, Instant now) {
        if (current != State.PENDING) {
            throw new IllegalTransitionException(
                    "approval " + request.approvalId() + " is " + current + " and can no longer be decided");
        }
        if (desired != State.APPROVED && desired != State.REJECTED) {
            throw new IllegalTransitionException("a human can only approve or reject, got " + desired);
        }
        if (!decidedBy.isHuman()) {
            throw new IllegalTransitionException(
                    "approval must be decided by a natural human, got " + decidedBy
                            + " - AI must not authorise itself (P2 / R-02)");
        }
        int deciderEmployeeId = decidedBy.employeeId();
        if (deciderEmployeeId == request.ownerEmployeeId()) {
            throw new IllegalTransitionException(
                    "employee " + deciderEmployeeId + " owns agent " + request.agentKey()
                            + " and may not decide its own escalation (no self-approval, R-02)");
        }

        // An approval that outlived its TTL cannot be revived by a late click.
        if (!now.isBefore(request.expiresAt())) {
            return new Verdict(request.approvalId(), State.EXPIRED, decidedBy,
                    note == null ? "expired without a decision" : note, now, String.valueOf(deciderEmployeeId));
        }
        return new Verdict(request.approvalId(), desired, decidedBy, note, now,
                String.valueOf(deciderEmployeeId));
    }

    /** Marks an approved escalation as spent, so one approval buys exactly one execution. */
    public static Verdict consume(Verdict approval, Instant now) {
        if (approval.state() != State.APPROVED) {
            throw new IllegalTransitionException("only an approved escalation can be consumed, got " + approval.state());
        }
        return new Verdict(approval.approvalId(), State.USED, approval.decidedBy(), approval.note(), now,
                approval.humanApproverEmployeeId());
    }

    /**
     * Dual approval (L4 / destructive): two <em>independent</em> humans. "Independent" means
     * different people and not the requester's family - the same rule, applied twice.
     */
    public static void assertDualApprovalComplete(Request request, Verdict... verdicts) {
        Set<Integer> approvers = new java.util.LinkedHashSet<>();
        for (Verdict v : verdicts) {
            if (v.state() != State.APPROVED) {
                throw new IllegalTransitionException("dual approval incomplete: one decision is " + v.state());
            }
            if (!v.decidedBy().isHuman()) {
                throw new IllegalTransitionException("dual approval requires natural humans, got " + v.decidedBy());
            }
            int id = v.decidedBy().employeeId();
            if (id == request.ownerEmployeeId()) {
                throw new IllegalTransitionException("agent owner " + id + " may not co-sign their own escalation");
            }
            approvers.add(id);
        }
        if (approvers.size() < 2) {
            throw new IllegalTransitionException(
                    "L4 escalation needs two different humans, got " + approvers.size() + ": " + approvers);
        }
    }
}