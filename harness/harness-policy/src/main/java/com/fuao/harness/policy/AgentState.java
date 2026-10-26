package com.fuao.harness.policy;

import java.util.Locale;

/**
 * Lifecycle state of a digital employee (01 §5.1).
 *
 * <p>{@link #ACTIVE} is the only state in which any capability call is considered; the rest are
 * administrative. This mirrors {@code harness_agent.status} but lives here so the policy module
 * stays independent of the persistence model.
 */
public enum AgentState {

    /** Created, not yet onboarded into the portal organisation. */
    DRAFT,
    /** Written into portal as a real employee, not yet granted working capabilities. */
    ONBOARDING,
    /** On duty. */
    ACTIVE,
    /** Temporarily stopped by an operator or by the degradation rules (01 §14.4). */
    PAUSED,
    /** Offboarded; permissions reclaimed, experience archived (01 §15.3). */
    RETIRED;

    public String wire() {
        return name().toLowerCase(Locale.ROOT);
    }

    public boolean canWork() {
        return this == ACTIVE;
    }

    public static AgentState fromWire(String s) {
        return AgentState.valueOf(s.trim().toUpperCase(Locale.ROOT));
    }
}