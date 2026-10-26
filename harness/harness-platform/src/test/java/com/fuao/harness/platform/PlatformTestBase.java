package com.fuao.harness.platform;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fuao.harness.platform.security.HmacSigner;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Map;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.testcontainers.containers.MySQLContainer;

/**
 * Shared fixture for the platform integration tests: a real MySQL 8 with the Flyway migrations
 * applied, plus the two signing helpers every test needs.
 *
 * <p>A real database rather than an in-memory substitute, on purpose. The behaviour these tests
 * pin down <em>is</em> MySQL behaviour - {@code ON DUPLICATE KEY UPDATE} as the dedup mechanism,
 * JSON columns, {@code UPDATE ... WHERE status = :expected} as the concurrency guard - and none
 * of it is faithfully modelled by H2.
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
public abstract class PlatformTestBase {

    protected static final String SERVICE_CLIENT = "harness-test-service";
    protected static final String SERVICE_SECRET = "test-only-secret-value-0123456789";
    protected static final String HUMAN_CLIENT = "harness-test-console";
    protected static final String HUMAN_SECRET = "another-test-secret-0123456789";
    protected static final int HUMAN_EMPLOYEE_ID = 9001;
    protected static final int AGENT_OWNER_EMPLOYEE_ID = 100;

    /**
     * Singleton container, started by hand rather than by the Testcontainers JUnit extension:
     * the extension stops containers when the first test class finishes, which breaks every
     * class after the first one. Starting it in a static initialiser keeps it alive for the whole
     * JVM and stops it on shutdown.
     *
     * <p>{@code --default-time-zone=+00:00} plus {@code connectionTimeZone=UTC} makes the server
     * session and the JVM agree on what a DATETIME means. Without it, a DATETIME written by
     * {@code NOW()} is read back shifted by the container/host offset and every TTL comparison
     * silently disagrees with the database.
     */
    @SuppressWarnings("resource")
    static final MySQLContainer<?> MYSQL = startMysql();

    private static MySQLContainer<?> startMysql() {
        MySQLContainer<?> container = new MySQLContainer<>("mysql:8.4")
                .withDatabaseName("harness")
                .withUsername("harness")
                .withPassword("harness")
                .withCommand("--character-set-server=utf8mb4", "--collation-server=utf8mb4_bin",
                        "--default-time-zone=+00:00");
        container.start();
        return container;
    }

    @DynamicPropertySource
    static void datasource(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", () -> MYSQL.getJdbcUrl()
                + "?connectionTimeZone=UTC&forceConnectionTimeZoneToSession=true&useUnicode=true&characterEncoding=utf8");
        registry.add("spring.datasource.username", MYSQL::getUsername);
        registry.add("spring.datasource.password", MYSQL::getPassword);
    }

    @Autowired
    protected MockMvc mvc;

    @Autowired
    protected ObjectMapper json;

    @Autowired
    protected JdbcClient jdbc;

    // ------------------------------------------------------------------ helpers

    protected String body(Object value) throws Exception {
        return json.writeValueAsString(value);
    }

    /** Signs a request as the machine service principal. */
    protected void signAsService(String method, String path, MockHttpServletRequestBuilder builder, String body) {
        signAs(SERVICE_CLIENT, SERVICE_SECRET, method, path, builder, body);
    }

    /** Signs a request as the console principal, which carries a natural-human employee id. */
    protected void signAsHuman(String method, String path, MockHttpServletRequestBuilder builder, String body) {
        signAs(HUMAN_CLIENT, HUMAN_SECRET, method, path, builder, body);
    }

    protected void signAs(String clientId, String secret, String method, String path,
                          MockHttpServletRequestBuilder builder, String body) {
        String timestamp = String.valueOf(Instant.now().getEpochSecond());
        String nonce = UUID.randomUUID().toString();
        builder.header("X-Harness-Client", clientId);
        builder.header("X-Harness-Timestamp", timestamp);
        builder.header("X-Harness-Nonce", nonce);
        builder.header("X-Harness-Signature", HmacSigner.sign(HmacSigner.deriveKey(secret), method, path,
                timestamp, nonce,
                body == null ? new byte[0] : body.getBytes(StandardCharsets.UTF_8)));
    }

    /** Creates a service, console or terminal principal with a known secret. */
    protected void createPrincipal(String clientId, String secret, String type, Integer employeeId) {
        createPrincipal(clientId, secret, type, employeeId, "employee", null);
    }

    /**
     * Creates a principal with a known secret.
     *
     * @param type  {@code service}, {@code human}, {@code agent} or {@code terminal}. The type is
     *              what the "natural human" gate reads, so a human principal must say
     *              {@code human}.
     * @param role  what a human may approve: {@code employee}, {@code dept_director},
     *              {@code system_admin}
     */
    protected void createPrincipal(String clientId, String secret, String type, Integer employeeId,
                                   String role, Integer deptId) {
        jdbc.sql("""
                        INSERT INTO harness_principal
                          (principal_id, client_id, principal_type, secret_hash, employee_id, api_scope, status,
                           role, dept_id, created_by, created_at)
                        VALUES (:id, :clientId, :type, :hash, :employeeId, '/api/harness/*', 'active',
                                :role, :deptId, 'system:test', NOW())
                        ON DUPLICATE KEY UPDATE secret_hash = VALUES(secret_hash),
                                                employee_id = VALUES(employee_id),
                                                principal_type = VALUES(principal_type),
                                                role = VALUES(role),
                                                dept_id = VALUES(dept_id)
                        """)
                .param("id", "0198f500-0000-7000-8000-" + UUID.randomUUID().toString().substring(0, 12))
                .param("clientId", clientId)
                .param("type", type)
                .param("hash", HmacSigner.deriveKey(secret))
                .param("employeeId", employeeId)
                .param("role", role)
                .param("deptId", deptId)
                .update();
    }

    /**
     * An agent row, ready for lifecycle tests. Re-seeding the same key replaces the previous row
     * so tests stay independent of execution order.
     */
    protected String seedAgent(String agentKey, int ownerEmployeeId, int deptId, int autonomyLevel) {
        jdbc.sql("DELETE FROM harness_grant WHERE agent_id IN "
                        + "(SELECT agent_id FROM harness_agent WHERE agent_key = :key)")
                .param("key", agentKey).update();
        jdbc.sql("DELETE FROM harness_agent_state_log WHERE agent_id IN "
                        + "(SELECT agent_id FROM harness_agent WHERE agent_key = :key)")
                .param("key", agentKey).update();
        jdbc.sql("DELETE FROM harness_agent WHERE agent_key = :key").param("key", agentKey).update();

        String agentId = com.fuao.harness.protocol.Ids.newId();
        jdbc.sql("""
                        INSERT INTO harness_agent
                          (agent_id, agent_key, name, agent_type, dept_id, owner_id, autonomy_level,
                           model_id, local_model, status, created_at, updated_at)
                        VALUES (:id, :key, 'leon', 'service', :deptId, :ownerId, :level, 'brain-core',
                                'qwen3.8b', 'active', NOW(), NOW())
                        """)
                .param("id", agentId)
                .param("key", agentKey)
                .param("deptId", deptId)
                .param("ownerId", ownerEmployeeId)
                .param("level", autonomyLevel)
                .update();
        return agentId;
    }

    protected String grant(String agentId, String capKey, int deptId, long ttlSeconds) {
        String capId = jdbc.sql("SELECT cap_id FROM harness_capability WHERE cap_key = :capKey")
                .param("capKey", capKey)
                .query(String.class)
                .single();
        String grantId = com.fuao.harness.protocol.Ids.newId();
        jdbc.sql("""
                        INSERT INTO harness_grant
                          (grant_id, agent_id, cap_id, scope, ttl_seconds, granted_at, expires_at,
                           granted_by, reason, status)
                        VALUES (:id, :agentId, :capId, :scope, :ttl, NOW(), DATE_ADD(NOW(), INTERVAL :ttl SECOND),
                                'human:1', 'test fixture', 'active')
                        """)
                .param("id", grantId)
                .param("agentId", agentId)
                .param("capId", capId)
                .param("scope", "{\"deptIds\":[" + deptId + "],\"rowFilter\":{},\"resourcePerm\":\"\"}")
                .param("ttl", ttlSeconds)
                .update();
        return grantId;
    }

    protected Map<String, Object> parse(String payload) throws Exception {
        return json.readValue(payload, new com.fasterxml.jackson.core.type.TypeReference<>() {
        });
    }
}