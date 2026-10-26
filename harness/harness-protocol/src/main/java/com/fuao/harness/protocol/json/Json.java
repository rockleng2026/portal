package com.fuao.harness.protocol.json;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 * Minimal, dependency-free JSON with a <b>canonical</b> serialisation.
 *
 * <p>Why hand-rolled: two contracts in this system are defined as hashes over JSON bytes -
 * the idempotency key {@code harness_action.arguments_hash} (03 §3.4) and the signed payload
 * of a capability token (03 §5). Both require that "the same logical object always produces
 * the same bytes", otherwise idempotency breaks across processes and token signatures break
 * across nodes. Pulling in a JSON library would be fine on the platform, but this module is
 * also embedded in the terminal runtime, so we keep it self-contained.
 *
 * <p>Canonical form:
 * <ul>
 *   <li>object members sorted by key, ascending UTF-16 code unit order;</li>
 *   <li>no insignificant whitespace;</li>
 *   <li>strings escaped per RFC 8259 with backslash-u escapes for control characters;</li>
 *   <li>integral numbers printed as longs, other numbers via {@link BigDecimal#stripTrailingZeros()}
 *       in plain notation;</li>
 *   <li>{@code null} is a legal value, {@code NaN}/{@code Infinity} are not.</li>
 * </ul>
 *
 * <p>Values are plain Java objects: {@code null}, {@link Boolean}, {@link String},
 * {@link Number}, {@code List<Object>}, {@code Map<String,Object>}.
 */
public final class Json {

    private Json() {
    }

    // ------------------------------------------------------------------ building

    public static Map<String, Object> obj() {
        return new LinkedHashMap<>();
    }

    public static Map<String, Object> obj(Object... keyValuePairs) {
        if (keyValuePairs.length % 2 != 0) {
            throw new IllegalArgumentException("expected an even number of key/value arguments");
        }
        Map<String, Object> m = new LinkedHashMap<>();
        for (int i = 0; i < keyValuePairs.length; i += 2) {
            m.put(String.valueOf(keyValuePairs[i]), keyValuePairs[i + 1]);
        }
        return m;
    }

    public static List<Object> arr(Object... items) {
        List<Object> l = new ArrayList<>(items.length);
        Collections.addAll(l, items);
        return l;
    }

    // ------------------------------------------------------------------ serialising

    /** Serialises {@code value} in canonical form. */
    public static String canonical(Object value) {
        StringBuilder sb = new StringBuilder();
        write(sb, value);
        return sb.toString();
    }

    /** Canonical UTF-8 bytes - the form that gets hashed and signed. */
    public static byte[] canonicalBytes(Object value) {
        return canonical(value).getBytes(java.nio.charset.StandardCharsets.UTF_8);
    }

    private static void write(StringBuilder sb, Object value) {
        if (value == null) {
            sb.append("null");
        } else if (value instanceof String s) {
            writeString(sb, s);
        } else if (value instanceof Boolean b) {
            sb.append(b.booleanValue() ? "true" : "false");
        } else if (value instanceof Number n) {
            sb.append(number(n));
        } else if (value instanceof Map<?, ?> m) {
            Map<String, Object> sorted = new TreeMap<>();
            for (Map.Entry<?, ?> e : m.entrySet()) {
                if (e.getKey() == null) {
                    throw new IllegalArgumentException("JSON object keys must not be null");
                }
                sorted.put(String.valueOf(e.getKey()), e.getValue());
            }
            sb.append('{');
            boolean first = true;
            for (Map.Entry<String, Object> e : sorted.entrySet()) {
                if (!first) {
                    sb.append(',');
                }
                first = false;
                writeString(sb, e.getKey());
                sb.append(':');
                write(sb, e.getValue());
            }
            sb.append('}');
        } else if (value instanceof Iterable<?> it) {
            sb.append('[');
            boolean first = true;
            for (Object item : it) {
                if (!first) {
                    sb.append(',');
                }
                first = false;
                write(sb, item);
            }
            sb.append(']');
        } else {
            throw new IllegalArgumentException("unsupported JSON value type: " + value.getClass().getName());
        }
    }

    private static String number(Number n) {
        if (n instanceof Double || n instanceof Float) {
            double d = n.doubleValue();
            if (Double.isNaN(d) || Double.isInfinite(d)) {
                throw new IllegalArgumentException("NaN/Infinity are not valid JSON numbers");
            }
            if (d == Math.rint(d) && Math.abs(d) < 1e15) {
                return Long.toString((long) d);
            }
            return BigDecimal.valueOf(d).stripTrailingZeros().toPlainString();
        }
        if (n instanceof BigDecimal bd) {
            return bd.stripTrailingZeros().toPlainString();
        }
        return n.toString();
    }

    private static void writeString(StringBuilder sb, String s) {
        sb.append('"');
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '"' -> sb.append("\\\"");
                case '\\' -> sb.append("\\\\");
                case '\n' -> sb.append("\\n");
                case '\r' -> sb.append("\\r");
                case '\t' -> sb.append("\\t");
                case '\b' -> sb.append("\\b");
                case '\f' -> sb.append("\\f");
                default -> {
                    if (c < 0x20) {
                        sb.append(String.format("\\u%04x", (int) c));
                    } else {
                        sb.append(c);
                    }
                }
            }
        }
        sb.append('"');
    }

    // ------------------------------------------------------------------ parsing

    /** Parses JSON text. Throws {@link JsonException} on any malformed input. */
    public static Object parse(String text) {
        Parser p = new Parser(text);
        p.skipWhitespace();
        Object v = p.parseValue(0);
        p.skipWhitespace();
        if (!p.eof()) {
            throw new JsonException("trailing content at offset " + p.pos);
        }
        return v;
    }

    /** Parses JSON text and requires the result to be an object. */
    @SuppressWarnings("unchecked")
    public static Map<String, Object> parseObject(String text) {
        Object v = parse(text);
        if (!(v instanceof Map)) {
            throw new JsonException("expected a JSON object");
        }
        return (Map<String, Object>) v;
    }

    // ------------------------------------------------------------------ accessors (null-safe, no silent coercion)

    public static String requireString(Map<String, Object> o, String key) {
        Object v = o.get(key);
        if (!(v instanceof String s)) {
            throw new JsonException("field '" + key + "' must be a string");
        }
        return s;
    }

    public static String optString(Map<String, Object> o, String key) {
        Object v = o.get(key);
        return v instanceof String s ? s : null;
    }

    public static long requireLong(Map<String, Object> o, String key) {
        Object v = o.get(key);
        if (!(v instanceof Number n)) {
            throw new JsonException("field '" + key + "' must be a number");
        }
        return n.longValue();
    }

    public static long optLong(Map<String, Object> o, String key, long fallback) {
        Object v = o.get(key);
        return v instanceof Number n ? n.longValue() : fallback;
    }

    public static boolean optBoolean(Map<String, Object> o, String key, boolean fallback) {
        Object v = o.get(key);
        return v instanceof Boolean b ? b.booleanValue() : fallback;
    }

    @SuppressWarnings("unchecked")
    public static List<Object> requireArray(Map<String, Object> o, String key) {
        Object v = o.get(key);
        if (!(v instanceof List<?> l)) {
            throw new JsonException("field '" + key + "' must be an array");
        }
        return (List<Object>) l;
    }

    @SuppressWarnings("unchecked")
    public static Map<String, Object> optObject(Map<String, Object> o, String key) {
        Object v = o.get(key);
        return v instanceof Map ? (Map<String, Object>) v : null;
    }

    public static final class JsonException extends RuntimeException {
        public JsonException(String message) {
            super(message);
        }
    }

    private static final class Parser {
        private final String s;
        private int pos;

        Parser(String s) {
            this.s = s;
        }

        boolean eof() {
            return pos >= s.length();
        }

        void skipWhitespace() {
            while (pos < s.length()) {
                char c = s.charAt(pos);
                if (c == ' ' || c == '\t' || c == '\n' || c == '\r') {
                    pos++;
                } else {
                    break;
                }
            }
        }

        Object parseValue(int depth) {
            if (depth > 64) {
                throw new JsonException("nesting too deep");
            }
            if (eof()) {
                throw new JsonException("unexpected end of input");
            }
            char c = s.charAt(pos);
            return switch (c) {
                case '{' -> parseObject(depth);
                case '[' -> parseArray(depth);
                case '"' -> parseString();
                case 't' -> literal("true", Boolean.TRUE);
                case 'f' -> literal("false", Boolean.FALSE);
                case 'n' -> literal("null", null);
                default -> parseNumber();
            };
        }

        Object literal(String token, Object value) {
            if (!s.startsWith(token, pos)) {
                throw new JsonException("invalid literal at offset " + pos);
            }
            pos += token.length();
            return value;
        }

        Map<String, Object> parseObject(int depth) {
            Map<String, Object> m = new LinkedHashMap<>();
            pos++; // '{'
            skipWhitespace();
            if (!eof() && s.charAt(pos) == '}') {
                pos++;
                return m;
            }
            while (true) {
                skipWhitespace();
                String key = parseString();
                skipWhitespace();
                expect(':');
                skipWhitespace();
                m.put(key, parseValue(depth + 1));
                skipWhitespace();
                if (eof()) {
                    throw new JsonException("unterminated object");
                }
                char c = s.charAt(pos++);
                if (c == '}') {
                    return m;
                }
                if (c != ',') {
                    throw new JsonException("expected ',' or '}' at offset " + (pos - 1));
                }
            }
        }

        List<Object> parseArray(int depth) {
            List<Object> l = new ArrayList<>();
            pos++; // '['
            skipWhitespace();
            if (!eof() && s.charAt(pos) == ']') {
                pos++;
                return l;
            }
            while (true) {
                skipWhitespace();
                l.add(parseValue(depth + 1));
                skipWhitespace();
                if (eof()) {
                    throw new JsonException("unterminated array");
                }
                char c = s.charAt(pos++);
                if (c == ']') {
                    return l;
                }
                if (c != ',') {
                    throw new JsonException("expected ',' or ']' at offset " + (pos - 1));
                }
            }
        }

        String parseString() {
            expect('"');
            StringBuilder sb = new StringBuilder();
            while (true) {
                if (eof()) {
                    throw new JsonException("unterminated string");
                }
                char c = s.charAt(pos++);
                if (c == '"') {
                    return sb.toString();
                }
                if (c != '\\') {
                    sb.append(c);
                    continue;
                }
                if (eof()) {
                    throw new JsonException("unterminated escape");
                }
                char e = s.charAt(pos++);
                switch (e) {
                    case '"' -> sb.append('"');
                    case '\\' -> sb.append('\\');
                    case '/' -> sb.append('/');
                    case 'b' -> sb.append('\b');
                    case 'f' -> sb.append('\f');
                    case 'n' -> sb.append('\n');
                    case 'r' -> sb.append('\r');
                    case 't' -> sb.append('\t');
                    case 'u' -> {
                        if (pos + 4 > s.length()) {
                            throw new JsonException("truncated \\u escape");
                        }
                        sb.append((char) Integer.parseInt(s.substring(pos, pos + 4), 16));
                        pos += 4;
                    }
                    default -> throw new JsonException("invalid escape '\\" + e + "'");
                }
            }
        }

        Object parseNumber() {
            int start = pos;
            if (!eof() && (s.charAt(pos) == '-' || s.charAt(pos) == '+')) {
                pos++;
            }
            boolean fractional = false;
            while (!eof()) {
                char c = s.charAt(pos);
                if (c >= '0' && c <= '9') {
                    pos++;
                } else if (c == '.' || c == 'e' || c == 'E' || c == '+' || c == '-') {
                    fractional = fractional || c == '.' || c == 'e' || c == 'E';
                    pos++;
                } else {
                    break;
                }
            }
            String raw = s.substring(start, pos);
            if (raw.isEmpty()) {
                throw new JsonException("invalid number at offset " + start);
            }
            if (!fractional) {
                try {
                    return Long.parseLong(raw);
                } catch (NumberFormatException ignored) {
                    // fall through to decimal
                }
            }
            try {
                return new BigDecimal(raw);
            } catch (NumberFormatException e) {
                throw new JsonException("invalid number '" + raw + "'");
            }
        }

        void expect(char c) {
            if (eof() || s.charAt(pos) != c) {
                throw new JsonException("expected '" + c + "' at offset " + pos);
            }
            pos++;
        }
    }
}