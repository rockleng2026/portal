package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.domain.AgentTemplateRecord;
import com.fuao.harness.platform.repo.AgentRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.policy.AgentState;
import com.fuao.harness.policy.AutonomyLevel;
import com.fuao.harness.protocol.Ids;
import java.time.Instant;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Agent registry and lifecycle (01 §5.1, 01 §6.3).
 *
 * <p>Two rules are enforced here rather than left to callers:
 * <ul>
 *   <li>an agent is created at autonomy level L0. Templates may carry a higher ceiling, but the
 *       ceiling is not the starting point - M0 exists to establish trustworthy identity, not to
 *       let agents write (04 §2.1);</li>
 *   <li>every transition is a single conditional update plus a state-log row, so two operators
 *       clicking at the same time cannot both win and no transition can happen unrecorded.</li>
 * </ul>
 */
@Service
public class AgentService {

    private final AgentRepository agents;
    private final GrantService grants;
    private final AuditService audit;
    private final AuthContext authContext;

    public AgentService(AgentRepository agents, GrantService grants, AuditService audit, AuthContext authContext) {
        this.agents = agents;
        this.grants = grants;
        this.audit = audit;
        this.authContext = authContext;
    }

    public record CreateAgentCommand(
            String agentKey,
            String name,
            String templateKey,
            Integer deptId,
            Integer workpositionId,
            Integer ownerId,
            Integer reportsTo,
            Integer requestedLevel) {
    }

    @Transactional
    public AgentRecord create(CreateAgentCommand cmd) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "agent.create");

        if (cmd.agentKey() == null || cmd.agentKey().isBlank()) {
            throw new IllegalArgumentException("agentKey is required");
        }
        if (agents.existsByKey(cmd.agentKey())) {
            throw new DuplicateAgentKeyException(cmd.agentKey());
        }
        if (cmd.ownerId() == null) {
            throw new IllegalArgumentException("ownerId is required: every digital employee has a human owner "
                    + "(01 §5.1, and the approval chain needs a natural-human anchor)");
        }

        AgentTemplateRecord template = cmd.templateKey() == null
                ? null
                : agents.findTemplate(cmd.templateKey()).orElseThrow(
                        () -> new AgentNotFound("unknown template: " + cmd.templateKey()));

        int level = 0;
        if (cmd.requestedLevel() != null) {
            AutonomyLevel requested = AutonomyLevel.of(cmd.requestedLevel());
            if (template != null && requested.level() > template.autonomyLevel()) {
                throw new IllegalArgumentException("requested level " + requested
                        + " exceeds the template ceiling " + AutonomyLevel.of(template.autonomyLevel()));
            }
            level = requested.level();
        }

        Instant now = Instant.now();
        AgentRecord agent = new AgentRecord(
                Ids.newId(),
                cmd.agentKey(),
                cmd.name() == null || cmd.name().isBlank()
                        ? (template != null ? template.name() : "leon")
                        : cmd.name(),
                template != null
                        ? AgentRecord.AgentType.valueOf(template.agentType().toUpperCase(Locale.ROOT))
                        : AgentRecord.AgentType.SERVICE,
                template != null ? template.templateId() : null,
                null,
                null,
                cmd.workpositionId(),
                cmd.deptId(),
                cmd.reportsTo(),
                cmd.ownerId(),
                level,
                template != null ? template.modelId() : "brain-core",
                template != null ? template.localModel() : "qwen3.8b",
                AgentRecord.AgentStatus.DRAFT,
                now,
                now);

        agents.insert(agent);
        agents.logStateChange(agent.agentId(), null, AgentRecord.AgentStatus.DRAFT,
                "created from template " + (template != null ? template.templateKey() : "none"),
                actor.actorId(), Map.of("autonomyLevel", level, "deptId", String.valueOf(cmd.deptId())));

        audit.record(actor, "agent.create", "agent", agent.agentId(), "allow", null,
                "created " + agent.agentKey() + " at L" + level,
                Map.of("agentKey", agent.agentKey(), "template", String.valueOf(cmd.templateKey()),
                        "ownerId", String.valueOf(cmd.ownerId())));

        return agent;
    }

    /**
     * Moves an agent along its lifecycle.
     *
     * <p>Legal transitions: draft -> onboarding (portal identity attached) -> active, plus
     * pause/resume from active and retire from any non-retired state. Retiring reclaims grants
     * rather than leaving them to expire on their own (01 §15.3).
     */
    @Transactional
    public AgentRecord transition(String agentId, AgentState target, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "agent." + target.wire());

        AgentRecord current = agents.findById(agentId)
                .orElseThrow(() -> new AgentNotFound("no such agent: " + agentId));
        AgentState from = AgentState.fromWire(current.status().wire());

        if (!isLegal(from, target)) {
            throw new IllegalStateException("illegal lifecycle transition " + from + " -> " + target);
        }
        if (target == AgentState.ACTIVE && current.portalEmployeeId() == null) {
            throw new IllegalStateException("agent " + current.agentKey()
                    + " has no portal employee id yet; onboarding must finish before it can take work (01 §5.1)");
        }

        int updated = agents.updateStatus(agentId, current.status(),
                AgentRecord.AgentStatus.valueOf(target.name()));
        if (updated == 0) {
            throw new ConcurrentModificationException("agent " + agentId + " changed state concurrently");
        }

        if (target == AgentState.PAUSED || target == AgentState.RETIRED) {
            grants.revokeAllFor(agentId, "agent moved to " + target + ": " + reason);
        }

        agents.logStateChange(agentId, current.status(), AgentRecord.AgentStatus.valueOf(target.name()),
                reason, actor.actorId(),
                Map.of("from", from.wire(), "to", target.wire(), "autonomyLevel", current.autonomyLevel()));

        audit.record(actor, "agent." + target.wire(), "agent", agentId, "allow", null, reason,
                Map.of("from", from.wire(), "to", target.wire(), "agentKey", current.agentKey()));

        return agents.findById(agentId).orElseThrow();
    }

    /** Records that portal accepted the digital employee and returns the new employee id. */
    @Transactional
    public AgentRecord attachPortalIdentity(String agentId, int portalEmployeeId, int portalUserId) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "agent.onboard");

        agents.attachPortalIdentity(agentId, portalEmployeeId, portalUserId);
        audit.record(actor, "agent.onboard", "agent", agentId, "allow", null,
                "portal employee " + portalEmployeeId + " created for this agent",
                Map.of("portalEmployeeId", portalEmployeeId, "portalUserId", portalUserId));
        return agents.findById(agentId).orElseThrow();
    }

    @Transactional
    public void setAutonomyLevel(String agentId, AutonomyLevel level, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "agent.autonomy");

        AgentRecord agent = agents.findById(agentId)
                .orElseThrow(() -> new AgentNotFound("no such agent: " + agentId));
        agents.updateAutonomyLevel(agentId, level, reason);
        agents.logStateChange(agentId, agent.status(), agent.status(),
                "autonomy level set to " + level + ": " + reason, actor.actorId(),
                Map.of("from", agent.autonomyLevel(), "to", level.level()));
        audit.record(actor, "agent.autonomy", "agent", agentId, "allow", "AUTONOMY_CHANGED", reason,
                Map.of("from", agent.autonomyLevel(), "to", level.level()));
    }

    public List<AgentRecord> list(String status, Integer deptId, int limit) {
        return agents.list(status, deptId, limit);
    }

    public AgentRecord get(String agentId) {
        return agents.findById(agentId).orElseThrow(() -> new AgentNotFound("no such agent: " + agentId));
    }

    public List<AgentTemplateRecord> templates() {
        return agents.listTemplates(false);
    }

    public AgentRecord byKey(String agentKey) {
        return agents.findByKey(agentKey).orElseThrow(() -> new AgentNotFound("no such agent: " + agentKey));
    }

    private static boolean isLegal(AgentState from, AgentState to) {
        return switch (from) {
            case DRAFT -> to == AgentState.ONBOARDING || to == AgentState.RETIRED;
            case ONBOARDING -> to == AgentState.ACTIVE || to == AgentState.PAUSED || to == AgentState.RETIRED;
            case ACTIVE -> to == AgentState.PAUSED || to == AgentState.RETIRED;
            case PAUSED -> to == AgentState.ACTIVE || to == AgentState.RETIRED;
            case RETIRED -> false;
        };
    }

    /**
     * Only humans change agent state. A service account may create nothing, activate nothing and
     * certainly cannot activate itself (P2 / R-02).
     */
    private static void requireHuman(AuthenticatedClient actor, String op) {
        if (!actor.isHuman()) {
            throw new NotAHumanException(op + " requires a natural human, caller was " + actor.actorType()
                    + " (" + actor.clientId() + ")");
        }
    }

    public static class DuplicateAgentKeyException extends RuntimeException {
        public DuplicateAgentKeyException(String key) {
            super("agent_key already in use: " + key);
        }
    }

    public static class AgentNotFound extends RuntimeException {
        public AgentNotFound(String message) {
            super(message);
        }
    }

    public static class NotAHumanException extends RuntimeException {
        public NotAHumanException(String message) {
            super(message);
        }
    }

    public static class ConcurrentModificationException extends RuntimeException {
        public ConcurrentModificationException(String message) {
            super(message);
        }
    }
}