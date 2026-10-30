package com.fuao.fajxc.action.harness;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.fuao.fajxc.dao.harness.HarnessAccountDao;
import com.fuao.fajxc.util.HarnessJson;

/**
 * The portal side of the harness API (03 ��9).
 *
 * <p>Three endpoints at M0, all of them things the platform cannot do by reading the database
 * alone:
 * <ul>
 *   <li>{@code health} - is the namespace reachable and authenticated;</li>
 *   <li>{@code permission/snapshot} - the authoritative permission view of one employee, used to
 *       verify that the platform's own parser agrees with the portal's (A0-3);</li>
 *   <li>{@code agent/onboard} - create the digital employee in the portal organisation, so that it
 *       appears in the org tree, the directory, task pickers and every report that counts people
 *       (ADR-002).</li>
 * </ul>
 *
 * <p>Requests are form encoded rather than JSON: this is a Struts2 action in a 2011 code base,
 * and the form encoding is what the parameter interceptor already understands. The platform
 * signs the exact bytes it sends, so the encoding choice does not weaken the authentication.
 */
public class HarnessApiAction {

    private static final Logger logger = Logger.getLogger(HarnessApiAction.class);

    private HarnessAccountDao harnessAccountDao;

    private HarnessJson.HarnessMap payload = new HarnessJson.HarnessMap();
    private HarnessJson.HarnessMap error = new HarnessJson.HarnessMap();

    public void setHarnessAccountDao(HarnessAccountDao harnessAccountDao) {
        this.harnessAccountDao = harnessAccountDao;
    }

    public HarnessJson.HarnessMap getPayload() {
        return payload;
    }

    public HarnessJson.HarnessMap getError() {
        return error;
    }

    /** Called by the API interceptor so the rejection body is rendered by the json result. */
    public void setError(String code, String message) {
        error.put("code", code);
        error.put("message", message);
    }

    /** Liveness plus the identity the namespace accepted. */
    public String health() {
        // This action is a Spring bean, and a bean is a singleton: the payload of one
        // request would still be in here when the next one arrives. Every request starts
        // with an empty answer.
        payload.clear();
        error.clear();
        payload.put("status", "ok");
        payload.put("service", "portal-harness-api");
        payload.put("timestamp", new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
        return "success";
    }

    /**
     * The permission snapshot of one employee.
     *
     * @param employeeId portal.employee.id
     */
    public String permissionSnapshot() {
        // This action is a Spring bean, and a bean is a singleton: the payload of one
        // request would still be in here when the next one arrives. Every request starts
        // with an empty answer.
        payload.clear();
        error.clear();
        String raw = parameter("employeeId");
        int employeeId;
        try {
            employeeId = Integer.parseInt(raw);
        } catch (NumberFormatException e) {
            error.put("code", "BAD_REQUEST");
            error.put("message", "employeeId is required and must be numeric");
            return "harnessRejected";
        }
        try {
            Map snapshot = harnessAccountDao.permissionSnapshot(employeeId);
            payload.putAll(snapshot);
            return "success";
        } catch (Exception e) {
            logger.error("harness permission snapshot failed for employee " + employeeId, e);
            error.put("code", "SNAPSHOT_FAILED");
            error.put("message", e.getMessage());
            return "harnessRejected";
        }
    }

    /**
     * Creates the digital employee in the portal organisation.
     *
     * <p>Parameters: agentKey, name, deptId, workpositionId, groupId, roleId, loginName (optional).
     */
    /**
     * What hiring this digital employee would write into the portal.
     *
     * <p>Nothing is written. The platform shows this before it asks for a confirmation, so
     * the operator sees the department and the employee number that will really be used.
     */
    public String onboardPreview() {
        // This action is a Spring bean, and a bean is a singleton: the payload of one
        // request would still be in here when the next one arrives. Every request starts
        // with an empty answer.
        payload.clear();
        error.clear();
        Map command = new HashMap();
        command.put("agentKey", parameter("agentKey"));
        command.put("deptId", parameter("deptId"));
        try {
            Map result = harnessAccountDao.onboardPreview(command);
            payload.putAll(result);
            if (Boolean.FALSE.equals(result.get("ok"))) {
                error.put("code", "REJECTED");
                error.put("message", String.valueOf(result.get("error")));
                return "harnessRejected";
            }
            return "success";
        } catch (Exception e) {
            logger.error("harness onboarding preview failed for agent " + parameter("agentKey"), e);
            error.put("code", "ONBOARD_FAILED");
            error.put("message", e.getMessage());
            return "harnessRejected";
        }
    }

    public String onboard() {
        // This action is a Spring bean, and a bean is a singleton: the payload of one
        // request would still be in here when the next one arrives. Every request starts
        // with an empty answer.
        payload.clear();
        error.clear();
        Map command = new HashMap();
        command.put("agentKey", parameter("agentKey"));
        command.put("name", parameter("name"));
        command.put("deptId", parameter("deptId"));
        command.put("workpositionId", parameter("workpositionId"));
        command.put("groupId", parameter("groupId"));
        command.put("roleId", parameter("roleId"));
        command.put("loginName", parameter("loginName"));
        if (integer(command, "roleId") <= 0) {
            // The portal's user row has a NOT NULL role column, so a digital employee cannot
            // be created without one. It cannot log in anyway (A0-2), so the role only has to
            // be the most limited one there is - the operator names it in the configuration.
            command.put("roleId", Integer.valueOf(digitalRoleId()));
        }
        try {
            Map result = harnessAccountDao.onboard(command);
            payload.putAll(result);
            if (Boolean.FALSE.equals(result.get("ok"))) {
                error.put("code", "REJECTED");
                error.put("message", String.valueOf(result.get("error")));
                return "harnessRejected";
            }
            return "success";
        } catch (Exception e) {
            logger.error("harness onboarding failed for agent " + parameter("agentKey"), e);
            error.put("code", "ONBOARD_FAILED");
            error.put("message", e.getMessage());
            return "harnessRejected";
        }
    }

    /**
     * The role a digital employee gets when the caller does not name one.
     *
     * <p>Read from {@code harness.api.digitalRoleId}. The file lives under WEB-INF, so it can
     * only be read through the servlet context.
     */
    private int digitalRoleId() {
        java.io.InputStream in = null;
        try {
            javax.servlet.ServletContext context = org.apache.struts2.ServletActionContext.getServletContext();
            if (context != null) {
                in = context.getResourceAsStream("/WEB-INF/props/harness-api.properties");
            }
            if (in == null) {
                return 0;
            }
            java.util.Properties properties = new java.util.Properties();
            properties.load(in);
            String value = properties.getProperty("harness.api.digitalRoleId", "").trim();
            return value.length() == 0 ? 0 : Integer.parseInt(value);
        } catch (Exception e) {
            logger.error("cannot read harness.api.digitalRoleId", e);
            return 0;
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (Exception ignored) {
                    // nothing to do
                }
            }
        }
    }

    /** A parameter as a number, or 0 when it is missing. */
    private int integer(Map command, String name) {
        Object value = command.get(name);
        if (value == null) {
            return 0;
        }
        try {
            return Integer.parseInt(String.valueOf(value).trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private String parameter(String name) {
        Map parameters = (Map) org.apache.struts2.ServletActionContext.getRequest().getAttribute(
                "harness.parameters");
        if (parameters != null && parameters.get(name) != null) {
            return String.valueOf(parameters.get(name));
        }
        return org.apache.struts2.ServletActionContext.getRequest().getParameter(name);
    }
}
