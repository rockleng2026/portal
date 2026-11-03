package com.fuao.harness.platform.repo;

import com.fuao.harness.platform.repo.HarnessLessonRepository;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/** {@code harness_harness_lesson} access - the lessons the harness has learned (V14). */
@Repository
public class HarnessLessonRepository {

    private final JdbcClient jdbc;

    public HarnessLessonRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    private static final String COLUMNS = """
            lesson_id, agent_id, terminal_id, cue, lesson, component, evidence, confidence, status,
            task_id, proposed_by, decided_by, created_at, updated_at
            """;

    /** One row of the lesson table. */
    public record LessonRow(
            String lessonId,
            String agentId,
            String terminalId,
            String cue,
            String lesson,
            String component,
            String evidence,
            String confidence,
            String status,
            String taskId,
            String proposedBy,
            String decidedBy,
            Instant createdAt,
            Instant updatedAt) {
    }

    public void insert(String lessonId, String agentId, String terminalId, String cue, String lesson,
                       String component, String evidence, String confidence, String status,
                       String taskId, String proposedBy, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_harness_lesson
                          (lesson_id, agent_id, terminal_id, cue, lesson, component, evidence,
                           confidence, status, task_id, proposed_by, created_at, updated_at)
                        VALUES
                          (:lessonId, :agentId, :terminalId, :cue, :lesson, :component, :evidence,
                           :confidence, :status, :taskId, :proposedBy, :now, :now)
                        """)
                .param("lessonId", lessonId)
                .param("agentId", agentId)
                .param("terminalId", terminalId)
                .param("cue", cue)
                .param("lesson", lesson)
                .param("component", component)
                .param("evidence", evidence)
                .param("confidence", confidence)
                .param("status", status)
                .param("taskId", taskId)
                .param("proposedBy", proposedBy)
                .param("now", Timestamp.from(now))
                .update();
    }

    public java.util.Optional<LessonRow> find(String lessonId) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_harness_lesson WHERE lesson_id = :id")
                .param("id", lessonId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public List<LessonRow> list(String status, String agentId) {
        StringBuilder sql = new StringBuilder("SELECT " + COLUMNS + " FROM harness_harness_lesson WHERE 1=1");
        if (status != null && !status.isBlank()) {
            sql.append(" AND status = :status");
        }
        if (agentId != null && !agentId.isBlank()) {
            sql.append(" AND agent_id = :agentId");
        }
        sql.append(" ORDER BY created_at DESC");
        java.util.Map<String, Object> params = new java.util.LinkedHashMap<>();
        if (status != null && !status.isBlank()) {
            params.put("status", status.trim());
        }
        if (agentId != null && !agentId.isBlank()) {
            params.put("agentId", agentId.trim());
        }
        var spec = jdbc.sql(sql.toString());
        for (var entry : params.entrySet()) {
            spec = spec.param(entry.getKey(), entry.getValue());
        }
        return spec.query((rs, i) -> map(rs)).list();
    }

    /**
     * Whether the harness already carries this lesson.
     *
     * <p>A rejected one does not count: the same run may teach the same thing again, and the
     * person who turned it down may have had a reason that has since gone away.
     */
    public boolean exists(String cue, String component, String agentId) {
        return jdbc.sql("""
                        SELECT COUNT(*) FROM harness_harness_lesson
                         WHERE cue = :cue AND component = :component AND status <> 'rejected'
                           AND (:agentId IS NULL OR agent_id = :agentId)
                        """)
                .param("cue", cue)
                .param("component", component)
                .param("agentId", agentId)
                .query(Integer.class)
                .single() > 0;
    }

    public void markStatus(String lessonId, String status, String decidedBy, String reason, Instant now) {
        jdbc.sql("""
                        UPDATE harness_harness_lesson
                           SET status = :status, decided_by = :decidedBy, updated_at = :now
                         WHERE lesson_id = :id
                        """)
                .param("status", status)
                .param("decidedBy", decidedBy)
                .param("now", Timestamp.from(now))
                .param("id", lessonId)
                .update();
    }

    /**
     * Records what a run did.
     *
     * <p>The reflection reads it, and so does anybody who asks why the agent behaves the way
     * it does. It is the evidence the lessons rest on.
     */
    public void insertRun(String runId, String taskId, String agentId, String terminalId, int steps,
                          int toolCalls, int files, boolean actedOnFirstTurn, boolean deliveryNote,
                          String endedOn, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_task_run
                          (run_id, task_id, agent_id, terminal_id, steps, tool_calls, files,
                           first_turn_acted, delivery_note, ended_on, observed_at)
                        VALUES
                          (:runId, :taskId, :agentId, :terminalId, :steps, :toolCalls, :files,
                           :acted, :note, :endedOn, :now)
                        """)
                .param("runId", runId)
                .param("taskId", taskId)
                .param("agentId", agentId)
                .param("terminalId", terminalId)
                .param("steps", steps)
                .param("toolCalls", toolCalls)
                .param("files", files)
                .param("acted", actedOnFirstTurn ? 1 : 0)
                .param("note", deliveryNote ? 1 : 0)
                .param("endedOn", endedOn)
                .param("now", Timestamp.from(now))
                .update();
    }

    /** The last run of an agent, for the probe. */
    public java.util.Optional<RunRow> lastRun(String agentId) {
        return jdbc.sql("""
                        SELECT run_id, task_id, agent_id, terminal_id, steps, tool_calls, files,
                               first_turn_acted, delivery_note, ended_on, observed_at
                          FROM harness_task_run
                         WHERE (:agentId IS NULL OR agent_id = :agentId)
                         ORDER BY observed_at DESC
                         LIMIT 1
                        """)
                .param("agentId", agentId)
                .query((rs, i) -> new RunRow(
                        rs.getString("run_id"),
                        rs.getString("task_id"),
                        rs.getString("agent_id"),
                        rs.getString("terminal_id"),
                        rs.getInt("steps"),
                        rs.getInt("tool_calls"),
                        rs.getInt("files"),
                        rs.getInt("first_turn_acted") == 1,
                        rs.getInt("delivery_note") == 1,
                        rs.getString("ended_on"),
                        rs.getTimestamp("observed_at").toInstant()))
                .optional();
    }

    /** One recorded run. */
    public record RunRow(
            String runId,
            String taskId,
            String agentId,
            String terminalId,
            int steps,
            int toolCalls,
            int files,
            boolean actedOnFirstTurn,
            boolean deliveryNote,
            String endedOn,
            Instant observedAt) {
    }

    private static LessonRow map(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new LessonRow(
                rs.getString("lesson_id"),
                rs.getString("agent_id"),
                rs.getString("terminal_id"),
                rs.getString("cue"),
                rs.getString("lesson"),
                rs.getString("component"),
                rs.getString("evidence"),
                rs.getString("confidence"),
                rs.getString("status"),
                rs.getString("task_id"),
                rs.getString("proposed_by"),
                rs.getString("decided_by"),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant());
    }
}
