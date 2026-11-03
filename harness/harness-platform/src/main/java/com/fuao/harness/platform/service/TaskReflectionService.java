package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.HarnessLessonRepository;
import com.fuao.harness.platform.repo.TaskRepository;
import com.fuao.harness.platform.repo.TerminalRepository;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * What a run teaches the harness.
 *
 * <p>Harness² (Google, arXiv 2610.14224) reflects on a run and writes at most one
 * transferable lesson, and it insists the lesson rests on <em>evidence</em>: "the cue describes
 * the shape of situation the lesson applies to, so it can fire on a different matter - not this
 * task's facts, but the pattern"; "a lesson resting only on confounded rows is a guess".
 *
 * <p>So the cue here is the shape of the run - "the run ended on the step budget with files on
 * the disk and no delivery note" - and not "the demo about the earth's orbit needed 120 turns".
 * The lesson is the operation to perform on the harness, and the evidence is the contrast
 * between this run and what a good run looks like.
 *
 * <p>The reflection is deterministic. A model asked "what did you learn?" writes a lesson
 * about the situation it was in; the facts below are the situation, and they can be checked.
 * A lesson that cannot be checked is a lesson nobody can roll back.
 */
@Service
public class TaskReflectionService {

    /** The facts about one run. */
    public record Observation(
            String taskId,
            String agentId,
            String terminalId,
            int steps,
            int toolCalls,
            int files,
            boolean actedOnTheFirstTurn,
            boolean wroteADeliveryNote,
            String endedOn) {
    }

    /** What the run teaches. */
    public record Candidate(String cue, String lesson, String component, String evidence, String confidence) {
    }

    private final TaskRepository tasks;
    private final TerminalRepository terminals;
    private final HarnessLessonRepository runs;

    public TaskReflectionService(TaskRepository tasks, TerminalRepository terminals,
                                 HarnessLessonRepository runs) {
        this.tasks = tasks;
        this.terminals = terminals;
        this.runs = runs;
    }

    /**
     * Reads what a run did.
     *
     * <p>Everything here is countable: the turns it took, the tools it called, the files it
     * produced, whether it acted on its first turn, whether it handed in a note of its own,
     * and how it ended.
     */
    public Observation observe(String taskId) {
        TaskRepository.TaskRow task = tasks.find(taskId).orElse(null);
        if (task == null) {
            return null;
        }
        List<Map<String, Object>> transcript = TaskRepository.parseJsonList(task.transcript());

        int steps = 0;
        int toolCalls = 0;
        boolean actedOnFirstTurn = false;
        for (Map<String, Object> event : transcript) {
            if ("model".equals(event.get("kind"))) {
                steps++;
                Object tools = event.get("tools");
                if (steps == 1 && tools instanceof List<?> list && !list.isEmpty()) {
                    actedOnFirstTurn = true;
                }
            } else if ("tool".equals(event.get("kind"))) {
                toolCalls++;
            }
        }

        int files = 0;
        for (Object path : TaskRepository.parseJsonArray(task.touched())) {
            if (path != null) {
                files++;
            }
        }

        String answer = task.answer() == null ? "" : task.answer();
        String error = task.error() == null ? "" : task.error();
        boolean wroteADeliveryNote = !answer.isBlank() && !isAFallback(answer)
                && (error.isBlank() || !isAFallback(error));

        String endedOn = "finished";
        if (answer.contains("步数上限") || error.contains("step budget")) {
            endedOn = "out_of_steps";
        } else if (answer.contains("上下文预算") || error.contains("context budget")) {
            endedOn = "out_of_context";
        } else if (answer.contains("一次调用都没做") || answer.contains("没有动手")) {
            endedOn = "never_acted";
        } else if (answer.contains("一直在用输出") || error.contains("output tokens")) {
            endedOn = "kept_thinking";
        } else if ("failed".equals(task.status())) {
            endedOn = "failed";
        }

        String agentId = null;
        if (task.terminalId() != null) {
            agentId = terminals.findById(task.terminalId())
                    .map(t -> t.agentId())
                    .orElse(null);
        }
        return new Observation(taskId, agentId, task.terminalId(), steps, toolCalls, files,
                actedOnFirstTurn, wroteADeliveryNote, endedOn);
    }

    /**
     * The lesson the run teaches, if there is one.
     *
     * <p>At most one, and only when the run shows something the harness could have prevented.
     * A run that went well teaches nothing, and a lesson about a run that went well is a
     * sentence in everyone's context for nothing.
     */
    public Candidate lessonFor(Observation observation) {
        if (observation == null) {
            return null;
        }
        String evidence = "这一次：%d 轮模型调用、%d 次工具调用、%d 个文件；第一轮%s；结束方式 %s。"
                .formatted(observation.steps(), observation.toolCalls(), observation.files(),
                        observation.actedOnTheFirstTurn() ? "就动手了" : "没有动手",
                        observation.endedOn());

        if ("out_of_steps".equals(observation.endedOn())) {
            if (observation.files() > 0 && !observation.wroteADeliveryNote()) {
                return new Candidate(
                        "产出写好了，但没说清楚就交回",
                        "写完文件就用一句话交差：改了哪个文件、怎么验证的。写完就停，不要继续打磨。",
                        "tool_guidance",
                        evidence + " 文件已经写好，却没有交付说明——人拿到的是一句“步数用完了”。",
                        "high");
            }
            return new Candidate(
                    "活多到步数用完",
                    "一次只做一件事：先落一个能跑的最小版本，再一步一步改。",
                    "systemprompt",
                    evidence + " 步数用完，产出可能只完成了一部分。",
                    "medium");
        }
        if ("out_of_context".equals(observation.endedOn())) {
            return new Candidate(
                    "反复读整份文件把上下文读满",
                    "文件大的时候只读需要的那一段；工具输出已经截断了，别指望再读一遍。",
                    "tool_guidance",
                    evidence + " 上下文用满，说明读的东西比需要的多。",
                    "high");
        }
        if ("never_acted".equals(observation.endedOn()) || "kept_thinking".equals(observation.endedOn())) {
            return new Candidate(
                    "一直在想，没动手",
                    "先动手再解释：先调一次工具看现场，再决定怎么做。方案写在脑子里不算进度。",
                    "systemprompt",
                    evidence + " 没有一次工具调用，产出为零。",
                    "high");
        }
        if (!observation.actedOnTheFirstTurn() && observation.toolCalls() > 0) {
            return new Candidate(
                    "第一轮只想不做",
                    "先看一眼现场再动手：第一步就用工具看目录或读文件，别先在回答里设计。",
                    "systemprompt",
                    evidence + " 第一轮没有工具调用，后面才想起来看。",
                    "medium");
        }
        return null;
    }

    /**
     * Records what a run did, so the reflection and the audit can both read it.
     */
    @Transactional
    public void record(Observation observation) {
        if (observation == null) {
            return;
        }
        Instant now = Instant.now();
        runs.insertRun(com.fuao.harness.protocol.Ids.newId(), observation.taskId(), observation.agentId(),
                observation.terminalId(), observation.steps(), observation.toolCalls(),
                observation.files(), observation.actedOnTheFirstTurn(),
                observation.wroteADeliveryNote(), observation.endedOn(), now);
    }

    /**
     * The probe: a lesson that was adopted has to earn its place.
     *
     * <p>It is a candidate until a task runs with it. If that task finished with a delivery
     * note of its own and did not run out of anything, the lesson is confirmed; if the task
     * ran into a wall anyway, the lesson is rolled back and the terminal stops being sent
     * it.
     *
     * <p>One task of evidence, and no more - that is what a probe is in Harness² too: a
     * single rollout is weak evidence either way, and a lesson that rests on one is a
     * candidate, not a fact.
     */
    @Transactional
    public void probe(String agentId) {
        if (agentId == null) {
            return;
        }
        List<HarnessLessonRepository.LessonRow> candidates = runs.list("candidate", agentId);
        if (candidates.isEmpty()) {
            return;
        }
        HarnessLessonRepository.RunRow last = runs.lastRun(agentId).orElse(null);
        if (last == null) {
            return;
        }
        Instant now = Instant.now();
        for (HarnessLessonRepository.LessonRow candidate : candidates) {
            // The probe is the run that came AFTER the lesson was adopted. A run from
            // before says nothing about it.
            if (!last.observedAt().isAfter(candidate.updatedAt())) {
                continue;
            }
            boolean good = last.deliveryNote()
                    && !last.endedOn().startsWith("out_of")
                    && !"failed".equals(last.endedOn());
            String reason = "探测：这一次 " + last.steps() + " 轮、" + last.toolCalls() + " 次工具调用、"
                    + last.files() + " 个文件，" + (good ? "交了自己的说明" : "没有交成");
            runs.markStatus(candidate.lessonId(), good ? "confirmed" : "rolled_back",
                    "system:reflection", reason, now);
        }
    }

    /** The fallback answers the agent writes when it did not finish. */
    private static boolean isAFallback(String text) {
        if (text == null || text.isBlank()) {
            return true;
        }
        return text.contains("步数上限") || text.contains("上下文预算")
                || text.contains("the model failed") || text.contains("the step budget")
                || text.contains("the context budget") || text.contains("模型没有写交付说明");
    }
}
