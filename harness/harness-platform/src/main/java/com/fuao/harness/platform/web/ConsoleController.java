package com.fuao.harness.platform.web;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.platform.repo.KillSwitchRepository;
import com.fuao.harness.platform.service.AgentService;
import com.fuao.harness.platform.service.AuditService;
import com.fuao.harness.platform.service.GrantService;
import com.fuao.harness.platform.service.KillSwitchService;
import com.fuao.harness.platform.service.PolicyFacade;
import com.fuao.harness.platform.service.TerminalService;
import com.fuao.harness.policy.AgentState;
import com.fuao.harness.policy.AutonomyLevel;
import com.fuao.harness.policy.PolicyDecision;
import com.fuao.harness.policy.Scope;
import com.fuao.harness.protocol.event.ContentTrust;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * The M0 console API (subset of 03 §9).
 *
 * <p>Endpoints split by who may call them: {@code /policy/**}, {@code /audit/**}, {@code /events/poll}
 * and the human governance endpoints require a natural human; machine callers get the terminal and
 * event ingest endpoints plus read-only views. The rule is enforced in the services, not here,
 * because a REST filter is too easy to forget when a new endpoint is added.
 */
@RestController
@RequestMapping("/api/harness")
public class ConsoleController {

    private final AgentService agents;
    private final GrantService grants;
    private final ApprovalServiceHolder approvals;
    private final KillSwitchService killSwitches;
    private final PolicyFacade policy;
    private final TerminalService terminals;
    private final AuditService audit;
    private final com.fuao.harness.platform.service.TaskService tasks;
    private final com.fuao.harness.platform.repo.CapabilityRepository capabilities;
    private final com.fuao.harness.platform.service.ModelConfigService modelConfigs;
    private final com.fuao.harness.platform.security.ClientAuthenticator authenticator;

    public ConsoleController(AgentService agents, GrantService grants,
                             com.fuao.harness.platform.service.ApprovalService approvals,
                             KillSwitchService killSwitches, PolicyFacade policy,
                             TerminalService terminals, AuditService audit,
                             com.fuao.harness.platform.service.TaskService tasks,
                             com.fuao.harness.platform.repo.CapabilityRepository capabilities,
                             com.fuao.harness.platform.service.ModelConfigService modelConfigs,
                             com.fuao.harness.platform.security.ClientAuthenticator authenticator) {
        this.agents = agents;
        this.grants = grants;
        this.approvals = new ApprovalServiceHolder(approvals);
        this.killSwitches = killSwitches;
        this.policy = policy;
        this.terminals = terminals;
        this.audit = audit;
        this.tasks = tasks;
        this.capabilities = capabilities;
        this.modelConfigs = modelConfigs;
        this.authenticator = authenticator;
    }

    /** Exists so the constructor signature stays readable while the approval service is injected. */
    public record ApprovalServiceHolder(com.fuao.harness.platform.service.ApprovalService service) {
    }

    // ------------------------------------------------------------------ agents

    public record CreateAgentRequest(
            @NotBlank String agentKey,
            String name,
            String templateKey,
            @NotNull Integer deptId,
            Integer workpositionId,
            @NotNull Integer ownerId,
            Integer reportsTo,
            Integer requestedLevel) {
    }

    public record AgentView(String agentId, String agentKey, String name, String agentType, String status,
                            int autonomyLevel, Integer deptId, Integer workpositionId, Integer portalEmployeeId,
                            Integer ownerId, String modelId, Instant createdAt) {

        static AgentView of(AgentRecord a) {
            return new AgentView(a.agentId(), a.agentKey(), a.name(), a.agentType().wire(), a.status().wire(),
                    a.autonomyLevel(), a.deptId(), a.portalWorkpositionId(), a.portalEmployeeId(), a.ownerId(),
                    a.modelId(), a.createdAt());
        }
    }

    @PostMapping("/agent")
    public AgentView createAgent(@RequestBody CreateAgentRequest request) {
        AgentRecord agent = agents.create(new AgentService.CreateAgentCommand(
                request.agentKey(), request.name(), request.templateKey(), request.deptId(),
                request.workpositionId(), request.ownerId(), request.reportsTo(), request.requestedLevel()));
        return AgentView.of(agent);
    }

    @GetMapping("/agent")
    public List<AgentView> listAgents(@RequestParam(required = false) String status,
                                      @RequestParam(required = false) Integer deptId,
                                      @RequestParam(defaultValue = "200") int limit) {
        return agents.list(status, deptId, limit).stream().map(AgentView::of).toList();
    }

    @GetMapping("/agent/{agentId}")
    public AgentView getAgent(@PathVariable String agentId) {
        return AgentView.of(agents.get(agentId));
    }

    public record TransitionRequest(@NotBlank String to, @NotBlank String reason) {
    }

    @PostMapping("/agent/{agentId}/lifecycle")
    public AgentView transition(@PathVariable String agentId, @RequestBody TransitionRequest request) {
        AgentRecord updated = agents.transition(agentId, AgentState.fromWire(request.to()), request.reason());
        return AgentView.of(updated);
    }

    public record OnboardRequest(@NotNull int portalEmployeeId, @NotNull int portalUserId) {
    }

    @PostMapping("/agent/{agentId}/onboard")
    public AgentView onboard(@PathVariable String agentId, @RequestBody OnboardRequest request) {
        return AgentView.of(agents.attachPortalIdentity(agentId, request.portalEmployeeId(), request.portalUserId()));
    }

    public record AutonomyRequest(@NotNull int level, @NotBlank String reason) {
    }

    @PostMapping("/agent/{agentId}/autonomy")
    public AgentView setAutonomy(@PathVariable String agentId, @RequestBody AutonomyRequest request) {
        agents.setAutonomyLevel(agentId, AutonomyLevel.of(request.level()), request.reason());
        return AgentView.of(agents.get(agentId));
    }

    @GetMapping("/template")
    public List<Map<String, Object>> templates() {
        return agents.templates().stream()
                .map(t -> {
                    Map<String, Object> m = new java.util.LinkedHashMap<>();
                    m.put("templateKey", t.templateKey());
                    m.put("name", t.name());
                    m.put("agentType", t.agentType());
                    m.put("domain", t.domain());
                    m.put("description", t.description());
                    m.put("autonomyCeiling", t.autonomyLevel());
                    m.put("goals", t.goals());
                    m.put("capKeys", t.capKeys());
                    m.put("builtIn", t.builtIn());
                    return m;
                })
                .toList();
    }

    // ------------------------------------------------------------------ grants

    public record IssueGrantRequest(@NotBlank String agentId, @NotBlank String capKey, Scope scope,
                                    Long ttlSeconds, String reason, String approvalId) {
    }

    public record GrantView(String grantId, String agentId, String capId, String capKey, Scope scope,
                            Instant grantedAt, Instant expiresAt, String grantedBy, String reason,
                            boolean revoked) {

        static GrantView of(PolicyInputs.GrantRow g, String capKey) {
            return new GrantView(g.grantId(), g.agentId(), g.capId(), capKey, g.scope(), g.grantedAt(),
                    g.expiresAt(), g.grantedBy(), g.reason(), g.revokedAt() != null);
        }
    }

    @PostMapping("/grant")
    public GrantView issueGrant(@RequestBody IssueGrantRequest request) {
        PolicyInputs.GrantRow grant = grants.issue(new GrantService.IssueCommand(
                request.agentId(), request.capKey(), request.scope(),
                request.ttlSeconds() == null ? null : java.time.Duration.ofSeconds(request.ttlSeconds()),
                request.reason(), request.approvalId()));
        return GrantView.of(grant, capabilities.capKeyOf(grant.capId()));
    }

    /**
     * The grants of one agent, or of every agent when no agent is named.
     *
     * <p>The console needs the second form: an operator looks at "who holds what", not at one
     * agent at a time.
     */
    @GetMapping("/grant")
    public List<GrantView> activeGrants(@RequestParam(required = false) String agentId) {
        return grants.activeFor(agentId).stream()
                .map(g -> GrantView.of(g, capabilities.capKeyOf(g.capId())))
                .toList();
    }

    @PostMapping("/grant/{grantId}/revoke")
    public Map<String, Object> revokeGrant(@PathVariable String grantId,
                                           @RequestBody(required = false) Map<String, String> body) {
        boolean revoked = grants.revoke(grantId, body == null ? null : body.get("reason"));
        return Map.of("grantId", grantId, "revoked", revoked);
    }

    // ------------------------------------------------------------------ policy

    public record PolicyCheckRequest(@NotBlank String agentId, @NotBlank String capKey, Scope scope,
                                     String contentTrust, Set<String> sourceRefs, String planId, int stepSeq,
                                     String terminalId) {
    }

    public record PolicyCheckResponse(String outcome, String reasonCode, String reason,
                                      Map<String, Object> effectivePermission, String approvalId,
                                      String approverScope) {

        static PolicyCheckResponse of(PolicyDecision decision, PolicyInputs.ApprovalRow approval) {
            Map<String, Object> permission = decision.effectivePermission() == null
                    ? null
                    : Map.of("capKey", decision.effectivePermission().capKey(),
                            "scope", decision.effectivePermission().scope().toMap(),
                            "grantIds", decision.effectivePermission().contributingGrantIds(),
                            "expiresAt", String.valueOf(decision.effectivePermission().expiresAt()));
            return new PolicyCheckResponse(
                    decision.outcome().name().toLowerCase(java.util.Locale.ROOT),
                    decision.reasonCode(),
                    decision.reason(),
                    permission,
                    approval == null ? null : approval.approvalId(),
                    approval == null ? null : approval.justification());
        }
    }

    @PostMapping("/policy/check")
    public PolicyCheckResponse check(@RequestBody PolicyCheckRequest request) {
        // The trust level of the content the arguments came from must be declared. Defaulting
        // it would either hand a caller the trusted path by omitting a field (ADR-011) or break
        // every legitimate instruction-channel call; declaring it keeps the two channels apart
        // (01 §16: 数据与指令双通道).
        if (request.contentTrust() == null || request.contentTrust().isBlank()) {
            throw new IllegalArgumentException(
                    "contentTrust is required: declare whether the arguments came from the instruction "
                            + "channel (trusted) or from external content (untrusted)");
        }
        ContentTrust trust;
        try {
            trust = ContentTrust.valueOf(request.contentTrust().toUpperCase(java.util.Locale.ROOT));
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("contentTrust must be 'trusted' or 'untrusted', got "
                    + request.contentTrust());
        }
        PolicyFacade.CheckResult result = policy.check(new PolicyFacade.CheckRequest(
                request.agentId(), request.capKey(), request.scope(), trust,
                request.sourceRefs() == null ? Set.of() : request.sourceRefs(),
                request.planId(), request.stepSeq(), request.terminalId()));
        return PolicyCheckResponse.of(result.decision(), result.approval());
    }

    // ------------------------------------------------------------------ approvals

    @GetMapping("/approval")
    public List<Map<String, Object>> approvals(@RequestParam(required = false) String status,
                                               @RequestParam(defaultValue = "100") int limit) {
        return approvals.service().list(status, limit).stream().map(a -> Maps.of(
                "approvalId", a.approvalId(),
                "agentId", a.agentId(),
                "requestedCap", a.requestedCap(),
                "scope", a.scope().toMap(),
                "ttlSeconds", a.ttlSeconds(),
                "riskClass", a.riskClass(),
                "blastRadius", a.blastRadius(),
                "rollbackPlan", a.rollbackPlan(),
                "justification", a.justification(),
                "status", a.status(),
                "expiresAt", a.expiresAt().toString(),
                "decidedBy", a.decidedBy() == null ? "" : a.decidedBy())).toList();
    }

    public record DecisionRequest(@NotBlank String decision, String note) {
    }

    @PostMapping("/approval/{approvalId}/decide")
    public Map<String, Object> decide(@PathVariable String approvalId, @RequestBody DecisionRequest request) {
        com.fuao.harness.policy.ApprovalStateMachine.State desired =
                com.fuao.harness.policy.ApprovalStateMachine.State.valueOf(
                        request.decision().toUpperCase(java.util.Locale.ROOT));
        var verdict = approvals.service().decide(approvalId, desired, request.note());
        return Map.of("approvalId", approvalId, "state", verdict.state().wire(),
                "decidedBy", verdict.decidedBy().id(), "decidedAt", verdict.decidedAt().toString());
    }

    // ------------------------------------------------------------------ kill switches

    public record KillSwitchRequest(@NotBlank String scope, String scopeId, String effect, @NotBlank String reason) {
    }

    @PostMapping("/killswitch")
    public Map<String, Object> activateSwitch(@RequestBody KillSwitchRequest request) {
        String id = killSwitches.activate(request.scope(), request.scopeId(), request.effect(), request.reason());
        return Map.of("switchId", id, "active", true);
    }

    @DeleteMapping("/killswitch/{switchId}")
    public Map<String, Object> releaseSwitch(@PathVariable String switchId,
                                             @RequestParam(required = false) String reason) {
        boolean released = killSwitches.release(switchId, reason == null ? "no reason given" : reason);
        return Map.of("switchId", switchId, "active", !released);
    }

    @GetMapping("/killswitch")
    public List<KillSwitchRepository.Switch> switches() {
        return killSwitches.list();
    }

    // ------------------------------------------------------------------ terminals

    public record HelloRequest(@NotBlank String deviceId, @NotBlank String os, String osVersion, String hostname,
                               String agentVersion, Map<String, Object> capabilities) {
    }

    @PostMapping("/terminal/hello")
    public Map<String, Object> hello(@RequestBody HelloRequest request) {
        TerminalService.HelloResult result = terminals.hello(new TerminalService.HelloCommand(
                request.deviceId(), request.os(), request.osVersion(), request.hostname(),
                request.agentVersion(), request.capabilities() == null ? Map.of() : request.capabilities()));
        Map<String, Object> body = new java.util.LinkedHashMap<>();
        body.put("terminalId", result.terminalId());
        body.put("status", result.status());
        if (result.bindingCode() != null) {
            body.put("bindingCode", result.bindingCode());
            body.put("bindingCodeTtlSeconds", result.bindingCodeTtlSeconds());
        }
        return body;
    }

    public record BindRequest(@NotBlank String bindingCode, String agentKey, Integer portalEmployeeId) {
    }

    @PostMapping("/terminal/bind")
    public Map<String, Object> bind(@RequestBody BindRequest request) {
        PolicyInputs.TerminalRow row = terminals.bind(new TerminalService.BindCommand(
                request.bindingCode(), request.agentKey(), request.portalEmployeeId()));
        return Map.of("terminalId", row.terminalId(), "agentId", row.agentId() == null ? "" : row.agentId(),
                "bindType", row.bindType(), "status", row.status());
    }

    @PostMapping("/terminal/{terminalId}/heartbeat")
    public Map<String, Object> heartbeat(@PathVariable String terminalId) {
        PolicyInputs.TerminalRow row = terminals.heartbeat(terminalId);
        return Map.of("terminalId", row.terminalId(), "status", row.status(),
                "lastHeartbeat", row.lastHeartbeat() == null ? "" : row.lastHeartbeat().toString());
    }

    public record RevokeRequest(String reason) {
    }

    @PostMapping("/terminal/{terminalId}/revoke")
    public Map<String, Object> revokeTerminal(@PathVariable String terminalId,
                                              @RequestBody(required = false) RevokeRequest request) {
        terminals.revoke(terminalId, request == null ? null : request.reason());
        return Map.of("terminalId", terminalId, "status", "revoked");
    }

    @GetMapping("/terminal/{terminalId}/grant")
    public Map<String, Object> grant(@PathVariable String terminalId) {
        TerminalService.TerminalGrant grant = terminals.grant(terminalId);
        return Map.of(
                "terminalId", grant.terminalId(),
                "agentId", grant.agentId() == null ? "" : grant.agentId(),
                "autonomyLevel", String.valueOf(grant.autonomyLevel()),
                "capabilities", grant.capabilities(),
                "deptIds", grant.deptIds(),
                "grantedAt", grant.grantedAt().toString(),
                "source", grant.source());
    }

    @GetMapping("/terminal")
    public List<PolicyInputs.TerminalRow> terminals(@RequestParam(defaultValue = "200") int limit) {
        return terminals.list(limit);
    }

    // ------------------------------------------------------------------ principals

    /**
     * The machine identities this platform knows about.
     *
     * <p>Without their secrets: the platform only stores sha256(secret), so it cannot produce
     * one. An operator who needs it has it in the platform's own configuration.
     */
    @GetMapping("/principal")
    public List<Map<String, Object>> principals() {
        return authenticator.listPrincipals();
    }

    // ------------------------------------------------------------------ model configuration

    public record ModelConfigRequest(@NotBlank String scope, String scopeId, @NotBlank String provider,
                                     @NotBlank String modelName, String baseUrl, @NotBlank String apiKey) {
    }

    /** The model configurations, without the keys. */
    @GetMapping("/model-config")
    public List<Map<String, Object>> modelConfigs() {
        return modelConfigs.list().stream().map(c -> Map.<String, Object>of(
                "configId", c.configId(),
                "scope", c.scope(),
                "scopeId", c.scopeId(),
                "provider", c.provider(),
                "modelName", c.modelName(),
                "baseUrl", c.baseUrl(),
                "keyConfigured", c.keyConfigured(),
                "createdBy", c.createdBy(),
                "updatedAt", c.updatedAt().toString())).toList();
    }

    /** Sets the model configuration of a terminal, an agent, or the whole platform. */
    @PostMapping("/model-config")
    public Map<String, Object> setModelConfig(@RequestBody ModelConfigRequest request) {
        com.fuao.harness.platform.service.ModelConfigService.ModelConfigView view =
                modelConfigs.set(request.scope(), request.scopeId(), request.provider(),
                        request.modelName(), request.baseUrl(), request.apiKey());
        return Map.of("configId", view.configId(), "scope", view.scope(), "scopeId", view.scopeId(),
                "provider", view.provider(), "modelName", view.modelName(), "keyConfigured", true);
    }

    @DeleteMapping("/model-config")
    public Map<String, Object> deleteModelConfig(@RequestParam String scope,
                                                 @RequestParam(required = false) String scopeId) {
        return Map.of("deleted", modelConfigs.delete(scope, scopeId == null ? "*" : scopeId));
    }

    /**
     * The terminal's own view of the configuration - with the key, because it has to call the
     * model provider with it. Only a terminal may ask for its own.
     */
    @GetMapping("/terminal/{terminalId}/model")
    public Map<String, Object> terminalModel(@PathVariable String terminalId) {
        // A terminal that asks before it is registered gets an empty answer, not an error:
        // it will ask again.
        String agentId = null;
        try {
            agentId = terminals.get(terminalId).agentId();
        } catch (IllegalArgumentException e) {
            agentId = null;
        }
        return modelConfigs.forTerminal(terminalId, agentId)
                .map(c -> Map.<String, Object>of(
                        "provider", c.provider(),
                        "modelName", c.modelName(),
                        "baseUrl", c.baseUrl() == null ? "" : c.baseUrl(),
                        "apiKey", c.apiKey()))
                .orElse(Map.of("provider", "", "modelName", "", "baseUrl", "", "apiKey", ""));
    }

    // ------------------------------------------------------------------ tasks (the console-to-terminal channel)

    public record CreateTaskRequest(@NotBlank String prompt) {
    }

    public record TaskResultRequest(String status, String answer,
                                    List<Map<String, Object>> transcript,
                                    java.util.List<String> touched, String error) {
    }

    /** A human asks a terminal to do something. */
    @PostMapping("/terminal/{terminalId}/tasks")
    public Map<String, Object> createTask(@PathVariable String terminalId,
                                          @RequestBody CreateTaskRequest request) {
        com.fuao.harness.platform.repo.TaskRepository.TaskRow task =
                tasks.create(terminalId, request.prompt());
        return taskView(task);
    }

    /** The tasks of a terminal (or of every terminal). */
    @GetMapping("/tasks")
    public List<Map<String, Object>> listTasks(@RequestParam(required = false) String terminalId,
                                               @RequestParam(required = false) String status,
                                               @RequestParam(defaultValue = "50") int limit) {
        return tasks.list(terminalId, status, limit).stream().map(ConsoleController::taskView).toList();
    }

    @GetMapping("/tasks/{taskId}")
    public Map<String, Object> getTask(@PathVariable String taskId) {
        return taskView(tasks.get(taskId));
    }

    /** The terminal's side: take the next task, if there is one. */
    @GetMapping("/terminal/{terminalId}/tasks/next")
    public Map<String, Object> nextTask(@PathVariable String terminalId) {
        com.fuao.harness.platform.repo.TaskRepository.TaskRow task = tasks.claimNext(terminalId);
        if (task == null) {
            // The same shape as a task, with an empty id: the terminal polls this in a loop and
            // must be able to tell "nothing to do" from "the answer is empty".
            return Map.of("taskId", "", "status", "idle");
        }
        return taskView(task);
    }

    /** The terminal's side: the answer. */
    @PostMapping("/tasks/{taskId}/result")
    public Map<String, Object> completeTask(@PathVariable String taskId,
                                             @RequestBody TaskResultRequest request) {
        boolean ok = tasks.complete(taskId, request.status(), request.answer(),
                request.transcript(), request.touched(), request.error());
        return Map.of("accepted", ok);
    }

    @PostMapping("/tasks/{taskId}/cancel")
    public Map<String, Object> cancelTask(@PathVariable String taskId,
                                          @RequestParam(defaultValue = "cancelled by a human") String reason) {
        return Map.of("cancelled", tasks.cancel(taskId, reason));
    }

    private static Map<String, Object> taskView(com.fuao.harness.platform.repo.TaskRepository.TaskRow task) {
        java.util.Map<String, Object> out = new java.util.LinkedHashMap<>();
        out.put("taskId", task.taskId());
        out.put("terminalId", task.terminalId());
        out.put("prompt", task.prompt());
        out.put("status", task.status());
        out.put("answer", task.answer() == null ? "" : task.answer());
        out.put("transcript", com.fuao.harness.platform.repo.TaskRepository.parseJsonList(task.transcript()));
        out.put("touched", com.fuao.harness.platform.repo.TaskRepository.parseJsonArray(task.touched()));
        out.put("error", task.error() == null ? "" : task.error());
        out.put("createdBy", task.createdBy());
        out.put("createdAt", task.createdAt().toString());
        out.put("startedAt", task.startedAt() == null ? "" : task.startedAt().toString());
        out.put("finishedAt", task.finishedAt() == null ? "" : task.finishedAt().toString());
        return out;
    }

    // ------------------------------------------------------------------ audit

    @GetMapping("/audit")
    public List<Map<String, Object>> audit(@RequestParam(required = false) String traceId,
                                           @RequestParam(required = false) String objectType,
                                           @RequestParam(required = false) String objectId,
                                           @RequestParam(required = false) String outcome,
                                           @RequestParam(defaultValue = "100") int limit) {
        var entries = traceId != null
                ? audit.byTrace(traceId)
                : audit.search(objectType, objectId, outcome, limit);
        return entries.stream().map(e -> Maps.of(
                "auditId", e.auditId(),
                "at", e.at().toString(),
                "traceId", e.traceId(),
                "actorType", e.actorType(),
                "actorId", e.actorId(),
                "op", e.op(),
                "objectType", e.objectType(),
                "objectId", e.objectId() == null ? "" : e.objectId(),
                "outcome", e.outcome(),
                "reasonCode", e.reasonCode() == null ? "" : e.reasonCode(),
                "reason", e.reason() == null ? "" : e.reason())).toList();
    }

    @GetMapping("/audit/verify")
    public Map<String, Object> verifyAudit() {
        String broken = audit.verifyChain();
        return Map.of("intact", broken == null, "firstBrokenEntry", broken == null ? "" : broken);
    }
}