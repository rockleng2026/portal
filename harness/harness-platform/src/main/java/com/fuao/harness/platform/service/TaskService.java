package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.TaskRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import com.fuao.harness.protocol.json.Json;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * The console-to-terminal channel (V9).
 *
 * <p>A task is a request, not an authority. Creating one needs a natural human - the console is
 * a person, and the whole point of the harness is that a person stays in the loop for anything
 * that acts. The terminal then does the work under <em>its own</em> policy: the capability set
 * and the approval tokens the platform granted it, and nothing else. A task cannot widen what
 * the agent is allowed to do.
 */
@Service
public class TaskService {

    private final TaskRepository tasks;
    private final AuditService audit;
    private final AuthContext authContext;

    public TaskService(TaskRepository tasks, AuditService audit, AuthContext authContext) {
        this.tasks = tasks;
        this.audit = audit;
        this.authContext = authContext;
    }

    /** Creates a request for a terminal. Only a natural human may. */
    @Transactional
    public TaskRepository.TaskRow create(String terminalId, String prompt) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "asking a terminal to do something requires a natural human, caller was "
                            + actor.actorType() + " (" + actor.clientId() + ")");
        }
        if (prompt == null || prompt.isBlank()) {
            throw new IllegalArgumentException("the request must not be empty");
        }
        String taskId = Ids.newId();
        Instant now = Instant.now();
        tasks.insert(taskId, terminalId, prompt.trim(), actor.actorId(), now);
        audit.record(actor, taskId, "task.create", "task", taskId, "allow", null,
                "request sent to terminal " + terminalId,
                Map.of("terminalId", terminalId, "promptLength", String.valueOf(prompt.trim().length())));
        return tasks.find(taskId).orElseThrow();
    }

    /**
     * The terminal's side: take the oldest pending task, if any.
     *
     * <p>The claim is atomic, so two pollers never take the same task.
     */
    @Transactional
    public TaskRepository.TaskRow claimNext(String terminalId) {
        AuthenticatedClient actor = authContext.require();
        return tasks.claimNext(terminalId, Instant.now())
                .map(task -> {
                    audit.record(actor, task.taskId(), "task.claim", "task", task.taskId(), "allow", null,
                            "terminal " + terminalId + " took the task", Map.of("terminalId", terminalId));
                    return task;
                })
                .orElse(null);
    }

    /** The terminal's side: the answer. */
    @Transactional
    public boolean complete(String taskId, String status, String answer,
                            List<Map<String, Object>> transcript, List<String> touched, String error) {
        AuthenticatedClient actor = authContext.require();
        boolean ok = tasks.complete(taskId, status == null ? "done" : status, answer,
                transcript == null ? null : Json.canonical(transcript),
                touched == null ? null : Json.canonical(touched), error, Instant.now());
        audit.record(actor, taskId, "task.complete", "task", taskId, ok ? "allow" : "deny",
                ok ? null : "NOT_CLAIMED", error == null ? "the terminal answered" : error,
                Map.of("status", status == null ? "done" : status));
        return ok;
    }

    @Transactional
    public boolean cancel(String taskId, String reason) {
        AuthenticatedClient actor = authContext.require();
        boolean ok = tasks.cancel(taskId, reason);
        audit.record(actor, taskId, "task.cancel", "task", taskId, ok ? "allow" : "deny",
                ok ? null : "NOT_PENDING", reason, Map.of());
        return ok;
    }

    public List<TaskRepository.TaskRow> list(String terminalId, String status, int limit) {
        return tasks.list(terminalId, status, limit);
    }

    public TaskRepository.TaskRow get(String taskId) {
        return tasks.find(taskId)
                .orElseThrow(() -> new IllegalArgumentException("no such task: " + taskId));
    }
}
