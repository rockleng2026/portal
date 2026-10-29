package com.fuao.harness.platform.security;

/**
 * An authenticated caller, as resolved from a verified HMAC signature.
 *
 * @param principalType one of {@code human}, {@code service}, {@code agent}, {@code terminal},
 *                      {@code system} - the type is authoritative, not a label
 * @param role          what a human is allowed to approve: {@code employee},
 *                      {@code dept_director}, {@code system_admin} (red-team R-02: the approver
 *                      has to be the responsible person, not "anybody with a console")
 * @param deptId        the department a human belongs to; a department director may only
 *                      approve escalations that stay inside it
 */
public record AuthenticatedClient(
        String clientId,
        String principalType,
        String agentId,
        String terminalId,
        Integer employeeId,
        String apiScope,
        String role,
        Integer deptId) {

    /** The platform acting on its own behalf (schedulers, policy engine, expiry jobs). */
    public static AuthenticatedClient system(String code) {
        return new AuthenticatedClient("system:" + code, "system", null, null, null, "/api/harness/*",
                "system", null);
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

    /** The platform itself: schedulers, expiry jobs, the policy engine. */
    public boolean isSystem() {
        return "system".equals(principalType);
    }

    /**
     * Whether this caller is a natural human.
     *
     * <p>The type is the authority, not the presence of an employee id: every human-only
     * endpoint (grant issue, approval decision, kill switch, agent lifecycle, terminal binding)
     * gates on this, so a machine principal that merely happens to carry an {@code employee_id}
     * must not be able to act as a person. Red-team R-02 / R-04 depend on it.
     */
    public boolean isHuman() {
        return "human".equals(principalType) && employeeId != null;
    }

    /** Whether this human may approve escalations that reach beyond their own department. */
    public boolean isSystemAdmin() {
        return isHuman() && "system_admin".equals(role);
    }

    /** Whether this human is the director of {@code departmentId}. */
    public boolean isDepartmentDirectorOf(Integer departmentId) {
        return isHuman() && "dept_director".equals(role) && deptId != null && deptId.equals(departmentId);
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
