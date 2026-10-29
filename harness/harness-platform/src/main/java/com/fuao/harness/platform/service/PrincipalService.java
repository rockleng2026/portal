package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.AgentRecord;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.Map;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Machine identities (red-team R-01).
 *
 * <p>The point of this service is that <b>every device gets its own account</b>. A shared
 * service account for all terminals would mean: one lost machine can impersonate all of them,
 * and revoking one device revokes all of them. A device account is bound to one terminal, and
 * the terminal may only speak for that terminal.
 *
 * <p>The secret is shown <b>once</b>, at creation, and only its sha256 is kept afterwards -
 * exactly like the other accounts (03 §9). That is also why the console cannot fill it in
 * for the operator: the platform has no plaintext to give.
 */
@Service
public class PrincipalService {

    private static final SecureRandom RANDOM = new SecureRandom();

    /** What a device may call: its own terminal endpoints, and the task channel. */
    private static final String DEVICE_SCOPE = "/api/harness/terminal/*,/api/harness/tasks/*";

    private final JdbcClient jdbc;
    private final AuditService audit;
    private final AuthContext authContext;

    public PrincipalService(JdbcClient jdbc, AuditService audit, AuthContext authContext) {
        this.jdbc = jdbc;
        this.audit = audit;
        this.authContext = authContext;
    }

    /**
     * A device account, with its secret.
     *
     * <p>The secret is in the answer and nowhere else - the platform keeps sha256(secret), so
     * it cannot show it again.
     */
    public record DeviceAccount(String clientId, String secret, String agentId, String agentKey,
                                String installCommand) {
    }

    /**
     * Creates a machine account for a device.
     *
     * @param agentKey the digital employee this device belongs to; may be empty, in which case
     *                 the account is bound to the device when it registers
     */
    @Transactional
    public DeviceAccount createDeviceAccount(String agentKey, String platformUrl, String agentKeyForCommand) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new AgentService.NotAHumanException(
                    "creating a machine account requires a natural human, caller was " + actor.actorType());
        }
        String clientId = "dev-" + randomHex(6);
        String secret = randomHex(32);
        String agentId = null;
        if (agentKey != null && !agentKey.isBlank()) {
            agentId = jdbc.sql("SELECT agent_id FROM harness_agent WHERE agent_key = :key")
                    .param("key", agentKey).query(String.class).optional().orElse(null);
            if (agentId == null) {
                throw new IllegalArgumentException("no such agent: " + agentKey);
            }
        }
        jdbc.sql("""
                        INSERT INTO harness_principal
                          (principal_id, client_id, principal_type, secret_hash, agent_id, api_scope, status,
                           created_by, created_at)
                        VALUES (:id, :clientId, 'terminal', :secretHash, :agentId, :scope, 'active',
                                :createdBy, :now)
                        """)
                .param("id", Ids.newId())
                .param("clientId", clientId)
                .param("secretHash", com.fuao.harness.platform.security.HmacSigner.deriveKey(secret))
                .param("agentId", agentId)
                .param("scope", DEVICE_SCOPE)
                .param("createdBy", actor.actorId())
                .param("now", Timestamp.from(Instant.now()))
                .update();

        audit.record(actor, clientId, "principal.create", "principal", clientId, "allow", null,
                "a machine account for a device was created",
                Map.of("principalType", "terminal", "agentId", agentId == null ? "" : agentId));

        String key = agentKeyForCommand == null || agentKeyForCommand.isBlank() ? agentKey : agentKeyForCommand;
        String command = "./install.sh \\\n"
                + "    --platform " + (platformUrl == null ? "<平台地址>" : platformUrl) + " \\\n"
                + "    --agent-key " + (key == null ? "<数字员工业务键>" : key) + " \\\n"
                + "    --client-id " + clientId + " \\\n"
                + "    --client-secret " + secret;
        return new DeviceAccount(clientId, secret, agentId, agentKey, command);
    }

    /**
     * Binds a device account to the terminal that registered with it.
     *
     * <p>Until this happens the account is not bound to anything and cannot do anything: the
     * filter refuses a terminal account that speaks for a terminal it is not bound to.
     */
    @Transactional
    public void bindToTerminal(String clientId, String terminalId) {
        jdbc.sql("UPDATE harness_principal SET terminal_id = :terminalId WHERE client_id = :clientId")
                .param("terminalId", terminalId)
                .param("clientId", clientId)
                .update();
    }

    /** The agent a device account belongs to, if it was created with one. */
    public String agentIdOf(String clientId) {
        return jdbc.sql("SELECT agent_id FROM harness_principal WHERE client_id = :clientId")
                .param("clientId", clientId)
                .query(String.class)
                .optional()
                .orElse(null);
    }

    /** Binds the account to the agent when the device is bound to a digital employee. */
    @Transactional
    public void bindToAgent(String clientId, String agentId) {
        jdbc.sql("UPDATE harness_principal SET agent_id = :agentId "
                        + "WHERE client_id = :clientId AND (agent_id IS NULL OR agent_id = '')")
                .param("agentId", agentId)
                .param("clientId", clientId)
                .update();
    }

    private static String randomHex(int bytes) {
        byte[] buffer = new byte[bytes];
        RANDOM.nextBytes(buffer);
        return com.fuao.harness.protocol.Digests.hex(buffer);
    }
}
