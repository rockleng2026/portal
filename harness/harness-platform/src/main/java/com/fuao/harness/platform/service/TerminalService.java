package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.platform.repo.AgentRepository;
import com.fuao.harness.platform.repo.TerminalRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Terminal registration and binding (03 §3.5, 01 §11.1).
 *
 * <p>The binding flow is deliberately two-legged: the device proves who it is with a device id
 * derived from hardware, and a human proves who it should work for by entering a short-lived code
 * in the console. Neither side alone is enough, and the terminal never receives a portal
 * password - it inherits the bound account's authority through the capability layer, which is
 * revocable in seconds.
 */
@Service
public class TerminalService {

    private final TerminalRepository terminals;
    private final AgentRepository agents;
    private final com.fuao.harness.platform.repo.CapabilityRepository capabilityRepo;
    private final BindingCodeStore codes;
    private final AuditService audit;
    private final AuthContext authContext;
    private final Duration heartbeatTimeout;

    public TerminalService(TerminalRepository terminals, AgentRepository agents,
                           com.fuao.harness.platform.repo.CapabilityRepository capabilities,
                           BindingCodeStore codes,
                           AuditService audit, AuthContext authContext,
                           com.fuao.harness.platform.config.HarnessProperties properties) {
        this.terminals = terminals;
        this.agents = agents;
        this.capabilityRepo = capabilities;
        this.codes = codes;
        this.audit = audit;
        this.authContext = authContext;
        this.heartbeatTimeout = properties.terminal().heartbeatTimeout();
    }

    public record HelloCommand(String deviceId, String os, String osVersion, String hostname,
                               String agentVersion, Map<String, Object> capabilities) {
    }

    public record HelloResult(String terminalId, String bindingCode, int bindingCodeTtlSeconds, String status) {
    }

    @Transactional
    public HelloResult hello(HelloCommand cmd) {
        AuthenticatedClient actor = authContext.current() != null
                ? authContext.current()
                : AuthenticatedClient.system("terminal");
        Instant now = Instant.now();

        Optional<PolicyInputs.TerminalRow> existing = terminals.findByDevice(cmd.deviceId());
        String terminalId = existing.map(PolicyInputs.TerminalRow::terminalId)
                .orElseGet(() -> com.fuao.harness.protocol.Ids.newId());
        boolean isNew = existing.isEmpty();

        terminals.insert(terminalId, cmd.deviceId(), cmd.os(), cmd.osVersion(), cmd.hostname(),
                cmd.agentVersion(), cmd.capabilities(), now);

        String code = null;
        int ttl = 0;
        PolicyInputs.TerminalRow row = terminals.findById(terminalId).orElseThrow();
        if ("binding".equals(row.status()) || "unbound".equals(row.status())) {
            code = codes.issue(terminalId, Duration.ofSeconds(600));
            ttl = 600;
        }
        if ("revoked".equals(row.status())) {
            audit.record(actor, "terminal.hello", "terminal", terminalId, "deny", "TERMINAL_REVOKED",
                    "a revoked terminal tried to register again", Map.of("deviceId", cmd.deviceId()));
            throw new RevokedTerminalException(terminalId);
        }

        audit.record(actor, "terminal.hello", "terminal", terminalId, "allow",
                isNew ? "REGISTERED" : null,
                "hello from " + cmd.os() + " " + cmd.hostname(),
                Map.of("deviceId", cmd.deviceId(), "isNew", String.valueOf(isNew),
                        "agentVersion", cmd.agentVersion()));
        return new HelloResult(terminalId, code, ttl, row.status());
    }

    public record BindCommand(String bindingCode, String agentKey, Integer portalEmployeeId) {
    }

    @Transactional
    public PolicyInputs.TerminalRow bind(BindCommand cmd) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "binding a device to an account requires a natural human, caller was " + actor.actorType());
        }

        String terminalId = codes.redeem(cmd.bindingCode());
        if (terminalId == null) {
            throw new IllegalArgumentException("binding code is unknown or expired");
        }

        String bindType;
        String agentId = null;
        Integer employeeId = cmd.portalEmployeeId();

        if (cmd.agentKey() != null && !cmd.agentKey().isBlank()) {
            AgentRecord agent = agents.findByKey(cmd.agentKey())
                    .orElseThrow(() -> new AgentService.AgentNotFound("no such agent: " + cmd.agentKey()));
            if (agent.portalEmployeeId() != null && employeeId != null
                    && !agent.portalEmployeeId().equals(employeeId)) {
                throw new IllegalArgumentException("agent " + cmd.agentKey() + " is bound to portal employee "
                        + agent.portalEmployeeId() + ", not " + employeeId);
            }
            agentId = agent.agentId();
            employeeId = agent.portalEmployeeId();
            bindType = "agent";
        } else if (employeeId != null) {
            bindType = "human";
        } else {
            throw new IllegalArgumentException("bind to either an agentKey or a portalEmployeeId");
        }

        boolean bound = terminals.bind(terminalId, agentId, bindType, employeeId, Instant.now());
        if (!bound) {
            throw new IllegalStateException("terminal " + terminalId + " cannot be bound in its current state");
        }

        audit.record(actor, "terminal.bind", "terminal", terminalId, "allow", null,
                "bound to " + bindType + " " + (agentId == null ? String.valueOf(employeeId) : agentId),
                Map.of("bindType", bindType, "agentId", String.valueOf(agentId),
                        "portalEmployeeId", String.valueOf(employeeId)));

        return terminals.findById(terminalId).orElseThrow();
    }

    @Transactional
    public PolicyInputs.TerminalRow heartbeat(String terminalId) {
        PolicyInputs.TerminalRow row = terminals.findById(terminalId)
                .orElseThrow(() -> new IllegalArgumentException("no such terminal: " + terminalId));
        if ("revoked".equals(row.status())) {
            throw new RevokedTerminalException(terminalId);
        }
        boolean accepted = terminals.heartbeat(terminalId, Instant.now());
        if (!accepted) {
            throw new RevokedTerminalException(terminalId);
        }
        return terminals.findById(terminalId).orElseThrow();
    }

    /** A0-5: after revocation the next request from the device is refused. */
    @Transactional
    public PolicyInputs.TerminalRow revoke(String terminalId, String reason) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "revoking a terminal requires a natural human, caller was " + actor.actorType());
        }
        boolean revoked = terminals.revoke(terminalId, Instant.now());
        codes.revokeAllFor(terminalId);
        // The device credential is a principal. Revoking the device without revoking the
        // credential would leave it with full API access (A0-5: "loses all capabilities").
        int disabled = terminals.disablePrincipalsFor(terminalId);
        audit.record(actor, "terminal.revoke", "terminal", terminalId,
                revoked ? "allow" : "deny", revoked ? null : "NOT_FOUND", reason,
                Map.of("disabledPrincipals", String.valueOf(disabled)));
        if (!revoked) {
            throw new IllegalArgumentException("no such terminal: " + terminalId);
        }
        return terminals.findById(terminalId).orElseThrow();
    }

    /**
     * What this terminal is allowed to do, according to the platform.
     *
     * <p>This is the answer to the question both runtimes on the machine ask: the shell (which
     * registers and heartbeats) and the agent (which acts). The platform holds the grants, so
     * the platform is the only place that can answer - there is no second copy of the authority
     * to drift out of date (red-team R-01, 01 §5.2).
     *
     * <p>The grant carries capabilities and the autonomy level. It carries <b>no</b> approval
     * tokens: an approval is signed for one command and travels with that command, so it is
     * never handed out in advance.
     */
    public record TerminalGrant(String terminalId, String agentId, int autonomyLevel,
                                 List<String> capabilities, List<Integer> deptIds,
                                 Instant grantedAt, String source) {
    }

    /**
     * The grant for a terminal.
     *
     * @throws RevokedTerminalException when the terminal was revoked - a revoked device gets
     *         nothing, not even an empty grant
     */
    @Transactional
    public TerminalGrant grant(String terminalId) {
        PolicyInputs.TerminalRow row = terminals.findById(terminalId)
                .orElseThrow(() -> new IllegalArgumentException("no such terminal: " + terminalId));
        if ("revoked".equals(row.status())) {
            throw new RevokedTerminalException(terminalId);
        }
        String agentId = row.agentId();
        int autonomy = 0;
        List<Integer> deptIds = List.of();
        if (agentId != null && !agentId.isBlank()) {
            AgentRecord agent = agents.findById(agentId).orElse(null);
            if (agent != null) {
                autonomy = agent.autonomyLevel();
                if (agent.deptId() != null) {
                    deptIds = List.of(agent.deptId());
                }
            }
        }
        List<String> capKeys = capabilityRepo.activeCapKeysFor(agentId);
        return new TerminalGrant(terminalId, agentId, autonomy, capKeys, deptIds, Instant.now(),
                "platform");
    }

    public List<PolicyInputs.TerminalRow> list(int limit) {
        return terminals.list(limit);
    }

    /** Dashboard helper: which machines are quiet, and for how long. */
    public List<PolicyInputs.TerminalRow> stale() {
        return terminals.list(500).stream()
                .filter(t -> t.lastHeartbeat() == null
                        || t.lastHeartbeat().isBefore(Instant.now().minus(heartbeatTimeout)))
                .toList();
    }

    public static final class RevokedTerminalException extends RuntimeException {
        public RevokedTerminalException(String terminalId) {
            super("terminal " + terminalId + " is revoked");
        }
    }
}