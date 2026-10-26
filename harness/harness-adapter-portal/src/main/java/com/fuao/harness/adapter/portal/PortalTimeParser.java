package com.fuao.harness.adapter.portal;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

/**
 * Strict parsing of the portal's timestamps.
 *
 * <p>Several portal columns store a datetime in a {@code varchar}: {@code scheduleplan.begintime},
 * {@code scheduleplan.endtime}, {@code new_task.begintime} and others (03 §8). The values are
 * written by hand in a handful of formats and read back by a report that sorts by them.
 *
 * <p>The rule here is the one from 03 §8: a value that cannot be parsed is a reported problem,
 * never a silent fallback to {@code null}, never an epoch zero and never a string comparison.
 * A mis-parsed timestamp silently moves a task to the end of the timeline, and nobody notices
 * until a deadline is missed.
 */
public final class PortalTimeParser {

    /** The formats seen in the portal, most specific first. */
    private static final List<DateTimeFormatter> FORMATS = List.of(
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"),
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"),
            DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss"),
            DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm"));

    /** Date-only values, which mean the start of that day. */
    private static final List<DateTimeFormatter> DATE_FORMATS = List.of(
            DateTimeFormatter.ofPattern("yyyy-MM-dd"),
            DateTimeFormatter.ofPattern("yyyy/MM/dd"));

    /** One reported problem. */
    public record Problem(String field, String rawValue, String reason) {
    }

    public record Result(Instant value, List<Problem> problems) {

        public boolean parsed() {
            return value != null;
        }
    }

    private PortalTimeParser() {
    }

    /**
     * @param field the column the value came from
     * @param raw   the raw string; {@code null} and blank mean "not set", which is not an error
     */
    public static Result parse(String field, String raw) {
        List<Problem> problems = new ArrayList<>();
        if (raw == null) {
            return new Result(null, problems);
        }
        String trimmed = raw.trim();
        if (trimmed.isEmpty()) {
            return new Result(null, problems);
        }
        for (DateTimeFormatter formatter : FORMATS) {
            try {
                LocalDateTime local = LocalDateTime.parse(trimmed, formatter);
                return new Result(local.atZone(ZoneId.systemDefault()).toInstant(), problems);
            } catch (DateTimeParseException ignored) {
                // try the next format
            }
        }
        for (DateTimeFormatter formatter : DATE_FORMATS) {
            try {
                java.time.LocalDate date = java.time.LocalDate.parse(trimmed, formatter);
                return new Result(date.atStartOfDay(ZoneId.systemDefault()).toInstant(), problems);
            } catch (DateTimeParseException ignored) {
                // try the next format
            }
        }
        problems.add(new Problem(field, trimmed,
                "none of the known portal timestamp formats matched ("
                        + String.join(", ", FORMATS.stream().map(DateTimeFormatter::toString).toList())
                        + " and the date-only variants)"));
        return new Result(null, problems);
    }
}
