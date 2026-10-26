package com.fuao.harness.platform.domain;

import com.fuao.harness.policy.CapabilityDescriptor;
import java.time.Instant;
import java.util.Map;

/** Rows the policy engine needs, flattened from harness tables. */
public final class PolicyInputs {

    private PolicyInputs() {
    }

    public record CapabilityRow(CapabilityDescriptor descriptor, Map<String, Object> inputSchema) {

        public static CapabilityRow of(CapabilityDescriptor d) {
            return new CapabilityRow(d, Map.of());
        }
    }

    public record GrantRow(
            String grantId,
            String agentId,
            String capId,
            com.fuao.harness.policy.Scope scope,
            Instant grantedAt,
            Instant expiresAt,
            String grantedBy,
            String reason,
            Instant revokedAt,
            String status) {
    }

    public record ApprovalRow(
            String approvalId,
            String issueId,
            String planId,
            String agentId,
            String requestedCap,
            com.fuao.harness.policy.Scope scope,
            int ttlSeconds,
            Instant expiresAt,
            String riskClass,
            int blastRadius,
            String rollbackPlan,
            String justification,
            String status,
            String decidedBy,
            Instant decidedAt,
            String decisionNote,
            Instant createdAt) {
    }

    public record TerminalRow(
            String terminalId,
            String deviceId,
            String os,
            String agentId,
            String bindType,
            Integer portalEmployeeId,
            String status,
            String agentVersion,
            Instant lastHeartbeat,
            Instant boundAt,
            Instant revokedAt) {
    }
}