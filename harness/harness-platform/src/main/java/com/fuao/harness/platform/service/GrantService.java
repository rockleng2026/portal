package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.platform.repo.AgentRepository;
import com.fuao.harness.platform.repo.AuditRepository;
import com.fuao.harness.platform.repo.CapabilityRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.policy.CapabilityDescriptor;
import com.fuao.harness.policy.Grant;
import com.fuao.harness.policy.PolicyEngine;
import com.fuao.harness.policy.Scope;
import com.fuao.harness.protocol.Ids;
import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Capability grants: the write side of {@code capability ∩ scope ∩ TTL} (01 §5.2).
 *
 * <p>A grant can only be issued for an agent a human is responsible for. That is not
 * bureaucracy: a grant is the raw material of both an action and an escalation, so the ability
 * to mint grants must not be reachable by a service account (P2 / R-02).
 */
@Service
public class GrantService {

    private final CapabilityRepository capabilities;
    private final AgentRepository agents;
    private final AuditRepository auditRepository;
    private final AuditService audit;
    private final AuthContext authContext;

    public GrantService(CapabilityRepository capabilities, AgentRepository agents,
                        AuditRepository auditRepository, AuditService audit, AuthContext authContext) {
        this.capabilities = capabilities;
        this.agents = agents;
        this.auditRepository = auditRepository;
        this.audit = audit;
        this.authContext = authContext;
    }

    public record IssueCommand(
            String agentId,
            String capKey,
            Scope scope,
            Duration ttl,
            String reason,
            String approvalId) {
    }

    @Transactional
    public PolicyInputs.GrantRow issue(IssueCommand cmd) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException("grant.issue requires a natural human, caller was "
                    + actor.actorType() + " (" + actor.clientId() + ")");
        }

        CapabilityDescriptor cap = capabilities.findByKey(cmd.capKey())
                .orElseThrow(() -> new IllegalArgumentException("unknown capability: " + cmd.capKey()));

        AgentRecord agent = agents.findById(cmd.agentId())
                .orElseThrow(() -> new AgentService.AgentNotFound("no such agent: " + cmd.agentId()));

        Duration ttl = cmd.ttl() == null ? PolicyEngine.MAX_GRANT_TTL : cmd.ttl();
        if (ttl.isNegative() || ttl.isZero()) {
            audit.record(actor, "grant.issue", "grant", cmd.agentId(), "deny", "INVALID_TTL",
                    "ttl must be positive", Map.of("capKey", cmd.capKey(),
                            "ttlSeconds", String.valueOf(ttl.toSeconds())));
            throw new IllegalArgumentException("ttl must be positive");
        }
        if (ttl.compareTo(PolicyEngine.MAX_GRANT_TTL) > 0) {
            audit.record(actor, "grant.issue", "grant", cmd.agentId(), "deny", "TTL_CEILING_EXCEEDED",
                    "ttl " + ttl + " exceeds the " + PolicyEngine.MAX_GRANT_TTL + " ceiling (01 §5.2)",
                    Map.of("capKey", cmd.capKey(), "ttlSeconds", String.valueOf(ttl.toSeconds()),
                            "agentKey", agent.agentKey()));
            throw new IllegalArgumentException(
                    "ttl " + ttl + " exceeds the " + PolicyEngine.MAX_GRANT_TTL + " ceiling (01 §5.2): "
                            + "temporary privilege must be able to expire on its own");
        }

        Instant now = Instant.now();
        PolicyInputs.GrantRow grant = new PolicyInputs.GrantRow(
                Ids.newId(),
                cmd.agentId(),
                cap.capId(),
                cmd.scope() == null ? Scope.ofDept(agent.deptId()) : cmd.scope(),
                now,
                now.plus(ttl),
                actor.actorId(),
                cmd.reason(),
                null,
                "active");

        Grant asPolicyGrant = new Grant(grant.grantId(), grant.agentId(), grant.capId(), grant.scope(),
                grant.grantedAt(), grant.expiresAt(), null, grant.reason(), null, Grant.Status.ACTIVE);
        if (asPolicyGrant.ttlCapViolated()) {
            throw new IllegalArgumentException("ttl ceiling violated");
        }

        capabilities.insertGrant(grant);

        auditRepository.append(actor, Ids.newId(), "grant.issue", "grant", grant.grantId(), "allow", null,
                cmd.reason() == null ? "no reason given" : cmd.reason(),
                Map.of("agentId", cmd.agentId(), "agentKey", agent.agentKey(), "capKey", cmd.capKey(),
                        "ttlSeconds", String.valueOf(ttl.toSeconds()),
                        "scope", String.valueOf(grant.scope().toMap()),
                        "approvalId", String.valueOf(cmd.approvalId())), null, now);

        return grant;
    }

    @Transactional
    public boolean revoke(String grantId, String reason) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException("grant.revoke requires a natural human, caller was "
                    + actor.actorType());
        }
        Instant now = Instant.now();
        boolean revoked = capabilities.revokeGrant(grantId, now);
        audit.record(actor, "grant.revoke", "grant", grantId,
                revoked ? "allow" : "deny", revoked ? null : "NOT_ACTIVE", reason, Map.of());
        return revoked;
    }

    /** Called when an agent is paused or retired so nothing keeps running on its authority. */
    @Transactional
    public int revokeAllFor(String agentId, String reason) {
        List<PolicyInputs.GrantRow> live = capabilities.activeGrantsFor(agentId);
        int count = 0;
        for (PolicyInputs.GrantRow g : live) {
            if (capabilities.revokeGrant(g.grantId(), Instant.now())) {
                count++;
            }
        }
        if (count > 0) {
            AuthenticatedClient actor = authContext.current();
            audit.record(actor == null ? AuthenticatedClient.system("platform") : actor,
                    "grant.revokeAll", "agent", agentId, "allow", null, reason,
                    Map.of("revokedCount", String.valueOf(count)));
        }
        return count;
    }

    public List<PolicyInputs.GrantRow> activeFor(String agentId) {
        return capabilities.activeGrantsFor(agentId);
    }

    public CapabilityDescriptor capability(String capKey) {
        return capabilities.findByKey(capKey)
                .orElseThrow(() -> new IllegalArgumentException("unknown capability: " + capKey));
    }
}