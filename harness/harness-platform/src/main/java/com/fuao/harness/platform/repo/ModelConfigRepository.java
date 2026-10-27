package com.fuao.harness.platform.repo;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/** {@code harness_model_config} access (V10). */
@Repository
public class ModelConfigRepository {

    private final JdbcClient jdbc;

    public ModelConfigRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    /** One model configuration. */
    public record ConfigRow(
            String configId,
            String scope,
            String scopeId,
            String provider,
            String modelName,
            String baseUrl,
            String apiKeyCipher,
            String createdBy,
            Instant createdAt,
            Instant updatedAt) {
    }

    private static final String COLUMNS = """
            config_id, scope, scope_id, provider, model_name, base_url, api_key_cipher,
            created_by, created_at, updated_at
            """;

    public Optional<ConfigRow> find(String scope, String scopeId) {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_model_config WHERE scope = :scope AND scope_id = :id")
                .param("scope", scope)
                .param("id", scopeId)
                .query((rs, i) -> map(rs))
                .optional();
    }

    public List<ConfigRow> list() {
        return jdbc.sql("SELECT " + COLUMNS + " FROM harness_model_config ORDER BY scope, scope_id")
                .query((rs, i) -> map(rs))
                .list();
    }

    /**
     * The configuration that applies to a terminal: its own, else its agent's, else the brain's.
     *
     * <p>The most specific wins, so a terminal that has been given its own model does not
     * silently fall back to the agent's or the platform's.
     *
     * <p>The three scopes are: <b>terminal</b> (one machine), <b>agent</b> (one digital
     * employee) and <b>brain</b> (the platform-wide default the core brain reasons with).
     */
    public List<ConfigRow> resolveFor(String terminalId, String agentId) {
        List<ConfigRow> candidates = new java.util.ArrayList<>();
        if (terminalId != null && !terminalId.isBlank()) {
            candidates.addAll(find("terminal", terminalId).stream().toList());
        }
        if (agentId != null && !agentId.isBlank()) {
            candidates.addAll(find("agent", agentId).stream().toList());
        }
        candidates.addAll(find("brain", "*").stream().toList());
        candidates.addAll(find("global", "*").stream().toList());
        return candidates;
    }

    public void upsert(String configId, String scope, String scopeId, String provider, String modelName,
                       String baseUrl, String apiKeyCipher, String createdBy, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_model_config
                          (config_id, scope, scope_id, provider, model_name, base_url, api_key_cipher,
                           created_by, created_at, updated_at)
                        VALUES (:configId, :scope, :scopeId, :provider, :modelName, :baseUrl, :cipher,
                                :createdBy, :now, :now)
                        ON DUPLICATE KEY UPDATE
                          provider = VALUES(provider), model_name = VALUES(model_name),
                          base_url = VALUES(base_url), api_key_cipher = VALUES(api_key_cipher),
                          updated_at = VALUES(updated_at)
                        """)
                .param("configId", configId)
                .param("scope", scope)
                .param("scopeId", scopeId)
                .param("provider", provider)
                .param("modelName", modelName)
                .param("baseUrl", baseUrl)
                .param("cipher", apiKeyCipher)
                .param("createdBy", createdBy)
                .param("now", Timestamp.from(now))
                .update();
    }

    public boolean delete(String scope, String scopeId) {
        return jdbc.sql("DELETE FROM harness_model_config WHERE scope = :scope AND scope_id = :id")
                .param("scope", scope)
                .param("id", scopeId)
                .update() == 1;
    }

    private static ConfigRow map(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new ConfigRow(
                rs.getString("config_id"),
                rs.getString("scope"),
                rs.getString("scope_id"),
                rs.getString("provider"),
                rs.getString("model_name"),
                rs.getString("base_url"),
                rs.getString("api_key_cipher"),
                rs.getString("created_by"),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant());
    }
}
