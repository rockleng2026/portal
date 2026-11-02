package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.repo.AgentRepository;
import com.fuao.harness.platform.repo.TaskRepository;
import com.fuao.harness.protocol.Ids;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * The bridge: a task in the portal reaches the digital employee that has to do it, and the
 * answer comes back.
 *
 * <p>The chain has four links, and three of them existed before this class:
 * <ol>
 *   <li>the portal publishes a task and assigns it to an employee (portal's own code);</li>
 *   <li><b>this class</b> polls the portal's task API and turns each assignment into a task on
 *       the digital employee's terminal;</li>
 *   <li>the terminal picks the task up and works on it (the Rust agent's serve loop);</li>
 *   <li><b>this class again</b> writes the answer back into the portal's own todo.</li>
 * </ol>
 *
 * <p>Two decisions worth naming:
 * <ul>
 *   <li><b>The portal is asked, not read.</b> The portal owns its tasks; the platform asks
 *       through its API instead of reading its tables behind its back, so the portal's own
 *       validation and caches still apply (ADR-008, D-04: one task system, not two).</li>
 *   <li><b>The work is only delivered to the digital employee.</b> The task list is filtered by
 *       {@code users.isAI}, so a human's own task never comes through this door - a human's
 *       task is a human's business.</li>
 * </ul>
 */
@Service
public class PortalTaskService {

    private static final Logger log = LoggerFactory.getLogger(PortalTaskService.class);

    private final PortalClient portal;
    private final AgentRepository agents;
    private final TaskRepository tasks;
    private final TerminalService terminals;
    private final AuditService audit;
    private final TaskProposalService proposals;

    public PortalTaskService(PortalClient portal, AgentRepository agents, TaskRepository tasks,
                             TerminalService terminals, AuditService audit,
                             TaskProposalService proposals) {
        this.portal = portal;
        this.agents = agents;
        this.tasks = tasks;
        this.terminals = terminals;
        this.audit = audit;
        this.proposals = proposals;
    }

    /**
     * Picks up the assignments that are waiting for a digital employee.
     *
     * @return how many new tasks were created
     */
    @Transactional
    public int poll() {
        List<Map<String, Object>> portalTasks;
        try {
            portalTasks = portal.listTasks();
        } catch (RuntimeException e) {
            // The portal being unreachable is not a failure of the platform; the next poll tries
            // again. It is worth a line in the log, though: a portal that has been down for an
            // hour looks exactly like a portal with no work.
            log.warn("cannot read the tasks of the portal: {}", e.getMessage());
            return 0;
        }

        int created = 0;
        for (Map<String, Object> portalTask : portalTasks) {
            try {
                if (deliver(portalTask)) {
                    created++;
                }
            } catch (RuntimeException e) {
                log.warn("cannot deliver the portal task {}: {}", portalTask.get("assignmentId"), e.getMessage());
            }
        }
        if (created > 0) {
            log.info("picked up {} task(s) from the portal", created);
        }
        return created;
    }

    /**
     * Turns one portal assignment into a task for the digital employee.
     *
     * @return true when a task was created
     */
    private boolean deliver(Map<String, Object> portalTask) {
        String assignmentId = string(portalTask.get("assignmentId"));
        String missionId = string(portalTask.get("missionId"));
        String agentKey = string(portalTask.get("agentKey"));
        String employeeId = string(portalTask.get("employeeId"));
        if (assignmentId == null || missionId == null || agentKey == null || agentKey.isBlank()) {
            return false;
        }

        AgentRecord agent = agents.findByKey(agentKey).orElse(null);
        if (agent == null) {
            // The portal has an assignment for somebody the platform does not know. That is
            // worth a line: either the employee was hired outside the platform, or the agent was
            // retired. Neither should be silent.
            log.warn("the portal assigned task {} to {}, which is not a known digital employee",
                    assignmentId, agentKey);
            return false;
        }

        String terminalId = terminals.liveTerminalOf(agent.agentId());
        if (terminalId == null) {
            log.info("the digital employee {} has no live terminal; the task waits", agentKey);
            return false;
        }

        // The platform polls, so the same assignment is offered again and again. The link is
        // what stops the second poll from creating a second task.
        if (tasks.findByPortalAssignment(assignmentId, terminalId).isPresent()) {
            return false;
        }

        String prompt = promptOf(portalTask);
        String taskId = Ids.newId();
        tasks.insertFromPortal(taskId, terminalId, prompt, "portal:mission:" + missionId,
                assignmentId, integer(missionId), string(portalTask.get("sbh")), integer(employeeId),
                Instant.now());

        audit.record(com.fuao.harness.platform.security.AuthenticatedClient.system("portal-sync"),
                "task.create", "task", taskId, "allow", null,
                "picked up the portal task " + missionId + " for " + agentKey,
                Map.of("portalMissionId", missionId, "portalAssignmentId", assignmentId,
                        "agentKey", agentKey, "terminalId", terminalId));

        return true;
    }

    /**
     * The task, as the agent will read it.
     *
     * <p>The name first, then the description, then what the agent is expected to hand back.
     * A request that only says "here is a task" leaves the agent guessing what a finished one
     * looks like.
     */
    private String promptOf(Map<String, Object> portalTask) {
        String name = string(portalTask.get("name"));
        String description = string(portalTask.get("description"));
        StringBuilder prompt = new StringBuilder();
        prompt.append("【portal 任务】").append(name == null ? "" : name).append('\n');
        if (description != null && !description.isBlank()) {
            prompt.append(description).append('\n');
        }
        prompt.append('\n');
        // How to work comes before what to do. A model that is handed "build an HTML demo"
        // and nothing else will happily design the whole thing in prose - and a design in
        // prose is not a deliverable. Saying it plainly is worth more than a paragraph of
        // system prompt: a model asked to write a file writes a file.
        prompt.append("工作方式：\n");
        prompt.append("- 这是在一个代码工作区里干活。要看和要改的东西都用工具做"
                + "（list_files / read_file / write_file / edit_file / run_tests / shell_exec），")
                .append("不要把文件内容打在回答里。\n");
        prompt.append("- 产出物请写进工作区的文件；回答里说明写了哪个文件、怎么验证的。\n");
        prompt.append("- 回答会作为交付说明回到 portal 的任务列表，所以回答要说得清楚做了什么。\n");
        return prompt.toString();
    }

    /**
     * Writes the answer back into the portal.
     *
     * <p>The description is the agent's own answer. A human reading the employee's todo asks
     * "what did the digital employee actually do?", and a summary written by the platform would
     * be the platform's opinion rather than the agent's report.
     */
    @Transactional
    public boolean deliverBack(TaskRepository.TaskRow task, String answer) {
        if (task.portalMissionId() == null || task.portalEmployeeId() == null) {
            return false;
        }
        String description = answer == null ? "" : answer;
        try {
            portal.completeTask(task.portalMissionId(), task.portalEmployeeId(), description);
        } catch (RuntimeException e) {
            log.warn("cannot write the answer of task {} back to the portal: {}", task.taskId(),
                    e.getMessage());
            return false;
        }
        tasks.markDelivered(task.taskId(), "已回写 portal 任务 " + task.portalMissionId());
        // A proposal that the brain made is now delivered: the row says the whole story -
        // who asked, who published it, when the work came back and what the brain thought
        // of it.
        if (task.portalAssignmentId() != null) {
            proposals.byPortalAssignment(task.portalAssignmentId()).ifPresent(proposal ->
                    proposals.markDelivered(proposal.proposalId(), task.taskId(), Instant.now()));
        }
        audit.record(com.fuao.harness.platform.security.AuthenticatedClient.system("portal-sync"),
                "task.deliver", "task", task.taskId(), "allow", null,
                "wrote the answer back to the portal task " + task.portalMissionId(),
                Map.of("portalMissionId", String.valueOf(task.portalMissionId()),
                        "employeeId", String.valueOf(task.portalEmployeeId())));
        return true;
    }

    /**
     * The portal's "handout": the task appears in the digital employee's own todo.
     *
     * <p>Called when the terminal claims the task, because that is the moment the work really
     * starts - not the moment the platform noticed it.
     */
    public void acceptInPortal(TaskRepository.TaskRow task) {
        if (task.portalMissionId() == null || task.portalEmployeeId() == null) {
            return;
        }
        try {
            portal.acceptTask(task.portalMissionId(), task.portalEmployeeId());
        } catch (RuntimeException e) {
            log.warn("cannot hand the portal task {} to the employee: {}", task.portalMissionId(),
                    e.getMessage());
        }
    }

    /** Publishes a task in the portal for a digital employee. */
    public Map<String, Object> publish(String name, String description, String agentKey,
                                       String startTime, String endTime) {
        Map<String, Object> answer = portal.publishTask(name, description, agentKey, startTime, endTime);
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("ok", Boolean.TRUE);
        result.putAll(answer);
        return result;
    }

    private static String string(Object value) {
        if (value == null) {
            return null;
        }
        String text = String.valueOf(value).trim();
        return text.isEmpty() ? null : text;
    }

    private static Integer integer(Object value) {
        String text = string(value);
        if (text == null) {
            return null;
        }
        try {
            return Integer.valueOf(text);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
