package com.fuao.harness.platform.repo;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.domain.AgentTemplateRecord;
import com.fuao.harness.policy.AgentLookup;
import com.fuao.harness.policy.AutonomyLevel;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/** {@code harness_agent} and {@code harness_agent_template} access. */
@Repository
public class AgentRepository {

    private final JdbcClient jdbc;

    public AgentRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    private static final String AGENT_COLUMNS = """
            agent_id, agent_key, name, agent_type, template_id, portal_employee_id, portal_user_id,
            portal_workposition_id, dept_id, reports_to, owner_id, autonomy_level, model_id, local_model,
            status, created_at, updated_at
            """;

    public Optional<AgentRecord> findById(String agentId) {
        return jdbc.sql("SELECT " + AGENT_COLUMNS + " FROM harness_agent WHERE agent_id = :agentId")
                .param("agentId", agentId)
                .query((rs, i) -> mapAgent(rs))
                .optional();
    }

    public Optional<AgentRecord> findByKey(String agentKey) {
        return jdbc.sql("SELECT " + AGENT_COLUMNS + " FROM harness_agent WHERE agent_key = :agentKey")
                .param("agentKey", agentKey)
                .query((rs, i) -> mapAgent(rs))
                .optional();
    }

    public boolean existsByKey(String agentKey) {
        return findByKey(agentKey).isPresent();
    }

    public List<AgentRecord> list(String status, Integer deptId, int limit) {
        StringBuilder sql = new StringBuilder("SELECT " + AGENT_COLUMNS + " FROM harness_agent WHERE 1=1");
        if (status != null && !status.isBlank()) {
            sql.append(" AND status = :status");
        }
        if (deptId != null) {
            sql.append(" AND dept_id = :deptId");
        }
        sql.append(" ORDER BY created_at DESC LIMIT :limit");
        JdbcClient.StatementSpec spec = jdbc.sql(sql.toString());
        if (status != null && !status.isBlank()) {
            spec = spec.param("status", AgentRecord.AgentStatus.fromWire(status).wire());
        }
        if (deptId != null) {
            spec = spec.param("deptId", deptId);
        }
        return spec.param("limit", limit).query((rs, i) -> mapAgent(rs)).list();
    }

    public void insert(AgentRecord a) {
        jdbc.sql("""
                        INSERT INTO harness_agent
                          (agent_id, agent_key, name, agent_type, template_id, portal_employee_id,
                           portal_user_id, portal_workposition_id, dept_id, reports_to, owner_id,
                           autonomy_level, model_id, local_model, status, created_at, updated_at)
                        VALUES
                          (:agentId, :agentKey, :name, :agentType, :templateId, NULL, NULL, :workpositionId,
                           :deptId, :reportsTo, :ownerId, :autonomyLevel, :modelId, :localModel,
                           :status, :createdAt, :updatedAt)
                        """)
                .param("agentId", a.agentId())
                .param("agentKey", a.agentKey())
                .param("name", a.name())
                .param("agentType", a.agentType().wire())
                .param("templateId", a.templateId())
                .param("workpositionId", a.portalWorkpositionId())
                .param("deptId", a.deptId())
                .param("reportsTo", a.reportsTo())
                .param("ownerId", a.ownerId())
                .param("autonomyLevel", a.autonomyLevel())
                .param("modelId", a.modelId())
                .param("localModel", a.localModel())
                .param("status", a.status().wire())
                .param("createdAt", java.sql.Timestamp.from(a.createdAt()))
                .param("updatedAt", java.sql.Timestamp.from(a.updatedAt()))
                .update();
    }

    /** @return 1 when this call performed the transition, 0 when somebody else got there first */
    public int updateStatus(String agentId, AgentRecord.AgentStatus from, AgentRecord.AgentStatus to) {
        return jdbc.sql("""
                        UPDATE harness_agent
                           SET status = :to, updated_at = NOW()
                         WHERE agent_id = :agentId AND status = :from
                        """)
                .param("agentId", agentId)
                .param("from", from.wire())
                .param("to", to.wire())
                .update();
    }

    public void updateAutonomyLevel(String agentId, AutonomyLevel level, String reason) {
        jdbc.sql("UPDATE harness_agent SET autonomy_level = :level, updated_at = NOW() WHERE agent_id = :agentId")
                .param("agentId", agentId)
                .param("level", level.level())
                .update();
    }

    public void attachPortalIdentity(String agentId, int employeeId, int userId) {
        jdbc.sql("""
                        UPDATE harness_agent
                           SET portal_employee_id = :employeeId,
                               portal_user_id = :userId,
                               status = IF(status = 'draft', 'onboarding', status),
                               updated_at = NOW()
                         WHERE agent_id = :agentId
                        """)
                .param("agentId", agentId)
                .param("employeeId", employeeId)
                .param("userId", userId)
                .update();
    }

    public Optional<AgentLookup> lookupForPolicy(String agentId) {
        return jdbc.sql("""
                        SELECT agent_id, agent_key, name, dept_id, autonomy_level, status, owner_id
                          FROM harness_agent WHERE agent_id = :agentId
                        """)
                .param("agentId", agentId)
                .query((rs, i) -> new AgentLookup(
                        rs.getString("agent_id"),
                        rs.getString("agent_key"),
                        rs.getString("name"),
                        (Integer) rs.getObject("dept_id"),
                        AutonomyLevel.of(rs.getInt("autonomy_level")),
                        com.fuao.harness.policy.AgentState.fromWire(rs.getString("status")),
                        rs.getInt("owner_id")))
                .optional();
    }

    public void logStateChange(String agentId, AgentRecord.AgentStatus from, AgentRecord.AgentStatus to,
                               String reason, String changedBy, Map<String, Object> snapshot) {
        jdbc.sql("""
                        INSERT INTO harness_agent_state_log
                          (agent_id, from_status, to_status, reason, changed_by, snapshot, at)
                        VALUES (:agentId, :from, :to, :reason, :changedBy, :snapshot, NOW())
                        """)
                .param("agentId", agentId)
                .param("from", from == null ? null : from.wire())
                .param("to", to.wire())
                .param("reason", reason)
                .param("changedBy", changedBy)
                .param("snapshot", snapshot == null ? "{}" : com.fuao.harness.protocol.json.Json.canonical(snapshot))
                .update();
    }

    public List<AgentTemplateRecord> listTemplates(boolean includeDeprecated) {
        String sql = """
                SELECT template_id, template_key, name, agent_type, domain, description, autonomy_level,
                       model_id, local_model, goals, skill_refs, position_hint, cap_keys, built_in
                  FROM harness_agent_template
                 WHERE 1=1
                """ + (includeDeprecated ? "" : " AND status = 'active'")
                + " ORDER BY domain, name";
        return jdbc.sql(sql).query((rs, i) -> new AgentTemplateRecord(
                rs.getString("template_id"),
                rs.getString("template_key"),
                rs.getString("name"),
                rs.getString("agent_type"),
                rs.getString("domain"),
                rs.getString("description"),
                rs.getInt("autonomy_level"),
                rs.getString("model_id"),
                rs.getString("local_model"),
                stringList(rs.getString("goals")),
                stringList(rs.getString("skill_refs")),
                (Integer) rs.getObject("position_hint"),
                stringList(rs.getString("cap_keys")),
                rs.getInt("built_in") == 1)).list();
    }

    public Optional<AgentTemplateRecord> findTemplate(String templateKey) {
        return jdbc.sql("""
                        SELECT template_id, template_key, name, agent_type, domain, description, autonomy_level,
                               model_id, local_model, goals, skill_refs, position_hint, cap_keys, built_in
                          FROM harness_agent_template WHERE template_key = :key
                        """)
                .param("key", templateKey)
                .query((rs, i) -> new AgentTemplateRecord(
                        rs.getString("template_id"),
                        rs.getString("template_key"),
                        rs.getString("name"),
                        rs.getString("agent_type"),
                        rs.getString("domain"),
                        rs.getString("description"),
                        rs.getInt("autonomy_level"),
                        rs.getString("model_id"),
                        rs.getString("local_model"),
                        stringList(rs.getString("goals")),
                        stringList(rs.getString("skill_refs")),
                        (Integer) rs.getObject("position_hint"),
                        stringList(rs.getString("cap_keys")),
                        rs.getInt("built_in") == 1))
                .optional();
    }

    static AgentRecord mapAgent(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new AgentRecord(
                rs.getString("agent_id"),
                rs.getString("agent_key"),
                rs.getString("name"),
                AgentRecord.AgentType.valueOf(rs.getString("agent_type").toUpperCase()),
                rs.getString("template_id"),
                (Integer) rs.getObject("portal_employee_id"),
                (Integer) rs.getObject("portal_user_id"),
                (Integer) rs.getObject("portal_workposition_id"),
                rs.getInt("dept_id"),
                (Integer) rs.getObject("reports_to"),
                rs.getInt("owner_id"),
                rs.getInt("autonomy_level"),
                rs.getString("model_id"),
                rs.getString("local_model"),
                AgentRecord.AgentStatus.fromWire(rs.getString("status")),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant());
    }

    @SuppressWarnings("unchecked")
    public static Map<String, Object> stringListAsMap(String json) {
        if (json == null || json.isBlank()) {
            return Map.of();
        }
        Object parsed = com.fuao.harness.protocol.json.Json.parse(json);
        return parsed instanceof Map ? (Map<String, Object>) parsed : Map.of();
    }

    static List<String> stringList(String json) {
        if (json == null || json.isBlank()) {
            return List.of();
        }
        Object parsed = com.fuao.harness.protocol.json.Json.parse(json);
        if (parsed instanceof List<?> list) {
            return list.stream().map(String::valueOf).toList();
        }
        return List.of();
    }
}