package com.fuao.harness.platform.web;

import java.util.Map;

/**
 * Error shape for the whole API. The {@code code} is stable and machine-readable - it is what
 * agents and dashboards branch on - while {@code message} is for humans and may change.
 *
 * <p>Serialised as {@code {"error":{...}}} so that a rejection from a controller and a rejection
 * from the auth filter look the same to a client.
 */
public record ApiError(String code, String message, Map<String, Object> details) {

    public Map<String, Object> enveloped() {
        return Map.of("error", this);
    }


    public static ApiError of(String code, String message) {
        return new ApiError(code, message, null);
    }
}