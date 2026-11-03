package com.fuao.harness.platform;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fuao.harness.platform.service.TaskReflectionService;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

/**
 * The harness gets better as the tasks accumulate.
 *
 * <p>Harness² (Google, arXiv 2610.14224) keeps a persistent improvement harness: after each
 * task it is updated with the lessons the run taught, and the next task starts from them. The
 * paper is strict about the evidence, and so is this: a lesson is only stored when its cue,
 * its lesson and its evidence are all there, and an adopted lesson is a candidate until a
 * later task shows whether it helped.
 */
class HarnessLessonIT extends PlatformTestBase {

    @Autowired
    private TaskReflectionService reflection;

    private String agentId;
    private String terminalId;

    @BeforeEach
    void fixtures() throws Exception {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", 91);
        agentId = seedAgent("agent:reflect:" + java.util.UUID.randomUUID().toString().substring(0, 8),
                AGENT_OWNER_EMPLOYEE_ID, 91, 0);
        terminalId = java.util.UUID.randomUUID().toString();
        jdbc.sql("""
                        INSERT INTO harness_terminal
                          (terminal_id, device_id, os, agent_id, bind_type, agent_version, status)
                        VALUES
                          (:id, :device, 'linux', :agentId, 'agent', '0.1.0', 'online')
                        """)
                .param("id", terminalId)
                .param("device", "device-reflect-" + java.util.UUID.randomUUID())
                .param("agentId", agentId)
                .update();
    }

    /** A task that ran out of steps with files on the disk and no note of its own. */
    private String aRunThatRanOutOfSteps() {
        String taskId = java.util.UUID.randomUUID().toString();
        jdbc.sql("""
                        INSERT INTO harness_terminal_task
                          (task_id, terminal_id, prompt, status, answer, transcript, touched, error,
                           created_by, created_at, started_at, finished_at, claimed_at)
                        VALUES
                          (:taskId, :terminalId, '做一个演示', 'done', :answer, :transcript, :touched, NULL,
                           'human:1', NOW(), NOW(), NOW(), NOW())
                        """)
                .param("taskId", taskId)
                .param("terminalId", terminalId)
                .param("answer", "【本次运行到步数上限结束，模型没有写交付说明】\n\n工具调用 123 次。")
                .param("transcript", """
                        [{"kind":"model","step":1,"text":null,"tools":["list_files"]},
                         {"kind":"tool","step":1,"tool":"list_files","ok":true,"output":"main.rs"},
                         {"kind":"model","step":2,"text":null,"tools":["write_file"]},
                         {"kind":"tool","step":2,"tool":"write_file","ok":true,"output":"wrote 10612 bytes"}]
                        """)
                .param("touched", "[\"index.html\"]")
                .update();
        return taskId;
    }

    @Test
    void aRunThatRanOutOfStepsTeachesTheHarnessSomething() {
        String taskId = aRunThatRanOutOfSteps();

        TaskReflectionService.Observation observation = reflection.observe(taskId);
        assertNotNull(observation);
        assertEquals(2, observation.steps());
        assertEquals(2, observation.toolCalls());
        assertEquals(1, observation.files());
        assertTrue(observation.actedOnTheFirstTurn(), "the first turn used a tool");
        assertFalse(observation.wroteADeliveryNote(), "there was no note of its own");
        assertEquals("out_of_steps", observation.endedOn());

        // The lesson names the shape of the run, not the facts of this task.
        TaskReflectionService.Candidate candidate = reflection.lessonFor(observation);
        assertNotNull(candidate, "a run that ended on the step budget teaches something");
        assertEquals("tool_guidance", candidate.component());
        assertTrue(candidate.cue().contains("交"), "the cue says what shape of run it applies to: " + candidate.cue());
        assertTrue(candidate.lesson().contains("交差"), "the lesson says what to do: " + candidate.lesson());
        assertTrue(candidate.evidence().contains("工具调用"), "the lesson rests on the evidence: " + candidate.evidence());
    }

    @Test
    void aRunThatWentWellTeachesNothing() {
        // A run that finished with a note of its own has nothing to teach: a lesson about a
        // run that went well is a sentence in everyone's context for nothing.
        String taskId = java.util.UUID.randomUUID().toString();
        jdbc.sql("""
                        INSERT INTO harness_terminal_task
                          (task_id, terminal_id, prompt, status, answer, transcript, touched, error,
                           created_by, created_at, started_at, finished_at, claimed_at)
                        VALUES
                          (:taskId, :terminalId, '做一个演示', 'done', :answer, :transcript, :touched, NULL,
                           'human:1', NOW(), NOW(), NOW(), NOW())
                        """)
                .param("taskId", taskId)
                .param("terminalId", terminalId)
                .param("answer", "写好了 index.html，用 read_file 回读确认过。")
                .param("transcript", """
                        [{"kind":"model","step":1,"text":null,"tools":["write_file"]},
                         {"kind":"tool","step":1,"tool":"write_file","ok":true,"output":"wrote 10 bytes"},
                         {"kind":"model","step":2,"text":"写好了","tools":[]}]
                        """)
                .param("touched", "[\"index.html\"]")
                .update();

        TaskReflectionService.Observation observation = reflection.observe(taskId);
        assertNotNull(observation);
        assertTrue(observation.wroteADeliveryNote());
        assertEquals("finished", observation.endedOn());
        assertNull(reflection.lessonFor(observation), "a good run teaches nothing");
    }

    @Test
    void aLessonIsAProposalUntilAHumanAdoptsIt() throws Exception {
        String taskId = aRunThatRanOutOfSteps();

        MockHttpServletRequestBuilder propose = post("/api/harness/harness-lesson")
                .param("taskId", taskId);
        signAsHuman("POST", "/api/harness/harness-lesson?taskId=" + taskId, propose, "");
        String response = mvc.perform(propose)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.proposed").value(true))
                .andReturn().getResponse().getContentAsString();
        String lessonId = String.valueOf(parse(response).get("lessonId"));

        // A proposal is not a lesson yet: the terminal does not get it.
        MockHttpServletRequestBuilder list = get("/api/harness/harness-lesson");
        signAsHuman("GET", "/api/harness/harness-lesson", list, "");
        mvc.perform(list)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].status").value("proposed"));

        MockHttpServletRequestBuilder adopt = put("/api/harness/harness-lesson/" + lessonId + "/adopt")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body(Map.of("reason", "控制台采纳")));
        signAsHuman("PUT", "/api/harness/harness-lesson/" + lessonId + "/adopt", adopt, body(Map.of("reason", "控制台采纳")));
        mvc.perform(adopt)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("candidate"));
    }

    @Test
    void theTerminalGetsTheLessonsThatAreInForce() throws Exception {
        String taskId = aRunThatRanOutOfSteps();
        MockHttpServletRequestBuilder propose = post("/api/harness/harness-lesson")
                .param("taskId", taskId);
        signAsHuman("POST", "/api/harness/harness-lesson?taskId=" + taskId, propose, "");
        String response = mvc.perform(propose).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String lessonId = String.valueOf(parse(response).get("lessonId"));

        MockHttpServletRequestBuilder adopt = put("/api/harness/harness-lesson/" + lessonId + "/adopt")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body(Map.of("reason", "采纳")));
        signAsHuman("PUT", "/api/harness/harness-lesson/" + lessonId + "/adopt", adopt, body(Map.of("reason", "采纳")));
        mvc.perform(adopt).andExpect(status().isOk());

        // The terminal asks for its harness and gets the lesson, with the component it names.
        MockHttpServletRequestBuilder harness =
                get("/api/harness/terminal/" + terminalId + "/harness");
        signAsHuman("GET", "/api/harness/terminal/" + terminalId + "/harness", harness, "");
        mvc.perform(harness)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.lessons.length()").value(1))
                .andExpect(jsonPath("$.lessons[0].component").value("tool_guidance"))
                .andExpect(jsonPath("$.lessons[0].text").isNotEmpty());
    }

    @Test
    void aRejectedLessonIsNotSentToTheTerminal() throws Exception {
        String taskId = aRunThatRanOutOfSteps();
        MockHttpServletRequestBuilder propose = post("/api/harness/harness-lesson")
                .param("taskId", taskId);
        signAsHuman("POST", "/api/harness/harness-lesson?taskId=" + taskId, propose, "");
        String response = mvc.perform(propose).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        String lessonId = String.valueOf(parse(response).get("lessonId"));

        MockHttpServletRequestBuilder reject = put("/api/harness/harness-lesson/" + lessonId + "/reject")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body(Map.of("reason", "不需要")));
        signAsHuman("PUT", "/api/harness/harness-lesson/" + lessonId + "/reject", reject, body(Map.of("reason", "不需要")));
        mvc.perform(reject).andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("rejected"));

        MockHttpServletRequestBuilder harness =
                get("/api/harness/terminal/" + terminalId + "/harness");
        signAsHuman("GET", "/api/harness/terminal/" + terminalId + "/harness", harness, "");
        mvc.perform(harness)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.lessons.length()").value(0));
    }

}
