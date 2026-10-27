package com.fuao.harness.platform.repo;

import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.policy.CapabilityDescriptor;
import com.fuao.harness.policy.Scope;
import com.fuao.harness.protocol.json.Json;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/** {@code harness_capability} and {@code harness_grant} access. */
@Repository
public class CapabilityRepository {

    private final JdbcClient jdbc;

    public CapabilityRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    private static final String CAP_COLUMNS = """
            cap_id, cap_key, name, kind, side_effect, reversible, blast_radius, requires_human,
            min_level, risk_class, destructive, approval_policy, timeout_ms, status
            """;

    public Optional<CapabilityDescriptor> findByKey(String capKey) {
        return jdbc.sql("SELECT " + CAP_COLUMNS + " FROM harness_capability WHERE cap_key = :capKey")
                .param("capKey", capKey)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public Optional<CapabilityDescriptor> findById(String capId) {
        return jdbc.sql("SELECT " + CAP_COLUMNS + " FROM harness_capability WHERE cap_id = :capId")
                .param("capId", capId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    /** The cap key of a capability id, or the id itself when the capability is unknown. */
    public String capKeyOf(String capId) {
        if (capId == null || capId.isBlank()) {
            return "";
        }
        return jdbc.sql("SELECT cap_key FROM harness_capability WHERE cap_id = :id")
                .param("id", capId)
                .query(String.class)
                .optional()
                .orElse(capId);
    }

    public List<CapabilityDescriptor> findAllByKeys(List<String> capKeys) {
        if (capKeys == null || capKeys.isEmpty()) {
            return List.of();
        }
        return jdbc.sql("SELECT " + CAP_COLUMNS + " FROM harness_capability WHERE cap_key IN (:capKeys)")
                .param("capKeys", capKeys)
                .query((rs, i) -> map(rs))
                .list();
    }

    private static CapabilityDescriptor map(java.sql.ResultSet rs) throws java.sql.SQLException {
        CapabilityDescriptor.Status status = switch (rs.getString("status")) {
            case "active" -> CapabilityDescriptor.Status.ACTIVE;
            case "disabled" -> CapabilityDescriptor.Status.DISABLED;
            default -> CapabilityDescriptor.Status.KILL_SWITCHED;
        };
        return new CapabilityDescriptor(
                rs.getString("cap_id"),
                rs.getString("cap_key"),
                rs.getString("kind"),
                CapabilityDescriptor.SideEffect.of(rs.getString("side_effect")),
                rs.getInt("reversible") == 1,
                rs.getInt("blast_radius"),
                rs.getInt("requires_human") == 1,
                rs.getInt("min_level"),
                rs.getString("risk_class"),
                rs.getInt("destructive") == 1,
                CapabilityDescriptor.ApprovalPolicy.of(rs.getString("approval_policy")),
                rs.getInt("timeout_ms"),
                status);
    }

    // ------------------------------------------------------------------ grants

    public List<PolicyInputs.GrantRow> grantsFor(String agentId, String capId) {
        return jdbc.sql("""
                        SELECT grant_id, agent_id, cap_id, scope, granted_at, expires_at, granted_by,
                               reason, revoked_at, status
                          FROM harness_grant
                         WHERE agent_id = :agentId AND cap_id = :capId
                         ORDER BY granted_at
                        """)
                .param("agentId", agentId)
                .param("capId", capId)
                .query((rs, i) -> new PolicyInputs.GrantRow(
                        rs.getString("grant_id"),
                        rs.getString("agent_id"),
                        rs.getString("cap_id"),
                        Scope.fromMap(readScope(rs.getString("scope"))),
                        rs.getTimestamp("granted_at").toInstant(),
                        rs.getTimestamp("expires_at").toInstant(),
                        rs.getString("granted_by"),
                        rs.getString("reason"),
                        rs.getTimestamp("revoked_at") == null ? null : rs.getTimestamp("revoked_at").toInstant(),
                        rs.getString("status")))
                .list();
    }

    /** The live grants of one agent, or of every agent when no agent is named. */
    public List<PolicyInputs.GrantRow> activeGrantsFor(String agentId) {
        return jdbc.sql("""
                        SELECT grant_id, agent_id, cap_id, scope, granted_at, expires_at, granted_by,
                               reason, revoked_at, status
                          FROM harness_grant
                         WHERE (:agentId IS NULL OR agent_id = :agentId)
                           AND status = 'active' AND expires_at > NOW()
                         ORDER BY granted_at DESC
                        """)
                .param("agentId", agentId)
                .query((rs, i) -> new PolicyInputs.GrantRow(
                        rs.getString("grant_id"),
                        rs.getString("agent_id"),
                        rs.getString("cap_id"),
                        Scope.fromMap(readScope(rs.getString("scope"))),
                        rs.getTimestamp("granted_at").toInstant(),
                        rs.getTimestamp("expires_at").toInstant(),
                        rs.getString("granted_by"),
                        rs.getString("reason"),
                        null,
                        rs.getString("status")))
                .list();
    }

    /**
     * The capabilities an agent currently holds, as cap keys.
     *
     * <p>This is the answer to "what may this agent do right now", and it is what the terminal
     * asks the platform for: the platform holds the grants, so the platform is the only place
     * that can answer it. A revoked or expired grant disappears from the list by itself.
     */
    public List<String> activeCapKeysFor(String agentId) {
        if (agentId == null || agentId.isBlank()) {
            return List.of();
        }
        return jdbc.sql("""
                        SELECT c.cap_key
                          FROM harness_grant g
                          JOIN harness_capability c ON c.cap_id = g.cap_id
                         WHERE g.agent_id = :agentId AND g.status = 'active' AND g.expires_at > NOW()
                           AND c.status = 'active'
                         ORDER BY c.cap_key
                        """)
                .param("agentId", agentId)
                .query(String.class)
                .list();
    }

    public void insertGrant(PolicyInputs.GrantRow grant) {
        jdbc.sql("""
                        INSERT INTO harness_grant
                          (grant_id, agent_id, cap_id, scope, ttl_seconds, granted_at, expires_at,
                           granted_by, reason, status)
                        VALUES
                          (:grantId, :agentId, :capId, :scope, :ttlSeconds, :grantedAt, :expiresAt,
                           :grantedBy, :reason, 'active')
                        """)
                .param("grantId", grant.grantId())
                .param("agentId", grant.agentId())
                .param("capId", grant.capId())
                .param("scope", Json.canonical(grant.scope().toMap()))
                .param("ttlSeconds", (int) java.time.Duration.between(grant.grantedAt(), grant.expiresAt()).toSeconds())
                .param("grantedAt", java.sql.Timestamp.from(grant.grantedAt()))
                .param("expiresAt", java.sql.Timestamp.from(grant.expiresAt()))
                .param("grantedBy", grant.grantedBy())
                .param("reason", grant.reason())
                .update();
    }

    public boolean revokeGrant(String grantId, Instant at) {
        return jdbc.sql("""
                        UPDATE harness_grant
                           SET status = 'revoked', revoked_at = :at
                         WHERE grant_id = :grantId AND status = 'active'
                        """)
                .param("grantId", grantId)
                .param("at", java.sql.Timestamp.from(at))
                .update() == 1;
    }

    @SuppressWarnings("unchecked")
    private static Map<String, Object> readScope(String json) {
        Object parsed = Json.parse(json == null || json.isBlank() ? "{}" : json);
        return parsed instanceof Map ? (Map<String, Object>) parsed : Map.of();
    }
}