package com.fuao.fajxc.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Minimal JSON writer for the harness API.
 *
 * <p>The portal carries json-lib 2.1 but not its ezmorph dependency, and pulling a new library
 * into a 2011 build for a handful of responses is not a trade worth making. This writer covers
 * exactly what the API needs: objects, arrays, strings, numbers, booleans and null, with correct
 * escaping and deterministic key order (insertion order), so two responses to the same question
 * are byte-identical and can be diffed during an incident.
 *
 * <p>Written for Java 5 source level: no generics diamond, no varargs on constructors, no
 * StandardCharsets.
 */
public final class HarnessJson {

    private HarnessJson() {
    }

    public static String object(Map<String, Object> values) {
        StringBuilder sb = new StringBuilder();
        writeObject(sb, values);
        return sb.toString();
    }

    public static String array(Collection<?> values) {
        StringBuilder sb = new StringBuilder();
        writeArray(sb, values);
        return sb.toString();
    }

    /** Convenience for the very common {"key": "value"} shape. */
    public static String of(String key, Object value) {
        HarnessMap map = new HarnessMap();
        map.put(key, value);
        return object(map);
    }

    public static String escape(String value) {
        StringBuilder sb = new StringBuilder();
        writeString(sb, value);
        return sb.toString();
    }

    private static void writeValue(StringBuilder sb, Object value) {
        if (value == null) {
            sb.append("null");
        } else if (value instanceof String) {
            writeString(sb, (String) value);
        } else if (value instanceof Boolean) {
            sb.append(value.toString());
        } else if (value instanceof Number) {
            writeNumber(sb, (Number) value);
        } else if (value instanceof Map) {
            writeObject(sb, castMap(value));
        } else if (value instanceof Collection) {
            writeArray(sb, castCollection(value));
        } else if (value instanceof Object[]) {
            writeArray(sb, java.util.Arrays.asList((Object[]) value));
        } else {
            writeString(sb, value.toString());
        }
    }

    private static void writeObject(StringBuilder sb, Map<?, ?> values) {
        sb.append('{');
        boolean first = true;
        for (Map.Entry<?, ?> entry : values.entrySet()) {
            if (!first) {
                sb.append(',');
            }
            first = false;
            writeString(sb, String.valueOf(entry.getKey()));
            sb.append(':');
            writeValue(sb, entry.getValue());
        }
        sb.append('}');
    }

    private static void writeArray(StringBuilder sb, Collection<?> values) {
        sb.append('[');
        boolean first = true;
        for (Object value : values) {
            if (!first) {
                sb.append(',');
            }
            first = false;
            writeValue(sb, value);
        }
        sb.append(']');
    }

    private static void writeNumber(StringBuilder sb, Number number) {
        double d = number.doubleValue();
        if (d == Math.rint(d) && !Double.isInfinite(d) && Math.abs(d) < 1e15) {
            sb.append(Long.toString((long) d));
        } else {
            sb.append(number.toString());
        }
    }

    private static void writeString(StringBuilder sb, String value) {
        if (value == null) {
            sb.append("null");
            return;
        }
        sb.append('"');
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            if (c == '"') {
                sb.append("\\\"");
            } else if (c == '\\') {
                sb.append("\\\\");
            } else if (c == '\n') {
                sb.append("\\n");
            } else if (c == '\r') {
                sb.append("\\r");
            } else if (c == '\t') {
                sb.append("\\t");
            } else if (c == '\b') {
                sb.append("\\b");
            } else if (c == '\f') {
                sb.append("\\f");
            } else if (c < 0x20) {
                sb.append(String.format("\\u%04x", Integer.valueOf(c)));
            } else {
                sb.append(c);
            }
        }
        sb.append('"');
    }

    @SuppressWarnings("unchecked")
    private static Map<String, Object> castMap(Object value) {
        return (Map<String, Object>) value;
    }

    @SuppressWarnings("unchecked")
    private static Collection<Object> castCollection(Object value) {
        return (Collection<Object>) value;
    }

    /** Ordered map, so response key order is stable. */
    public static final class HarnessMap extends java.util.LinkedHashMap<String, Object> {
        private static final long serialVersionUID = 1L;

        public HarnessMap put(String key, Object value) {
            super.put(key, value);
            return this;
        }
    }

    /** Ordered list helper. */
    public static final class HarnessList extends ArrayList<Object> {
        private static final long serialVersionUID = 1L;

        /** Named differently from List.add because add has to keep returning boolean. */
        public HarnessList append(Object value) {
            super.add(value);
            return this;
        }
    }

    static List<Object> emptyList() {
        return new ArrayList<Object>();
    }
}