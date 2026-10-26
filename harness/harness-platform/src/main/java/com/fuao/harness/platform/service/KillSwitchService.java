package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.AgentRepository;
import com.fuao.harness.platform.repo.KillSwitchRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.policy.KillSwitchState;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Kill switches (04 §8.2). Pulling a digital employee back is the operation that must work when
 * everything else is broken, so it is deliberately simple and deliberately audited.
 *
 * <p>Only a natural human may flip one, and the reason is mandatory - an unexplained kill switch
 * during an incident is indistinguishable from a mistake.
 */
@Service
public class KillSwitchService {

    private final KillSwitchRepository switches;
    private final AgentRepository agents;
    private final AuditService audit;
    private final AuthContext authContext;

    public KillSwitchService(KillSwitchRepository switches, AgentRepository agents,
                             AuditService audit, AuthContext authContext) {
        this.switches = switches;
        this.agents = agents;
        this.audit = audit;
        this.authContext = authContext;
    }

    @Transactional
    public String activate(String scope, String scopeId, String effect, String reason) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "kill-switch activation requires a natural human, caller was " + actor.actorType());
        }
        KillSwitchState.Scope parsedScope = KillSwitchState.Scope.valueOf(scope.toUpperCase(Locale.ROOT));
        if (reason == null || reason.isBlank()) {
            throw new IllegalArgumentException("a kill switch needs a reason; unexplained switches are "
                    + "indistinguishable from mistakes during an incident");
        }
        if (parsedScope == KillSwitchState.Scope.AGENT && agents.findById(scopeId).isEmpty()) {
            throw new AgentService.AgentNotFound("no such agent: " + scopeId);
        }

        String id = switches.activate(parsedScope.name().toLowerCase(Locale.ROOT),
                parsedScope == KillSwitchState.Scope.GLOBAL ? "*" : scopeId,
                effect == null ? "to_l0" : effect, reason, actor.actorId());

        audit.record(actor, "killswitch.activate", "killswitch", id, "allow", null, reason,
                Map.of("scope", parsedScope.name(), "scopeId", scopeId, "effect", effect == null ? "to_l0" : effect));
        return id;
    }

    @Transactional
    public boolean release(String switchId, String reason) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "kill-switch release requires a natural human, caller was " + actor.actorType());
        }
        boolean released = switches.release(switchId, actor.actorId());
        audit.record(actor, "killswitch.release", "killswitch", switchId,
                released ? "allow" : "deny", released ? null : "NOT_ACTIVE", reason, Map.of());
        return released;
    }

    public List<KillSwitchRepository.Switch> list() {
        return switches.list();
    }

    public KillSwitchState state() {
        return switches.activeState();
    }

    public KillSwitchRepository.Switch find(String id) {
        return switches.find(id).orElseThrow(() -> new IllegalArgumentException("no such switch: " + id));
    }
}