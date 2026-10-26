package com.fuao.harness.policy;

import java.time.Duration;
import java.time.Instant;

/**
 * One row of {@code harness_grant} (03 §2.1): a capability, bound to a scope, valid until a
 * deadline, issued by somebody. Grants stack - a grant from the position plus a temporary
 * grant from an approval - and the effective scope is their intersection, never their union.
 */
public record Grant(
        String grantId,
        String agentId,
        String capId,
        Scope scope,
        Instant grantedAt,
        Instant expiresAt,
        ActorRef grantedBy,
        String reason,
        Instant revokedAt,
        Status status) {

    public enum Status {
        ACTIVE,
        REVOKED,
        EXPIRED
    }

    public boolean isLiveAt(Instant now) {
        return status == Status.ACTIVE && revokedAt == null && now.isBefore(expiresAt);
    }

    /** Human-readable reason a grant is not live; {@code null} when it is. */
    public String deadReasonAt(Instant now) {
        if (status == Status.REVOKED || revokedAt != null) {
            return "grant revoked at " + revokedAt;
        }
        if (status == Status.EXPIRED || !now.isBefore(expiresAt)) {
            return "grant expired at " + expiresAt;
        }
        if (status != Status.ACTIVE) {
            return "grant status " + status;
        }
        return null;
    }

    public Grant revokedAt(Instant at) {
        return new Grant(grantId, agentId, capId, scope, grantedAt, expiresAt, grantedBy, reason, at, Status.REVOKED);
    }

    /**
     * Whether the grant outlives the platform-wide ceiling (01 §5.2: temporary escalation is
     * capped at 24h so that a forgotten grant cannot become permanent authority).
     */
    public boolean ttlCapViolated() {
        return Duration.between(grantedAt, expiresAt).compareTo(PolicyEngine.MAX_GRANT_TTL) > 0;
    }
}