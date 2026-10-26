package com.fuao.harness.protocol.json;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

class JsonTest {

    @Test
    void canonicalFormSortsKeysRegardlessOfInsertionOrder() {
        Map<String, Object> a = new LinkedHashMap<>();
        a.put("b", 1);
        a.put("a", 2);
        Map<String, Object> b = new LinkedHashMap<>();
        b.put("a", 2);
        b.put("b", 1);

        assertEquals("{\"a\":2,\"b\":1}", Json.canonical(a));
        assertEquals(Json.canonical(a), Json.canonical(b),
                "idempotency keys must not depend on map iteration order");
    }

    @Test
    void canonicalFormNestsAndEscapes() {
        Map<String, Object> v = Json.obj(
                "msg", "line1\nsay \"hi\"\tdone",
                "list", List.of(3, 1, 2),
                "nested", Json.obj("k", true));
        assertEquals("{\"list\":[3,1,2],\"msg\":\"line1\\nsay \\\"hi\\\"\\tdone\",\"nested\":{\"k\":true}}",
                Json.canonical(v));
    }

    @Test
    void numbersAreNormalised() {
        assertEquals("{\"n\":3}", Json.canonical(Json.obj("n", 3.0)));
        assertEquals("{\"n\":3}", Json.canonical(Json.obj("n", new BigDecimal("3.000"))));
        assertEquals("{\"n\":3}", Json.canonical(Json.obj("n", 3L)));
        assertEquals("{\"n\":3.5}", Json.canonical(Json.obj("n", 3.50)));
    }

    @Test
    void roundTripsThroughParse() {
        String text = "{\"a\":[1,2,{\"b\":null}],\"c\":\"中文\",\"d\":true,\"e\":1.25}";
        Object parsed = Json.parse(text);
        assertEquals(text, Json.canonical(parsed));
    }

    @Test
    void parsesNullAndUnicodeEscapes() {
        Map<String, Object> m = Json.parseObject("{\"a\":null,\"b\":\"\\u4e2d\",\"c\":-3}");
        assertTrue(m.containsKey("a"));
        assertEquals(null, m.get("a"));
        assertEquals("中", m.get("b"));
        assertEquals(-3L, m.get("c"));
    }

    @Test
    void rejectsMalformedInputInsteadOfGuessing() {
        assertThrows(Json.JsonException.class, () -> Json.parse("{\"a\":}"));
        assertThrows(Json.JsonException.class, () -> Json.parse("{\"a\":1"));
        assertThrows(Json.JsonException.class, () -> Json.parse("{} trailing"));
        assertThrows(Json.JsonException.class, () -> Json.parse("{'a':1}"));
    }

    @Test
    void accessorsFailLoudlyOnTypeMismatch() {
        Map<String, Object> m = Json.parseObject("{\"n\":1,\"s\":\"x\",\"o\":{}}");
        assertThrows(Json.JsonException.class, () -> Json.requireString(m, "n"));
        assertThrows(Json.JsonException.class, () -> Json.requireLong(m, "s"));
        assertThrows(Json.JsonException.class, () -> Json.requireArray(m, "o"));
        assertEquals(1L, Json.requireLong(m, "n"));
        assertEquals(7L, Json.optLong(m, "missing", 7L));
    }
}