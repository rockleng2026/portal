package com.fuao.harness.policy;

import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * The governance core: {@code capability ∩ scope ∩ TTL} (01 §5.2), evaluated in a fixed order.
 *
 * <p>Check order is part of the contract. The first three checks are platform-availability
 * checks (kill-switch, agent state, capability state) and must run before anything that
 * touches the database or the clock-heavy TTL logic, because they are the checks that must
 * work during an incident. Everything after them is the permission conversation with the
 * organisation.
 *
 * <p>What this class deliberately does <b>not</b> do: it does not decide whether an approval
 * request is <em>justified</em>, only that one is required. That judgement belongs to the
 * management-state agent and the human (01 §6.2).
 */
public final class PolicyEngine {

    /** Maximum TTL any single grant may carry (01 §5.2, 03 §5). */
    public static final Duration MAX_GRANT_TTL = Duration.ofHours(24);

    /** Risk class at or above which blast radius forces system-administrator approval. */
    public static final String HIGH_RISK_CLASS = "R3";
    public static final String CRITICAL_RISK_CLASS = "R4";

    public PolicyDecision evaluate(PolicyRequest req,
                                   List<Grant> grants,
                                   KillSwitchState killSwitch,
                                   Instant now) {
        Objects.requireNonNull(req, "request");
        Objects.requireNonNull(now, "now");
        if (grants == null) {
            grants = List.of();
        }
        if (killSwitch == null) {
            killSwitch = KillSwitchState.empty();
        }
        CapabilityDescriptor cap = req.capability();
        if (cap == null) {
            return PolicyDecision.deny("CAPABILITY_UNKNOWN", "no capability descriptor supplied", now);
        }
        if (req.autonomyLevel() == null) {
            req = withLevel(req, AutonomyLevel.L0);
        }
        if (req.agentState() == null) {
            return PolicyDecision.deny("AGENT_NOT_ACTIVE", "no agent state supplied", now);
        }

        // -- 1. kill-switch -------------------------------------------------------
        KillSwitchState.Switch sw = killSwitch.activeFor(req.agentId(), req.deptId(), cap.capKey(), req.terminalId());
        if (sw != null) {
            String detail = "kill-switch " + sw.scope() + ":" + sw.scopeId() + " -> " + sw.effect();
            if (sw.effect() == KillSwitchState.Effect.HALT) {
                return PolicyDecision.deny("KILL_SWITCH_HALT", detail, now);
            }
            // STOP / TO_L0 are not blanket denials: the engine keeps evaluating so that the
            // decision is explainable, but it forces the L0 floor for the rest of the chain.
            if (req.autonomyLevel().level() > AutonomyLevel.L0.level()) {
                req = withLevel(req, AutonomyLevel.L0);
            }
        }

        // -- 2. agent state -------------------------------------------------------
        if (req.agentState() == AgentState.RETIRED) {
            return PolicyDecision.deny("AGENT_RETIRED",
                    "agent " + req.agentKey() + " is retired; hand over before any further work", now);
        }
        if (req.agentState() == AgentState.PAUSED) {
            return PolicyDecision.deny("AGENT_PAUSED", "agent " + req.agentKey() + " is paused", now);
        }
        if (!req.agentState().canWork()) {
            return PolicyDecision.deny("AGENT_NOT_ACTIVE",
                    "agent " + req.agentKey() + " is " + req.agentState() + " (M0 agents observe only)", now);
        }

        // -- 3. capability state --------------------------------------------------
        if (cap.status() == CapabilityDescriptor.Status.KILL_SWITCHED) {
            return PolicyDecision.deny("CAPABILITY_KILL_SWITCHED", "capability " + cap.capKey() + " is switched off", now);
        }
        if (cap.status() == CapabilityDescriptor.Status.DISABLED) {
            return PolicyDecision.deny("CAPABILITY_DISABLED", "capability " + cap.capKey() + " is disabled", now);
        }

        // -- 4. grant must exist and be live ------------------------------------
        // 03 §6.3 ①: the grant check comes before the autonomy check - "you have no grant" is
        // the first permission question, and answering it with "your level is too low" leaks the
        // capability's min_level to a caller that holds nothing.
        List<Grant> live = new ArrayList<>();
        List<String> deadReasons = new ArrayList<>();
        for (Grant g : grants) {
            if (!cap.capId().equals(g.capId())) {
                continue;
            }
            if (g.agentId() != null && req.agentId() != null && !g.agentId().equals(req.agentId())) {
                // A grant belongs to one agent. Another agent's grant is not a grant for this one.
                deadReasons.add("grant " + g.grantId() + " belongs to agent " + g.agentId());
                continue;
            }
            String deadReason = g.deadReasonAt(now);
            if (deadReason == null) {
                live.add(g);
            } else {
                deadReasons.add(deadReason);
            }
        }
        if (live.isEmpty()) {
            String why = deadReasons.isEmpty()
                    ? "no grant exists"
                    : "all " + deadReasons.size() + " grant(s) are unusable: " + deadReasons.get(0);
            return PolicyDecision.deny("GRANT_MISSING", cap.capKey() + ": " + why, now);
        }
        // A grant longer than the ceiling is a caller bug, not something to silently shorten.
        live.removeIf(Grant::ttlCapViolated);
        if (live.isEmpty()) {
            return PolicyDecision.deny("GRANT_TTL_TOO_LONG",
                    cap.capKey() + ": every grant exceeds the " + MAX_GRANT_TTL.toHours() + "h ceiling", now);
        }

        // -- 5. scope must cover the object --------------------------------------
        Scope effectiveScope = null;
        List<String> contributing = new ArrayList<>();
        Instant expiresAt = null;
        Scope requested = req.requestedScope() == null ? Scope.UNBOUNDED : req.requestedScope();
        for (Grant g : live) {
            Scope narrowed = g.scope().intersect(requested);
            if (narrowed == null) {
                continue;
            }
            if (effectiveScope == null) {
                effectiveScope = narrowed;
                contributing.add(g.grantId());
                expiresAt = g.expiresAt();
            } else {
                Scope merged = effectiveScope.intersect(narrowed);
                if (merged != null) {
                    effectiveScope = merged;
                    contributing.add(g.grantId());
                    if (expiresAt == null || g.expiresAt().isBefore(expiresAt)) {
                        expiresAt = g.expiresAt();
                    }
                }
            }
        }
        if (effectiveScope == null) {
            return PolicyDecision.deny("SCOPE_NOT_COVERED",
                    cap.capKey() + ": grant scope " + describe(live.get(0).scope())
                            + " does not reach " + describe(requested), now);
        }

        PolicyDecision.EffectivePermission permission =
                new PolicyDecision.EffectivePermission(cap.capKey(), effectiveScope, contributing, expiresAt);

        // -- 6. autonomy level ---------------------------------------------------
        // 03 §6.3 ②, after the grant conversation of ①.
        AutonomyLevel effectiveLevel = sw != null ? AutonomyLevel.L0 : req.autonomyLevel();
        if (effectiveLevel.level() < cap.minLevel()) {
            return PolicyDecision.deny("AUTONOMY_TOO_LOW",
                    cap.capKey() + " needs " + cap.minAutonomyLevel() + ", agent " + req.agentKey()
                            + " is at " + effectiveLevel, now);
        }

        // -- 7. untrusted content must be traceable -------------------------------
        // ADR-011 / red-team R-03: data read from a mail, chat or document may become a fact
        // but never a tool argument unless the argument carries a reference back to it.
        // A blank reference is not a reference: the check is on the content of the citation, not
        // on the presence of a string.
        if (!req.contentTrust().isTrusted() && !req.untrustedSourcesWithoutRefs().isEmpty()) {
            return PolicyDecision.deny("UNTRUSTED_CONTENT_WITHOUT_REF",
                    "arguments derived from " + req.contentTrust() + " content must cite a source_ref", now);
        }

        // -- 8. approval policy ---------------------------------------------------
        // 03 §6.3 ③. Note the deliberate deviation from the document's ordering: the
        // source-reference check (⑤) runs before this one, because refusing untraceable
        // arguments is strictly stronger than routing them to a human.
        boolean escalates = cap.approvalPolicy() == CapabilityDescriptor.ApprovalPolicy.HUMAN
                || cap.approvalPolicy() == CapabilityDescriptor.ApprovalPolicy.DUAL
                || cap.requiresHuman()
                || (cap.sideEffect().mutates() && effectiveLevel == AutonomyLevel.L3
                    && !cap.reversible())
                || effectiveLevel == AutonomyLevel.L4;
        if (!escalates) {
            return PolicyDecision.allow("GRANT_MATCHES",
                    cap.capKey() + " granted at " + effectiveLevel + " within " + describe(effectiveScope), now, permission);
        }

        PolicyDecision.ApprovalRequest approvalRequest = buildApprovalRequest(req, cap, effectiveScope, now);
        return PolicyDecision.requireApproval("APPROVAL_REQUIRED",
                approvalRequiredReason(cap, effectiveLevel), now, approvalRequest);
    }

    // ------------------------------------------------------------------ helpers

    /**
     * Returns a copy of the request with the autonomy level forced down.
     *
     * <p>Used by the kill-switch: a switch that demotes to L0 does not change what the agent
     * asked for, only what it is allowed to ask for. TTL policy lives in {@link Grant} and in
     * {@link #MAX_GRANT_TTL}; nothing here shortens a grant.
     */
    private static PolicyRequest withLevel(PolicyRequest req, AutonomyLevel level) {
        return new PolicyRequest(req.agentId(), req.agentKey(), req.agentName(), req.agentState(), level,
                req.deptId(), req.terminalId(), req.capability(), req.requestedScope(), req.contentTrust(),
                req.sourceRefs(), req.requestedBy(), req.planId(), req.stepSeq());
    }

    private PolicyDecision.ApprovalRequest buildApprovalRequest(PolicyRequest req,
                                                                CapabilityDescriptor cap,
                                                                Scope scope,
                                                                Instant now) {
        Duration ttl = MAX_GRANT_TTL;
        PolicyDecision.ApproverScope approverScope = requiredApproverScope(cap, scope, req.deptId());
        if (approverScope == PolicyDecision.ApproverScope.DUAL_CISO) {
            ttl = Duration.ofHours(4);
        }
        String justification = cap.capKey() + " requires " + cap.approvalPolicy() + " approval (risk "
                + cap.riskClass() + ", blast radius " + cap.blastRadius() + ", reversible=" + cap.reversible()
                + "); requested by " + req.agentKey() + " at level " + req.autonomyLevel()
                + " for scope " + describe(scope);
        return new PolicyDecision.ApprovalRequest(
                com.fuao.harness.protocol.Ids.newId(),
                req.agentId(),
                req.agentKey(),
                cap.capKey(),
                scope,
                ttl,
                cap.riskClass(),
                cap.blastRadius(),
                rollbackHint(cap),
                justification,
                now.plus(ttl),
                approverScope);
    }

    private static String rollbackHint(CapabilityDescriptor cap) {
        if (!cap.reversible() || cap.destructive()) {
            return "irreversible: no rollback possible - back up first, then execute, then file an incident report";
        }
        return "revert via the shadow diff recorded in harness_action.result and re-run the previous plan version";
    }

    /** Approver scope follows impact radius, not the identity of the requester (01 §7.1). */
    public static PolicyDecision.ApproverScope requiredApproverScope(CapabilityDescriptor cap, Scope scope,
                                                                     Integer agentDeptId) {
        boolean irreversible = cap.sideEffect() == CapabilityDescriptor.SideEffect.IRREVERSIBLE
                || cap.destructive()
                || CRITICAL_RISK_CLASS.equals(cap.riskClass());
        if (irreversible) {
            return PolicyDecision.ApproverScope.DUAL_CISO;
        }
        boolean outsideOwnDept = scope != null && scope.deptIds() != null && agentDeptId != null
                && scope.deptIds().stream().noneMatch(d -> d.intValue() == agentDeptId.intValue());
        if (HIGH_RISK_CLASS.equals(cap.riskClass()) || outsideOwnDept) {
            return PolicyDecision.ApproverScope.SYSTEM_ADMIN;
        }
        return PolicyDecision.ApproverScope.DEPARTMENT_DIRECTOR;
    }

    private static String approvalRequiredReason(CapabilityDescriptor cap, AutonomyLevel level) {
        return "capability policy " + cap.approvalPolicy() + " / requiresHuman=" + cap.requiresHuman()
                + " at level " + level + " for " + cap.capKey();
    }

    static String describe(Scope s) {
        if (s == null) {
            return "null";
        }
        if (s.isUnbounded()) {
            return "{whole organisation}";
        }
        return s.toMap().toString();
    }
}