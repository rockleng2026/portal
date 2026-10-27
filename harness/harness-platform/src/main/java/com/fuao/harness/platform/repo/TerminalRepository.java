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

/** {@code harness_terminal} access (03 §2.1, 03 §3.5). */
@Repository
public class TerminalRepository {

    private final JdbcClient jdbc;

    public TerminalRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    private static final String COLUMNS = """
            terminal_id, device_id, os, os_version, hostname, agent_id, bind_type, portal_employee_id,
            status, agent_version, last_heartbeat, bound_at, revoked_at
            """;

    public String insert(String terminalId, String deviceId, String os, String osVersion, String hostname,
                         String agentVersion, Map<String, Object> capabilities, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_terminal
                          (terminal_id, device_id, os, os_version, hostname, agent_id, bind_type,
                           portal_employee_id, status, agent_version, capabilities, last_heartbeat)
                        VALUES
                          (:id, :deviceId, :os, :osVersion, :hostname, NULL, 'none', NULL, 'binding',
                           :agentVersion, :capabilities, :lastHeartbeat)
                        ON DUPLICATE KEY UPDATE
                          os_version = VALUES(os_version), hostname = VALUES(hostname),
                          agent_version = VALUES(agent_version), capabilities = VALUES(capabilities),
                          last_heartbeat = VALUES(last_heartbeat),
                          status = IF(status = 'revoked', 'revoked', status)
                        """)
                .param("id", terminalId)
                .param("deviceId", deviceId)
                .param("os", os)
                .param("osVersion", osVersion)
                .param("hostname", hostname)
                .param("agentVersion", agentVersion)
                .param("capabilities", Json.canonical(capabilities == null ? Map.of() : capabilities))
                .param("lastHeartbeat", Timestamp.from(now))
                .update();
        return jdbc.sql("SELECT terminal_id FROM harness_terminal WHERE device_id = :deviceId")
                .param("deviceId", deviceId)
                .query(String.class)
                .single();
    }

    public Optional<PolicyInputs.TerminalRow> findByDevice(String deviceId) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_terminal WHERE device_id = :deviceId")
                .param("deviceId", deviceId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public Optional<PolicyInputs.TerminalRow> findById(String terminalId) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_terminal WHERE terminal_id = :id")
                .param("id", terminalId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public List<PolicyInputs.TerminalRow> list(int limit) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_terminal ORDER BY last_heartbeat DESC LIMIT :limit")
                .param("limit", limit)
                .query((rs, i) -> map(rs))
                .list();
    }

    public boolean bind(String terminalId, String agentId, String bindType, Integer employeeId, Instant at) {
        return jdbc.sql("""
                        UPDATE harness_terminal
                           SET agent_id = :agentId, bind_type = :bindType, portal_employee_id = :employeeId,
                               status = 'online', bound_at = :at
                         WHERE terminal_id = :id AND status IN ('unbound', 'binding', 'online')
                        """)
                .param("id", terminalId)
                .param("agentId", agentId)
                .param("bindType", bindType)
                .param("employeeId", employeeId)
                .param("at", Timestamp.from(at))
                .update() == 1;
    }

    /**
     * One heartbeat from the device.
     *
     * <p>A terminal that was marked offline because it stopped heartbeating has to be able to
     * come back: the heartbeat is the proof that it is there (04 §2.2 A0-6: "恢复 → 自动回绿").
     * A terminal that is still waiting to be bound stays as it is, and a revoked one is not
     * resurrected - the WHERE clause keeps it out.
     */
    public boolean heartbeat(String terminalId, Instant at) {
        return jdbc.sql("""
                        UPDATE harness_terminal
                           SET last_heartbeat = :at,
                               status = CASE WHEN status IN ('unbound', 'binding') THEN status
                                            ELSE 'online' END
                         WHERE terminal_id = :id AND status <> 'revoked'
                        """)
                .param("id", terminalId)
                .param("at", Timestamp.from(at))
                .update() == 1;
    }

    public boolean revoke(String terminalId, Instant at) {
        return jdbc.sql("""
                        UPDATE harness_terminal
                           SET status = 'revoked', revoked_at = :at, agent_id = NULL, bind_type = 'none'
                         WHERE terminal_id = :id
                        """)
                .param("id", terminalId)
                .param("at", Timestamp.from(at))
                .update() == 1;
    }

    /**
     * Disables every principal that authenticates as this terminal.
     *
     * <p>A0-5 says a revoked terminal loses <em>all</em> capabilities within 30 seconds, not just
     * its heartbeat. The device credential is a principal in {@code harness_principal}, so the
     * revocation has to reach it - otherwise the device keeps its API access and only its
     * heartbeat is refused.
     */
    public int disablePrincipalsFor(String terminalId) {
        return jdbc.sql("""
                        UPDATE harness_principal
                           SET status = 'disabled'
                         WHERE terminal_id = :id AND status = 'active'
                        """)
                .param("id", terminalId)
                .update();
    }

    /** The terminal's current status, or {@code null} when the device is unknown. */
    public String statusOf(String terminalId) {
        return jdbc.sql("SELECT status FROM harness_terminal WHERE terminal_id = :id")
                .param("id", terminalId)
                .query(String.class)
                .optional()
                .orElse(null);
    }

    public int markStaleOffline(Instant cutoff) {
        return jdbc.sql("UPDATE harness_terminal SET status = 'offline' "
                        + "WHERE status = 'online' AND (last_heartbeat IS NULL OR last_heartbeat < :cutoff)")
                .param("cutoff", Timestamp.from(cutoff))
                .update();
    }

    public long countByStatus(String status) {
        return jdbc.sql("SELECT COUNT(*) FROM harness_terminal WHERE status = :status")
                .param("status", status)
                .query(Long.class)
                .single();
    }

    private static PolicyInputs.TerminalRow map(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new PolicyInputs.TerminalRow(
                rs.getString("terminal_id"),
                rs.getString("device_id"),
                rs.getString("os"),
                rs.getString("agent_id"),
                rs.getString("bind_type"),
                (Integer) rs.getObject("portal_employee_id"),
                rs.getString("status"),
                rs.getString("agent_version"),
                rs.getTimestamp("last_heartbeat") == null ? null : rs.getTimestamp("last_heartbeat").toInstant(),
                rs.getTimestamp("bound_at") == null ? null : rs.getTimestamp("bound_at").toInstant(),
                rs.getTimestamp("revoked_at") == null ? null : rs.getTimestamp("revoked_at").toInstant());
    }
}