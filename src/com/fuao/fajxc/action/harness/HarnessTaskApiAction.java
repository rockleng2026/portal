package com.fuao.fajxc.action.harness;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.fuao.fajxc.dao.harness.HarnessTaskDao;
import com.fuao.fajxc.util.HarnessJson;

/**
 * The portal side of the harness task API (03 §9).
 *
 * <p>Four endpoints, and they are the four ends of the chain a digital employee walks:
 * <ul>
 *   <li>{@code task/list} - the assignments that are waiting for a digital employee. The
 *       platform polls this (03 §9: "portal 任务 API 轮询"), because the portal owns its own
 *       tasks and the platform should not read its tables behind its back;</li>
 *   <li>{@code task/accept} - the digital employee took the task: a row in the employee's own
 *       todo ({@code mission_emp}, status 1 处理中);</li>
 *   <li>{@code task/complete} - the work is done: status 2 已完成, with the agent's own answer
 *       as the feedback text a human reads;</li>
 *   <li>{@code task/publish} - a task is published for a digital employee. This is the write
 *       behind the brain's proposals: the brain proposes, a natural human publishes, and the
 *       portal's own rows are what appear (ADR-007, ADR-008).</li>
 * </ul>
 *
 * <p>Requests are form encoded rather than JSON, like the rest of this namespace: the parameter
 * interceptor already understands it, and the platform signs the exact bytes it sends, so the
 * encoding choice does not weaken the authentication.
 */
public class HarnessTaskApiAction {

    private static final Logger logger = Logger.getLogger(HarnessTaskApiAction.class);

    private HarnessTaskDao harnessTaskDao;

    private HarnessJson.HarnessMap payload = new HarnessJson.HarnessMap();
    private HarnessJson.HarnessMap error = new HarnessJson.HarnessMap();

    public void setHarnessTaskDao(HarnessTaskDao harnessTaskDao) {
        this.harnessTaskDao = harnessTaskDao;
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

    /** The assignments that are waiting for a digital employee. */
    public String list() {
        reset();
        try {
            List tasks = harnessTaskDao.listForDigitalEmployees();
            payload.put("tasks", tasks);
            payload.put("count", String.valueOf(tasks == null ? 0 : tasks.size()));
            return "success";
        } catch (Exception e) {
            logger.error("cannot list the tasks of the digital employees", e);
            error.put("code", "TASK_LIST_FAILED");
            error.put("message", e.getMessage());
            return "harnessRejected";
        }
    }

    /** The digital employee takes the task. */
    public String accept() {
        reset();
        try {
            Map result = harnessTaskDao.accept(parameter("missionId"), parameter("employeeId"));
            if (!Boolean.TRUE.equals(result.get("ok"))) {
                error.put("code", "TASK_ACCEPT_FAILED");
                error.put("message", String.valueOf(result.get("error")));
                return "harnessRejected";
            }
            payload.putAll(result);
            return "success";
        } catch (Exception e) {
            logger.error("cannot accept the task " + parameter("missionId"), e);
            error.put("code", "TASK_ACCEPT_FAILED");
            error.put("message", e.getMessage());
            return "harnessRejected";
        }
    }

    /** The work is done: the answer goes into the employee's todo as the feedback. */
    public String complete() {
        reset();
        try {
            Map result = harnessTaskDao.complete(parameter("missionId"), parameter("employeeId"),
                    parameter("describe"), parameter("attachmentId"));
            if (!Boolean.TRUE.equals(result.get("ok"))) {
                error.put("code", "TASK_COMPLETE_FAILED");
                error.put("message", String.valueOf(result.get("error")));
                return "harnessRejected";
            }
            payload.putAll(result);
            return "success";
        } catch (Exception e) {
            logger.error("cannot complete the task " + parameter("missionId"), e);
            error.put("code", "TASK_COMPLETE_FAILED");
            error.put("message", e.getMessage());
            return "harnessRejected";
        }
    }

    /** Publishes a task for a digital employee. */
    public String publish() {
        reset();
        try {
            Map command = new HashMap();
            command.put("name", parameter("name"));
            command.put("description", parameter("description"));
            command.put("agentKey", parameter("agentKey"));
            command.put("startTime", parameter("startTime"));
            command.put("endTime", parameter("endTime"));

            Map result = harnessTaskDao.publish(command);
            if (!Boolean.TRUE.equals(result.get("ok"))) {
                error.put("code", "TASK_PUBLISH_FAILED");
                error.put("message", String.valueOf(result.get("error")));
                return "harnessRejected";
            }
            payload.putAll(result);
            return "success";
        } catch (Exception e) {
            logger.error("cannot publish a task for " + parameter("agentKey"), e);
            error.put("code", "TASK_PUBLISH_FAILED");
            error.put("message", e.getMessage());
            return "harnessRejected";
        }
    }

    /**
     * Every request starts with an empty answer.
     *
     * <p>This action is a Spring bean, and a bean is a singleton: the payload of one request
     * would still be in here when the next one arrives.
     */
    private void reset() {
        payload.clear();
        error.clear();
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
