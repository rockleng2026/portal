package com.fuao.harness.policy;

/**
 * Who is asking (01 §5.1, 03 §9, 03 §5).
 *
 * <p>The type matters more than the id. Two invariants in this codebase depend on it:
 * <ul>
 *   <li>only {@link Type#HUMAN} can decide an approval - "AI must not authorise itself" (P2 / R-02);</li>
 *   <li>the decider of an approval must not be in the same family as the requester's owner
 *       (01 §0, 03 §2.3: 同源禁止).</li>
 * </ul>
 * Human ids are written {@code human:<portal_employee_id>} because the platform needs to prove
 * a natural person was involved, and "the string starts with human:" is the cheapest possible
 * proof that survives a database dump.
 */
public record ActorRef(Type type, String id) {

    public enum Type {
        HUMAN("human"),
        AGENT("agent"),
        TERMINAL("terminal"),
        SYSTEM("system");

        private final String prefix;

        Type(String prefix) {
            this.prefix = prefix;
        }

        public String prefix() {
            return prefix;
        }

        static Type fromPrefix(String prefix) {
            for (Type t : values()) {
                if (t.prefix.equals(prefix)) {
                    return t;
                }
            }
            throw new IllegalArgumentException("unknown actor type prefix: " + prefix);
        }
    }

    public ActorRef {
        if (type == null || id == null || id.isBlank()) {
            throw new IllegalArgumentException("actor type and id are required");
        }
        int colon = id.indexOf(':');
        if (colon <= 0) {
            throw new IllegalArgumentException("actor id must be prefixed, got: " + id);
        }
        Type declared = Type.fromPrefix(id.substring(0, colon));
        if (declared != type) {
            throw new IllegalArgumentException("actor id prefix '" + declared + "' does not match type " + type);
        }
    }

    public static ActorRef human(int portalEmployeeId) {
        return new ActorRef(Type.HUMAN, Type.HUMAN.prefix() + ":" + portalEmployeeId);
    }

    public static ActorRef humanRef(String raw) {
        return parse(raw);
    }

    public static ActorRef agent(String agentId) {
        return new ActorRef(Type.AGENT, Type.AGENT.prefix() + ":" + agentId);
    }

    public static ActorRef terminal(String terminalId) {
        return new ActorRef(Type.TERMINAL, Type.TERMINAL.prefix() + ":" + terminalId);
    }

    public static ActorRef system(String code) {
        return new ActorRef(Type.SYSTEM, Type.SYSTEM.prefix() + ":" + code);
    }

    public static ActorRef parse(String raw) {
        int colon = raw.indexOf(':');
        if (colon <= 0) {
            throw new IllegalArgumentException("unprefixed actor id: " + raw);
        }
        return new ActorRef(Type.fromPrefix(raw.substring(0, colon)), raw);
    }

    public boolean isHuman() {
        return type == Type.HUMAN;
    }

    /** Portal employee id of a human actor; -1 for anything else. */
    public int employeeId() {
        if (!isHuman()) {
            return -1;
        }
        return Integer.parseInt(id.substring(id.indexOf(':') + 1));
    }

    /** Same reporting family as this actor's owner (used for the no-self-approval rule). */
    public boolean sameFamilyAs(ActorRef other) {
        return other != null && other.type == Type.HUMAN && isHuman() && other.employeeId() == employeeId();
    }
}