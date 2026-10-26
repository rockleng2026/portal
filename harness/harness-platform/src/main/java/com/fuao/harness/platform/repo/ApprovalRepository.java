package com.fuao.harness.platform.repo;

import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.policy.ApprovalStateMachine;
import com.fuao.harness.policy.PolicyDecision;
import com.fuao.harness.policy.Scope;
import com.fuao.harness.protocol.json.Json;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/** {@code harness_approval} access (03 §2.3). */
@Repository
public class ApprovalRepository {

    private final JdbcClient jdbc;

    public ApprovalRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    private static final String COLUMNS = """
            approval_id, issue_id, plan_id, agent_id, requested_cap, scope, ttl_seconds, expires_at,
            risk_class, blast_radius, rollback_plan, justification, status, decided_by, decided_at,
            decision_note, created_at
            """;

    public void insert(String approvalId, PolicyDecision.ApprovalRequest request, String status) {
        jdbc.sql("""
                        INSERT INTO harness_approval
                          (approval_id, issue_id, plan_id, agent_id, requested_cap, scope, ttl_seconds,
                           expires_at, risk_class, blast_radius, rollback_plan, justification, status, created_at)
                        VALUES
                          (:approvalId, NULL, NULL, :agentId, :cap, :scope, :ttlSeconds, :expiresAt,
                           :riskClass, :blastRadius, :rollbackPlan, :justification, :status, :createdAt)
                        """)
                .param("approvalId", approvalId)
                .param("agentId", request.agentId())
                .param("cap", request.requestedCapKey())
                .param("scope", Json.canonical(request.scope().toMap()))
                .param("ttlSeconds", (int) request.ttl().toSeconds())
                .param("expiresAt", Timestamp.from(request.expiresAt()))
                .param("riskClass", request.riskClass())
                .param("blastRadius", request.blastRadius())
                .param("rollbackPlan", request.rollbackPlan())
                .param("justification", request.justification())
                .param("status", status)
                .param("createdAt", Timestamp.from(Instant.now()))
                .update();
    }

    public Optional<PolicyInputs.ApprovalRow> find(String approvalId) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_approval WHERE approval_id = :id")
                .param("id", approvalId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public List<PolicyInputs.ApprovalRow> list(String status, int limit) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_approval "
                        + "WHERE (:status IS NULL OR status = :status) ORDER BY created_at DESC LIMIT :limit")
                .param("status", status)
                .param("limit", limit)
                .query((rs, i) -> map(rs))
                .list();
    }

    /**
     * Conditional update on the current state. The {@code AND status = :expected} clause is the
     * concurrency guard: two clicks on the same approval produce one update and one zero-row
     * result, so the caller cannot double-approve.
     */
    public boolean transition(String approvalId, ApprovalStateMachine.State expected,
                               ApprovalStateMachine.State next, String decidedBy, String note, Instant at) {
        return jdbc.sql("""
                        UPDATE harness_approval
                           SET status = :next, decided_by = :decidedBy, decided_at = :at, decision_note = :note
                         WHERE approval_id = :id AND status = :expected
                        """)
                .param("id", approvalId)
                .param("expected", expected.wire())
                .param("next", next.wire())
                .param("decidedBy", decidedBy)
                .param("note", note)
                .param("at", Timestamp.from(at))
                .update() == 1;
    }

    public int expireOverdue() {
        return jdbc.sql("UPDATE harness_approval SET status = 'expired' WHERE status = 'pending' AND expires_at <= NOW()")
                .update();
    }

    // ------------------------------------------------------------------ dual approval

    /**
     * Records one human signature on an escalation.
     *
     * <p>Dual approval (L4 / irreversible) needs every signature on its own row, because the
     * approval itself may only become APPROVED once two <em>different</em> humans signed. A
     * single {@code decided_by} column cannot hold that.
     *
     * @return {@code true} when this signature was new, {@code false} when the same person
     *         signed again
     */
    public boolean recordSignoff(String approvalId, int employeeId, Instant at, String note) {
        return jdbc.sql("""
                        INSERT INTO harness_approval_signoff
                          (signoff_id, approval_id, employee_id, decided_at, note, created_at)
                        VALUES (:id, :approvalId, :employeeId, :at, :note, NOW())
                        ON DUPLICATE KEY UPDATE note = VALUES(note)
                        """)
                .param("id", com.fuao.harness.protocol.Ids.newId())
                .param("approvalId", approvalId)
                .param("employeeId", employeeId)
                .param("at", Timestamp.from(at))
                .param("note", note)
                .update() == 1;
    }

    /** How many different humans signed this escalation. */
    public int distinctSignoffs(String approvalId) {
        return jdbc.sql("SELECT COUNT(DISTINCT employee_id) FROM harness_approval_signoff WHERE approval_id = :id")
                .param("id", approvalId)
                .query(Integer.class)
                .single();
    }

    /** The employee ids that signed this escalation. */
    public List<Integer> signoffEmployeeIds(String approvalId) {
        return jdbc.sql("SELECT DISTINCT employee_id FROM harness_approval_signoff WHERE approval_id = :id")
                .param("id", approvalId)
                .query(Integer.class)
                .list();
    }

    private static PolicyInputs.ApprovalRow map(java.sql.ResultSet rs) throws java.sql.SQLException {
        Object scopeObj = Json.parse(rs.getString("scope") == null ? "{}" : rs.getString("scope"));
        Scope scope = scopeObj instanceof java.util.Map<?, ?> m
                ? Scope.fromMap(castMap(m))
                : Scope.UNBOUNDED;
        return new PolicyInputs.ApprovalRow(
                rs.getString("approval_id"),
                rs.getString("issue_id"),
                rs.getString("plan_id"),
                rs.getString("agent_id"),
                rs.getString("requested_cap"),
                scope,
                rs.getInt("ttl_seconds"),
                rs.getTimestamp("expires_at").toInstant(),
                rs.getString("risk_class"),
                rs.getInt("blast_radius"),
                rs.getString("rollback_plan"),
                rs.getString("justification"),
                rs.getString("status"),
                rs.getString("decided_by"),
                rs.getTimestamp("decided_at") == null ? null : rs.getTimestamp("decided_at").toInstant(),
                rs.getString("decision_note"),
                rs.getTimestamp("created_at").toInstant());
    }

    @SuppressWarnings("unchecked")
    private static java.util.Map<String, Object> castMap(java.util.Map<?, ?> m) {
        return (java.util.Map<String, Object>) m;
    }
}