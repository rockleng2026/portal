package com.fuao.harness.protocol.event;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;
import org.junit.jupiter.api.Test;

class EventEnvelopeTest {

    private static final Instant AT = Instant.parse("2026-10-22T10:00:31Z");

    @Test
    void fingerprintIsStableForTheSameBusinessKey() {
        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("message_id", 88213);
        payload.put("content", "@leon 整理回款异常清单");

        String first = EventEnvelope.fingerprint("im", "msg:88213", payload);
        String second = EventEnvelope.fingerprint("im", "msg:88213", payload);

        assertEquals(first, second);
        assertTrue(first.length() <= 128);
    }

    @Test
    void fingerprintIgnoresKeyOrderButNotContent() {
        Map<String, Object> a = new LinkedHashMap<>();
        a.put("x", 1);
        a.put("y", 2);
        Map<String, Object> b = new LinkedHashMap<>();
        b.put("y", 2);
        b.put("x", 1);
        assertEquals(EventEnvelope.fingerprint("im", "k", a), EventEnvelope.fingerprint("im", "k", b));

        b.put("y", 3);
        assertNotEquals(EventEnvelope.fingerprint("im", "k", a), EventEnvelope.fingerprint("im", "k", b));
    }

    @Test
    void fingerprintSeparatesSources() {
        Map<String, Object> p = Map.of("a", 1);
        assertNotEquals(EventEnvelope.fingerprint("im", "k", p), EventEnvelope.fingerprint("email", "k", p));
    }

    @Test
    void windowBucketsByLatencyClass() {
        assertEquals(EventEnvelope.window(AT, LatencyClass.REALTIME),
                EventEnvelope.window(AT.plusSeconds(20), LatencyClass.REALTIME),
                "two realtime events 20s apart share a 1-minute window");
        assertNotEquals(EventEnvelope.window(AT, LatencyClass.REALTIME),
                EventEnvelope.window(AT.plusSeconds(90), LatencyClass.REALTIME));
        assertEquals(EventEnvelope.window(AT, LatencyClass.BATCH),
                EventEnvelope.window(AT.plusSeconds(60), LatencyClass.BATCH),
                "batch events share a daily window");
        assertNotEquals(EventEnvelope.window(AT, LatencyClass.BATCH),
                EventEnvelope.window(AT.plusSeconds(86400), LatencyClass.BATCH));
    }

    @Test
    void realtimeEventsRequireAnAcknowledgement() {
        assertTrue(LatencyClass.REALTIME.requiresAck());
        assertTrue(LatencyClass.REALTIME.sla().getSeconds() <= 10, "01 §8.2 sets a 10s realtime SLA");
        assertEquals(java.time.Duration.ofSeconds(60), LatencyClass.NEARLINE.sla());
    }

    @Test
    void createFillsDerivedFields() {
        EventEnvelope e = EventEnvelope.create("im", "group.at", "msg:88213", LatencyClass.REALTIME, 3,
                ContentTrust.UNTRUSTED, "portal:message:88213", Map.of("a", 1), "0198f0c2-0000-7000-8000-000000000001", AT);

        assertEquals(64, e.fingerprint().length());
        assertEquals("r" + (AT.getEpochSecond() / 60), e.eventWindow());
        assertEquals(ContentTrust.UNTRUSTED, e.contentTrust());
        assertTrue(e.requiresAcknowledgement());
    }
}