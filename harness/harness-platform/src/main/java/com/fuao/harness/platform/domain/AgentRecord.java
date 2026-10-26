package com.fuao.harness.platform.domain;

import java.time.Instant;

/** Row of {@code harness_agent} (03 §2.1) as the platform sees it. */
public record AgentRecord(
        String agentId,
        String agentKey,
        String name,
        AgentType agentType,
        String templateId,
        Integer portalEmployeeId,
        Integer portalUserId,
        Integer portalWorkpositionId,
        Integer deptId,
        Integer reportsTo,
        Integer ownerId,
        int autonomyLevel,
        String modelId,
        String localModel,
        AgentStatus status,
        Instant createdAt,
        Instant updatedAt) {

    public enum AgentType {
        SERVICE,
        MANAGEMENT,
        EXPERT,
        WORKER;

        public String wire() {
            return name().toLowerCase();
        }
    }

    public enum AgentStatus {
        DRAFT,
        ONBOARDING,
        ACTIVE,
        PAUSED,
        RETIRED;

        public String wire() {
            return name().toLowerCase();
        }

        public static AgentStatus fromWire(String s) {
            return AgentStatus.valueOf(s.toUpperCase());
        }
    }
}