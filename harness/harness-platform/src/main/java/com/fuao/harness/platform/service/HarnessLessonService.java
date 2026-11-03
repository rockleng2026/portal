package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.HarnessLessonRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * The harness gets better as the tasks accumulate.
 *
 * <p>Harness² (Google, arXiv 2610.14224) keeps a persistent <em>improvement harness</em>:
 * after each task it is updated with the harnesses that were adopted and with
 * evidence-supported lessons, and the next task starts from them. This is the same idea, with
 * the paper's strictness about the evidence kept:
 *
 * <ul>
 *   <li>a lesson is only stored when its <b>cue</b>, its <b>lesson</b> and its
 *       <b>evidence</b> are all there. A lesson that rests on nothing is a guess, and a guess
 *       in the library is read by every later task;</li>
 *   <li>the lesson names the <b>component</b> it concerns, so it can be filed and so a
 *       reader knows where it applies;</li>
 *   <li>an adopted lesson is a <b>candidate</b> until a later task shows whether it
 *       helped. That is the probe: one task of evidence, and the lesson is confirmed or
 *       rolled back.</li>
 * </ul>
 *
 * <p>What is <em>not</em> here: the authority. The policy and the grant decide what the
 * digital employee may do; the harness decides how it does it. So a lesson is a proposal, and
 * a natural human adopts it - the same rule the skill market follows, and the same rule that
 * keeps "AI cannot grant itself authority" true even where the authority is not at stake.
 */
@Service
public class HarnessLessonService {

    /** The components a lesson may concern. */
    public static final List<String> COMPONENTS =
            List.of("systemprompt", "guardrails", "tool_guidance", "memory");

    private final HarnessLessonRepository lessons;
    private final TaskReflectionService reflection;
    private final AuditService audit;
    private final AuthContext authContext;

    public HarnessLessonService(HarnessLessonRepository lessons, TaskReflectionService reflection,
                                AuditService audit, AuthContext authContext) {
        this.lessons = lessons;
        this.reflection = reflection;
        this.audit = audit;
        this.authContext = authContext;
    }

    /**
     * Reflects on a run and proposes what it taught.
     *
     * <p>The proposal is derived from what the run <em>did</em>, not from what the model
     * said about itself: the number of turns it took, the number of files it produced, whether
     * it acted on its first turn, whether it handed in a delivery note of its own, and how it
     * ended. Those are facts, and a lesson that rests on a fact can be checked.
     */
    @Transactional
    public HarnessLessonRepository.LessonRow propose(String taskId, String agentId, String terminalId) {
        AuthenticatedClient actor = authContext.require();
        TaskReflectionService.Observation observation = reflection.observe(taskId);
        if (observation == null) {
            return null;
        }
        // What the run did is recorded first: the lesson rests on it, and the probe needs it
        // to judge whether the lesson helped.
        reflection.record(observation);
        TaskReflectionService.Candidate candidate = reflection.lessonFor(observation);
        if (candidate == null) {
            // Nothing to learn from this one: the run went well and there is nothing to change.
            return null;
        }
        // The same lesson twice is not two lessons. A run that ends the same way teaches the
        // same thing, and a library with the same sentence in it five times is a library
        // nobody reads - and every copy is context the model pays for.
        if (lessons.exists(candidate.cue(), candidate.component(), agentId)) {
            return null;
        }
        Instant now = Instant.now();
        String lessonId = Ids.newId();
        lessons.insert(lessonId, agentId, terminalId, candidate.cue(), candidate.lesson(),
                candidate.component(), candidate.evidence(), candidate.confidence(), "proposed",
                taskId, actor.actorId(), now);
        audit.record(actor, "harness.lesson.propose", "harness_lesson", lessonId, "allow", null,
                "proposed a lesson from the run " + taskId,
                Map.of("cue", candidate.cue(), "component", candidate.component()));
        return lessons.find(lessonId).orElse(null);
    }

    /**
     * Reflects on a run and probes the lessons that were waiting for one.
     *
     * <p>Called when a task finishes. The order matters: the probe judges the run that just
     * happened, and the proposal is about the run that just happened - so the probe comes
     * first, or a lesson would be judged by the run that tested it.
     */
    @Transactional
    public HarnessLessonRepository.LessonRow reflect(String taskId, String agentId, String terminalId) {
        reflection.probe(agentId);
        return propose(taskId, agentId, terminalId);
    }

    public List<HarnessLessonRepository.LessonRow> list(String status, String agentId) {
        return lessons.list(status, agentId);
    }

    /**
     * The lessons the terminal should have.
     *
     * <p>Only the confirmed ones and the candidates that are being probed: a proposal nobody
     * adopted is not a lesson, and a candidate that was rolled back is not a lesson either.
     */
    public List<Map<String, Object>> forTerminal(String terminalId, String agentId) {
        List<Map<String, Object>> out = new java.util.ArrayList<>();
        for (HarnessLessonRepository.LessonRow lesson : lessons.list(null, agentId)) {
            if (!"confirmed".equals(lesson.status()) && !"candidate".equals(lesson.status())) {
                continue;
            }
            Map<String, Object> m = new java.util.LinkedHashMap<>();
            m.put("id", lesson.lessonId());
            m.put("component", lesson.component());
            m.put("text", lesson.lesson());
            m.put("status", lesson.status());
            out.add(m);
        }
        return out;
    }

    /**
     * Adopts a lesson.
     *
     * <p>It goes in as a <b>candidate</b>: the next task is the probe. If that task goes
     * better the lesson is confirmed, and if it does not, it is rolled back.
     */
    @Transactional
    public HarnessLessonRepository.LessonRow adopt(String lessonId, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "harness.lesson.adopt");
        HarnessLessonRepository.LessonRow lesson = lessons.find(lessonId)
                .orElseThrow(() -> new IllegalArgumentException("no such lesson: " + lessonId));
        if (!"proposed".equals(lesson.status())) {
            throw new IllegalStateException("the lesson has already been " + lesson.status());
        }
        lessons.markStatus(lessonId, "candidate", actor.actorId(), reason, Instant.now());
        audit.record(actor, "harness.lesson.adopt", "harness_lesson", lessonId, "allow", null,
                reason == null ? "adopted for a probe" : reason, Map.of());
        return lessons.find(lessonId).orElse(null);
    }

    /** Turns a lesson down. */
    @Transactional
    public HarnessLessonRepository.LessonRow reject(String lessonId, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "harness.lesson.reject");
        HarnessLessonRepository.LessonRow lesson = lessons.find(lessonId)
                .orElseThrow(() -> new IllegalArgumentException("no such lesson: " + lessonId));
        lessons.markStatus(lessonId, "rejected", actor.actorId(), reason, Instant.now());
        audit.record(actor, "harness.lesson.reject", "harness_lesson", lessonId, "allow", null,
                reason == null ? "rejected" : reason, Map.of());
        return lessons.find(lessonId).orElse(null);
    }

    private static void requireHuman(AuthenticatedClient actor, String op) {
        if (!actor.isHuman()) {
            throw new IllegalArgumentException(op + " requires a natural human, caller was "
                    + actor.actorType() + " (" + actor.clientId() + ")");
        }
    }
}
