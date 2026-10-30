package com.fuao.harness.platform.service;

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
 * The categories a skill can be filed under.
 *
 * <p>A market with hundreds of skills in one flat list is a list nobody reads, so the market
 * needs categories. The ones a company actually reaches for are built in; an operator can add
 * their own and rename any of them.
 *
 * <p>The list of choices is data, not code: a category that only makes sense here - 「飞书」
 * next to the built-in 「沟通协作」, say - has no business being a migration.
 *
 * <p>Renaming a category moves the skills with it. The category is stored by name on the
 * skill, so a rename is one update on the table and one on the skills - which is why it is
 * done in one transaction: a category that has been renamed but whose skills still carry the
 * old name is a category nobody can find anything in.
 */
@Service
public class SkillCategoryService {

    private final SkillRepository skills;
    private final AuditService audit;
    private final AuthContext authContext;

    public SkillCategoryService(SkillRepository skills, AuditService audit, AuthContext authContext) {
        this.skills = skills;
        this.audit = audit;
        this.authContext = authContext;
    }

    /** The categories, built-in ones first. */
    public List<SkillRepository.CategoryRow> list() {
        return skills.listCategories();
    }

    /** Adds a category. */
    @Transactional
    public SkillRepository.CategoryRow add(String name) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.category.add");
        String trimmed = name == null ? "" : name.trim();
        if (trimmed.isEmpty()) {
            throw new IllegalArgumentException("a category needs a name");
        }
        if (trimmed.length() > 64) {
            throw new IllegalArgumentException("a category name is at most 64 characters");
        }
        if (skills.findCategory(trimmed).isPresent()) {
            throw new IllegalStateException("the category already exists: " + trimmed);
        }
        Instant now = Instant.now();
        SkillRepository.CategoryRow row = new SkillRepository.CategoryRow(
                Ids.newId(), trimmed, false, 500, actor.actorId(), now, now);
        skills.insertCategory(row);
        audit.record(actor, "skill.category.add", "skill_category", row.categoryId(), "allow", null,
                "added the category " + trimmed, AuditService.evidence("name", trimmed));
        return row;
    }

    /**
     * Renames a category.
     *
     * <p>The skills under it move with it. A rename that left them behind would be a rename
     * that lost half the market.
     */
    @Transactional
    public SkillRepository.CategoryRow rename(String categoryId, String name) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.category.rename");
        SkillRepository.CategoryRow current = skills.findCategoryById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("no such category: " + categoryId));
        String trimmed = name == null ? "" : name.trim();
        if (trimmed.isEmpty()) {
            throw new IllegalArgumentException("a category needs a name");
        }
        if (!trimmed.equals(current.name()) && skills.findCategory(trimmed).isPresent()) {
            throw new IllegalStateException("the category already exists: " + trimmed);
        }
        skills.renameCategory(categoryId, trimmed);
        int moved = skills.recategorise(current.name(), trimmed);
        audit.record(actor, "skill.category.rename", "skill_category", current.categoryId(), "allow", null,
                "renamed the category " + current.name() + " to " + trimmed,
                AuditService.evidence("from", current.name(), "to", trimmed,
                        "skills", String.valueOf(moved)));
        return skills.findCategoryById(categoryId).orElseThrow();
    }

    /**
     * Removes a category.
     *
     * <p>The skills that were filed under it keep their content and lose their filing - they
     * are not deleted, and they are not published on the strength of having been in a
     * category that no longer exists.
     */
    @Transactional
    public void remove(String categoryId) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.category.remove");
        SkillRepository.CategoryRow current = skills.findCategoryById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("no such category: " + categoryId));
        if (current.builtin()) {
            throw new IllegalStateException("the built-in categories can be renamed but not removed: "
                    + current.name());
        }
        skills.deleteCategory(categoryId);
        int orphaned = skills.recategorise(current.name(), null);
        audit.record(actor, "skill.category.remove", "skill_category", current.categoryId(), "allow", null,
                "removed the category " + current.name(),
                AuditService.evidence("name", current.name(), "skills", String.valueOf(orphaned)));
    }

    /**
     * Checks that a category exists.
     *
     * @return the category's name, trimmed
     * @throws IllegalArgumentException when nobody has ever heard of it - with the list of the
     *                                  ones there are, because "unknown category" on its own
     *                                  is a guessing game
     */
    public String requireKnown(String name) {
        String trimmed = name == null ? "" : name.trim();
        if (trimmed.isEmpty()) {
            return null;
        }
        if (skills.findCategory(trimmed).isPresent()) {
            return trimmed;
        }
        String known = skills.listCategories().stream().map(SkillRepository.CategoryRow::name)
                .reduce((a, b) -> a + "、" + b).orElse("（还没有分类）");
        throw new IllegalArgumentException("没有这个分类：" + trimmed + "。现在有的是：" + known);
    }

    private static void requireHuman(AuthenticatedClient actor, String op) {
        if (!actor.isHuman()) {
            throw new SkillMarketService.NotAHumanException(op + " requires a natural human, caller was "
                    + actor.actorType() + " (" + actor.clientId() + ")");
        }
    }

    /** The categories as the console sees them. */
    public static List<Map<String, Object>> describe(List<SkillRepository.CategoryRow> rows) {
        return rows.stream().map(r -> {
            Map<String, Object> m = new java.util.LinkedHashMap<>();
            m.put("categoryId", r.categoryId());
            m.put("name", r.name());
            m.put("builtin", r.builtin());
            m.put("sortOrder", r.sortOrder());
            return m;
        }).toList();
    }
}
