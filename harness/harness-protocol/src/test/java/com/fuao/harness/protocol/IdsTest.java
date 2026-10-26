package com.fuao.harness.protocol;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.Test;

class IdsTest {

    @Test
    void producesVersion7Variant1Uuids() {
        UUID u = Ids.uuid7();
        assertEquals(7, u.version(), "version nibble must be 7");
        assertEquals(7, Ids.versionOf(u), "RFC 9562 version nibble must be 7");
        assertEquals(2, u.variant(), "variant must be RFC 9562 (0b10)");
    }

    @Test
    void theTimestampSurvivesTheRoundTrip() {
        // Before the RFC 9562 fix only 32 bits of the millisecond counter were kept, so the
        // decoded timestamp was wrong by multiples of 2^32 milliseconds (~56.8 years).
        long before = System.currentTimeMillis();
        UUID u = Ids.uuid7();
        long after = System.currentTimeMillis();
        long decoded = Ids.timestampOf(u);
        assertTrue(decoded >= before && decoded <= after,
                "decoded timestamp " + decoded + " outside [" + before + "," + after + "]");
    }

    @Test
    void idsSortInCreationOrderAcrossMilliseconds() {
        // Before the RFC 9562 fix the low 32 bits of the millisecond counter sat in the most
        // significant hex characters, so the order broke every 2^32 milliseconds (~49.7 days).
        List<String> ids = new ArrayList<>();
        for (int i = 0; i < 2000; i++) {
            ids.add(Ids.newId());
            try {
                Thread.sleep(1);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        List<String> sorted = new ArrayList<>(ids);
        Collections.sort(sorted);
        assertEquals(ids, sorted, "UUIDv7 must sort in creation order across milliseconds");
    }

    @Test
    void embedsCurrentTime() {
        long before = System.currentTimeMillis();
        UUID u = Ids.uuid7();
        long after = System.currentTimeMillis();
        long ts = Ids.timestampOf(u);
        assertTrue(ts >= before - 1 && ts <= after + 1, "timestamp " + ts + " outside [" + before + "," + after + "]");
    }

    @Test
    void idsAreMonotonicInsideOneMillisecond() {
        List<String> ids = new ArrayList<>();
        for (int i = 0; i < 5000; i++) {
            ids.add(Ids.newId());
        }
        List<String> sorted = new ArrayList<>(ids);
        Collections.sort(sorted);
        assertEquals(ids, sorted, "UUIDv7 must sort in creation order");
    }

    @Test
    void idsAreUnique() {
        List<String> ids = new ArrayList<>();
        for (int i = 0; i < 20000; i++) {
            ids.add(Ids.newId());
        }
        assertEquals(ids.size(), ids.stream().distinct().count());
    }

    @Test
    void prefixAndStripAreSymmetric() {
        String id = Ids.newId(Ids.PREFIX_AGENT);
        assertTrue(id.startsWith("agent:"));
        assertEquals(36, Ids.stripPrefix(id).length());
        assertNotEquals(id, Ids.newId(Ids.PREFIX_AGENT));
    }
}