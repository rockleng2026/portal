package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.SkillRecord;
import com.fuao.harness.platform.repo.SkillRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * The upstream registries the market pulls from (V11).
 *
 * <p>A registry is a place skills can be found but not where they live. Registering one is a
 * human action and the registry is disabled until somebody says so - cross-organisation sharing
 * starts with explicit authorisation, not with automatic discovery (02 D-09, D-14).
 */
@Service
public class SkillRegistryService {

    private final SkillRepository skills;
    private final SkillRegistryClient client;
    private final SkillMarketService market;
    private final AuditService audit;
    private final AuthContext authContext;

    public SkillRegistryService(SkillRepository skills, SkillRegistryClient client, SkillMarketService market,
                                AuditService audit, AuthContext authContext) {
        this.skills = skills;
        this.client = client;
        this.market = market;
        this.audit = audit;
        this.authContext = authContext;
    }

    public List<SkillRepository.RegistryRow> list() {
        return skills.listRegistries();
    }

    /** Registers an upstream registry. Only a human may point the platform at the internet. */
    @Transactional
    public SkillRepository.RegistryRow register(String registryKey, String name, String searchUrl,
                                               String packageUrl) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new SkillMarketService.NotAHumanException("skill.registry.register requires a natural human, "
                    + "caller was " + actor.actorType() + " (" + actor.clientId() + ")");
        }
        if (registryKey == null || registryKey.isBlank()) {
            throw new IllegalArgumentException("registryKey is required");
        }
        if (skills.findRegistry(registryKey).isPresent()) {
            throw new IllegalStateException("registry already registered: " + registryKey);
        }
        if (searchUrl == null || searchUrl.isBlank() || packageUrl == null || packageUrl.isBlank()) {
            throw new IllegalArgumentException("a registry needs a search url and a package url");
        }

        Instant now = Instant.now();
        SkillRepository.RegistryRow row = new SkillRepository.RegistryRow(
                Ids.newId(), registryKey.trim(),
                name == null || name.isBlank() ? registryKey.trim() : name.trim(),
                "external", searchUrl.trim(), packageUrl.trim(), true,
                actor.actorId(), now, now);
        skills.insertRegistry(row);
        audit.record(actor, "skill.registry.register", "skill_registry", row.registryId(), "allow", null,
                "registered the registry " + registryKey,
                AuditService.evidence("registryKey", registryKey, "searchUrl", searchUrl));
        return row;
    }

    /**
     * Searches a registry.
     *
     * <p>Browsing is read-only, so anybody may do it. What comes back is third-party text and is
     * shown as text - it is never executed, and it never becomes a skill until somebody pulls it
     * in and a human has reviewed it.
     */
    public List<SkillRegistryClient.RegistrySkill> search(String registryKey, String query, int limit) {
        SkillRepository.RegistryRow registry = registry(registryKey);
        if (!registry.enabled()) {
            throw new IllegalStateException("registry " + registryKey + " is disabled");
        }
        if (query == null || query.isBlank()) {
            throw new IllegalArgumentException("query is required");
        }
        return client.search(registry, query.trim(), Math.min(Math.max(limit, 1), 50));
    }

    /**
     * Pulls a package out of a registry into the market.
     *
     * <p>The content lands as a candidate with {@code source=external}: the market now owns it,
     * it is versioned and signed like any other skill, and it has to be reviewed before it can be
     * installed.
     */
    @Transactional
    public SkillRecord pull(String registryKey, String packageRef, String skillKey, Integer deptId,
                             SkillRecord.Visibility visibility) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman()) {
            throw new SkillMarketService.NotAHumanException("skill.pull requires a natural human, caller was "
                    + actor.actorType() + " (" + actor.clientId() + ")");
        }
        SkillRepository.RegistryRow registry = registry(registryKey);
        if (!registry.enabled()) {
            throw new IllegalStateException("registry " + registryKey + " is disabled");
        }
        if (packageRef == null || packageRef.isBlank()) {
            throw new IllegalArgumentException("package is required");
        }

        SkillRegistryClient.PulledPackage pulled = client.pull(registry, packageRef.trim());
        String key = skillKey == null || skillKey.isBlank() ? deriveKey(pulled.packageRef()) : skillKey.trim();

        SkillRecord skill = market.importExternal(key, pulled.content(), pulled.name(),
                pulled.packageRef(), null, deptId, visibility, pulled.scripts());
        audit.record(actor, "skill.pull", "skill", skill.skillId(), "allow", null,
                "pulled " + pulled.packageRef() + " from " + registryKey,
                AuditService.evidence("registryKey", registryKey, "package", pulled.packageRef(),
                        "skillKey", key));
        return skill;
    }

    /**
     * The market key for an upstream package.
     *
     * <p>The package reference is {@code owner/repo@skill}, which is not a key the market can
     * use as-is: it is long, it carries a slash and it changes when the owner renames the
     * repository. The key is derived from it so that the same package always lands on the same
     * skill, which is what makes an upgrade an upgrade.
     */
    static String deriveKey(String packageRef) {
        String cleaned = packageRef.trim().toLowerCase(java.util.Locale.ROOT);
        cleaned = cleaned.replaceAll("[^a-z0-9]+", "-").replaceAll("^-+", "").replaceAll("-+$", "");
        if (cleaned.length() > 100) {
            cleaned = cleaned.substring(0, 100);
        }
        return "ext-" + cleaned;
    }

    private SkillRepository.RegistryRow registry(String registryKey) {
        if (registryKey == null || registryKey.isBlank()) {
            throw new IllegalArgumentException("registryKey is required");
        }
        return skills.findRegistry(registryKey.trim())
                .orElseThrow(() -> new IllegalStateException("no such registry: " + registryKey));
    }

    /** The registry rows as the console sees them. */
    public static List<Map<String, Object>> describe(List<SkillRepository.RegistryRow> rows) {
        return rows.stream()
                .map(r -> {
                    Map<String, Object> m = new java.util.LinkedHashMap<>();
                    m.put("registryKey", r.registryKey());
                    m.put("name", r.name());
                    m.put("kind", r.kind());
                    m.put("searchUrl", r.searchUrl());
                    m.put("packageUrl", r.packageUrl());
                    m.put("enabled", r.enabled());
                    return m;
                })
                .toList();
    }
}
