package com.fuao.harness.platform.service;

import com.fuao.harness.platform.config.HarnessProperties;
import com.fuao.harness.protocol.Ids;
import java.time.Instant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Component;

/**
 * Creates the very first service account at startup.
 *
 * <p>There is intentionally no seeded credential in the migrations: a migration carrying a known
 * secret would hand every deployment the same key until somebody remembered to change it, which
 * is the same class of mistake portal already made with reversible password columns (01 §2.1
 * 结论 B). Instead the operator supplies {@code harness.bootstrap.secret}; when it is absent the
 * platform starts fine and simply has no way in until an administrator provisions one.
 */
@Component
public class PrincipalBootstrap implements ApplicationRunner {

    private static final Logger log = LoggerFactory.getLogger(PrincipalBootstrap.class);

    private final JdbcClient jdbc;
    private final HarnessProperties properties;

    public PrincipalBootstrap(JdbcClient jdbc, HarnessProperties properties) {
        this.jdbc = jdbc;
        this.properties = properties;
    }

    @Override
    public void run(ApplicationArguments args) {
        HarnessProperties.Bootstrap bootstrap = properties.bootstrap();
        if (bootstrap == null || bootstrap.secret() == null || bootstrap.secret().isBlank()) {
            log.warn("no harness.bootstrap.secret configured: the platform has no service account and "
                    + "every /api/harness/** call will be refused until one is provisioned");
            return;
        }
        if (bootstrap.secret().length() < 24) {
            throw new IllegalStateException("harness.bootstrap.secret must be at least 24 characters");
        }

        int existing = jdbc.sql("SELECT COUNT(*) FROM harness_principal WHERE client_id = :clientId")
                .param("clientId", bootstrap.clientId())
                .query(Integer.class)
                .single();
        if (existing > 0) {
            log.info("bootstrap principal '{}' already exists, leaving it untouched", bootstrap.clientId());
            return;
        }

        jdbc.sql("""
                        INSERT INTO harness_principal
                          (principal_id, client_id, principal_type, secret_hash, api_scope, status,
                           created_by, created_at)
                        VALUES (:id, :clientId, 'service', :secretHash, '/api/harness/*', 'active',
                                'system:bootstrap', :now)
                        """)
                .param("id", Ids.newId())
                .param("clientId", bootstrap.clientId())
                .param("secretHash", com.fuao.harness.platform.security.HmacSigner.deriveKey(bootstrap.secret()))
                .param("now", java.sql.Timestamp.from(Instant.now()))
                .update();
        log.warn("created bootstrap principal '{}' - restrict it to operator tooling and rotate the secret",
                bootstrap.clientId());
    }
}