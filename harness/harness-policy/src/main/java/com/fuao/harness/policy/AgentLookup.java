package com.fuao.harness.policy;

/**
 * The agent facts the policy engine needs, as read from {@code harness_agent}.
 *
 * <p>Lives in the policy module so that every caller (REST, event router, terminal command
 * path) hands the engine the same projection - there is no second, looser code path into the
 * governance decisions.
 */
public record AgentLookup(
        String agentId,
        String agentKey,
        String name,
        Integer deptId,
        AutonomyLevel autonomyLevel,
        AgentState state,
        int ownerEmployeeId) {
}