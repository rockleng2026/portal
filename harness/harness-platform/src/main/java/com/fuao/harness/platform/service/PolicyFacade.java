package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.platform.repo.ApprovalRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.policy.AgentLookup;
import com.fuao.harness.policy.AutonomyLevel;
import com.fuao.harness.policy.CapabilityDescriptor;
import com.fuao.harness.policy.KillSwitchState;
import com.fuao.harness.policy.PolicyDecision;
import com.fuao.harness.policy.PolicyEngine;
import com.fuao.harness.policy.PolicyRequest;
import com.fuao.harness.policy.Scope;
import com.fuao.harness.protocol.event.ContentTrust;
import com.fuao.harness.protocol.json.Json;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import org.springframework.stereotype.Service;

/**
 * The one door into {@link PolicyEngine}: load the facts, ask, then persist whatever the answer
 * obliges us to do.
 *
 * <p>Two things happen after every decision, without exception:
 * <ol>
 *   <li>the decision is written to {@code harness_audit} - a denial is as auditable as an allow;</li>
 *   <li>if the answer is {@code REQUIRE_APPROVAL}, an approval row is opened, carrying scope, TTL,
 *       blast radius and rollback plan so a human is deciding on the same terms the machine saw.</li>
 * </ol>
 * A caller cannot "forget" step 2, which is how an escalation quietly turns into an execution.
 */
@Service
public class PolicyFacade {

    private final com.fuao.harness.platform.repo.AgentRepository agents;
    private final com.fuao.harness.platform.repo.CapabilityRepository capabilities;
    private final com.fuao.harness.platform.repo.KillSwitchRepository killSwitches;
    private final ApprovalService approvals;
    private final AuditService audit;
    private final AuthContext authContext;
    private final PolicyEngine engine = new PolicyEngine();

    public PolicyFacade(com.fuao.harness.platform.repo.AgentRepository agents,
                        com.fuao.harness.platform.repo.CapabilityRepository capabilities,
                        com.fuao.harness.platform.repo.KillSwitchRepository killSwitches,
                        ApprovalService approvals, AuditService audit, AuthContext authContext) {
        this.agents = agents;
        this.capabilities = capabilities;
        this.killSwitches = killSwitches;
        this.approvals = approvals;
        this.audit = audit;
        this.authContext = authContext;
    }

    public record CheckRequest(
            String agentId,
            String capKey,
            Scope requestedScope,
            ContentTrust contentTrust,
            Set<String> sourceRefs,
            String planId,
            int stepSeq) {
    }

    public record CheckResult(PolicyDecision decision, PolicyInputs.ApprovalRow approval) {
    }

    @SuppressWarnings("removal")
    public CheckResult check(CheckRequest request) {
        AgentLookup agent = agents.lookupForPolicy(request.agentId())
                .orElseThrow(() -> new AgentService.AgentNotFound("no such agent: " + request.agentId()));
        CapabilityDescriptor cap = capabilities.findByKey(request.capKey())
                .orElseThrow(() -> new IllegalArgumentException("unknown capability: " + request.capKey()));

        List<com.fuao.harness.policy.Grant> grants = new ArrayList<>();
        for (PolicyInputs.GrantRow row : capabilities.grantsFor(request.agentId(), cap.capId())) {
            grants.add(new com.fuao.harness.policy.Grant(
                    row.grantId(), row.agentId(), row.capId(), row.scope(), row.grantedAt(), row.expiresAt(),
                    com.fuao.harness.policy.ActorRef.parse(row.grantedBy()), row.reason(), row.revokedAt(),
                    com.fuao.harness.policy.Grant.Status.valueOf(row.status().toUpperCase(Locale.ROOT))));
        }

        KillSwitchState switches = killSwitches.activeState();

        PolicyRequest policyRequest = PolicyRequest.builder()
                .agent(agent.agentId(), agent.agentKey(), agent.name(), agent.state(), agent.autonomyLevel(),
                        agent.deptId())
                .capability(cap)
                .scope(request.requestedScope() == null ? Scope.UNBOUNDED : request.requestedScope())
                .content(request.contentTrust() == null ? ContentTrust.TRUSTED : request.contentTrust(),
                        request.sourceRefs())
                .requestedBy(authContext.current() == null
                        ? com.fuao.harness.policy.ActorRef.agent(agent.agentId())
                        : com.fuao.harness.policy.ActorRef.parse(authContext.current().actorId()))
                .plan(request.planId() == null ? "" : request.planId(), request.stepSeq())
                .build();

        PolicyDecision decision = engine.evaluate(policyRequest, grants, switches, Instant.now());
        String traceId = com.fuao.harness.protocol.Ids.newId();

        AuthenticatedClient actor = authContext.current() != null
                ? authContext.current()
                : AuthenticatedClient.system("policy-engine");

        Map<String, Object> evidence = Map.of(
                "agentKey", agent.agentKey(),
                "capKey", cap.capKey(),
                "capId", cap.capId(),
                "autonomyLevel", String.valueOf(agent.autonomyLevel().level()),
                "contentTrust", String.valueOf(request.contentTrust()),
                "grantCount", String.valueOf(grants.size()));

        switch (decision.outcome()) {
            case ALLOW -> audit.record(actor, traceId, "policy.allow", "capability", cap.capKey(), "allow",
                    decision.reasonCode(), decision.reason(), evidence);
            case DENY -> audit.record(actor, traceId, "policy.deny", "capability", cap.capKey(), "deny",
                    decision.reasonCode(), decision.reason(), evidence);
            case REQUIRE_APPROVAL -> {
                PolicyDecision.ApprovalRequest approvalRequest = decision.approvalRequest();
                audit.record(actor, traceId, "policy.require_approval", "capability", cap.capKey(),
                        "approval", decision.reasonCode(), decision.reason(),
                        Map.of("evidence", Json.canonical(evidence),
                                "approvalId", approvalRequest.approvalId(),
                                "requestedCapKey", approvalRequest.requestedCapKey()));
                approvals.open(approvalRequest);
                return new CheckResult(decision,
                        approvals.get(approvalRequest.approvalId()));
            }
            default -> throw new IllegalStateException("unreachable policy outcome");
        }
        return new CheckResult(decision, null);
    }

    public KillSwitchState killSwitchState() {
        return killSwitches.activeState();
    }

    public AgentLookup agentFor(String agentId) {
        return agents.lookupForPolicy(agentId).orElseThrow();
    }

    public AutonomyLevel levelOf(String agentId) {
        return agentFor(agentId).autonomyLevel();
    }
}