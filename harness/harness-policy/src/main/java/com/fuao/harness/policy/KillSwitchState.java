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
        TERMINAL;

        /** The wire name stored in {@code harness_killswitch.scope} (03 §2.4 / V2 DDL). */
        public String wire() {
            return switch (this) {
                case GLOBAL -> "global";
                case DEPT -> "dept";
                case AGENT -> "agent";
                case CAPABILITY -> "cap";
                case TERMINAL -> "terminal";
            };
        }

        /**
         * Reads a scope name leniently: the DDL says {@code cap}, the enum says
         * {@code CAPABILITY}, and both appear in operator tooling. Refusing one of them would
         * make the kill switch - the control that must work during an incident - fail on a
         * spelling.
         */
        public static Scope fromWire(String value) {
            String v = value == null ? "" : value.trim().toUpperCase(java.util.Locale.ROOT);
            return switch (v) {
                case "CAP", "CAPABILITY" -> CAPABILITY;
                case "GLOBAL" -> GLOBAL;
                case "DEPT", "DEPARTMENT" -> DEPT;
                case "AGENT" -> AGENT;
                case "TERMINAL" -> TERMINAL;
                default -> throw new IllegalArgumentException("unknown kill-switch scope: " + value);
            };
        }
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

    /**
     * The switch that actually governs this actor/capability, or {@code null} when clear.
     *
     * <p>The effective switch is the <em>most restrictive</em> one that matches, not the most
     * specific one. A global {@code HALT} is the platform's "stop everything" lever (04 §8.2) and
     * must not be defeated by a narrower {@code TO_L0}; conversely a narrow {@code HALT} must not
     * be diluted by a global {@code TO_L0}. When two matching switches are equally restrictive the
     * more specific scope wins, because it is the one an operator will recognise in the audit.
     */
    public Switch activeFor(String agentId, Integer deptId, String capKey, String terminalId) {
        Switch best = null;
        int bestRank = -1;
        for (Switch s : switches) {
            if (!matches(s, agentId, deptId, capKey, terminalId)) {
                continue;
            }
            int r = rank(s.scope());
            if (best == null
                    || restrictiveness(s.effect()) > restrictiveness(best.effect())
                    || (restrictiveness(s.effect()) == restrictiveness(best.effect()) && r > bestRank)) {
                best = s;
                bestRank = r;
            }
        }
        return best;
    }

    /** How much a switch takes away: a higher number is more restrictive. */
    private static int restrictiveness(Effect effect) {
        return switch (effect) {
            case TO_L0 -> 1;
            case STOP -> 2;
            case HALT -> 3;
        };
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

    /**
     * Parses {@code scope:scopeId:effect}, e.g. {@code agent:0198...:to_l0}.
     *
     * <p>The scope id of a capability switch is a cap_key, and a cap_key contains colons
     * ({@code cap:portal.mission.complete}). The format is therefore read from both ends: the
     * scope is the first token, the effect is after the <em>last</em> colon, and everything in
     * between is the scope id. A capability id that was written without its {@code cap:} prefix
     * gets it back, so both spellings reach the same switch.
     */
    public static Switch parse(String spec) {
        int first = spec.indexOf(':');
        int last = spec.lastIndexOf(':');
        if (first < 0 || last <= first || last == spec.length() - 1) {
            throw new IllegalArgumentException("expected scope:scopeId:effect, got " + spec);
        }
        Scope scope = Scope.fromWire(spec.substring(0, first));
        String scopeId = spec.substring(first + 1, last);
        Effect effect = Effect.valueOf(spec.substring(last + 1).trim().toUpperCase(java.util.Locale.ROOT));
        if (scope == Scope.CAPABILITY && !scopeId.startsWith("cap:")) {
            scopeId = "cap:" + scopeId;
        }
        return new Switch(scope, scopeId, effect);
    }
}