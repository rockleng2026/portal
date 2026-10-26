package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.platform.repo.ApprovalRepository;
import com.fuao.harness.platform.repo.AuditRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.policy.ApprovalStateMachine;
import com.fuao.harness.policy.ActorRef;
import com.fuao.harness.policy.Scope;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Escalation approvals (01 §6.2, 03 §2.3).
 *
 * <p>All of the judgement lives in {@link ApprovalStateMachine}; this class is the plumbing that
 * persists it and guarantees that the row in {@code harness_approval} and the row in
 * {@code harness_audit} agree about what happened.
 */
@Service
public class ApprovalService {

    private final ApprovalRepository approvals;
    private final com.fuao.harness.platform.repo.AgentRepository agents;
    private final com.fuao.harness.platform.repo.CapabilityRepository capabilityRepo;
    private final AuditRepository auditRepository;
    private final AuthContext authContext;

    public ApprovalService(ApprovalRepository approvals,
                           com.fuao.harness.platform.repo.AgentRepository agents,
                           com.fuao.harness.platform.repo.CapabilityRepository capabilityRepo,
                           AuditRepository auditRepository, AuthContext authContext) {
        this.approvals = approvals;
        this.agents = agents;
        this.capabilityRepo = capabilityRepo;
        this.auditRepository = auditRepository;
        this.authContext = authContext;
    }

    @Transactional
    public PolicyInputs.ApprovalRow open(com.fuao.harness.policy.PolicyDecision.ApprovalRequest request) {
        AuthenticatedClient actor = authContext.require();
        approvals.insert(request.approvalId(), request, ApprovalStateMachine.State.PENDING.wire());
        auditRepository.append(actor, com.fuao.harness.protocol.Ids.newId(), "approval.open", "approval", request.approvalId(),
                "approval", "ESCALATION_REQUESTED", request.justification(),
                Map.of("agentId", request.agentId(), "capKey", request.requestedCapKey(),
                        "ttlSeconds", String.valueOf(request.ttl().toSeconds()),
                        "approverScope", request.requiredApproverScope().name(),
                        "blastRadius", String.valueOf(request.blastRadius()),
                        "riskClass", request.riskClass()), null, Instant.now());
        return approvals.find(request.approvalId()).orElseThrow();
    }

    /**
     * A human approves or rejects.
     *
     * @throws ApprovalStateMachine.IllegalTransitionException when the decider is not a natural
     *         human, is the agent's own owner, or the approval is no longer pending. Callers must
     *         not catch it and report success.
     */
    @Transactional
    public ApprovalStateMachine.Verdict decide(String approvalId, ApprovalStateMachine.State desired, String note) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman() || actor.employeeId() == null) {
            throw new AgentService.NotAHumanException(
                    "only a natural human may decide an escalation; caller was " + actor.actorType()
                            + " (" + actor.clientId() + ") - AI must not authorise itself (P2 / R-02)");
        }

        PolicyInputs.ApprovalRow row = approvals.find(approvalId)
                .orElseThrow(() -> new IllegalArgumentException("no such approval: " + approvalId));
        int ownerEmployeeId = agentOwnerEmployeeId(row.agentId());

        ApprovalStateMachine.Request request = new ApprovalStateMachine.Request(
                row.approvalId(),
                row.agentId(),
                row.agentId(),
                ownerEmployeeId,
                row.requestedCap(),
                row.scope(),
                row.ttlSeconds(),
                row.riskClass(),
                row.blastRadius(),
                row.rollbackPlan(),
                row.justification(),
                row.createdAt(),
                row.expiresAt(),
                com.fuao.harness.policy.PolicyEngine.requiredApproverScope(
                        capabilityFor(row.requestedCap()), row.scope(), null));

        ApprovalStateMachine.Verdict verdict = ApprovalStateMachine.decide(
                request, ApprovalStateMachine.State.fromWire(row.status()), desired,
                ActorRef.human(actor.employeeId()), note, Instant.now());

        String boundedNote = note == null || note.length() <= 1024 ? note : note.substring(0, 1021) + "...";

        boolean persisted = approvals.transition(approvalId, ApprovalStateMachine.State.fromWire(row.status()),
                verdict.state(), actor.actorId(), boundedNote, verdict.decidedAt());
        if (!persisted) {
            throw new ApprovalStateMachine.IllegalTransitionException(
                    "approval " + approvalId + " was decided by somebody else a moment earlier");
        }

        auditRepository.append(actor, com.fuao.harness.protocol.Ids.newId(), "approval.decide", "approval", approvalId,
                verdict.state() == ApprovalStateMachine.State.APPROVED ? "allow" : "reject",
                verdict.state().wire(), boundedNote == null ? "" : boundedNote,
                Map.of("agentId", row.agentId(), "capKey", row.requestedCap(),
                        "deciderEmployeeId", String.valueOf(actor.employeeId())),
                null, verdict.decidedAt());

        return verdict;
    }

    /** Marks the escalation as spent so one approval buys exactly one execution. */
    @Transactional
    public boolean consume(String approvalId) {
        return approvals.transition(approvalId, ApprovalStateMachine.State.APPROVED,
                ApprovalStateMachine.State.USED, null, "consumed", Instant.now());
    }

    @Transactional
    public int expireOverdue() {
        int expired = approvals.expireOverdue();
        if (expired > 0) {
            auditRepository.append(AuthenticatedClient.system("platform"),
                    com.fuao.harness.protocol.Ids.newId(), "approval.expire", "approval", "*",
                    "allow", "TTL_ELAPSED", expired + " approval(s) expired without a decision",
                    Map.of("count", String.valueOf(expired)), null, java.time.Instant.now());
        }
        return expired;
    }

    public List<PolicyInputs.ApprovalRow> list(String status, int limit) {
        return approvals.list(status, limit);
    }

    public PolicyInputs.ApprovalRow get(String approvalId) {
        return approvals.find(approvalId)
                .orElseThrow(() -> new IllegalArgumentException("no such approval: " + approvalId));
    }

    private int agentOwnerEmployeeId(String agentId) {
        return agents.findById(agentId)
                .map(AgentRecord::ownerId)
                .orElseThrow(() -> new AgentService.AgentNotFound(
                        "approval references agent " + agentId + " which does not exist"));
    }

    private com.fuao.harness.policy.CapabilityDescriptor capabilityFor(String capKey) {
        return capabilityRepo.findByKey(capKey)
                .orElseThrow(() -> new IllegalArgumentException("unknown capability: " + capKey));
    }
}
