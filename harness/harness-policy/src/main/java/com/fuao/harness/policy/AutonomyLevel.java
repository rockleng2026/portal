package com.fuao.harness.policy;

/**
 * Autonomy levels (01 §5.3) - the single most important governance dial in the system.
 *
 * <p>The default is {@link #L0} and the interesting direction is <em>down</em>: a digital
 * employee loses autonomy automatically when its error rate rises (01 §14.4). Most systems
 * reward doing more work; here the failure response is explicitly "do less" (01 §14.4).
 */
public enum AutonomyLevel {

    /** Observe only: read and report, never write to any system. New hires and audit-only agents. */
    L0(0, "observe"),
    /** Suggest: produce proposals and drafts; a human executes them. */
    L1(1, "suggest"),
    /** Execute low risk: may write low-risk targets (own tickets, drafts, test environments). */
    L2(2, "execute_low"),
    /** Execute medium risk: may write production but must report afterwards, and it must be reversible. */
    L3(3, "execute_medium"),
    /** Execute high risk: irreversible writes (production DDL, outbound mail, money). Disabled by default. */
    L4(4, "execute_high");

    private final int level;
    private final String wireName;

    AutonomyLevel(int level, String wireName) {
        this.level = level;
        this.wireName = wireName;
    }

    public int level() {
        return level;
    }

    public String wireName() {
        return wireName;
    }

    public boolean atLeast(AutonomyLevel required) {
        return this.level >= required.level;
    }

    public static AutonomyLevel of(int level) {
        for (AutonomyLevel l : values()) {
            if (l.level == level) {
                return l;
            }
        }
        throw new IllegalArgumentException("unknown autonomy level: " + level);
    }

    /** One level down, floored at L0. Used by the degradation rules. */
    public AutonomyLevel demote() {
        return level == 0 ? L0 : of(level - 1);
    }

    public static AutonomyLevel fromWireName(String name) {
        for (AutonomyLevel l : values()) {
            if (l.wireName.equals(name) || l.name().equalsIgnoreCase(name)) {
                return l;
            }
        }
        throw new IllegalArgumentException("unknown autonomy level: " + name);
    }
}