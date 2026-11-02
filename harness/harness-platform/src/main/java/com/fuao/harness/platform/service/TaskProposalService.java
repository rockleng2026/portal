package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.TaskProposalRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * A task the brain proposed, waiting for a natural human to publish it.
 *
 * <p>The brain may write a proposal and nothing else. A proposal is a request: it creates no
 * portal row, assigns no machine and changes nothing a person or a machine can see. Turning it
 * into work is a human pressing a button, and that is where the audit line is (ADR-007,
 * 02 R-02 - "AI 不能给自己授权").
 *
 * <p>So the chain reads:
 * <pre>
 *   大脑：给研发中心派个活        → propose_task   → 提案（什么都没发生）
 *   人在控制台点「发布」          → publish         → portal 里出现任务
 *   平台轮询 → 数字员工干活        →                → 交付回到 portal
 *   大脑验收                      → assess         → 提案上写下结论
 * </pre>
 */
@Service
public class TaskProposalService {

    private final TaskProposalRepository proposals;
    private final PortalClient portal;
    private final AuditService audit;
    private final AuthContext authContext;

    public TaskProposalService(TaskProposalRepository proposals, PortalClient portal,
                               AuditService audit, AuthContext authContext) {
        this.proposals = proposals;
        this.portal = portal;
        this.audit = audit;
        this.authContext = authContext;
    }

    /**
     * Writes down what was asked for.
     *
     * <p>Nothing else happens here. The proposal is a request, and the request does not touch
     * the portal, the terminals or the agents.
     */
    @Transactional
    public TaskProposalRepository.ProposalRow propose(String title, String description, String agentKey, Integer deptId,
                            AuthenticatedClient actor) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("a proposal needs a title");
        }
        if (title.trim().length() > 20) {
            // The portal's function name column is 20 characters and its mission name is 32;
            // a title that does not fit would fail at the far end, in the middle of the night.
            throw new IllegalArgumentException("the task title is at most 20 characters (it is "
                    + title.trim().length() + ")");
        }
        if (description == null || description.trim().isEmpty()) {
            throw new IllegalArgumentException("a proposal needs a description");
        }
        Instant now = Instant.now();
        String proposalId = Ids.newId();
        proposals.insert(proposalId, title.trim(), description.trim(), agentKey, deptId,
                actor.actorId(), "proposed", now);
        audit.record(actor, "task.propose", "task_proposal", proposalId, "allow", null,
                "proposed: " + title.trim(),
                Map.of("title", title.trim(), "agentKey", String.valueOf(agentKey)));
        return proposals.find(proposalId).orElseThrow();
    }

    public List<TaskProposalRepository.ProposalRow> list(String status) {
        return proposals.list(status);
    }

    /**
     * Publishes the proposal: the task appears in the portal, assigned to the digital
     * employee.
     *
     * <p>Only a natural human does this. The brain proposed it; a person decided.
     */
    @Transactional
    public TaskProposalRepository.ProposalRow publish(String proposalId, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "task.proposal.publish");
        TaskProposalRepository.ProposalRow proposal = proposals.find(proposalId)
                .orElseThrow(() -> new IllegalArgumentException("no such proposal: " + proposalId));
        if (!"proposed".equals(proposal.status())) {
            throw new IllegalStateException("the proposal has already been " + proposal.status());
        }
        if (proposal.targetAgentKey() == null || proposal.targetAgentKey().isBlank()) {
            throw new IllegalArgumentException("the proposal does not name a digital employee");
        }

        Map<String, Object> published = portal.publishTask(proposal.title(), proposal.description(),
                proposal.targetAgentKey(), null, null);
        Object missionId = published.get("missionId");
        Object assignmentId = published.get("assignmentId");
        proposals.markPublished(proposalId, integer(missionId),
                assignmentId == null ? null : String.valueOf(assignmentId),
                actor.actorId(), reason, Instant.now());
        audit.record(actor, "task.proposal.publish", "task_proposal", proposalId, "allow", null,
                reason == null ? "published" : reason,
                Map.of("portalMissionId", String.valueOf(missionId),
                        "portalAssignmentId", String.valueOf(assignmentId)));
        return proposals.find(proposalId).orElseThrow();
    }

    /** Turns the proposal down. */
    @Transactional
    public TaskProposalRepository.ProposalRow reject(String proposalId, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "task.proposal.reject");
        if (reason == null || reason.isBlank()) {
            throw new IllegalArgumentException("a rejection has to say why");
        }
        proposals.markRejected(proposalId, actor.actorId(), reason, Instant.now());
        audit.record(actor, "task.proposal.reject", "task_proposal", proposalId, "allow", null, reason,
                Map.of());
        return proposals.find(proposalId).orElseThrow();
    }

    /**
     * The brain's verdict on the delivery.
     *
     * <p>Still not a change to the world: it is a note on the proposal. Whether the work
     * counts as done is a human's call.
     */
    @Transactional
    public TaskProposalRepository.ProposalRow assess(String proposalId, String assessment, AuthenticatedClient actor) {
        if (assessment == null || assessment.trim().isEmpty()) {
            throw new IllegalArgumentException("an assessment needs a word");
        }
        proposals.markAssessed(proposalId, assessment.trim(), actor.actorId(), Instant.now());
        audit.record(actor, "task.proposal.assess", "task_proposal", proposalId, "allow", null,
                assessment.trim(), Map.of());
        return proposals.find(proposalId).orElseThrow();
    }

    /**
     * Notices that a proposal's task was delivered.
     *
     * <p>Called by the bridge when the answer comes back from the portal.
     */
    @Transactional
    public void markDelivered(String proposalId, String harnessTaskId, Instant at) {
        proposals.markDelivered(proposalId, harnessTaskId, at);
    }

    /** The proposal a portal task came from, if there is one. */
    public java.util.Optional<TaskProposalRepository.ProposalRow> byPortalAssignment(String assignmentId) {
        return proposals.byPortalAssignment(assignmentId);
    }

    private static void requireHuman(AuthenticatedClient actor, String op) {
        if (!actor.isHuman()) {
            throw new SkillMarketService.NotAHumanException(op + " requires a natural human, caller was "
                    + actor.actorType() + " (" + actor.clientId() + ")");
        }
    }

    private static Integer integer(Object value) {
        if (value == null) {
            return null;
        }
        try {
            return Integer.valueOf(String.valueOf(value).trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
