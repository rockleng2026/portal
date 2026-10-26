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

    /**
     * Parses a JSON request body into a map.
     *
     * <p>The harness API takes flat JSON objects, but nested values are accepted too: the parser
     * returns {@link Map} for objects, {@link List} for arrays, {@link String}, {@link Double},
     * {@link Boolean} and {@code null} for the scalars.
     *
     * @return the parsed object, or {@code null} when the body is not a JSON object (an empty
     *         body is not an error: some calls carry no parameters at all)
     */
    public static Map parseObject(byte[] body) {
        if (body == null || body.length == 0) {
            return null;
        }
        try {
            Parser parser = new Parser(new String(body, "UTF-8"));
            parser.skipWhitespace();
            if (parser.eof()) {
                return null;
            }
            Object value = parser.readValue();
            parser.skipWhitespace();
            if (value instanceof Map) {
                return (Map) value;
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    /** A small recursive-descent JSON reader; enough for a request body, no more. */
    private static final class Parser {

        private final String text;
        private int pos;

        Parser(String text) {
            this.text = text;
        }

        boolean eof() {
            return pos >= text.length();
        }

        void skipWhitespace() {
            while (pos < text.length() && Character.isWhitespace(text.charAt(pos))) {
                pos++;
            }
        }

        Object readValue() {
            skipWhitespace();
            if (eof()) {
                throw new IllegalStateException("unexpected end of json");
            }
            char c = text.charAt(pos);
            if (c == '{') {
                return readObject();
            }
            if (c == '[') {
                return readArray();
            }
            if (c == '"') {
                return readString();
            }
            if (text.startsWith("true", pos)) {
                pos += 4;
                return Boolean.TRUE;
            }
            if (text.startsWith("false", pos)) {
                pos += 5;
                return Boolean.FALSE;
            }
            if (text.startsWith("null", pos)) {
                pos += 4;
                return null;
            }
            return readNumber();
        }

        Map readObject() {
            HarnessMap map = new HarnessMap();
            pos++; // {
            skipWhitespace();
            if (!eof() && text.charAt(pos) == '}') {
                pos++;
                return map;
            }
            while (true) {
                skipWhitespace();
                String key = readString();
                skipWhitespace();
                expect(':');
                Object value = readValue();
                map.put(key, value);
                skipWhitespace();
                if (eof()) {
                    throw new IllegalStateException("unterminated json object");
                }
                char c = text.charAt(pos++);
                if (c == '}') {
                    return map;
                }
                if (c != ',') {
                    throw new IllegalStateException("unexpected character in json object: " + c);
                }
            }
        }

        List readArray() {
            List list = new ArrayList();
            pos++; // [
            skipWhitespace();
            if (!eof() && text.charAt(pos) == ']') {
                pos++;
                return list;
            }
            while (true) {
                list.add(readValue());
                skipWhitespace();
                if (eof()) {
                    throw new IllegalStateException("unterminated json array");
                }
                char c = text.charAt(pos++);
                if (c == ']') {
                    return list;
                }
                if (c != ',') {
                    throw new IllegalStateException("unexpected character in json array: " + c);
                }
            }
        }

        String readString() {
            expect('"');
            StringBuilder sb = new StringBuilder();
            while (true) {
                if (eof()) {
                    throw new IllegalStateException("unterminated json string");
                }
                char c = text.charAt(pos++);
                if (c == '"') {
                    return sb.toString();
                }
                if (c == '\\') {
                    if (eof()) {
                        throw new IllegalStateException("unterminated json escape");
                    }
                    char e = text.charAt(pos++);
                    if (e == 'n') {
                        sb.append('\n');
                    } else if (e == 't') {
                        sb.append('\t');
                    } else if (e == 'r') {
                        sb.append('\r');
                    } else if (e == 'b') {
                        sb.append('\b');
                    } else if (e == 'f') {
                        sb.append('\f');
                    } else if (e == 'u') {
                        if (pos + 4 > text.length()) {
                            throw new IllegalStateException("truncated unicode escape");
                        }
                        sb.append((char) Integer.parseInt(text.substring(pos, pos + 4), 16));
                        pos += 4;
                    } else {
                        sb.append(e);
                    }
                } else {
                    sb.append(c);
                }
            }
        }

        Double readNumber() {
            int start = pos;
            while (pos < text.length() && "+-0123456789.eE".indexOf(text.charAt(pos)) >= 0) {
                pos++;
            }
            if (start == pos) {
                throw new IllegalStateException("not a number at " + pos);
            }
            return Double.valueOf(text.substring(start, pos));
        }

        void expect(char c) {
            skipWhitespace();
            if (eof() || text.charAt(pos) != c) {
                throw new IllegalStateException("expected " + c + " at " + pos);
            }
            pos++;
        }
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