package com.fuao.harness.platform.repo;

import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.protocol.json.Json;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/** {@code harness_terminal_task} access - the console-to-terminal channel (V9). */
@Repository
public class TaskRepository {

    private final JdbcClient jdbc;

    public TaskRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    private static final String COLUMNS = """
            task_id, terminal_id, prompt, status, answer, transcript, touched, error,
            created_by, created_at, started_at, finished_at, claimed_at
            """;

    /** A request from the console to a terminal. */
    public record TaskRow(
            String taskId,
            String terminalId,
            String prompt,
            String status,
            String answer,
            String transcript,
            String touched,
            String error,
            String createdBy,
            Instant createdAt,
            Instant startedAt,
            Instant finishedAt) {
    }

    public void insert(String taskId, String terminalId, String prompt, String createdBy, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_terminal_task
                          (task_id, terminal_id, prompt, status, created_by, created_at)
                        VALUES (:taskId, :terminalId, :prompt, 'pending', :createdBy, :now)
                        """)
                .param("taskId", taskId)
                .param("terminalId", terminalId)
                .param("prompt", prompt)
                .param("createdBy", createdBy)
                .param("now", Timestamp.from(now))
                .update();
    }

    public Optional<TaskRow> find(String taskId) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_terminal_task WHERE task_id = :id")
                .param("id", taskId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public List<TaskRow> list(String terminalId, String status, int limit) {
        // The column list is spelled out here rather than concatenated: a text block strips
        // trailing spaces, so "SELECT " + COLUMNS would come out as "SELECTtask_id".
        return jdbc.sql("""
                        SELECT task_id, terminal_id, prompt, status, answer, transcript, touched, error,
                               created_by, created_at, started_at, finished_at, claimed_at
                          FROM harness_terminal_task
                         WHERE (:terminalId IS NULL OR terminal_id = :terminalId)
                           AND (:status IS NULL OR status = :status)
                         ORDER BY created_at DESC
                         LIMIT :limit
                        """)
                .param("terminalId", terminalId)
                .param("status", status)
                .param("limit", limit)
                .query((rs, i) -> map(rs))
                .list();
    }

    /**
     * Claims the oldest pending task for a terminal.
     *
     * <p>The claim is a conditional update, so two terminals (or two pollers on the same
     * terminal) cannot take the same task: the second one updates zero rows and moves on.
     */
    public Optional<TaskRow> claimNext(String terminalId, Instant now) {
        List<String> pending = jdbc.sql("""
                        SELECT task_id FROM harness_terminal_task
                         WHERE terminal_id = :terminalId AND status = 'pending'
                         ORDER BY created_at
                         LIMIT 5
                        """)
                .param("terminalId", terminalId)
                .query(String.class)
                .list();
        for (String taskId : pending) {
            int updated = jdbc.sql("""
                            UPDATE harness_terminal_task
                               SET status = 'running', claimed_at = :now, started_at = :now
                             WHERE task_id = :id AND status = 'pending'
                            """)
                    .param("id", taskId)
                    .param("now", Timestamp.from(now))
                    .update();
            if (updated == 1) {
                return find(taskId);
            }
        }
        return Optional.empty();
    }

    /** Records the answer of a finished task. */
    public boolean complete(String taskId, String status, String answer, String transcript,
                            String touched, String error, Instant now) {
        return jdbc.sql("""
                        UPDATE harness_terminal_task
                           SET status = :status, answer = :answer, transcript = :transcript,
                               touched = :touched, error = :error, finished_at = :now
                         WHERE task_id = :id AND status = 'running'
                        """)
                .param("id", taskId)
                .param("status", status)
                .param("answer", answer)
                .param("transcript", transcript)
                .param("touched", touched)
                .param("error", error)
                .param("now", Timestamp.from(now))
                .update() == 1;
    }

    /** A task that was never picked up. */
    public boolean cancel(String taskId, String reason) {
        return jdbc.sql("""
                        UPDATE harness_terminal_task
                           SET status = 'cancelled', error = :reason, finished_at = NOW()
                         WHERE task_id = :id AND status = 'pending'
                        """)
                .param("id", taskId)
                .param("reason", reason)
                .update() == 1;
    }

    private static TaskRow map(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new TaskRow(
                rs.getString("task_id"),
                rs.getString("terminal_id"),
                rs.getString("prompt"),
                rs.getString("status"),
                rs.getString("answer"),
                rs.getString("transcript"),
                rs.getString("touched"),
                rs.getString("error"),
                rs.getString("created_by"),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("started_at") == null ? null : rs.getTimestamp("started_at").toInstant(),
                rs.getTimestamp("finished_at") == null ? null : rs.getTimestamp("finished_at").toInstant());
    }

    /** The JSON columns, parsed for the console. */
    public static Map<String, Object> parseJson(String json) {
        Object parsed = Json.parse(json == null || json.isBlank() ? "{}" : json);
        return parsed instanceof Map ? castMap(parsed) : Map.of();
    }

    /** A JSON array of anything, parsed for the console (the touched files are strings). */
    public static List<Object> parseJsonArray(String json) {
        Object parsed = Json.parse(json == null || json.isBlank() ? "[]" : json);
        if (parsed instanceof List<?> list) {
            return new java.util.ArrayList<>(list);
        }
        return List.of();
    }

    /** A JSON array, parsed for the console (the transcript is a list of events). */
    public static List<Map<String, Object>> parseJsonList(String json) {
        Object parsed = Json.parse(json == null || json.isBlank() ? "[]" : json);
        if (parsed instanceof List<?> list) {
            List<Map<String, Object>> out = new java.util.ArrayList<>();
            for (Object item : list) {
                if (item instanceof Map) {
                    out.add(castMap(item));
                }
            }
            return out;
        }
        return List.of();
    }

    @SuppressWarnings("unchecked")
    private static Map<String, Object> castMap(Object value) {
        return (Map<String, Object>) value;
    }
}
