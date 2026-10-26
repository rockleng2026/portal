package com.fuao.harness.adapter.portal;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/**
 * Writes the mirrored organisation into the harness library and parks everything that could not
 * be understood in {@code harness_dirty_queue}.
 *
 * <p>The dirty queue is the point of this class. The portal's data is hand-maintained and full
 * of edge cases; the only acceptable way to deal with one is to record it where an operator can
 * see it (A0-8, 03 §8.2). A parse failure that is swallowed looks exactly like a permission
 * nobody granted.
 */
@Repository
public class MirrorWriter {

    private final JdbcClient jdbc;

    public MirrorWriter(@Qualifier("jdbc") JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    // ------------------------------------------------------------------ organisation

    public void upsertDepartment(int nodeId, String name, int parentId, Integer directorId, Integer gradeId,
                                Integer delFlag, int level, String path, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_org_node
                          (node_id, name, parent_id, director_id, grade_id, level, path, delflag, synced_at)
                        VALUES (:id, :name, :parentId, :directorId, :gradeId, :level, :path, :delFlag, :now)
                        ON DUPLICATE KEY UPDATE
                          name = VALUES(name), parent_id = VALUES(parent_id),
                          director_id = VALUES(director_id), grade_id = VALUES(grade_id),
                          level = VALUES(level), path = VALUES(path), delflag = VALUES(delflag),
                          synced_at = VALUES(synced_at)
                        """)
                .param("id", nodeId)
                .param("name", name)
                .param("parentId", parentId)
                .param("directorId", directorId)
                .param("gradeId", gradeId)
                .param("level", level)
                .param("path", path)
                .param("delFlag", delFlag)
                .param("now", java.sql.Timestamp.from(now))
                .update();
    }

    public void upsertEmployee(int employeeId, String uuid, String name, Integer deptId, Integer positionGroupId,
                               Integer workpositionId, Integer gradeId, Integer isLeave, String empNo,
                               String email, boolean isAgent, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_org_employee
                          (employee_id, uuid, name, dept_id, position, workposition_id, grade_id, emp_no,
                           email, is_leave, is_agent, agent_ref, synced_at)
                        VALUES (:id, :uuid, :name, :deptId, :position, :workpositionId, :gradeId, :empNo,
                                :email, :isLeave, :isAgent, :agentRef, :now)
                        ON DUPLICATE KEY UPDATE
                          uuid = VALUES(uuid), name = VALUES(name), dept_id = VALUES(dept_id),
                          position = VALUES(position), workposition_id = VALUES(workposition_id),
                          grade_id = VALUES(grade_id), emp_no = VALUES(emp_no), email = VALUES(email),
                          is_leave = VALUES(is_leave), is_agent = VALUES(is_agent),
                          agent_ref = VALUES(agent_ref), synced_at = VALUES(synced_at)
                        """)
                .param("id", employeeId)
                .param("uuid", uuid)
                .param("name", name)
                .param("deptId", deptId)
                .param("position", positionGroupId)
                .param("workpositionId", workpositionId)
                .param("gradeId", gradeId)
                .param("empNo", empNo)
                .param("email", email)
                .param("isLeave", isLeave)
                .param("isAgent", isAgent ? 1 : 0)
                .param("agentRef", isAgent ? uuid : null)
                .param("now", java.sql.Timestamp.from(now))
                .update();
    }

    /**
     * Binds a position to a capability.
     *
     * <p>{@code sub_op} keeps the portal's sub-operation bit (the {@code .7} in {@code 351.7}) so
     * that a later comparison with the portal's own snapshot can be exact rather than "roughly
     * the same menu".
     */
    public void bindCapability(int workpositionId, String capId, Integer functionId, String subOp,
                               String source, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_cap_binding
                          (workposition_id, cap_id, function_id, sub_op, source, synced_at)
                        VALUES (:positionId, :capId, :functionId, :subOp, :source, :now)
                        ON DUPLICATE KEY UPDATE
                          function_id = VALUES(function_id), sub_op = VALUES(sub_op),
                          source = VALUES(source), synced_at = VALUES(synced_at)
                        """)
                .param("positionId", workpositionId)
                .param("capId", capId)
                .param("functionId", functionId)
                .param("subOp", subOp)
                .param("source", source)
                .param("now", java.sql.Timestamp.from(now))
                .update();
    }

    public void deleteBindingsFor(int workpositionId, String source) {
        jdbc.sql("DELETE FROM harness_cap_binding WHERE workposition_id = :positionId AND source = :source")
                .param("positionId", workpositionId)
                .param("source", source)
                .update();
    }

    // ------------------------------------------------------------------ dirty queue

    /**
     * Records a value that could not be interpreted.
     *
     * <p>The row is keyed by (source, object type, object reference, field), so a value that
     * stays broken does not pile up: its occurrence counter grows instead. The queue is a work
     * list, not a log.
     */
    public void reportDirty(String source, String objectType, String objectRef, String field, String rawValue,
                            String reason, String severity, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_dirty_queue
                          (dirty_id, source, object_type, object_ref, field, raw_value, reason, severity,
                           occurrences, first_seen_at, last_seen_at, status)
                        VALUES (:id, :source, :objectType, :objectRef, :field, :rawValue, :reason, :severity,
                                1, :now, :now, 'open')
                        ON DUPLICATE KEY UPDATE
                          occurrences = occurrences + 1,
                          last_seen_at = VALUES(last_seen_at),
                          raw_value = VALUES(raw_value),
                          reason = VALUES(reason),
                          severity = VALUES(severity),
                          status = 'open'
                        """)
                .param("id", com.fuao.harness.protocol.Ids.newId())
                .param("source", source)
                .param("objectType", objectType)
                .param("objectRef", objectRef)
                .param("field", field)
                .param("rawValue", rawValue == null ? null : truncate(rawValue, 2000))
                .param("reason", truncate(reason, 250))
                .param("severity", severity)
                .param("now", java.sql.Timestamp.from(now))
                .update();
    }

    public void resolveDirty(String source, String objectType, String objectRef, String field,
                             String resolution, String resolvedBy, Instant now) {
        jdbc.sql("""
                        UPDATE harness_dirty_queue
                           SET status = 'resolved', resolution = :resolution, resolved_by = :by,
                               resolved_at = :now
                         WHERE source = :source AND object_type = :objectType AND object_ref = :objectRef
                           AND field = :field AND status = 'open'
                        """)
                .param("resolution", truncate(resolution, 500))
                .param("by", resolvedBy)
                .param("now", java.sql.Timestamp.from(now))
                .param("source", source)
                .param("objectType", objectType)
                .param("objectRef", objectRef)
                .param("field", field)
                .update();
    }

    public int openDirtyCount() {
        return jdbc.sql("SELECT COUNT(*) FROM harness_dirty_queue WHERE status = 'open'")
                .query(Integer.class)
                .single();
    }

    public List<Map<String, Object>> openDirty(int limit) {
        return jdbc.sql("""
                        SELECT source, object_type, object_ref, field, raw_value, reason, severity, occurrences
                          FROM harness_dirty_queue
                         WHERE status = 'open'
                         ORDER BY severity DESC, occurrences DESC
                         LIMIT :limit
                        """)
                .param("limit", limit)
                .query((rs, i) -> {
                    Map<String, Object> row = new java.util.LinkedHashMap<>();
                    row.put("source", rs.getString("source"));
                    row.put("objectType", rs.getString("object_type"));
                    row.put("objectRef", rs.getString("object_ref"));
                    row.put("field", rs.getString("field"));
                    row.put("rawValue", rs.getString("raw_value"));
                    row.put("reason", rs.getString("reason"));
                    row.put("severity", rs.getString("severity"));
                    row.put("occurrences", rs.getInt("occurrences"));
                    return row;
                })
                .list();
    }

    private static String truncate(String value, int max) {
        if (value == null) {
            return null;
        }
        return value.length() <= max ? value : value.substring(0, max - 3) + "...";
    }
}
