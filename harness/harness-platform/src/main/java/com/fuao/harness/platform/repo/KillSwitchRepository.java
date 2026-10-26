package com.fuao.harness.platform.repo;

import com.fuao.harness.policy.KillSwitchState;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/** {@code harness_killswitch} access (04 §8.2). */
@Repository
public class KillSwitchRepository {

    private final JdbcClient jdbc;

    public KillSwitchRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    public record Switch(String switchId, String scope, String scopeId, String effect, boolean active,
                         String reason, String activatedBy, Instant activatedAt) {

        public KillSwitchState.Switch toState() {
            return new KillSwitchState.Switch(
                    KillSwitchState.Scope.valueOf(scope.toUpperCase(Locale.ROOT)),
                    scopeId,
                    KillSwitchState.Effect.valueOf(effect.toUpperCase(Locale.ROOT)));
        }
    }

    /**
     * Every active switch, which is what the policy engine consults. It is a small table by
     * construction - five granularities, one row per active switch - so reading it whole is
     * cheaper and far less bug-prone than caching parts of it.
     */
    public KillSwitchState activeState() {
        List<KillSwitchState.Switch> switches = jdbc.sql("""
                        SELECT scope, scope_id, effect FROM harness_killswitch WHERE active = 1
                        """)
                .query((rs, i) -> new KillSwitchState.Switch(
                        KillSwitchState.Scope.valueOf(rs.getString("scope").toUpperCase(Locale.ROOT)),
                        rs.getString("scope_id"),
                        KillSwitchState.Effect.valueOf(rs.getString("effect").toUpperCase(Locale.ROOT))))
                .list();
        return new KillSwitchState(switches);
    }

    public List<Switch> list() {
        return jdbc.sql("""
                        SELECT switch_id, scope, scope_id, effect, active, reason, activated_by, activated_at
                          FROM harness_killswitch ORDER BY activated_at DESC
                        """)
                .query((rs, i) -> new Switch(
                        rs.getString("switch_id"),
                        rs.getString("scope"),
                        rs.getString("scope_id"),
                        rs.getString("effect"),
                        rs.getInt("active") == 1,
                        rs.getString("reason"),
                        rs.getString("activated_by"),
                        rs.getTimestamp("activated_at").toInstant()))
                .list();
    }

    public Optional<Switch> find(String switchId) {
        return jdbc.sql("""
                        SELECT switch_id, scope, scope_id, effect, active, reason, activated_by, activated_at
                          FROM harness_killswitch WHERE switch_id = :id
                        """)
                .param("id", switchId)
                .query((rs, i) -> new Switch(
                        rs.getString("switch_id"),
                        rs.getString("scope"),
                        rs.getString("scope_id"),
                        rs.getString("effect"),
                        rs.getInt("active") == 1,
                        rs.getString("reason"),
                        rs.getString("activated_by"),
                        rs.getTimestamp("activated_at").toInstant()))
                .optional();
    }

    public String activate(String scope, String scopeId, String effect, String reason, String activatedBy) {
        String id = com.fuao.harness.protocol.Ids.newId();
        jdbc.sql("""
                        INSERT INTO harness_killswitch
                          (switch_id, scope, scope_id, effect, active, reason, activated_by, activated_at)
                        VALUES (:id, :scope, :scopeId, :effect, 1, :reason, :by, NOW())
                        ON DUPLICATE KEY UPDATE
                          effect = VALUES(effect), active = 1, reason = VALUES(reason),
                          activated_by = VALUES(activated_by), activated_at = NOW(), released_by = NULL,
                          released_at = NULL
                        """)
                .param("id", id)
                .param("scope", scope.toLowerCase(Locale.ROOT))
                .param("scopeId", scopeId)
                .param("effect", effect.toLowerCase(Locale.ROOT))
                .param("reason", reason)
                .param("by", activatedBy)
                .update();
        return jdbc.sql("SELECT switch_id FROM harness_killswitch WHERE scope = :scope AND scope_id = :scopeId")
                .param("scope", scope.toLowerCase(Locale.ROOT))
                .param("scopeId", scopeId)
                .query(String.class)
                .single();
    }

    public boolean release(String switchId, String releasedBy) {
        return jdbc.sql("""
                        UPDATE harness_killswitch
                           SET active = 0, released_by = :by, released_at = NOW()
                         WHERE switch_id = :id AND active = 1
                        """)
                .param("id", switchId)
                .param("by", releasedBy)
                .update() == 1;
    }

    static Timestamp ts(Instant at) {
        return Timestamp.from(at);
    }
}