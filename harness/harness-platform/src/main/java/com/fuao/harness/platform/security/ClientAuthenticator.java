package com.fuao.harness.platform.security;

import java.time.Duration;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Component;

/**
 * Resolves an HMAC signature to a caller, and refuses everything that does not add up:
 * unknown client, disabled or expired principal, clock skew, replayed nonce, wrong signature,
 * or a signature whose secret belongs to a different client.
 */
@Component
public class ClientAuthenticator {

    public static final String HEADER_CLIENT = "X-Harness-Client";
    public static final String HEADER_TIMESTAMP = "X-Harness-Timestamp";
    public static final String HEADER_NONCE = "X-Harness-Nonce";
    public static final String HEADER_SIGNATURE = "X-Harness-Signature";

    private final JdbcClient jdbc;
    private final NonceStore nonces;
    private final Duration clockSkew;
    private final Duration nonceTtl;

    public ClientAuthenticator(JdbcClient jdbc, NonceStore nonces,
                               com.fuao.harness.platform.config.HarnessProperties properties) {
        this.jdbc = jdbc;
        this.nonces = nonces;
        this.clockSkew = properties.security().clockSkew();
        this.nonceTtl = properties.security().nonceTtl();
    }

    public record Principal(
            String principalId,
            String clientId,
            String principalType,
            String secretHash,
            String agentId,
            String terminalId,
            Integer employeeId,
            String apiScope,
            String status,
            Instant expiresAt) {
    }

    public Optional<Principal> findPrincipal(String clientId) {
        return jdbc.sql("""
                        SELECT principal_id, client_id, principal_type, secret_hash, agent_id, terminal_id,
                               employee_id, api_scope, status, expires_at
                          FROM harness_principal
                         WHERE client_id = :clientId
                        """)
                .param("clientId", clientId)
                .query(Principal.class)
                .optional();
    }

    /**
     * @param secret supplied by the caller in plain text; only its hash is ever stored
     * @throws AuthenticationException when any single check fails
     */
    public AuthenticatedClient authenticate(String clientId, String timestamp, String nonce, String signature,
                                           String method, String path, byte[] body) {
        if (clientId == null || timestamp == null || nonce == null || signature == null) {
            throw new AuthenticationException(401, "MISSING_CREDENTIALS",
                    "all of " + HEADER_CLIENT + ", " + HEADER_TIMESTAMP + ", " + HEADER_NONCE + ", "
                            + HEADER_SIGNATURE + " are required");
        }
        Principal principal = findPrincipal(clientId)
                .orElseThrow(() -> new AuthenticationException(401, "UNKNOWN_CLIENT", "unknown client: " + clientId));

        if (!"active".equals(principal.status())) {
            throw new AuthenticationException(403, "PRINCIPAL_DISABLED", "client " + clientId + " is " + principal.status());
        }
        if (principal.expiresAt() != null && !Instant.now().isBefore(principal.expiresAt())) {
            throw new AuthenticationException(403, "PRINCIPAL_EXPIRED", "client " + clientId + " expired at " + principal.expiresAt());
        }

        Instant sentAt;
        try {
            sentAt = Instant.ofEpochSecond(Long.parseLong(timestamp.trim()));
        } catch (NumberFormatException e) {
            throw new AuthenticationException(400, "BAD_TIMESTAMP", HEADER_TIMESTAMP + " must be unix seconds");
        }
        if (Math.abs(Instant.now().getEpochSecond() - sentAt.getEpochSecond()) > clockSkew.toSeconds()) {
            throw new AuthenticationException(401, "CLOCK_SKEW",
                    "timestamp is outside the " + clockSkew.toSeconds() + "s window");
        }

        if (!HmacSigner.verify(principal.secretHash(), signature, method, path, timestamp, nonce, body)) {
            throw new AuthenticationException(401, "BAD_SIGNATURE", "signature does not match");
        }
        if (!nonces.claim(nonce, nonceTtl)) {
            throw new AuthenticationException(401, "NONCE_REPLAY", "nonce already used");
        }

        return new AuthenticatedClient(principal.clientId(), principal.principalType(), principal.agentId(),
                principal.terminalId(), principal.employeeId(), principal.apiScope());
    }

    /** Truncation helper used by audit rows that store the call instant at minute granularity. */
    public static Instant minuteFloor(Instant at) {
        return at.truncatedTo(ChronoUnit.MINUTES);
    }

    public static final class AuthenticationException extends RuntimeException {
        private final int status;
        private final String code;

        public AuthenticationException(int status, String code, String message) {
            super(message);
            this.status = status;
            this.code = code;
        }

        public int status() {
            return status;
        }

        public String code() {
            return code;
        }
    }
}