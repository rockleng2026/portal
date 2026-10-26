package com.fuao.harness.policy;

import java.util.Collection;
import java.util.List;

/**
 * Kill-switch state (04 §8.2). Five granularities, and they compose by most-specific-wins:
 * a global switch means everything is L0 no matter what the others say.
 *
 * <p>Read from a cache by the policy engine on every decision, so the whole platform can be
 * frozen in one write.
 */
public record KillSwitchState(List<Switch> switches) {

    public record Switch(Scope scope, String scopeId, Effect effect) {
    }

    public enum Scope {
        GLOBAL,
        DEPT,
        AGENT,
        CAPABILITY,
        TERMINAL
    }

    public enum Effect {
        /** Demote to L0: the agent may still read and report. */
        TO_L0,
        /** Stop autonomous execution but keep reporting. */
        STOP,
        /** Halt: no commands at all, terminal keeps only heartbeat. */
        HALT
    }

    public static KillSwitchState empty() {
        return new KillSwitchState(List.of());
    }

    public static KillSwitchState of(Switch... switches) {
        return new KillSwitchState(List.of(switches));
    }

    /** Most specific switch affecting this actor/capability, or {@code null} when clear. */
    public Switch activeFor(String agentId, Integer deptId, String capKey, String terminalId) {
        Switch global = null;
        Switch mostSpecific = null;
        int rank = -1;
        for (Switch s : switches) {
            if (!matches(s, agentId, deptId, capKey, terminalId)) {
                continue;
            }
            if (s.scope() == Scope.GLOBAL) {
                global = s;
                continue;
            }
            int r = rank(s.scope());
            if (r > rank) {
                rank = r;
                mostSpecific = s;
            }
        }
        return mostSpecific != null ? mostSpecific : global;
    }

    public boolean halted(String agentId, Integer deptId, String capKey, String terminalId) {
        Switch s = activeFor(agentId, deptId, capKey, terminalId);
        return s != null && s.effect() == Effect.HALT;
    }

    private static boolean matches(Switch s, String agentId, Integer deptId, String capKey, String terminalId) {
        return switch (s.scope()) {
            case GLOBAL -> true;
            case AGENT -> agentId != null && agentId.equals(s.scopeId());
            case DEPT -> deptId != null && String.valueOf(deptId).equals(s.scopeId());
            case CAPABILITY -> capKey != null && capKey.equals(s.scopeId());
            case TERMINAL -> terminalId != null && terminalId.equals(s.scopeId());
        };
    }

    private static int rank(Scope s) {
        return switch (s) {
            case GLOBAL -> 0;
            case DEPT -> 1;
            case AGENT -> 2;
            case TERMINAL -> 3;
            case CAPABILITY -> 4;
        };
    }

    public static KillSwitchState fromStrings(Collection<String> specs) {
        return new KillSwitchState(specs.stream().map(KillSwitchState::parse).toList());
    }

    /** Parses {@code scope:scopeId:effect}, e.g. {@code agent:0198...:to_l0}. */
    public static Switch parse(String spec) {
        String[] parts = spec.split(":", 3);
        if (parts.length != 3) {
            throw new IllegalArgumentException("expected scope:scopeId:effect, got " + spec);
        }
        Scope scope = Scope.valueOf(parts[0].toUpperCase());
        Effect effect = Effect.valueOf(parts[2].toUpperCase());
        return new Switch(scope, parts[1], effect);
    }
}