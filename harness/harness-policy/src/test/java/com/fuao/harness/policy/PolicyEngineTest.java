package com.fuao.harness.policy;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fuao.harness.protocol.event.ContentTrust;
import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.Test;

class PolicyEngineTest {

    private static final Instant NOW = Instant.parse("2026-10-22T10:00:00Z");
    private static final String AGENT = "0198f0c2-0000-7000-8000-00000000aaaa";
    private static final String AGENT_KEY = "agent:leon:sales:sh001";

    private final PolicyEngine engine = new PolicyEngine();

    private CapabilityDescriptor capMissionComplete() {
        return new CapabilityDescriptor("cap-1", "cap:portal.mission.complete", "openapi",
                CapabilityDescriptor.SideEffect.WRITE, true, 1, false, 2, "R2", false,
                CapabilityDescriptor.ApprovalPolicy.AUTO, 30000, CapabilityDescriptor.Status.ACTIVE);
    }

    private CapabilityDescriptor capProductionDdl() {
        return CapabilityDescriptor.productionOf("cap-prod");
    }

    private Grant grant(String capId, Scope scope, Duration ttl) {
        return new Grant("grant-1", AGENT, capId, scope, NOW.minusSeconds(60), NOW.plus(ttl),
                ActorRef.human(100), "onboarding", null, Grant.Status.ACTIVE);
    }

    private PolicyRequest request(CapabilityDescriptor cap, AutonomyLevel level, Scope scope) {
        return PolicyRequest.builder()
                .agent(AGENT, AGENT_KEY, "leon", AgentState.ACTIVE, level, 91)
                .capability(cap)
                .scope(scope)
                .content(ContentTrust.TRUSTED, Set.of())
                .requestedBy(ActorRef.agent(AGENT))
                .plan("plan-1", 1)
                .build();
    }

    private PolicyDecision evaluate(PolicyRequest req, List<Grant> grants) {
        return engine.evaluate(req, grants, KillSwitchState.empty(), NOW);
    }

    // ---------------------------------------------------------------- happy path

    @Test
    void allowsAGroundedLowRiskWrite() {
        CapabilityDescriptor cap = capMissionComplete();
        PolicyRequest req = request(cap, AutonomyLevel.L2, Scope.ofDept(91));

        PolicyDecision d = evaluate(req, List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(2))));

        assertEquals(PolicyDecision.Outcome.ALLOW, d.outcome(), d.reason());
        assertEquals("GRANT_MATCHES", d.reasonCode());
        assertNotNull(d.effectivePermission());
        assertEquals(List.of("grant-1"), d.effectivePermission().contributingGrantIds());
    }

    // ---------------------------------------------------------------- the three layers

    @Test
    void layerCapabilityWithoutGrantIsDenied() {
        PolicyDecision d = evaluate(request(capMissionComplete(), AutonomyLevel.L2, Scope.ofDept(91)), List.of());
        assertEquals(PolicyDecision.Outcome.DENY, d.outcome());
        assertEquals("GRANT_MISSING", d.reasonCode());
    }

    @Test
    void layerScopeMustReachTheObject() {
        CapabilityDescriptor cap = capMissionComplete();
        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L2, Scope.ofDept(7)),
                List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(2))));
        assertEquals("SCOPE_NOT_COVERED", d.reasonCode());
    }

    @Test
    void aBoundedGrantNeverAuthorisesAWholeOrganisationAction() {
        CapabilityDescriptor cap = capMissionComplete();
        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L2, Scope.UNBOUNDED),
                List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(2))));
        assertEquals("SCOPE_NOT_COVERED", d.reasonCode());
    }

    @Test
    void stackingGrantsIntersectsRatherThanUnions() {
        CapabilityDescriptor cap = capMissionComplete();
        Grant a = new Grant("g-a", AGENT, cap.capId(), Scope.ofDept(91, 92), NOW.minusSeconds(60),
                NOW.plus(Duration.ofHours(2)), ActorRef.human(100), "position", null, Grant.Status.ACTIVE);
        Grant b = new Grant("g-b", AGENT, cap.capId(), Scope.ofDept(92, 93), NOW.minusSeconds(60),
                NOW.plus(Duration.ofHours(1)), ActorRef.human(100), "escalation", null, Grant.Status.ACTIVE);

        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L2, Scope.ofDept(92, 93)), List.of(a, b));

        assertTrue(d.allowed(), d.reason());
        assertEquals(Set.of(92), d.effectivePermission().scope().deptIds());
        assertEquals(NOW.plus(Duration.ofHours(1)), d.effectivePermission().expiresAt(),
                "the earliest expiry among contributing grants wins");
    }

    @Test
    void layerTtlExpiresWithoutAnybodyNoticing() {
        CapabilityDescriptor cap = capMissionComplete();
        Grant expired = new Grant("g", AGENT, cap.capId(), Scope.ofDept(91), NOW.minus(Duration.ofHours(3)),
                NOW.minusSeconds(1), ActorRef.human(100), "temp", null, Grant.Status.ACTIVE);

        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L2, Scope.ofDept(91)), List.of(expired));
        assertEquals("GRANT_MISSING", d.reasonCode());
        assertTrue(d.reason().contains("expired"));
    }

    @Test
    void aGrantLongerThanTheCeilingIsRejectedRatherThanTruncated() {
        CapabilityDescriptor cap = capMissionComplete();
        Grant tooLong = new Grant("g", AGENT, cap.capId(), Scope.ofDept(91), NOW,
                NOW.plus(Duration.ofHours(48)), ActorRef.human(100), "permanent", null, Grant.Status.ACTIVE);

        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L2, Scope.ofDept(91)), List.of(tooLong));
        assertEquals("GRANT_TTL_TOO_LONG", d.reasonCode());
        assertTrue(tooLong.ttlCapViolated());
    }

    // ---------------------------------------------------------------- autonomy

    @Test
    void autonomyLevelGatesTheCapability() {
        CapabilityDescriptor cap = capMissionComplete(); // needs L2
        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L1, Scope.ofDept(91)),
                List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(2))));
        assertEquals("AUTONOMY_TOO_LOW", d.reasonCode());
    }

    @Test
    void pausedAndRetiredAgentsAreStoppedRegardlessOfGrants() {
        for (AgentState status : List.of(AgentState.PAUSED,
                AgentState.RETIRED, AgentState.DRAFT,
                AgentState.ONBOARDING)) {
            PolicyRequest req = PolicyRequest.builder()
                    .agent(AGENT, AGENT_KEY, "leon", status, AutonomyLevel.L3, 91)
                    .capability(capMissionComplete())
                    .scope(Scope.ofDept(91))
                    .build();
            PolicyDecision d = evaluate(req, List.of(grant("cap-1", Scope.ofDept(91), Duration.ofHours(2))));
            assertEquals(PolicyDecision.Outcome.DENY, d.outcome(), status + " must not work");
        }
    }

    // ---------------------------------------------------------------- kill-switch

    @Test
    void globalKillSwitchStopsEverything() {
        PolicyRequest req = request(capMissionComplete(), AutonomyLevel.L2, Scope.ofDept(91));
        KillSwitchState ks = KillSwitchState.fromStrings(List.of("global:*:halt"));

        PolicyDecision d = engine.evaluate(req, List.of(grant("cap-1", Scope.ofDept(91), Duration.ofHours(2))), ks, NOW);
        assertEquals("KILL_SWITCH_HALT", d.reasonCode());
    }

    @Test
    void departmentKillSwitchDemotesToL0RatherThanHidingIt() {
        PolicyRequest req = request(capMissionComplete(), AutonomyLevel.L3, Scope.ofDept(91));
        KillSwitchState ks = KillSwitchState.fromStrings(List.of("dept:91:to_l0"));

        PolicyDecision d = engine.evaluate(req, List.of(grant("cap-1", Scope.ofDept(91), Duration.ofHours(2))), ks, NOW);
        assertEquals(PolicyDecision.Outcome.DENY, d.outcome());
        assertEquals("AUTONOMY_TOO_LOW", d.reasonCode(), "kill-switch forces the L0 floor, the reason stays explainable");
    }

    @Test
    void aKillSwitchOnAnotherDepartmentDoesNotApply() {
        PolicyRequest req = request(capMissionComplete(), AutonomyLevel.L2, Scope.ofDept(91));
        KillSwitchState ks = KillSwitchState.fromStrings(List.of("dept:7:to_l0"));

        PolicyDecision d = engine.evaluate(req, List.of(grant("cap-1", Scope.ofDept(91), Duration.ofHours(2))), ks, NOW);
        assertTrue(d.allowed(), d.reason());
    }

    @Test
    void aGlobalHaltIsNotDefeatedByANarrowerSwitch() {
        // "stop everything" must survive a narrower switch, whatever the narrower one says.
        // Before the fix the most specific switch won and a global halt was silently lost.
        PolicyRequest req = request(capMissionComplete(), AutonomyLevel.L2, Scope.ofDept(91));
        KillSwitchState ks = KillSwitchState.fromStrings(List.of("global:*:halt", "agent:" + AGENT + ":to_l0"));

        PolicyDecision d = engine.evaluate(req, List.of(grant("cap-1", Scope.ofDept(91), Duration.ofHours(2))), ks, NOW);
        assertEquals("KILL_SWITCH_HALT", d.reasonCode(), d.reason());
    }

    @Test
    void aGlobalDemotionIsNotDilutedByANarrowerSwitch() {
        PolicyRequest req = request(capMissionComplete(), AutonomyLevel.L3, Scope.ofDept(91));
        KillSwitchState ks = KillSwitchState.fromStrings(List.of("global:*:to_l0", "dept:91:to_l0"));

        PolicyDecision d = engine.evaluate(req, List.of(grant("cap-1", Scope.ofDept(91), Duration.ofHours(2))), ks, NOW);
        assertEquals(PolicyDecision.Outcome.DENY, d.outcome());
        assertEquals("AUTONOMY_TOO_LOW", d.reasonCode());
    }

    @Test
    void aNarrowHaltSurvivesAGlobalDemotion() {
        PolicyRequest req = request(capMissionComplete(), AutonomyLevel.L2, Scope.ofDept(91));
        KillSwitchState ks = KillSwitchState.fromStrings(List.of("global:*:to_l0", "cap:portal.mission.complete:halt"));

        PolicyDecision d = engine.evaluate(req, List.of(grant("cap-1", Scope.ofDept(91), Duration.ofHours(2))), ks, NOW);
        assertEquals("KILL_SWITCH_HALT", d.reasonCode());
    }

    // ---------------------------------------------------------------- approval

    @Test
    void l4IsNeverAutonomousAndAsksForDualApproval() {
        CapabilityDescriptor cap = capProductionDdl();
        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L4, Scope.ofDept(91)),
                List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(1))));

        assertEquals(PolicyDecision.Outcome.REQUIRE_APPROVAL, d.outcome());
        PolicyDecision.ApprovalRequest ar = d.approvalRequest();
        assertEquals(PolicyDecision.ApproverScope.DUAL_CISO, ar.requiredApproverScope());
        assertTrue(ar.ttl().compareTo(PolicyEngine.MAX_GRANT_TTL) <= 0);
        assertTrue(ar.rollbackPlan().contains("irreversible"));
        assertTrue(ar.justification().contains("cap-prod"));
    }

    @Test
    void anApprovalRequestAlwaysCarriesScopeTtlAndRollback() {
        CapabilityDescriptor cap = new CapabilityDescriptor("cap-x", "cap:cdn.restart", "cli",
                CapabilityDescriptor.SideEffect.EXEC, false, 50, true, 3, "R3", false,
                CapabilityDescriptor.ApprovalPolicy.HUMAN, 60000, CapabilityDescriptor.Status.ACTIVE);

        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L3, Scope.ofDept(7)),
                List.of(grant(cap.capId(), Scope.ofDept(7), Duration.ofHours(1))));

        assertEquals(PolicyDecision.Outcome.REQUIRE_APPROVAL, d.outcome());
        assertEquals(PolicyDecision.ApproverScope.SYSTEM_ADMIN, d.approvalRequest().requiredApproverScope());
        assertEquals(50, d.approvalRequest().blastRadius());
        assertFalse(d.approvalRequest().rollbackPlan().isBlank());
        assertNotNull(d.approvalRequest().approvalId());
        assertEquals(36, d.approvalRequest().approvalId().length(),
                "approval ids are stored bare in CHAR(36) columns; the appr: prefix is display only (E-08)");
    }

    // ---------------------------------------------------------------- prompt injection

    @Test
    void untrustedArgumentsWithoutASourceReferenceAreRefused() {
        CapabilityDescriptor cap = capMissionComplete();
        PolicyRequest req = PolicyRequest.builder()
                .agent(AGENT, AGENT_KEY, "leon", AgentState.ACTIVE, AutonomyLevel.L2, 91)
                .capability(cap)
                .scope(Scope.ofDept(91))
                .content(ContentTrust.UNTRUSTED, Set.of())      // e.g. taken from a mail body
                .requestedBy(ActorRef.human(100))
                .build();

        PolicyDecision d = evaluate(req, List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(2))));
        assertEquals("UNTRUSTED_CONTENT_WITHOUT_REF", d.reasonCode());
    }

    @Test
    void untrustedArgumentsAreFineWhenTheyCiteTheirSource() {
        CapabilityDescriptor cap = capMissionComplete();
        PolicyRequest req = PolicyRequest.builder()
                .agent(AGENT, AGENT_KEY, "leon", AgentState.ACTIVE, AutonomyLevel.L2, 91)
                .capability(cap)
                .scope(Scope.ofDept(91))
                .content(ContentTrust.UNTRUSTED, Set.of("portal:message:88213"))
                .requestedBy(ActorRef.human(100))
                .build();

        assertTrue(evaluate(req, List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(2)))).allowed());
    }

    // ---------------------------------------------------------------- capability state

    @Test
    void aKillSwitchedCapabilityIsRefusedEvenWithAValidGrant() {
        CapabilityDescriptor cap = new CapabilityDescriptor("cap-1", "cap:portal.mission.complete", "openapi",
                CapabilityDescriptor.SideEffect.WRITE, true, 1, false, 2, "R2", false,
                CapabilityDescriptor.ApprovalPolicy.AUTO, 30000, CapabilityDescriptor.Status.KILL_SWITCHED);

        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L2, Scope.ofDept(91)),
                List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(2))));
        assertEquals("CAPABILITY_KILL_SWITCHED", d.reasonCode());
    }

    // ---------------------------------------------------------------- regressions

    @Test
    void aRequestedScopeCannotWidenTheGrantsRowFilter() {
        // The request is the attacker-controlled side. It must not be able to replace the
        // grant's constraint with a looser one.
        CapabilityDescriptor cap = capMissionComplete();
        Scope granted = new Scope(java.util.Set.of(91), java.util.Map.of("owner", "me"), "dept:91-only");
        Scope asked = new Scope(java.util.Set.of(91), java.util.Map.of("owner", "everyone"), "ALL");
        Grant g = new Grant("grant-1", AGENT, cap.capId(), granted, NOW.minusSeconds(60),
                NOW.plusSeconds(3600), ActorRef.human(100), "onboarding", null, Grant.Status.ACTIVE);

        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L2, asked), List.of(g));
        assertEquals("SCOPE_NOT_COVERED", d.reasonCode(),
                "a request that contradicts the grant's row filter must not be authorised");
    }

    @Test
    void aBlankSourceReferenceIsNotAReference() {
        CapabilityDescriptor cap = capMissionComplete();
        PolicyRequest req = PolicyRequest.builder()
                .agent(AGENT, AGENT_KEY, "leon", AgentState.ACTIVE, AutonomyLevel.L2, 91)
                .capability(cap)
                .scope(Scope.ofDept(91))
                .content(ContentTrust.UNTRUSTED, Set.of("   "))
                .requestedBy(ActorRef.human(100))
                .build();

        PolicyDecision d = evaluate(req, List.of(grant(cap.capId(), Scope.ofDept(91), Duration.ofHours(2))));
        assertEquals("UNTRUSTED_CONTENT_WITHOUT_REF", d.reasonCode());
    }

    @Test
    void anotherAgentsGrantIsNotThisAgentsGrant() {
        CapabilityDescriptor cap = capMissionComplete();
        Grant foreign = new Grant("grant-x", "0198f0c2-0000-7000-8000-00000000bbbb", cap.capId(),
                Scope.ofDept(91), NOW.minusSeconds(60), NOW.plusSeconds(3600),
                ActorRef.human(100), "onboarding", null, Grant.Status.ACTIVE);

        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L2, Scope.ofDept(91)), List.of(foreign));
        assertEquals("GRANT_MISSING", d.reasonCode());
    }

    @Test
    void aMissingGrantIsReportedBeforeTheAutonomyLevel() {
        // 03 §6.3 puts the grant check first: "you hold nothing" is the first permission
        // question, and the capability's min_level is not the answer to it.
        CapabilityDescriptor cap = capMissionComplete();
        PolicyDecision d = evaluate(request(cap, AutonomyLevel.L0, Scope.ofDept(91)), List.of());
        assertEquals("GRANT_MISSING", d.reasonCode());
    }
}