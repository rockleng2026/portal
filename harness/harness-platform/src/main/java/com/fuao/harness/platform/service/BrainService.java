package com.fuao.harness.platform.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fuao.harness.platform.repo.AuditRepository;
import com.fuao.harness.platform.repo.CapabilityRepository;
import com.fuao.harness.platform.repo.EventRepository;
import com.fuao.harness.platform.repo.KillSwitchRepository;
import com.fuao.harness.platform.repo.TaskRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * The platform's brain: the conversation an operator has with the platform about the platform.
 *
 * <p>The terminal agents work on the machines. This one works on the platform: it sees the
 * digital employees, the terminals, the grants, the approvals, the events and the audit, and
 * answers questions about them in words instead of making the operator read tables.
 *
 * <p>Two rules make this safe to offer:
 * <ul>
 *   <li>every tool is <b>read-only</b>. The brain observes and advises; a change goes through
 *       the console, where a natural human is the one who presses the button and the audit
 *       records it;</li>
 *   <li>the brain answers with what the platform actually holds. It has no memory of its own
 *       about the state of the world - every question goes through a tool, so an answer is a
 *       reading, not a recollection.</li>
 * </ul>
 */
@Service
public class BrainService {

    private static final Logger log = LoggerFactory.getLogger(BrainService.class);
    private static final ObjectMapper JSON = new ObjectMapper();

    /** How many turns of the conversation are kept for the model. */
    private static final int HISTORY_TURNS = 24;
    /** How many tool rounds one question may take. */
    private static final int MAX_TOOL_ROUNDS = 6;
    /** How many sessions are kept in memory. */
    private static final int MAX_SESSIONS = 200;

    private final ModelClient models;
    private final ModelConfigService modelConfigs;
    private final AgentService agents;
    private final TerminalService terminals;
    private final GrantService grants;
    private final ApprovalService approvals;
    private final TaskService tasks;
    private final EventIngestService events;
    private final AuditService audit;
    private final CapabilityRepository capabilities;
    private final KillSwitchService killSwitches;
    private final AuthContext authContext;

    private final Map<String, Session> sessions = new ConcurrentHashMap<>();

    public BrainService(ModelClient models, ModelConfigService modelConfigs, AgentService agents,
                        TerminalService terminals, GrantService grants, ApprovalService approvals,
                        TaskService tasks, EventIngestService events, AuditService audit,
                        CapabilityRepository capabilities, KillSwitchService killSwitches,
                        AuthContext authContext) {
        this.models = models;
        this.modelConfigs = modelConfigs;
        this.agents = agents;
        this.terminals = terminals;
        this.grants = grants;
        this.approvals = approvals;
        this.tasks = tasks;
        this.events = events;
        this.audit = audit;
        this.capabilities = capabilities;
        this.killSwitches = killSwitches;
        this.authContext = authContext;
    }

    /** One conversation. */
    public static class Session {
        private final String sessionId;
        private final String title;
        private final Instant createdAt;
        private final List<Map<String, Object>> turns = new ArrayList<>();
        private Instant touchedAt;

        Session(String sessionId, String title) {
            this.sessionId = sessionId;
            this.title = title;
            this.createdAt = Instant.now();
            this.touchedAt = this.createdAt;
        }

        public String sessionId() {
            return sessionId;
        }

        public String title() {
            return title;
        }

        public Instant createdAt() {
            return createdAt;
        }

        public Instant touchedAt() {
            return touchedAt;
        }

        public List<Map<String, Object>> turns() {
            return List.copyOf(turns);
        }
    }

    /** What the console shows about a session. */
    public record SessionView(String sessionId, String title, Instant createdAt, Instant touchedAt,
                              int messages) {
    }

    /** The answer to one question. */
    public record Answer(String sessionId, String answer, List<String> toolsUsed, List<Map<String, Object>> turns) {
    }

    /** The sessions of this platform. */
    public List<SessionView> sessions() {
        return sessions.values().stream()
                .sorted((a, b) -> b.touchedAt().compareTo(a.touchedAt()))
                .map(s -> new SessionView(s.sessionId(), s.title(), s.createdAt(), s.touchedAt(), s.turns.size()))
                .toList();
    }

    /** One session and its turns. */
    public Optional<SessionView> session(String sessionId) {
        Session session = sessions.get(sessionId);
        if (session == null) {
            return Optional.empty();
        }
        return Optional.of(new SessionView(session.sessionId(), session.title(), session.createdAt(),
                session.touchedAt(), session.turns.size()));
    }

    /** The messages of one session. */
    public List<Map<String, Object>> turns(String sessionId) {
        Session session = sessions.get(sessionId);
        return session == null ? List.of() : session.turns();
    }

    /** Forgets one session. */
    public boolean forget(String sessionId) {
        return sessions.remove(sessionId) != null;
    }

    /**
     * Asks the brain a question.
     *
     * @param sessionId the conversation to continue, or {@code null} to start a new one
     * @param question  what the operator asked
     */
    public Answer ask(String sessionId, String question) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "the platform's brain answers a natural human, caller was " + actor.actorType());
        }
        String text = question == null ? "" : question.trim();
        if (text.isEmpty()) {
            throw new IllegalArgumentException("说点什么吧");
        }
        ModelConfigService.TerminalModelConfig model = brainModel()
                .orElseThrow(() -> new BrainNotConfigured(
                        "还没有给大脑配模型。到「模型配置」里选「大脑（平台默认）」配一个，"
                                + "这个对话才有脑子。"));

        Session session = sessionId == null || sessionId.isBlank()
                ? new Session(UUID.randomUUID().toString(), title(text))
                : sessions.computeIfAbsent(sessionId, id -> new Session(id, title(text)));
        session.touchedAt = Instant.now();
        // A new conversation has to be remembered, or the list on the left stays empty and
        // the next question starts a new one every time.
        sessions.put(session.sessionId(), session);
        evictOldSessions();

        // The system message comes first: some gateways (and the chat template behind the
        // local model) refuse anything else.
        List<Map<String, Object>> history = new ArrayList<>();
        history.add(Map.of("role", "system", "content", SYSTEM));
        history.addAll(session.turns);
        history.add(Map.of("role", "user", "content", text));

        List<String> toolsUsed = new ArrayList<>();
        String answer = "";
        for (int round = 0; round <= MAX_TOOL_ROUNDS; round++) {
            ModelClient.Turn turn = models.nextTurn(model, history, toolCatalogue());
            if (!turn.wantsTools()) {
                answer = turn.text();
                break;
            }
            for (ModelClient.ToolCall call : turn.calls()) {
                toolsUsed.add(call.name());
                String result = runTool(call);
                history.add(Map.of("role", "user", "content", "工具 " + call.name() + " 的结果：\n" + result));
            }
            if (round == MAX_TOOL_ROUNDS) {
                answer = "这个问题需要的工具调用次数太多了，我先停在这里。";
            }
        }
        if (answer == null || answer.isBlank()) {
            answer = "模型没有给出回答。";
        }

        session.turns.add(Map.of("role", "user", "content", text));
        session.turns.add(Map.of("role", "assistant", "content", answer));
        while (session.turns.size() > HISTORY_TURNS) {
            session.turns.remove(0);
        }
        return new Answer(session.sessionId(), answer, toolsUsed, session.turns());
    }

    /** The brain's model: the global one. */
    public Optional<ModelConfigService.TerminalModelConfig> brainModel() {
        return modelConfigs.forBrain();
    }

    /** Forgets the oldest conversations when there are too many. */
    private void evictOldSessions() {
        if (sessions.size() <= MAX_SESSIONS) {
            return;
        }
        sessions.values().stream()
                .sorted(Comparator.comparing(Session::touchedAt))
                .limit(sessions.size() - MAX_SESSIONS)
                .map(Session::sessionId)
                .toList()
                .forEach(sessions::remove);
    }

    private static String title(String question) {
        String oneLine = question.replaceAll("\\s+", " ").trim();
        return oneLine.length() <= 24 ? oneLine : oneLine.substring(0, 24) + "…";
    }

    /** What the brain is told about itself, and what it may not do. */
    private static final String SYSTEM = """
            你是 Harness 数字员工平台的运维大脑。你为管理人员服务，回答关于这个平台的问题。

            你能看到的东西（用工具去读，不要凭记忆回答）：
              - 数字员工（harness_agent）：名字、业务键、状态、自主等级、部门、责任人、是否已入职 portal
              - 终端（harness_terminal）：绑定、状态、最后心跳、型号、绑定的数字员工
              - 授权（harness_grant）：谁、在什么部门范围、被授了什么能力、什么时候到期
              - 审批（harness_approval）：待批的动作、层级、状态
              - 任务（harness_task）：终端上的请求与结果
              - 事件（harness_event）：告警与注入判定
              - 审计（harness_audit）：谁在什么时候做了什么
              - Kill-Switch：各个粒度的开关状态
              - 模型配置：大脑与每个数字员工、每台终端用的是什么模型

            规矩：
              1. 你的工具**只读**。你要做的改动（授权、暂停、吊销、改配置）告诉管理人员去控制台上操作，
                 并说清楚在哪一页、点什么。绝不要声称自己已经改了。
              2. 数字说错了就直说，并说应该怎么查。
              3. 用中文回答，简短、直接、结论先行；需要细节时再展开。
              4. 不确定就说不确定，不要编。
            """;

    /** The tools the brain may call. Public so a test can check that none of them changes anything. */
    public static List<Map<String, Object>> toolCatalogue() {
        List<Map<String, Object>> tools = new ArrayList<>();
        tools.add(tool("list_agents", "列出数字员工：名字、业务键、状态、自主等级、部门、责任人。",
                Map.of("type", "object", "properties", Map.of("status", Map.of(
                        "type", "string", "description", "按状态过滤，可留空")))));
        tools.add(tool("list_terminals", "列出终端：终端号、绑定状态、最后心跳、绑定的数字员工。",
                Map.of("type", "object", "properties", Map.of())));
        tools.add(tool("get_agent", "看一个数字员工的详情（按业务键或 agentId）。",
                Map.of("type", "object", "properties", Map.of("agent", Map.of(
                        "type", "string", "description", "业务键或 agentId")), "required", List.of("agent"))));
        tools.add(tool("get_terminal", "看一台终端的详情。",
                Map.of("type", "object", "properties", Map.of("terminalId", Map.of("type", "string")),
                        "required", List.of("terminalId"))));
        tools.add(tool("list_grants", "列出当前生效的授权：谁、被授了什么能力、在哪些部门生效、什么时候到期。",
                Map.of("type", "object", "properties", Map.of("agentId", Map.of(
                        "type", "string", "description", "只看某个数字员工，可留空")))));
        tools.add(tool("list_approvals", "列出审批：待批的、已批的、已驳回的。",
                Map.of("type", "object", "properties", Map.of("status", Map.of(
                        "type", "string", "description", "pending / approved / rejected，可留空")))));
        tools.add(tool("list_tasks", "列出终端上的任务与结果。",
                Map.of("type", "object", "properties", Map.of("terminalId", Map.of(
                        "type", "string", "description", "可留空，留空看全部")))));
        tools.add(tool("list_events", "列出事件流与被判定为注入的那些。",
                Map.of("type", "object", "properties", Map.of("status", Map.of(
                        "type", "string", "description", "可留空")))));
        tools.add(tool("list_audit", "查审计流水：谁在什么时候做了什么。",
                Map.of("type", "object", "properties", Map.of("limit", Map.of(
                        "type", "integer", "description", "默认 30")))));
        tools.add(tool("list_killswitches", "列出 Kill-Switch 的状态。",
                Map.of("type", "object", "properties", Map.of())));
        tools.add(tool("list_model_configs", "列出模型配置（不含密钥）：大脑、每个数字员工、每台终端用的模型。",
                Map.of("type", "object", "properties", Map.of())));
        return tools;
    }

    private static Map<String, Object> tool(String name, String description, Map<String, Object> schema) {
        Map<String, Object> tool = new LinkedHashMap<>();
        tool.put("name", name);
        tool.put("description", description);
        tool.put("input_schema", schema);
        return tool;
    }

    /** Runs one read-only tool. */
    private String runTool(ModelClient.ToolCall call) {
        try {
            Map<String, Object> arguments = call.arguments() == null ? Map.of() : call.arguments();
            return switch (call.name()) {
                case "list_agents" -> json(agents.list(text(arguments, "status"), null, 100).stream()
                        .map(a -> Map.<String, Object>of(
                                "name", String.valueOf(a.name()),
                                "agentKey", String.valueOf(a.agentKey()),
                                "status", a.status().wire(),
                                "autonomyLevel", a.autonomyLevel(),
                                "deptId", String.valueOf(a.deptId()),
                                "ownerId", String.valueOf(a.ownerId()),
                                "portalEmployeeId", String.valueOf(a.portalEmployeeId()),
                                "terminalId", String.valueOf(a.portalUserId())))
                        .toList());
                case "list_terminals" -> json(terminals.list(100).stream()
                        .map(t -> Map.<String, Object>of(
                                "terminalId", t.terminalId(),
                                "status", t.status(),
                                "bindType", String.valueOf(t.bindType()),
                                "agentId", String.valueOf(t.agentId()),
                                "lastHeartbeat", String.valueOf(t.lastHeartbeat()),
                                "os", String.valueOf(t.os())))
                        .toList());
                case "get_agent" -> {
                    String key = text(arguments, "agent");
                    yield json(agents.list(null, null, 200).stream()
                            .filter(a -> key.equals(a.agentKey()) || key.equals(a.agentId()))
                            .findFirst()
                            .map(a -> Map.<String, Object>of(
                                    "name", String.valueOf(a.name()),
                                    "agentKey", String.valueOf(a.agentKey()),
                                    "status", a.status().wire(),
                                    "autonomyLevel", a.autonomyLevel(),
                                    "deptId", String.valueOf(a.deptId()),
                                    "ownerId", String.valueOf(a.ownerId()),
                                    "portalEmployeeId", String.valueOf(a.portalEmployeeId())))
                            .orElse(Map.of("found", false, "agent", key)));
                }
                case "get_terminal" -> {
                    String id = text(arguments, "terminalId");
                    yield json(terminals.list(500).stream()
                            .filter(t -> id.equals(t.terminalId()))
                            .findFirst()
                            .map(t -> Map.<String, Object>of(
                                    "terminalId", t.terminalId(),
                                    "status", t.status(),
                                    "bindType", String.valueOf(t.bindType()),
                                    "agentId", String.valueOf(t.agentId()),
                                    "lastHeartbeat", String.valueOf(t.lastHeartbeat()),
                                    "boundAt", String.valueOf(t.boundAt()),
                                    "os", String.valueOf(t.os())))
                            .orElse(Map.of("found", false, "terminalId", id)));
                }
                case "list_grants" -> json(grants.activeFor(text(arguments, "agentId")).stream()
                        .map(g -> Map.<String, Object>of(
                                "grantId", g.grantId(),
                                "agentId", g.agentId(),
                                "capKey", capabilities.capKeyOf(g.capId()),
                                "scope", String.valueOf(g.scope()),
                                "expiresAt", String.valueOf(g.expiresAt()),
                                "grantedBy", String.valueOf(g.grantedBy()),
                                "reason", String.valueOf(g.reason())))
                        .toList());
                case "list_approvals" -> json(approvals.list(text(arguments, "status"), 50).stream()
                        .map(a -> Map.<String, Object>of(
                                "approvalId", a.approvalId(),
                                "status", a.status(),
                                "requestedCap", String.valueOf(a.requestedCap()),
                                "agentId", String.valueOf(a.agentId()),
                                "riskClass", String.valueOf(a.riskClass()),
                                "expiresAt", String.valueOf(a.expiresAt()),
                                "justification", String.valueOf(a.justification())))
                        .toList());
                case "list_tasks" -> json(tasks.list(text(arguments, "terminalId"), null, 30).stream()
                        .map(t -> Map.<String, Object>of(
                                "taskId", t.taskId(),
                                "terminalId", String.valueOf(t.terminalId()),
                                "status", t.status(),
                                "prompt", String.valueOf(t.prompt()),
                                "answer", String.valueOf(t.answer())))
                        .toList());
                case "list_events" -> json(events.poll(text(arguments, "status"), 30).stream()
                        .map(e -> Map.<String, Object>of(
                                "eventId", e.eventId(),
                                "eventType", e.eventType(),
                                "status", e.status(),
                                "priority", e.priority(),
                                "receivedAt", String.valueOf(e.receivedAt()),
                                "dedupCount", e.dedupCount()))
                        .toList());
                case "list_audit" -> json(audit.search(null, null, null, 30).stream()
                        .map(entry -> Map.<String, Object>of(
                                "at", String.valueOf(entry.at()),
                                "actor", String.valueOf(entry.actorId()),
                                "op", String.valueOf(entry.op()),
                                "objectType", String.valueOf(entry.objectType()),
                                "objectId", String.valueOf(entry.objectId()),
                                "outcome", String.valueOf(entry.outcome())))
                        .toList());
                case "list_killswitches" -> json(killSwitches.list().stream()
                        .map(switchRow -> Map.<String, Object>of(
                                "switchId", switchRow.switchId(),
                                "scope", String.valueOf(switchRow.scope()),
                                "scopeId", String.valueOf(switchRow.scopeId()),
                                "effect", String.valueOf(switchRow.effect()),
                                "active", switchRow.active(),
                                "reason", String.valueOf(switchRow.reason())))
                        .toList());
                case "list_model_configs" -> json(modelConfigs.list().stream()
                        .map(config -> Map.<String, Object>of(
                                "scope", config.scope(),
                                "scopeId", config.scopeId(),
                                "provider", config.provider(),
                                "modelName", config.modelName(),
                                "baseUrl", config.baseUrl(),
                                "keyConfigured", config.keyConfigured()))
                        .toList());
                default -> "没有这个工具：" + call.name();
            };
        } catch (Exception e) {
            log.warn("the brain's tool {} failed: {}", call.name(), e.getMessage());
            return "工具 " + call.name() + " 失败了：" + e.getMessage();
        }
    }

    private static String text(Map<String, Object> arguments, String name) {
        Object value = arguments.get(name);
        if (value == null) {
            return null;
        }
        String text = String.valueOf(value).trim();
        return text.isEmpty() ? null : text;
    }

    private static String json(Object value) {
        try {
            return JSON.writeValueAsString(value);
        } catch (Exception e) {
            return String.valueOf(value);
        }
    }

    /** The brain has no model yet. */
    public static class BrainNotConfigured extends RuntimeException {
        public BrainNotConfigured(String message) {
            super(message);
        }
    }
}
