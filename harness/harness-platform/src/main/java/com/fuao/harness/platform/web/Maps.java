package com.fuao.harness.platform.web;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Small builder for response bodies.
 *
 * <p>{@code Map.of} stops at ten pairs, and these views routinely carry more than that. Building
 * a {@link LinkedHashMap} keeps the JSON key order stable, which makes diffing two responses
 * during an incident possible.
 */
public final class Maps {

    private Maps() {
    }

    public static Map<String, Object> of(Object... keyValues) {
        if (keyValues.length % 2 != 0) {
            throw new IllegalArgumentException("expected key/value pairs");
        }
        Map<String, Object> m = new LinkedHashMap<>();
        for (int i = 0; i < keyValues.length; i += 2) {
            m.put(String.valueOf(keyValues[i]), keyValues[i + 1]);
        }
        return m;
    }
}
