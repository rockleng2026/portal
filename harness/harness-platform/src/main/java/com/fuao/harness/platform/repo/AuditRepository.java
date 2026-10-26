package com.fuao.harness.platform.repo;

import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Digests;
import com.fuao.harness.protocol.Ids;
import com.fuao.harness.protocol.json.Json;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * The append-only audit trail (01 §0 P4, 01 §16: "自主动作可回放").
 *
 * <p>Each row carries {@code prev_hash} and {@code entry_hash}, forming a hash chain over the
 * governance-relevant fields. It is not a signature and does not claim to be tamper-proof against
 * a database administrator - it makes silent edits and deletions detectable by
 * {@link #verifyChain()}, which is the level of guarantee an audit log can actually offer.
 *
 * <p>Entries are written in their own transaction ({@code REQUIRES_NEW}) so that a denial is
 * recorded even when the request that triggered it rolls back. Losing the record of a refused
 * action is exactly the failure this table exists to prevent.
 */
@Repository
public class AuditRepository {

    private final JdbcClient jdbc;

    public AuditRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    public record AuditEntry(
            String auditId,
            Instant at,
            String traceId,
            String actorType,
            String actorId,
            String op,
            String objectType,
            String objectId,
            String outcome,
            String reasonCode,
            String reason,
            Map<String, Object> evidence,
            String sourceIp,
            String prevHash,
            String entryHash) {
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public AuditEntry append(AuthenticatedClient actor, String traceId, String op, String objectType,
                             String objectId, String outcome, String reasonCode, String reason,
                             Map<String, Object> evidence, String sourceIp, Instant at) {
        AuditEntry previous = tail();
        String prevHash = previous == null ? "GENESIS" : previous.entryHash();
        String auditId = Ids.newId();

        // DATETIME(3) stores milliseconds. Hashing a nanosecond-precision instant would make every
        // entry unverifiable after a round trip, which is precisely the "the chain is broken and
        // nobody knows why" situation the chain exists to rule out.
        at = at.truncatedTo(java.time.temporal.ChronoUnit.MILLIS);

        Map<String, Object> canonical = new LinkedHashMap<>();
        canonical.put("audit_id", auditId);
        canonical.put("at", at.toString());
        canonical.put("trace_id", traceId);
        canonical.put("actor_type", actor.actorType());
        canonical.put("actor_id", actor.actorId());
        canonical.put("op", op);
        canonical.put("object_type", objectType);
        canonical.put("object_id", objectId);
        canonical.put("outcome", outcome);
        canonical.put("reason_code", bounded(reasonCode, 64));
        canonical.put("reason", bounded(reason, 1024));
        canonical.put("evidence", evidence == null ? Map.of() : evidence);
        canonical.put("source_ip", sourceIp);
        canonical.put("prev_hash", prevHash);
        String entryHash = Digests.sha256Hex(Json.canonicalBytes(canonical));

        jdbc.sql("""
                        INSERT INTO harness_audit
                          (audit_id, at, trace_id, actor_type, actor_id, op, object_type, object_id,
                           outcome, reason_code, reason, evidence, source_ip, prev_hash, entry_hash)
                        VALUES
                          (:auditId, :at, :traceId, :actorType, :actorId, :op, :objectType, :objectId,
                           :outcome, :reasonCode, :reason, :evidence, :sourceIp, :prevHash, :entryHash)
                        """)
                .param("auditId", auditId)
                .param("at", Timestamp.from(at))
                .param("traceId", traceId)
                .param("actorType", actor.actorType())
                .param("actorId", actor.actorId())
                .param("op", op)
                .param("objectType", objectType)
                .param("objectId", objectId)
                .param("outcome", outcome)
                .param("reasonCode", bounded(reasonCode, 64))
                .param("reason", bounded(reason, 1024))
                .param("evidence", Json.canonical(evidence == null ? Map.of() : evidence))
                .param("sourceIp", sourceIp)
                .param("prevHash", prevHash)
                .param("entryHash", entryHash)
                .update();

        return new AuditEntry(auditId, at, traceId, actor.actorType(), actor.actorId(), op, objectType, objectId,
                outcome, reasonCode, reason, evidence, sourceIp, prevHash, entryHash);
    }

    /** Column-bounded text; truncating beats failing the write of a decision record. */
    static String bounded(String value, int max) {
        if (value == null) {
            return null;
        }
        return value.length() <= max ? value : value.substring(0, max - 3) + "...";
    }

    public AuditEntry tail() {
        return jdbc.sql("""
                        SELECT audit_id, at, trace_id, actor_type, actor_id, op, object_type, object_id,
                               outcome, reason_code, reason, evidence, source_ip, prev_hash, entry_hash
                          FROM harness_audit ORDER BY at DESC, audit_id DESC LIMIT 1
                        """)
                .query((rs, i) -> map(rs))
                .optional()
                .orElse(null);
    }

    /** Everything that happened inside one request or one task: the replay view (01 §0 P4). */
    public List<AuditEntry> byTrace(String traceId) {
        return jdbc.sql("""
                        SELECT audit_id, at, trace_id, actor_type, actor_id, op, object_type, object_id,
                               outcome, reason_code, reason, evidence, source_ip, prev_hash, entry_hash
                          FROM harness_audit WHERE trace_id = :traceId ORDER BY at ASC, audit_id ASC
                        """)
                .param("traceId", traceId)
                .query((rs, i) -> map(rs))
                .list();
    }

    public List<AuditEntry> search(String objectType, String objectId, String outcome, int limit) {
        return jdbc.sql("""
                        SELECT audit_id, at, trace_id, actor_type, actor_id, op, object_type, object_id,
                               outcome, reason_code, reason, evidence, source_ip, prev_hash, entry_hash
                          FROM harness_audit
                         WHERE (:objectType IS NULL OR object_type = :objectType)
                           AND (:objectId IS NULL OR object_id = :objectId)
                           AND (:outcome IS NULL OR outcome = :outcome)
                         ORDER BY at DESC LIMIT :limit
                        """)
                .param("objectType", objectType)
                .param("objectId", objectId)
                .param("outcome", outcome)
                .param("limit", limit)
                .query((rs, i) -> map(rs))
                .list();
    }

    /**
     * Walks the chain and recomputes every hash.
     *
     * @return the audit id of the first entry whose hash does not match, or {@code null} when the
     *         chain is intact from the beginning of retained data
     */
    public String verifyChain() {
        List<AuditEntry> entries = jdbc.sql("""
                        SELECT audit_id, at, trace_id, actor_type, actor_id, op, object_type, object_id,
                               outcome, reason_code, reason, evidence, source_ip, prev_hash, entry_hash
                          FROM harness_audit ORDER BY at ASC, audit_id ASC
                        """)
                .query((rs, i) -> map(rs))
                .list();

        String expectedPrev = "GENESIS";
        for (AuditEntry e : entries) {
            Map<String, Object> canonical = new LinkedHashMap<>();
            canonical.put("audit_id", e.auditId());
            canonical.put("at", e.at().toString());
            canonical.put("trace_id", e.traceId());
            canonical.put("actor_type", e.actorType());
            canonical.put("actor_id", e.actorId());
            canonical.put("op", e.op());
            canonical.put("object_type", e.objectType());
            canonical.put("object_id", e.objectId());
            canonical.put("outcome", e.outcome());
            canonical.put("reason_code", bounded(e.reasonCode(), 64));
            canonical.put("reason", bounded(e.reason(), 1024));
            canonical.put("evidence", e.evidence() == null ? Map.of() : e.evidence());
            canonical.put("source_ip", e.sourceIp());
            canonical.put("prev_hash", expectedPrev);
            String recomputed = Digests.sha256Hex(Json.canonicalBytes(canonical));
            if (!e.prevHash().equals(expectedPrev) || !recomputed.equals(e.entryHash())) {
                return e.auditId();
            }
            expectedPrev = e.entryHash();
        }
        return null;
    }

    private static AuditEntry map(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new AuditEntry(
                rs.getString("audit_id"),
                rs.getTimestamp("at").toInstant(),
                rs.getString("trace_id"),
                rs.getString("actor_type"),
                rs.getString("actor_id"),
                rs.getString("op"),
                rs.getString("object_type"),
                rs.getString("object_id"),
                rs.getString("outcome"),
                rs.getString("reason_code"),
                rs.getString("reason"),
                AgentRepository.stringListAsMap(rs.getString("evidence")),
                rs.getString("source_ip"),
                rs.getString("prev_hash"),
                rs.getString("entry_hash"));
    }
}