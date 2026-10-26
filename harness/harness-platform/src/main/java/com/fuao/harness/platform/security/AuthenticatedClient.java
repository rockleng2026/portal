package com.fuao.harness.platform.security;

/** An authenticated caller, as resolved from a verified HMAC signature. */
public record AuthenticatedClient(
        String clientId,
        String principalType,
        String agentId,
        String terminalId,
        Integer employeeId,
        String apiScope) {

    /** The platform acting on its own behalf (schedulers, policy engine, expiry jobs). */
    public static AuthenticatedClient system(String code) {
        return new AuthenticatedClient("system:" + code, "system", null, null, null, "/api/harness/*");
    }

    public boolean isTerminal() {
        return "terminal".equals(principalType);
    }

    public boolean isAgent() {
        return "agent".equals(principalType);
    }

    public boolean isService() {
        return "service".equals(principalType);
    }

    public boolean isHuman() {
        return employeeId != null;
    }

    /** Actor string used by {@code harness_audit.actor_id}: type prefixes are mandatory (03 §2.3). */
    public String actorId() {
        return switch (principalType) {
            case "human" -> "human:" + employeeId;
            case "agent" -> "agent:" + agentId;
            case "terminal" -> "terminal:" + terminalId;
            default -> "system:" + clientId;
        };
    }

    public String actorType() {
        return switch (principalType) {
            case "human", "agent", "terminal" -> principalType;
            default -> "system";
        };
    }
}