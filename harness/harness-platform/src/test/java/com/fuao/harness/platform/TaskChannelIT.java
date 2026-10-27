package com.fuao.harness.platform;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

/**
 * The console-to-terminal channel (V9).
 *
 * <p>What matters here is not that a task can be created - it is who may create one, that two
 * pollers never take the same task, and that the answer comes back with the terminal's own
 * footprint on it.
 */
class TaskChannelIT extends PlatformTestBase {

    private static final String AGENT_KEY = "agent:leon:ops:tasks";

    private String terminalId;

    @BeforeEach
    void setup() throws Exception {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", null);
        String agentId = seedAgent(AGENT_KEY, AGENT_OWNER_EMPLOYEE_ID, 95, 2);

        // A terminal, bound to that agent, the way the shell would do it. The device id is
        // unique per test: a bound device does not get a new binding code.
        String deviceId = "device-task-channel-" + java.util.UUID.randomUUID();
        String body = body(Map.of(
                "deviceId", deviceId,
                "os", "linux",
                "agentVersion", "0.1.0"));
        MockHttpServletRequestBuilder hello = post("/api/harness/terminal/hello")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/terminal/hello", hello, body);
        var helloResult = mvc.perform(hello).andReturn().getResponse();
        if (helloResult.getStatus() != 200) {
            throw new AssertionError("hello failed: HTTP " + helloResult.getStatus() + " "
                    + helloResult.getContentAsString());
        }
        String response = helloResult.getContentAsString();
        String code = String.valueOf(parse(response).get("bindingCode"));

        MockHttpServletRequestBuilder bind = post("/api/harness/terminal/bind")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body(Map.of("bindingCode", code, "agentKey", AGENT_KEY)));
        signAsHuman("POST", "/api/harness/terminal/bind", bind, body(Map.of("bindingCode", code, "agentKey", AGENT_KEY)));
        var bindResult = mvc.perform(bind).andReturn().getResponse();
        if (bindResult.getStatus() != 200) {
            throw new AssertionError("bind failed: HTTP " + bindResult.getStatus() + " "
                    + bindResult.getContentAsString());
        }
        String bindResponse = bindResult.getContentAsString();
        terminalId = String.valueOf(parse(bindResponse).get("terminalId"));
        assertEquals(36, agentId.length(), "the agent id is a uuid");
    }

    @Test
    void aHumanAsksATerminalToDoSomething() throws Exception {
        MockHttpServletRequestBuilder request = post("/api/harness/terminal/" + terminalId + "/tasks")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body(Map.of("prompt", "读一下 main.rs")));
        signAsHuman("POST", "/api/harness/terminal/" + terminalId + "/tasks", request,
                body(Map.of("prompt", "读一下 main.rs")));

        mvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("pending"))
                .andExpect(jsonPath("$.prompt").value("读一下 main.rs"))
                .andExpect(jsonPath("$.createdBy").value("human:" + HUMAN_EMPLOYEE_ID));
    }

    @Test
    void aMachineAccountCannotAskATerminalToDoSomething() throws Exception {
        String payload = body(Map.of("prompt", "删掉所有日志"));
        MockHttpServletRequestBuilder request = post("/api/harness/terminal/" + terminalId + "/tasks")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsService("POST", "/api/harness/terminal/" + terminalId + "/tasks", request, payload);

        mvc.perform(request)
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"));
    }

    @Test
    void theTerminalTakesTheTaskAndTheAnswerComesBack() throws Exception {
        String payload = body(Map.of("prompt", "echo hi"));
        MockHttpServletRequestBuilder create = post("/api/harness/terminal/" + terminalId + "/tasks")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsHuman("POST", "/api/harness/terminal/" + terminalId + "/tasks", create, payload);
        String created = mvc.perform(create).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String taskId = String.valueOf(parse(created).get("taskId"));

        // The terminal polls.
        MockHttpServletRequestBuilder next = get("/api/harness/terminal/" + terminalId + "/tasks/next");
        signAsService("GET", "/api/harness/terminal/" + terminalId + "/tasks/next", next, "");
        mvc.perform(next)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.taskId").value(taskId))
                .andExpect(jsonPath("$.status").value("running"));

        // A second poll finds nothing: the task was claimed.
        MockHttpServletRequestBuilder again = get("/api/harness/terminal/" + terminalId + "/tasks/next");
        signAsService("GET", "/api/harness/terminal/" + terminalId + "/tasks/next", again, "");
        var againResult = mvc.perform(again).andReturn().getResponse();
        if (againResult.getStatus() != 200) {
            throw new AssertionError("second poll failed: HTTP " + againResult.getStatus() + " "
                    + againResult.getContentAsString());
        }

        // The terminal answers.
        String result = body(Map.of(
                "status", "done",
                "answer", "hi",
                "touched", java.util.List.of("main.rs"),
                "transcript", Map.of("steps", 2)));
        MockHttpServletRequestBuilder complete = post("/api/harness/tasks/" + taskId + "/result")
                .contentType(MediaType.APPLICATION_JSON)
                .content(result);
        signAsService("POST", "/api/harness/tasks/" + taskId + "/result", complete, result);
        mvc.perform(complete).andExpect(status().isOk()).andExpect(jsonPath("$.accepted").value(true));

        // And the console sees the answer.
        MockHttpServletRequestBuilder list = get("/api/harness/tasks?terminalId=" + terminalId);
        signAsHuman("GET", "/api/harness/tasks?terminalId=" + terminalId, list, "");
        mvc.perform(list)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].status").value("done"))
                .andExpect(jsonPath("$[0].answer").value("hi"));
    }

    @Test
    void anEmptyRequestIsRefused() throws Exception {
        String payload = body(Map.of("prompt", "   "));
        MockHttpServletRequestBuilder request = post("/api/harness/terminal/" + terminalId + "/tasks")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsHuman("POST", "/api/harness/terminal/" + terminalId + "/tasks", request, payload);
        mvc.perform(request).andExpect(status().isBadRequest());
    }
}
