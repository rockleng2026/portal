package com.fuao.harness.policy;

import java.time.Duration;
import java.time.Instant;

/**
 * The decision, plus everything an auditor needs to reconstruct why it was reached.
 *
 * <p>Three outcomes, never two: "deny" and "allow" would force the engine to answer the
 * question "who signs off on this?" with a guess. {@link Outcome#REQUIRE_APPROVAL} is that
 * question being asked out loud (01 §6.2).
 */
public record PolicyDecision(
        Outcome outcome,
        String reasonCode,
        String reason,
        Instant decidedAt,
        ApprovalRequest approvalRequest,
        EffectivePermission effectivePermission) {

    public enum Outcome {
        ALLOW,
        DENY,
        REQUIRE_APPROVAL
    }

    public boolean allowed() {
        return outcome == Outcome.ALLOW;
    }

    public boolean requiresApproval() {
        return outcome == Outcome.REQUIRE_APPROVAL;
    }

    public static PolicyDecision allow(String reasonCode, String reason, Instant at,
                                       EffectivePermission permission) {
        return new PolicyDecision(Outcome.ALLOW, reasonCode, reason, at, null, permission);
    }

    public static PolicyDecision deny(String reasonCode, String reason, Instant at) {
        return new PolicyDecision(Outcome.DENY, reasonCode, reason, at, null, null);
    }

    public static PolicyDecision requireApproval(String reasonCode, String reason, Instant at,
                                                ApprovalRequest request) {
        return new PolicyDecision(Outcome.REQUIRE_APPROVAL, reasonCode, reason, at, request, null);
    }

    /**
     * What the agent actually got: which grants backed the decision and how far their scopes
     * reach. {@code null} on denial.
     */
    public record EffectivePermission(String capKey, Scope scope, java.util.List<String> contributingGrantIds,
                                      Instant expiresAt) {
    }

    /**
     * A fully specified approval request. {@link PolicyEngine} emits this; the approval service
     * stores it and a human decides it. Rolling TTL policy in here keeps "temporary privilege
     * expires by itself" impossible to forget (01 §5.2).
     */
    public record ApprovalRequest(
            String approvalId,
            String agentId,
            String agentKey,
            String requestedCapKey,
            Scope scope,
            Duration ttl,
            String riskClass,
            int blastRadius,
            String rollbackPlan,
            String justification,
            Instant expiresAt,
            ApproverScope requiredApproverScope) {
    }

    /** Approver scope required by blast radius and risk class (01 §7.1, 03 §2.3). */
    public enum ApproverScope {
        /** blast radius 1, risk <= R2: the agent's department director. */
        DEPARTMENT_DIRECTOR,
        /** R3, or the target sits outside the agent's department: system administrator. */
        SYSTEM_ADMIN,
        /** R4 / destructive: two independent approvals, the second outside the requester's family. */
        DUAL_CISO
    }
}