package com.fuao.harness.adapter.portal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Instant;
import org.junit.jupiter.api.Test;

class PortalTimeParserTest {

    @Test
    void parsesTheFormatsThePortalActuallyUses() {
        assertTrue(PortalTimeParser.parse("scheduleplan.begintime", "2026-10-22 10:00:00").parsed());
        assertTrue(PortalTimeParser.parse("scheduleplan.begintime", "2026-10-22 10:00").parsed());
        assertTrue(PortalTimeParser.parse("scheduleplan.begintime", "2026/10/22 10:00:00").parsed());
        assertTrue(PortalTimeParser.parse("scheduleplan.begintime", "2026-10-22").parsed());
    }

    @Test
    void aBlankValueMeansNotSetAndIsNotAnError() {
        PortalTimeParser.Result result = PortalTimeParser.parse("scheduleplan.begintime", "   ");

        assertFalse(result.parsed());
        assertTrue(result.problems().isEmpty(), "an empty value is not a parsing failure");
    }

    @Test
    void aNullValueMeansNotSetAndIsNotAnError() {
        PortalTimeParser.Result result = PortalTimeParser.parse("scheduleplan.begintime", null);

        assertNull(result.value());
        assertTrue(result.problems().isEmpty());
    }

    @Test
    void aBrokenValueIsReportedAndNeverGuessed() {
        PortalTimeParser.Result result = PortalTimeParser.parse("scheduleplan.begintime", "next tuesday");

        assertFalse(result.parsed());
        assertNull(result.value(), "a timestamp that cannot be parsed must not become epoch zero");
        assertEquals(1, result.problems().size());
        assertEquals("scheduleplan.begintime", result.problems().get(0).field());
        assertEquals("next tuesday", result.problems().get(0).rawValue());
    }

    @Test
    void theParsedValueIsARealInstant() {
        PortalTimeParser.Result result = PortalTimeParser.parse("scheduleplan.begintime", "2026-10-22 10:00:00");

        assertEquals(Instant.parse("2026-10-22T02:00:00Z"), result.value());
    }
}