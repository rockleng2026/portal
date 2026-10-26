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
     * <p>Three rules are enforced here, and they are the whole point of the module (red-team
     * R-02, ADR-007):
     * <ol>
     *   <li>only a natural human may decide;</li>
     *   <li>the agent's own owner may not decide its escalation;</li>
     *   <li>the decider must hold the role the escalation demands - a department director for
     *       the department, a system administrator for cross-department work, and <em>two</em>
     *       independent humans for anything irreversible (L4 / production DDL).</li>
     * </ol>
     * The third rule used to be computed and thrown away: a single human could approve a
     * production DDL. Two signatures are now recorded separately and the row only becomes
     * APPROVED when the second one arrives.
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
        AgentRecord agent = agents.findById(row.agentId())
                .orElseThrow(() -> new AgentService.AgentNotFound(
                        "approval references agent " + row.agentId() + " which does not exist"));
        int ownerEmployeeId = agent.ownerId();
        Integer agentDeptId = agent.deptId();

        com.fuao.harness.policy.PolicyDecision.ApproverScope requiredScope =
                com.fuao.harness.policy.PolicyEngine.requiredApproverScope(
                        capabilityFor(row.requestedCap()), row.scope(), agentDeptId);

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
                requiredScope);

        String boundedNote = note == null || note.length() <= 1024 ? note : note.substring(0, 1021) + "...";

        if (desired == ApprovalStateMachine.State.APPROVED) {
            if (requiredScope == com.fuao.harness.policy.PolicyDecision.ApproverScope.DUAL_CISO) {
                return decideDual(request, row, actor, boundedNote, requiredScope);
            }
            assertScopeAllows(actor, requiredScope, agentDeptId, row);
        }
        // A rejection is always allowed for a human who is not the agent's owner: refusing is
        // the safe direction and must never be made harder than approving.

        ApprovalStateMachine.Verdict verdict = ApprovalStateMachine.decide(
                request, ApprovalStateMachine.State.fromWire(row.status()), desired,
                ActorRef.human(actor.employeeId()), boundedNote, Instant.now());

        boolean persisted = approvals.transition(approvalId, ApprovalStateMachine.State.fromWire(row.status()),
                verdict.state(), verdict.decidedBy().id(), boundedNote, verdict.decidedAt());
        if (!persisted) {
            throw new ApprovalStateMachine.IllegalTransitionException(
                    "approval " + approvalId + " was decided by somebody else a moment earlier");
        }

        auditRepository.append(actor, com.fuao.harness.protocol.Ids.newId(), "approval.decide", "approval", approvalId,
                verdict.state() == ApprovalStateMachine.State.APPROVED ? "allow" : "reject",
                verdict.state().wire(), boundedNote == null ? "" : boundedNote,
                Map.of("agentId", row.agentId(), "capKey", row.requestedCap(),
                        "deciderEmployeeId", String.valueOf(actor.employeeId()),
                        "approverScope", requiredScope.name()),
                null, verdict.decidedAt());

        return verdict;
    }

    /**
     * The two-signature path for irreversible escalations.
     *
     * <p>The first signature leaves the row PENDING. Only the second, from a different natural
     * person, turns it into APPROVED - and the two signatures are visible in
     * {@code harness_approval_signoff}.
     */
    private ApprovalStateMachine.Verdict decideDual(ApprovalStateMachine.Request request,
                                                     PolicyInputs.ApprovalRow row,
                                                     AuthenticatedClient actor,
                                                     String note,
                                                     com.fuao.harness.policy.PolicyDecision.ApproverScope scope) {
        // The same rules a single signature has: a human, and not the agent's own owner.
        ApprovalStateMachine.assertDeciderEligible(request, ActorRef.human(actor.employeeId()));
        if (!actor.isSystemAdmin()) {
            throw new AgentService.NotAHumanException(
                    "an irreversible escalation needs two system administrators; employee "
                            + actor.employeeId() + " has role " + actor.role());
        }
        if (!Instant.now().isBefore(request.expiresAt())) {
            throw new ApprovalStateMachine.IllegalTransitionException(
                    "approval " + request.approvalId() + " expired before it was decided");
        }

        boolean fresh = approvals.recordSignoff(request.approvalId(), actor.employeeId(), Instant.now(), note);
        int distinct = approvals.distinctSignoffs(request.approvalId());
        List<Integer> signers = approvals.signoffEmployeeIds(request.approvalId());

        if (distinct < 2) {
            auditRepository.append(actor, com.fuao.harness.protocol.Ids.newId(), "approval.partial", "approval",
                    request.approvalId(), "approval", "SIGNATURE_PENDING",
                    note == null ? "" : note,
                    Map.of("agentId", row.agentId(), "capKey", row.requestedCap(),
                            "signatures", String.valueOf(distinct),
                            "requiredSignatures", "2",
                            "approverScope", scope.name(),
                            "newSignature", String.valueOf(fresh)),
                    null, Instant.now());
            // The row stays PENDING: one signature is not an approval.
            return new ApprovalStateMachine.Verdict(request.approvalId(), ApprovalStateMachine.State.PENDING,
                    ActorRef.human(actor.employeeId()), note, Instant.now(), String.valueOf(actor.employeeId()));
        }

        boolean persisted = approvals.transition(request.approvalId(), ApprovalStateMachine.State.PENDING,
                ApprovalStateMachine.State.APPROVED, signers.stream().map(e -> "human:" + e)
                        .reduce((a, b) -> a + "," + b).orElse(""), note, Instant.now());
        if (!persisted) {
            throw new ApprovalStateMachine.IllegalTransitionException(
                    "approval " + request.approvalId() + " was decided by somebody else a moment earlier");
        }

        auditRepository.append(actor, com.fuao.harness.protocol.Ids.newId(), "approval.decide", "approval",
                request.approvalId(), "allow", "APPROVED", note == null ? "" : note,
                Map.of("agentId", row.agentId(), "capKey", row.requestedCap(),
                        "deciderEmployeeId", String.valueOf(actor.employeeId()),
                        "signers", signers.stream().map(String::valueOf).reduce((a, b) -> a + "," + b).orElse(""),
                        "approverScope", scope.name()),
                null, Instant.now());

        return new ApprovalStateMachine.Verdict(request.approvalId(), ApprovalStateMachine.State.APPROVED,
                ActorRef.human(actor.employeeId()), note, Instant.now(), String.valueOf(actor.employeeId()));
    }

    /** The decider must hold the role the escalation's impact radius demands (red-team R-02). */
    private void assertScopeAllows(AuthenticatedClient actor,
                                   com.fuao.harness.policy.PolicyDecision.ApproverScope requiredScope,
                                   Integer agentDeptId,
                                   PolicyInputs.ApprovalRow row) {
        switch (requiredScope) {
            case SYSTEM_ADMIN -> {
                if (!actor.isSystemAdmin()) {
                    throw new AgentService.NotAHumanException(
                            "this escalation reaches beyond its own department and needs a system "
                                    + "administrator; employee " + actor.employeeId() + " has role "
                                    + actor.role());
                }
            }
            case DEPARTMENT_DIRECTOR -> {
                if (!actor.isDepartmentDirectorOf(agentDeptId)) {
                    throw new AgentService.NotAHumanException(
                            "this escalation needs the director of department " + agentDeptId
                                    + "; employee " + actor.employeeId() + " has role " + actor.role()
                                    + " in department " + actor.deptId());
                }
            }
            case DUAL_CISO -> {
                throw new ApprovalStateMachine.IllegalTransitionException(
                        "an irreversible escalation cannot be decided in one signature");
            }
            default -> {
            }
        }
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

    private com.fuao.harness.policy.CapabilityDescriptor capabilityFor(String capKey) {        return capabilityRepo.findByKey(capKey)
                .orElseThrow(() -> new IllegalArgumentException("unknown capability: " + capKey));
    }
}
