package com.fuao.harness.platform.repo;

import com.fuao.harness.protocol.event.ContentTrust;
import com.fuao.harness.protocol.event.EventEnvelope;
import com.fuao.harness.protocol.json.Json;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/**
 * {@code harness_event} access.
 *
 * <p>Ingestion is the interesting part: the dedup window is enforced by
 * {@code UNIQUE (fingerprint, event_window)} (errata E-01), so a burst of the same alert is a
 * single upsert that bumps a counter instead of thousands of rows that an agent would then have
 * to notice are the same thing (01 §7.3).
 */
@Repository
public class EventRepository {

    private final JdbcClient jdbc;

    public EventRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    public record IngestResult(String eventId, String fingerprint, String eventWindow, boolean deduplicated,
                               int dedupCount, long windowStartEpoch) {
    }

    public IngestResult ingest(EventEnvelope e) {
        int updated = jdbc.sql("""
                        INSERT INTO harness_event
                          (event_id, fingerprint, event_window, source, event_type, latency_class, priority,
                           payload, content_trust, source_ref, received_at, dedup_count, last_seen_at,
                           last_event_id, status)
                        VALUES
                          (:eventId, :fingerprint, :eventWindow, :source, :eventType, :latencyClass, :priority,
                           :payload, :contentTrust, :sourceRef, :receivedAt, 1, :receivedAt, :eventId, 'new')
                        ON DUPLICATE KEY UPDATE
                          dedup_count = dedup_count + 1,
                          last_seen_at = :receivedAt,
                          last_event_id = :eventId,
                          priority = LEAST(priority, :priority)
                        """)
                .param("eventId", e.eventId())
                .param("fingerprint", e.fingerprint())
                .param("eventWindow", e.eventWindow())
                .param("source", e.source())
                .param("eventType", e.eventType())
                .param("latencyClass", e.latencyClass().wireName())
                .param("priority", e.priority())
                .param("payload", Json.canonical(e.payload()))
                .param("contentTrust", e.contentTrust().name().toLowerCase())
                .param("sourceRef", e.sourceRef())
                .param("receivedAt", Timestamp.from(e.receivedAt()))
                .update();

        boolean deduplicated = updated == 2; // MySQL reports 2 for an ON DUPLICATE KEY UPDATE
        Integer count = jdbc.sql("SELECT dedup_count FROM harness_event WHERE fingerprint = :fp AND event_window = :win")
                .param("fp", e.fingerprint())
                .param("win", e.eventWindow())
                .query(Integer.class)
                .single();
        return new IngestResult(e.eventId(), e.fingerprint(), e.eventWindow(), deduplicated,
                count == null ? 1 : count, windowStartEpoch(e.receivedAt(), e.latencyClass()));
    }

    private static long windowStartEpoch(Instant at, com.fuao.harness.protocol.event.LatencyClass cls) {
        long epoch = at.getEpochSecond();
        return switch (cls) {
            case REALTIME -> (epoch / 60) * 60;
            case NEARLINE -> (epoch / 3600) * 3600;
            case BATCH -> (epoch / 86400) * 86400;
        };
    }

    public record EventRow(String eventId, String source, String eventType, String latencyClass, int priority,
                           String contentTrust, String sourceRef, int dedupCount, String status,
                           Instant receivedAt, Map<String, Object> payload) {
    }

    /** Polling fallback for portal (03 §9): events nobody has picked up yet. */
    public List<EventRow> poll(String status, int limit) {
        return jdbc.sql("""
                        SELECT event_id, source, event_type, latency_class, priority, content_trust, source_ref,
                               dedup_count, status, received_at, payload
                          FROM harness_event
                         WHERE (:status IS NULL OR status = :status)
                         ORDER BY priority ASC, received_at ASC
                         LIMIT :limit
                        """)
                .param("status", status)
                .param("limit", limit)
                .query((rs, i) -> new EventRow(
                        rs.getString("event_id"),
                        rs.getString("source"),
                        rs.getString("event_type"),
                        rs.getString("latency_class"),
                        rs.getInt("priority"),
                        rs.getString("content_trust"),
                        rs.getString("source_ref"),
                        rs.getInt("dedup_count"),
                        rs.getString("status"),
                        rs.getTimestamp("received_at").toInstant(),
                        AgentRepository.stringListAsMap(rs.getString("payload"))))
                .list();
    }

    public void markDispatched(String eventId, String status) {
        jdbc.sql("UPDATE harness_event SET status = :status WHERE event_id = :eventId")
                .param("eventId", eventId)
                .param("status", status)
                .update();
    }

    public long backlog(String status) {
        return jdbc.sql("SELECT COUNT(*) FROM harness_event WHERE status = :status")
                .param("status", status)
                .query(Long.class)
                .single();
    }

    static ContentTrust trustOf(String wire) {
        return "untrusted".equals(wire) ? ContentTrust.UNTRUSTED : ContentTrust.TRUSTED;
    }
}