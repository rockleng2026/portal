package com.fuao.harness.platform.repo;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/** {@code harness_task_proposal} access - the queue the brain writes into (V15). */
@Repository
public class TaskProposalRepository {

    private final JdbcClient jdbc;

    public TaskProposalRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    private static final String COLUMNS = """
            proposal_id, title, description, target_agent_key, target_dept_id, proposed_by, status,
            portal_mission_id, portal_assignment_id, harness_task_id, delivered_at, assessment,
            decided_by, created_at, updated_at
            """;

    public void insert(String proposalId, String title, String description, String agentKey,
                       Integer deptId, String proposedBy, String status, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_task_proposal
                          (proposal_id, title, description, target_agent_key, target_dept_id,
                           proposed_by, status, created_at, updated_at)
                        VALUES
                          (:proposalId, :title, :description, :agentKey, :deptId,
                           :proposedBy, :status, :now, :now)
                        """)
                .param("proposalId", proposalId)
                .param("title", title)
                .param("description", description)
                .param("agentKey", agentKey)
                .param("deptId", deptId)
                .param("proposedBy", proposedBy)
                .param("status", status)
                .param("now", Timestamp.from(now))
                .update();
    }

    public Optional<ProposalRow> find(String proposalId) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_task_proposal WHERE proposal_id = :id")
                .param("id", proposalId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public List<ProposalRow> list(String status) {
        if (status == null || status.isBlank()) {
            return jdbc.sql("SELECT " + COLUMNS + " FROM harness_task_proposal ORDER BY created_at DESC")
                    .query((rs, i) -> map(rs))
                    .list();
        }
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_task_proposal WHERE status = :status"
                        + " ORDER BY created_at DESC")
                .param("status", status.trim())
                .query((rs, i) -> map(rs))
                .list();
    }

    public Optional<ProposalRow> byPortalAssignment(String assignmentId) {
        if (assignmentId == null || assignmentId.isBlank()) {
            return Optional.empty();
        }
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_task_proposal"
                        + " WHERE portal_assignment_id = :assignmentId ORDER BY created_at DESC LIMIT 1")
                .param("assignmentId", assignmentId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public void markPublished(String proposalId, Integer missionId, String assignmentId,
                              String decidedBy, String reason, Instant now) {
        jdbc.sql("""
                        UPDATE harness_task_proposal
                           SET status = 'published', portal_mission_id = :missionId,
                               portal_assignment_id = :assignmentId, decided_by = :decidedBy,
                               updated_at = :now
                         WHERE proposal_id = :id
                        """)
                .param("missionId", missionId)
                .param("assignmentId", assignmentId)
                .param("decidedBy", decidedBy)
                .param("now", Timestamp.from(now))
                .param("id", proposalId)
                .update();
    }

    public void markRejected(String proposalId, String decidedBy, String reason, Instant now) {
        jdbc.sql("""
                        UPDATE harness_task_proposal
                           SET status = 'rejected', decided_by = :decidedBy, assessment = :reason,
                               updated_at = :now
                         WHERE proposal_id = :id
                        """)
                .param("decidedBy", decidedBy)
                .param("reason", reason)
                .param("now", Timestamp.from(now))
                .param("id", proposalId)
                .update();
    }

    public void markAssessed(String proposalId, String assessment, String decidedBy, Instant now) {
        jdbc.sql("""
                        UPDATE harness_task_proposal
                           SET status = 'assessed', assessment = :assessment, decided_by = :decidedBy,
                               updated_at = :now
                         WHERE proposal_id = :id
                        """)
                .param("assessment", assessment)
                .param("decidedBy", decidedBy)
                .param("now", Timestamp.from(now))
                .param("id", proposalId)
                .update();
    }

    public void markDelivered(String proposalId, String harnessTaskId, Instant at) {
        jdbc.sql("""
                        UPDATE harness_task_proposal
                           SET status = 'delivered', harness_task_id = :taskId, delivered_at = :at,
                               updated_at = :at
                         WHERE proposal_id = :id
                        """)
                .param("taskId", harnessTaskId)
                .param("at", Timestamp.from(at))
                .param("id", proposalId)
                .update();
    }

    /** One row of the queue. */
    public record ProposalRow(
            String proposalId,
            String title,
            String description,
            String targetAgentKey,
            Integer targetDeptId,
            String proposedBy,
            String status,
            Integer portalMissionId,
            String portalAssignmentId,
            String harnessTaskId,
            String assessment,
            String decidedBy,
            Instant createdAt,
            Instant updatedAt) {
    }

    private static ProposalRow map(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new ProposalRow(
                rs.getString("proposal_id"),
                rs.getString("title"),
                rs.getString("description"),
                rs.getString("target_agent_key"),
                (Integer) rs.getObject("target_dept_id"),
                rs.getString("proposed_by"),
                rs.getString("status"),
                (Integer) rs.getObject("portal_mission_id"),
                rs.getString("portal_assignment_id"),
                rs.getString("harness_task_id"),
                rs.getString("assessment"),
                rs.getString("decided_by"),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant());
    }
}
