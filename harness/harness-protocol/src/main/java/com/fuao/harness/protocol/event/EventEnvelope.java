package com.fuao.harness.protocol.event;

import java.time.Instant;
import java.util.Map;
import com.fuao.harness.protocol.Digests;
import com.fuao.harness.protocol.json.Json;

/**
 * The one event shape every trigger source funnels into (03 §4, 01 §8.2).
 *
 * <p>Dedup: {@code harness_event} has {@code UNIQUE (fingerprint, event_window)} (errata E-01).
 * {@link #fingerprint} must therefore be stable across redelivery of the same trigger, while
 * {@link #window} buckets time so that "the same alert storm" collapses into one row with a
 * counter instead of one row per line of a log file (A2-8, 01 §7.3).
 */
public record EventEnvelope(
        String eventId,
        String source,
        String eventType,
        LatencyClass latencyClass,
        int priority,
        ContentTrust contentTrust,
        String fingerprint,
        String eventWindow,
        String sourceRef,
        Map<String, Object> payload,
        Instant receivedAt) {

    public EventEnvelope {
        if (source == null || source.isBlank()) {
            throw new IllegalArgumentException("source is required");
        }
        if (eventType == null || eventType.isBlank()) {
            throw new IllegalArgumentException("eventType is required");
        }
        payload = payload == null ? Map.of() : Map.copyOf(payload);
    }

    /**
     * {@code sha256(source + ":" + businessKey + ":" + sha256(canonical(payload)))}, i.e. 64 hex
     * characters, comfortably inside the {@code VARCHAR(128)} column.
     *
     * @param businessKey stable business identity of the trigger, e.g. {@code msg:88213} or
     *                    {@code alert:cdn:node-7:5xx}. Two deliveries of the same trigger must
     *                    produce the same key - that is the whole point of the column.
     */
    public static String fingerprint(String source, String businessKey, Map<String, Object> payload) {
        String payloadHash = Digests.sha256Hex(Json.canonicalBytes(payload == null ? Map.of() : payload));
        return Digests.sha256Hex(source + ":" + businessKey + ":" + payloadHash);
    }

    /** Time bucket for {@code event_window}, derived from the latency class. */
    public static String window(Instant at, LatencyClass latencyClass) {
        long epoch = at.getEpochSecond();
        long bucket = switch (latencyClass) {
            case REALTIME -> epoch / 60;
            case NEARLINE -> epoch / 3600;
            case BATCH -> epoch / 86400;
        };
        return latencyClass.wireName().substring(0, 1) + bucket;
    }

    /** Factory that fills in id, fingerprint and window from the canonical inputs. */
    public static EventEnvelope create(String source,
                                       String eventType,
                                       String businessKey,
                                       LatencyClass latencyClass,
                                       int priority,
                                       ContentTrust contentTrust,
                                       String sourceRef,
                                       Map<String, Object> payload,
                                       String eventId,
                                       Instant receivedAt) {
        return new EventEnvelope(
                eventId,
                source,
                eventType,
                latencyClass,
                priority,
                contentTrust,
                fingerprint(source, businessKey, payload),
                window(receivedAt, latencyClass),
                sourceRef,
                payload,
                receivedAt);
    }

    public boolean requiresAcknowledgement() {
        return latencyClass.requiresAck();
    }
}