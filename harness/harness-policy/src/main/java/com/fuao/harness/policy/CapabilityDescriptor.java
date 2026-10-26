package com.fuao.harness.policy;

import java.time.Instant;

/**
 * A capability as registered in {@code harness_capability} (03 §2.1), flattened into the
 * fields the policy engine actually reasons about.
 *
 * <p>{@code minLevel} and {@code requiresHuman} are not advisory: they are the mechanical
 * consequence of "what this tool does", and they are what lets a terminal refuse a command
 * locally even when the edge says yes.
 */
public record CapabilityDescriptor(
        String capId,
        String capKey,
        String kind,
        SideEffect sideEffect,
        boolean reversible,
        int blastRadius,
        boolean requiresHuman,
        int minLevel,
        String riskClass,
        boolean destructive,
        ApprovalPolicy approvalPolicy,
        int timeoutMs,
        Status status) {

    public enum SideEffect {
        READ,
        WRITE,
        EXEC,
        IRREVERSIBLE;

        public static SideEffect of(String s) {
            return switch (s) {
                case "read" -> READ;
                case "write" -> WRITE;
                case "exec" -> EXEC;
                case "irreversible" -> IRREVERSIBLE;
                default -> throw new IllegalArgumentException("unknown side effect: " + s);
            };
        }

        public boolean mutates() {
            return this != READ;
        }
    }

    public enum ApprovalPolicy {
        /** No human involvement needed beyond the existing grant. */
        AUTO,
        /** One human approval. */
        HUMAN,
        /** Two independent human approvals (L4 / destructive). */
        DUAL;

        public static ApprovalPolicy of(String s) {
            return switch (s) {
                case "auto" -> AUTO;
                case "human" -> HUMAN;
                case "dual" -> DUAL;
                default -> throw new IllegalArgumentException("unknown approval policy: " + s);
            };
        }
    }

    public enum Status {
        ACTIVE,
        DISABLED,
        KILL_SWITCHED
    }

    public AutonomyLevel minAutonomyLevel() {
        return AutonomyLevel.of(minLevel);
    }

    public static CapabilityDescriptor readOnly(String capId, String capKey) {
        return new CapabilityDescriptor(capId, capKey, "internal", SideEffect.READ, true, 1, false,
                0, "R0", false, ApprovalPolicy.AUTO, 60000, Status.ACTIVE);
    }

    public static CapabilityDescriptor of(String capId, String capKey, SideEffect sideEffect, int minLevel) {
        return new CapabilityDescriptor(capId, capKey, "internal", sideEffect, sideEffect != SideEffect.IRREVERSIBLE,
                1, sideEffect.mutates() && minLevel >= 3, minLevel,
                minLevel >= 4 ? "R4" : minLevel >= 3 ? "R3" : "R2",
                sideEffect == SideEffect.IRREVERSIBLE,
                minLevel >= 4 ? ApprovalPolicy.DUAL : ApprovalPolicy.AUTO,
                60000, Status.ACTIVE);
    }

    public static CapabilityDescriptor productionOf(String id) {
        return new CapabilityDescriptor(id, id, "internal", SideEffect.IRREVERSIBLE, false, 1000, true,
                4, "R4", true, ApprovalPolicy.DUAL, 600000, Status.ACTIVE);
    }
}