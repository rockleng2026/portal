package com.fuao.harness.protocol.event;

import java.time.Duration;

/**
 * How fast an event class has to be handled (03 §4), with the SLA from 01 §8.2.
 *
 * <p>{@link #REALTIME} also implies an acknowledgement obligation: if the SLA cannot be met,
 * the agent must reply "received, ETA X" instead of silently dropping (01 §8.2).
 */
public enum LatencyClass {

    REALTIME("realtime", Duration.ofSeconds(10)),
    NEARLINE("nearline", Duration.ofSeconds(60)),
    BATCH("batch", Duration.ofHours(12));

    private final String wireName;
    private final Duration sla;

    LatencyClass(String wireName, Duration sla) {
        this.wireName = wireName;
        this.sla = sla;
    }

    public String wireName() {
        return wireName;
    }

    public Duration sla() {
        return sla;
    }

    public boolean requiresAck() {
        return this == REALTIME;
    }

    /** Length of the aggregation window used for {@code harness_event.event_window}. */
    public Duration window() {
        return switch (this) {
            case REALTIME -> Duration.ofMinutes(1);
            case NEARLINE -> Duration.ofHours(1);
            case BATCH -> Duration.ofDays(1);
        };
    }

    public static LatencyClass fromWireName(String name) {
        for (LatencyClass c : values()) {
            if (c.wireName.equals(name)) {
                return c;
            }
        }
        throw new IllegalArgumentException("unknown latency class: " + name);
    }
}