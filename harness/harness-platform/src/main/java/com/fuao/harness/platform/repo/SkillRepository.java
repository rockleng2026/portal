package com.fuao.harness.platform.repo;

import com.fuao.harness.platform.domain.SkillRecord;
import com.fuao.harness.protocol.json.Json;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

/**
 * {@code harness_skill}, {@code harness_skill_install} and {@code harness_skill_registry} access.
 *
 * <p>A skill key holds one row per version. Versions are never edited: a change writes a new row
 * whose {@code parent_version} points at the one it replaces (01 P6 - "记忆即代码": a skill is
 * versioned, signed and rollbackable, so a rollback is a pointer move and not a re-download).
 */
@Repository
public class SkillRepository {

    private final JdbcClient jdbc;

    public SkillRepository(JdbcClient jdbc) {
        this.jdbc = jdbc;
    }

    // ------------------------------------------------------------------ skills

    private static final String SKILL_COLUMNS = """
            skill_id, skill_key, version, parent_version, name, definition, signature, author_agent,
            author_human, eval_result, status, rollout_pct, scope, source, source_ref, source_url,
            publisher, dept_id, listing_status, visibility, content, content_digest, scripts,
            install_count, created_by, created_at, updated_at
            """;

    public void insert(SkillRecord s) {
        jdbc.sql("""
                        INSERT INTO harness_skill
                          (skill_id, skill_key, version, parent_version, name, definition, signature,
                           author_agent, author_human, eval_result, status, rollout_pct, scope,
                           source, source_ref, source_url, publisher, dept_id, listing_status, visibility,
                           content, content_digest, scripts, install_count, created_by, created_at, updated_at)
                        VALUES
                          (:skillId, :skillKey, :version, :parentVersion, :name, :definition, :signature,
                           :authorAgent, :authorHuman, :evalResult, :status, :rolloutPct, :scope,
                           :source, :sourceRef, :sourceUrl, :publisher, :deptId, :listingStatus, :visibility,
                           :content, :contentDigest, :scripts, :installCount, :createdBy, :createdAt, :updatedAt)
                        """)
                .param("skillId", s.skillId())
                .param("skillKey", s.skillKey())
                .param("version", s.version())
                .param("parentVersion", s.parentVersion())
                .param("name", s.name())
                .param("definition", Json.canonical(s.definition() == null ? Map.of() : s.definition()))
                .param("signature", s.signature())
                .param("authorAgent", s.authorAgent())
                .param("authorHuman", s.authorHuman())
                .param("evalResult", s.evalResult() == null ? null : Json.canonical(s.evalResult()))
                .param("status", s.status().wire())
                .param("rolloutPct", s.rolloutPct())
                .param("scope", s.scope() == null ? null : Json.canonical(s.scope()))
                .param("source", s.source().wire())
                .param("sourceRef", s.sourceRef())
                .param("sourceUrl", s.sourceUrl())
                .param("publisher", s.publisher())
                .param("deptId", s.deptId())
                .param("listingStatus", s.listingStatus().wire())
                .param("visibility", s.visibility().wire())
                .param("content", s.content())
                .param("contentDigest", s.contentDigest())
                .param("scripts", s.scripts() == null || s.scripts().isEmpty()
                        ? null : Json.canonical(s.scripts()))
                .param("installCount", s.installCount())
                .param("createdBy", s.createdBy())
                .param("createdAt", Timestamp.from(s.createdAt()))
                .param("updatedAt", Timestamp.from(s.updatedAt()))
                .update();
    }

    public Optional<SkillRecord> findVersion(String skillKey, int version) {
        return jdbc.sql("SELECT " + SKILL_COLUMNS + " FROM harness_skill WHERE skill_key = :key AND version = :version")
                .param("key", skillKey)
                .param("version", version)
                .query((rs, i) -> mapSkill(rs))
                .optional();
    }

    /** The newest version of a skill. */
    public Optional<SkillRecord> findLatest(String skillKey) {
        return jdbc.sql("SELECT " + SKILL_COLUMNS + " FROM harness_skill WHERE skill_key = :key"
                        + " ORDER BY version DESC LIMIT 1")
                .param("key", skillKey)
                .query((rs, i) -> mapSkill(rs))
                .optional();
    }

    public List<SkillRecord> listVersions(String skillKey) {
        return jdbc.sql("SELECT " + SKILL_COLUMNS + " FROM harness_skill WHERE skill_key = :key ORDER BY version DESC")
                .param("key", skillKey)
                .query((rs, i) -> mapSkill(rs))
                .list();
    }

    public boolean exists(String skillKey) {
        return jdbc.sql("SELECT COUNT(*) FROM harness_skill WHERE skill_key = :key")
                .param("key", skillKey)
                .query(Integer.class)
                .single() > 0;
    }

    /** The next version number for a key. */
    public int nextVersion(String skillKey) {
        Integer max = jdbc.sql("SELECT MAX(version) FROM harness_skill WHERE skill_key = :key")
                .param("key", skillKey)
                .query(Integer.class)
                .optional()
                .orElse(0);
        return (max == null ? 0 : max) + 1;
    }

    /** The external package a skill was pulled from, if any. */
    public Optional<SkillRecord> findBySourceRef(String sourceRef) {
        return jdbc.sql("SELECT " + SKILL_COLUMNS + " FROM harness_skill WHERE source_ref = :ref"
                        + " ORDER BY version DESC LIMIT 1")
                .param("ref", sourceRef)
                .query((rs, i) -> mapSkill(rs))
                .optional();
    }

    /**
     * The market list.
     *
     * <p>Only the newest version of each skill is listed: a market shows the current thing, and
     * the history is one drill-down away.
     */
    public List<SkillRecord> listMarket(String query, String source, String listingStatus, String status,
                                         String visibility, Integer deptId, Integer ownerDeptId,
                                         String authorAgentId, Integer limit) {
        StringBuilder sql = new StringBuilder("""
                SELECT s.skill_id, s.skill_key, s.version, s.parent_version, s.name, s.definition,
                       s.signature, s.author_agent, s.author_human, s.eval_result, s.status, s.rollout_pct,
                       s.scope, s.source, s.source_ref, s.source_url, s.publisher, s.dept_id,
                       s.listing_status, s.visibility, s.content, s.content_digest, s.scripts,
                       s.install_count, s.created_by, s.created_at, s.updated_at
                  FROM harness_skill s
                  JOIN (SELECT skill_key, MAX(version) AS version FROM harness_skill GROUP BY skill_key) newest
                    ON newest.skill_key = s.skill_key AND newest.version = s.version
                 WHERE 1=1
                """);
        Map<String, Object> params = new LinkedHashMap<>();

        if (query != null && !query.isBlank()) {
            sql.append(" AND (s.name LIKE :query OR s.skill_key LIKE :query OR s.publisher LIKE :query)");
            params.put("query", "%" + query.trim() + "%");
        }
        if (source != null && !source.isBlank()) {
            sql.append(" AND s.source = :source");
            params.put("source", SkillRecord.Source.fromWire(source.trim()).wire());
        }
        if (listingStatus != null && !listingStatus.isBlank()) {
            sql.append(" AND s.listing_status = :listingStatus");
            params.put("listingStatus", SkillRecord.ListingStatus.fromWire(listingStatus.trim()).wire());
        }
        if (status != null && !status.isBlank()) {
            sql.append(" AND s.status = :status");
            params.put("status", SkillRecord.Status.fromWire(status.trim()).wire());
        }
        if (visibility != null && !visibility.isBlank()) {
            sql.append(" AND s.visibility = :visibility");
            params.put("visibility", SkillRecord.Visibility.fromWire(visibility.trim()).wire());
        }
        if (deptId != null) {
            sql.append(" AND s.dept_id = :deptId");
            params.put("deptId", deptId);
        }
        // The caller's own reach: a private skill is only the author's, a department skill is the
        // department's, and an organisation skill is everybody's. The filters above narrow the
        // market further; this is the floor that nothing may talk its way under.
        sql.append(" AND (s.visibility = 'org'");
        if (ownerDeptId != null) {
            sql.append(" OR (s.visibility = 'dept' AND s.dept_id = :ownerDeptId)");
            params.put("ownerDeptId", ownerDeptId);
        }
        if (authorAgentId != null && !authorAgentId.isBlank()) {
            sql.append(" OR (s.visibility = 'private' AND s.author_agent = :authorAgentId)");
            params.put("authorAgentId", authorAgentId);
        }
        sql.append(")");
        sql.append(" ORDER BY s.install_count DESC, s.updated_at DESC LIMIT :limit");
        params.put("limit", limit);

        JdbcClient.StatementSpec spec = jdbc.sql(sql.toString());
        for (Map.Entry<String, Object> p : params.entrySet()) {
            spec = spec.param(p.getKey(), p.getValue());
        }
        return spec.query((rs, i) -> mapSkill(rs)).list();
    }

    /**
     * Moves a skill version along its lifecycle.
     *
     * <p>The {@code from} in the WHERE clause is the concurrency guard: two reviewers clicking
     * at the same time must not both win, and the loser has to be told.
     */
    public int updateLifecycle(String skillId, SkillRecord.Status from, SkillRecord.Status to,
                               SkillRecord.ListingStatus listingStatus, Integer rolloutPct) {
        StringBuilder set = new StringBuilder("status = :to, updated_at = NOW()");
        Map<String, Object> params = new LinkedHashMap<>();
        params.put("to", to.wire());
        params.put("skillId", skillId);
        params.put("from", from.wire());
        if (listingStatus != null) {
            set.append(", listing_status = :listing");
            params.put("listing", listingStatus.wire());
        }
        if (rolloutPct != null) {
            set.append(", rollout_pct = :rolloutPct");
            params.put("rolloutPct", rolloutPct);
        }
        String sql = "UPDATE harness_skill SET " + set
                + " WHERE skill_id = :skillId AND status = :from";
        JdbcClient.StatementSpec spec = jdbc.sql(sql);
        for (Map.Entry<String, Object> p : params.entrySet()) {
            spec = spec.param(p.getKey(), p.getValue());
        }
        return spec.update();
    }

    /** Changes the shelf state without touching the lifecycle status. */
    public boolean updateListing(String skillId, SkillRecord.ListingStatus listingStatus,
                                  SkillRecord.Visibility visibility, Integer deptId) {
        StringBuilder sql = new StringBuilder(
                "UPDATE harness_skill SET listing_status = :listing, updated_at = NOW()");
        Map<String, Object> params = new LinkedHashMap<>();
        params.put("listing", listingStatus.wire());
        if (visibility != null) {
            sql.append(", visibility = :visibility");
            params.put("visibility", visibility.wire());
        }
        if (deptId != null) {
            sql.append(", dept_id = :deptId");
            params.put("deptId", deptId);
        }
        sql.append(" WHERE skill_id = :skillId");
        params.put("skillId", skillId);
        JdbcClient.StatementSpec spec = jdbc.sql(sql.toString());
        for (Map.Entry<String, Object> p : params.entrySet()) {
            spec = spec.param(p.getKey(), p.getValue());
        }
        return spec.update() == 1;
    }

    public void incrementInstallCount(String skillId) {
        jdbc.sql("UPDATE harness_skill SET install_count = install_count + 1, updated_at = NOW()"
                        + " WHERE skill_id = :skillId")
                .param("skillId", skillId)
                .update();
    }

    // ------------------------------------------------------------------ installs

    public void insertInstall(String installId, String skillId, String skillKey, int version,
                              String targetType, String targetId, Integer deptId, String status,
                              String installedBy, String reason, Instant now) {
        jdbc.sql("""
                        INSERT INTO harness_skill_install
                          (install_id, skill_id, skill_key, version, target_type, target_id, dept_id,
                           status, installed_by, reason, created_at, updated_at)
                        VALUES
                          (:installId, :skillId, :skillKey, :version, :targetType, :targetId, :deptId,
                           :status, :installedBy, :reason, :now, :now)
                        """)
                .param("installId", installId)
                .param("skillId", skillId)
                .param("skillKey", skillKey)
                .param("version", version)
                .param("targetType", targetType)
                .param("targetId", targetId)
                .param("deptId", deptId)
                .param("status", status)
                .param("installedBy", installedBy)
                .param("reason", reason)
                .param("now", Timestamp.from(now))
                .update();
    }

    public boolean updateInstall(String installId, int version, String status, String installedBy,
                                 String reason, Instant now) {
        return jdbc.sql("""
                        UPDATE harness_skill_install
                           SET version = :version, status = :status, installed_by = :installedBy,
                               reason = :reason, updated_at = :now
                         WHERE install_id = :installId
                        """)
                .param("version", version)
                .param("status", status)
                .param("installedBy", installedBy)
                .param("reason", reason)
                .param("now", Timestamp.from(now))
                .param("installId", installId)
                .update() == 1;
    }

    public boolean deleteInstall(String installId) {
        return jdbc.sql("DELETE FROM harness_skill_install WHERE install_id = :installId")
                .param("installId", installId)
                .update() == 1;
    }

    /**
     * Removes every installation of a skill.
     *
     * <p>By key, not by id: an installation points at one <em>version</em>, and every version of
     * a skill has its own id. Withdrawing the skill has to withdraw all of them.
     */
    public int deleteInstallsForSkill(String skillKey) {
        return jdbc.sql("DELETE FROM harness_skill_install WHERE skill_key = :skillKey")
                .param("skillKey", skillKey)
                .update();
    }

    /** The installations of one skill, whatever version they point at. */
    public List<InstallRow> installsOfSkill(String skillKey) {
        return jdbc.sql("""
                        SELECT install_id, skill_id, skill_key, version, target_type, target_id, dept_id,
                               status, installed_by, reason, created_at, updated_at
                          FROM harness_skill_install WHERE skill_key = :skillKey
                        """)
                .param("skillKey", skillKey)
                .query((rs, i) -> mapInstall(rs))
                .list();
    }

    /** One installation, by its id. */
    public Optional<InstallRow> findInstallById(String installId) {
        return jdbc.sql("""
                        SELECT install_id, skill_id, skill_key, version, target_type, target_id, dept_id,
                               status, installed_by, reason, created_at, updated_at
                          FROM harness_skill_install WHERE install_id = :installId
                        """)
                .param("installId", installId)
                .query((rs, i) -> mapInstall(rs))
                .optional();
    }

    /** Removes one version of a skill. Only a version that was never published may go. */
    public boolean deleteVersion(String skillId) {
        return jdbc.sql("DELETE FROM harness_skill WHERE skill_id = :skillId")
                .param("skillId", skillId)
                .update() == 1;
    }

    public Optional<InstallRow> findInstall(String targetType, String targetId, String skillKey) {
        return jdbc.sql("""
                        SELECT install_id, skill_id, skill_key, version, target_type, target_id, dept_id,
                               status, installed_by, reason, created_at, updated_at
                          FROM harness_skill_install
                         WHERE target_type = :targetType AND target_id = :targetId AND skill_key = :skillKey
                        """)
                .param("targetType", targetType)
                .param("targetId", targetId)
                .param("skillKey", skillKey)
                .query((rs, i) -> mapInstall(rs))
                .optional();
    }

    public List<InstallRow> listInstalls(String targetType, String targetId, Integer deptId, int limit) {
        return jdbc.sql("""
                        SELECT install_id, skill_id, skill_key, version, target_type, target_id, dept_id,
                               status, installed_by, reason, created_at, updated_at
                          FROM harness_skill_install
                         WHERE (:targetType IS NULL OR target_type = :targetType)
                           AND (:targetId IS NULL OR target_id = :targetId)
                           AND (:deptId IS NULL OR dept_id = :deptId)
                         ORDER BY updated_at DESC LIMIT :limit
                        """)
                .param("targetType", targetType)
                .param("targetId", targetId)
                .param("deptId", deptId)
                .param("limit", limit)
                .query((rs, i) -> mapInstall(rs))
                .list();
    }

    /** One installation: which version of which skill sits on which target. */
    public record InstallRow(
            String installId,
            String skillId,
            String skillKey,
            int version,
            String targetType,
            String targetId,
            Integer deptId,
            String status,
            String installedBy,
            String reason,
            Instant createdAt,
            Instant updatedAt) {
    }

    // ------------------------------------------------------------------ registries

    public void insertRegistry(RegistryRow r) {
        jdbc.sql("""
                        INSERT INTO harness_skill_registry
                          (registry_id, registry_key, name, kind, search_url, package_url, enabled,
                           created_by, created_at, updated_at)
                        VALUES
                          (:id, :key, :name, :kind, :searchUrl, :packageUrl, :enabled,
                           :createdBy, :createdAt, :updatedAt)
                        """)
                .param("id", r.registryId())
                .param("key", r.registryKey())
                .param("name", r.name())
                .param("kind", r.kind())
                .param("searchUrl", r.searchUrl())
                .param("packageUrl", r.packageUrl())
                .param("enabled", r.enabled() ? 1 : 0)
                .param("createdBy", r.createdBy())
                .param("createdAt", Timestamp.from(r.createdAt()))
                .param("updatedAt", Timestamp.from(r.updatedAt()))
                .update();
    }

    public List<RegistryRow> listRegistries() {
        return jdbc.sql("""
                        SELECT registry_id, registry_key, name, kind, search_url, package_url, enabled,
                               created_by, created_at, updated_at
                          FROM harness_skill_registry ORDER BY registry_key
                        """)
                .query((rs, i) -> new RegistryRow(
                        rs.getString("registry_id"),
                        rs.getString("registry_key"),
                        rs.getString("name"),
                        rs.getString("kind"),
                        rs.getString("search_url"),
                        rs.getString("package_url"),
                        rs.getInt("enabled") == 1,
                        rs.getString("created_by"),
                        rs.getTimestamp("created_at").toInstant(),
                        rs.getTimestamp("updated_at").toInstant()))
                .list();
    }

    public Optional<RegistryRow> findRegistry(String registryKey) {
        return jdbc.sql("""
                        SELECT registry_id, registry_key, name, kind, search_url, package_url, enabled,
                               created_by, created_at, updated_at
                          FROM harness_skill_registry WHERE registry_key = :key
                        """)
                .param("key", registryKey)
                .query((rs, i) -> new RegistryRow(
                        rs.getString("registry_id"),
                        rs.getString("registry_key"),
                        rs.getString("name"),
                        rs.getString("kind"),
                        rs.getString("search_url"),
                        rs.getString("package_url"),
                        rs.getInt("enabled") == 1,
                        rs.getString("created_by"),
                        rs.getTimestamp("created_at").toInstant(),
                        rs.getTimestamp("updated_at").toInstant()))
                .optional();
    }

    /** An upstream registry the platform pulls skills from. */
    public record RegistryRow(
            String registryId,
            String registryKey,
            String name,
            String kind,
            String searchUrl,
            String packageUrl,
            boolean enabled,
            String createdBy,
            Instant createdAt,
            Instant updatedAt) {
    }

    // ------------------------------------------------------------------ mapping

    static SkillRecord mapSkill(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new SkillRecord(
                rs.getString("skill_id"),
                rs.getString("skill_key"),
                rs.getInt("version"),
                (Integer) rs.getObject("parent_version"),
                rs.getString("name"),
                readMap(rs.getString("definition")),
                rs.getString("signature"),
                rs.getString("author_agent"),
                (Integer) rs.getObject("author_human"),
                readMap(rs.getString("eval_result")),
                SkillRecord.Status.fromWire(rs.getString("status")),
                rs.getInt("rollout_pct"),
                readMap(rs.getString("scope")),
                SkillRecord.Source.fromWire(rs.getString("source")),
                rs.getString("source_ref"),
                rs.getString("source_url"),
                rs.getString("publisher"),
                (Integer) rs.getObject("dept_id"),
                SkillRecord.ListingStatus.fromWire(rs.getString("listing_status")),
                SkillRecord.Visibility.fromWire(rs.getString("visibility")),
                rs.getString("content"),
                rs.getString("content_digest"),
                readList(rs.getString("scripts")),
                rs.getInt("install_count"),
                rs.getString("created_by"),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant());
    }

    private static InstallRow mapInstall(java.sql.ResultSet rs) throws java.sql.SQLException {
        return new InstallRow(
                rs.getString("install_id"),
                rs.getString("skill_id"),
                rs.getString("skill_key"),
                rs.getInt("version"),
                rs.getString("target_type"),
                rs.getString("target_id"),
                (Integer) rs.getObject("dept_id"),
                rs.getString("status"),
                rs.getString("installed_by"),
                rs.getString("reason"),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant());
    }

    @SuppressWarnings("unchecked")
    static Map<String, Object> readMap(String json) {
        if (json == null || json.isBlank()) {
            return Map.of();
        }
        Object parsed = Json.parse(json);
        return parsed instanceof Map ? (Map<String, Object>) parsed : Map.of();
    }

    @SuppressWarnings("unchecked")
    static List<Map<String, Object>> readList(String json) {
        if (json == null || json.isBlank()) {
            return List.of();
        }
        Object parsed = Json.parse(json);
        if (!(parsed instanceof List<?> list)) {
            return List.of();
        }
        List<Map<String, Object>> out = new ArrayList<>();
        for (Object item : list) {
            if (item instanceof Map) {
                out.add(new LinkedHashMap<>((Map<String, Object>) item));
            }
        }
        return out;
    }
}
