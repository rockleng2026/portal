package com.fuao.harness.platform.service;

import com.fuao.harness.platform.config.HarnessProperties;
import com.fuao.harness.platform.domain.SkillRecord;
import com.fuao.harness.platform.repo.SkillRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Digests;
import com.fuao.harness.protocol.Ids;
import com.fuao.harness.protocol.json.Json;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * The skill market (V11).
 *
 * <p>A skill is program memory: versioned, signed, rollbackable (01 P6). The market is the shelf
 * those skills sit on. The rules this service enforces are the ones the design cannot do without:
 *
 * <ul>
 *   <li><b>A skill is content, never authority.</b> Installing a skill grants nothing. A skill
 *       can tell the agent what to do; it cannot make the policy engine allow anything (02 R-05).</li>
 *   <li><b>Nothing goes on the shelf unreviewed.</b> A skill - whoever wrote it, including a
 *       digital employee and including a package pulled from an upstream registry - starts as a
 *       candidate. A human who is not its author has to approve it, and only then can it be
 *       published and installed (01 §8.1.3.4, 02 R-18).</li>
 *   <li><b>The reviewer is not the author</b> (02 R-02, ADR-007). A digital employee that
 *       reviewed its own skill would be granting itself authority through the back door.</li>
 *   <li><b>Versions are immutable.</b> An edit writes a new version; the old one stays, so a
 *       rollback is a pointer move (04 A2-2: five minutes, and no re-download).</li>
 * </ul>
 */
@Service
public class SkillMarketService {

    private final SkillRepository skills;
    private final AuditService audit;
    private final AuthContext authContext;
    private final byte[] signingKey;

    public SkillMarketService(SkillRepository skills, AuditService audit, AuthContext authContext,
                              HarnessProperties properties) {
        this.skills = skills;
        this.audit = audit;
        this.authContext = authContext;
        this.signingKey = deriveKey(properties);
    }

    /**
     * The key skills are signed with.
     *
     * <p>From {@code harness.skill.signing-key} when it is set, otherwise derived from the
     * bootstrap secret - the same fallback the model credentials use.
     *
     * <p>The signature proves the platform issued this version. It is <em>not</em> a terminal
     * verification: the terminal has no copy of this key, and giving it one would let a
     * compromised machine mint skills. The terminal verifies {@code content_digest}, which is a
     * plain SHA-256 of the content it was handed.
     */
    private static byte[] deriveKey(HarnessProperties properties) {
        String configured = null;
        if (properties.skill() != null) {
            configured = properties.skill().signingKey();
        }
        if ((configured == null || configured.isBlank()) && properties.bootstrap() != null) {
            configured = properties.bootstrap().secret();
        }
        if (configured == null || configured.isBlank()) {
            throw new IllegalStateException("no key to sign skills with: set harness.skill.signing-key "
                    + "(or a bootstrap secret)");
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            return digest.digest(configured.getBytes(StandardCharsets.UTF_8));
        } catch (Exception e) {
            throw new IllegalStateException("SHA-256 unavailable", e);
        }
    }

    // ------------------------------------------------------------------ commands

    /** Everything it takes to put a skill into the market. */
    public record SkillCommand(
            String skillKey,
            String name,
            String description,
            String content,
            String visibility,
            Integer deptId,
            String publisher,
            List<ScriptContent> scripts) {
    }

    /** A script that travels with the skill. */
    public record ScriptContent(String name, String content) {
    }
    /**
     * Pulls a skill out of an upstream registry into the market.
     *
     * <p>This is the pi-web idea pointed at the company's own market: find a package in a
     * registry, pull it in, manage it here. What is different from pi-web is where it lands:
     * a candidate, in the market, waiting for a human who is not its author to read it. Third
     * party content does not get to skip the review (02 D-09, R-18).
     *
     * <p>Pulling the same package again writes a new version rather than a duplicate key, so an
     * upstream release becomes an upgrade instead of a conflict.
     */
    @Transactional
    public SkillRecord importExternal(String skillKey, String content, String publisher, String sourceRef,
                                      String sourceUrl, Integer deptId, SkillRecord.Visibility visibility,
                                      List<ScriptContent> scripts) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.pull");

        SkillDocument document = SkillDocument.parse(content);
        Instant now = Instant.now();

        SkillRecord previous = skills.findLatest(skillKey).orElse(null);
        int version = previous == null ? 1 : skills.nextVersion(skillKey);
        Integer parentVersion = previous == null ? null : previous.version();

        SkillRecord skill = build(actor,
                new SkillCommand(skillKey, document.name(), document.description(), content,
                        visibility == null ? SkillRecord.Visibility.DEPT.wire() : visibility.wire(),
                        deptId, publisher, scripts),
                document,
                visibility == null ? SkillRecord.Visibility.DEPT : visibility,
                deptId == null ? deptOf(actor) : deptId,
                version, parentVersion, now);
        SkillRecord external = withSource(skill, SkillRecord.Source.EXTERNAL, sourceRef, sourceUrl, publisher);
        skills.insert(external);

        audit.record(actor, "skill.pull", "skill", external.skillId(), "allow", null,
                "pulled " + sourceRef + " into the market as a candidate",
                AuditService.evidence("skillKey", skillKey, "version", String.valueOf(version),
                        "sourceRef", String.valueOf(sourceRef), "digest", external.contentDigest()));
        return external;
    }

    private static SkillRecord withSource(SkillRecord skill, SkillRecord.Source source, String sourceRef,
                                          String sourceUrl, String publisher) {
        return new SkillRecord(
                skill.skillId(), skill.skillKey(), skill.version(), skill.parentVersion(), skill.name(),
                skill.definition(), skill.signature(), skill.authorAgent(), skill.authorHuman(),
                skill.evalResult(), skill.status(), skill.rolloutPct(), skill.scope(), source, sourceRef,
                sourceUrl, publisher == null ? skill.publisher() : publisher, skill.deptId(),
                skill.listingStatus(), skill.visibility(), skill.content(), skill.contentDigest(),
                skill.scripts(), skill.installCount(), skill.createdBy(), skill.createdAt(), skill.updatedAt());
    }

    /**
     * A new skill, at version 1, as a candidate.
     *
     * <p>A human may write a skill for the company. A digital employee may push a skill it
     * distilled out of its own work - that is the second way into the market - but only for its
     * own department, and it still lands as a candidate.
     */
    @Transactional
    public SkillRecord create(SkillCommand cmd) {
        AuthenticatedClient actor = authContext.require();
        if (!actor.isHuman() && !actor.isAgent()) {
            throw new NotAHumanException("skill.create requires a natural human or a digital employee, caller was "
                    + actor.actorType() + " (" + actor.clientId() + ")");
        }
        if (cmd.skillKey() == null || cmd.skillKey().isBlank()) {
            throw new IllegalArgumentException("skillKey is required");
        }
        if (skills.exists(cmd.skillKey())) {
            throw new DuplicateSkillKeyException(cmd.skillKey());
        }
        if (actor.isAgent()) {
            // An agent speaks for itself: the skill belongs to its department.
            if (cmd.deptId() != null && !cmd.deptId().equals(deptOf(actor))) {
                throw new NotTheAuthorException("a digital employee may only push a skill for its own department");
            }
        }

        SkillDocument document = SkillDocument.parse(cmd.content());
        SkillRecord.Visibility visibility = resolveVisibility(cmd.visibility(), actor);
        Integer deptId = cmd.deptId() != null ? cmd.deptId() : deptOf(actor);
        if (visibility == SkillRecord.Visibility.ORG && !actor.isSystemAdmin()) {
            throw new NotAHumanException("only a system administrator may create an organisation-wide skill");
        }

        Instant now = Instant.now();
        SkillRecord skill = build(actor, cmd, document, visibility, deptId, 1, null, now);
        skills.insert(skill);

        audit.record(actor, "skill.create", "skill", skill.skillId(), "allow", null,
                "created " + skill.skillKey() + " v1 as a candidate",
                AuditService.evidence("skillKey", skill.skillKey(), "source", skill.source().wire(),
                        "visibility", visibility.wire(), "digest", skill.contentDigest()));
        return skill;
    }

    /**
     * A new version of an existing skill.
     *
     * <p>The author may edit their own skill. Anybody else needs to be a human, because a
     * stranger rewriting a published skill is exactly the "one agent's bad best practice becomes
     * everybody's best practice" failure the red team named (02 §0).
     */
    @Transactional
    public SkillRecord update(String skillKey, SkillCommand cmd) {
        AuthenticatedClient actor = authContext.require();
        SkillRecord current = get(skillKey);

        if (!isAuthor(actor, current) && !actor.isHuman()) {
            throw new NotTheAuthorException("only the author may change " + skillKey + ", caller was "
                    + actor.actorType() + " (" + actor.clientId() + ")");
        }
        if (current.listingStatus() == SkillRecord.ListingStatus.PUBLISHED && !actor.isHuman()) {
            throw new NotAHumanException("a published skill may only be changed by a human");
        }

        SkillDocument document = SkillDocument.parse(cmd.content());
        SkillRecord.Visibility visibility = resolveVisibility(cmd.visibility(), actor);
        Integer deptId = cmd.deptId() != null ? cmd.deptId() : current.deptId();
        if (visibility == SkillRecord.Visibility.ORG && !actor.isSystemAdmin()) {
            throw new NotAHumanException("only a system administrator may publish an organisation-wide skill");
        }

        int version = skills.nextVersion(skillKey);
        Instant now = Instant.now();
        // The key of the path wins: a body that names another skill must not create a version
        // of that other skill by accident.
        SkillRecord next = build(actor,
                new SkillCommand(skillKey, cmd.name(), cmd.description(), cmd.content(), cmd.visibility(),
                        cmd.deptId(), cmd.publisher(), cmd.scripts()),
                document, visibility, deptId, version, current.version(), now);
        skills.insert(next);

        audit.record(actor, "skill.update", "skill", next.skillId(), "allow", null,
                "published " + skillKey + " v" + version + " as a candidate",
                AuditService.evidence("skillKey", skillKey, "version", String.valueOf(version),
                        "parentVersion", String.valueOf(current.version()), "digest", next.contentDigest()));
        return next;
    }

    /** The author hands the skill over for review. */
    @Transactional
    public SkillRecord submit(String skillKey, String reason) {
        AuthenticatedClient actor = authContext.require();
        SkillRecord current = get(skillKey);
        if (!isAuthor(actor, current) && !actor.isHuman()) {
            throw new NotTheAuthorException("only the author may submit " + skillKey + " for review");
        }
        transition(current, SkillRecord.Status.EVALUATING, null, null, actor, "skill.submit",
                reason == null ? "submitted for review" : reason);
        return latest(skillKey);
    }

    /**
     * A human reviewer approves the skill.
     *
     * <p>The reviewer must not be the author. That is the whole point of the review: an agent
     * that writes a skill and approves it has granted itself authority without anybody noticing.
     */
    @Transactional
    public SkillRecord approve(String skillKey, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.approve");
        SkillRecord current = get(skillKey);
        requireDifferentReviewer(actor, current);

        transition(current, SkillRecord.Status.APPROVED, null, null, actor, "skill.approve",
                reason == null ? "approved" : reason);
        return latest(skillKey);
    }

    /** A human reviewer turns the skill down; it stays a candidate and can be worked on. */
    @Transactional
    public SkillRecord reject(String skillKey, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.reject");
        SkillRecord current = get(skillKey);
        requireDifferentReviewer(actor, current);
        if (reason == null || reason.isBlank()) {
            throw new IllegalArgumentException("a rejection has to say why: the author has to learn something");
        }

        transition(current, SkillRecord.Status.CANDIDATE, null, null, actor, "skill.reject", reason);
        return latest(skillKey);
    }

    /**
     * Puts an approved skill on the shelf.
     *
     * <p>Only an approved skill can be published, and only a human may publish it. Publishing to
     * the whole company needs a system administrator.
     */
    @Transactional
    public SkillRecord publish(String skillKey, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.publish");
        SkillRecord current = get(skillKey);
        if (current.visibility() == SkillRecord.Visibility.ORG && !actor.isSystemAdmin()) {
            throw new NotAHumanException("only a system administrator may publish an organisation-wide skill");
        }

        transition(current, SkillRecord.Status.RELEASED, SkillRecord.ListingStatus.PUBLISHED, null,
                actor, "skill.publish", reason == null ? "published" : reason);
        return latest(skillKey);
    }

    /**
     * Takes the skill off the shelf.
     *
     * <p>The versions stay - a rollback has to remain possible - and every installation of it is
     * withdrawn, because a skill that is not on the shelf must not be running on anybody's
     * machine.
     */
    @Transactional
    public SkillRecord unlist(String skillKey, String reason) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.unlist");
        SkillRecord current = get(skillKey);
        if (reason == null || reason.isBlank()) {
            throw new IllegalArgumentException("taking a skill off the shelf has to say why");
        }

        transition(current, SkillRecord.Status.DEPRECATED, SkillRecord.ListingStatus.UNLISTED, null,
                actor, "skill.unlist", reason);
        int withdrawn = skills.deleteInstallsForSkill(current.skillKey());
        audit.record(actor, "skill.install.withdraw", "skill", current.skillId(), "allow", "SKILL_UNLISTED",
                "withdrew " + withdrawn + " installations because the skill left the shelf",
                AuditService.evidence("skillKey", skillKey, "installations", String.valueOf(withdrawn)));
        return latest(skillKey);
    }

    /**
     * Removes the skill.
     *
     * <p>The default is to take it off the shelf and keep the versions: the audit trail points at
     * them, and a deleted row cannot be replayed. A skill that was never published and is
     * installed nowhere can be purged outright with {@code purge}.
     */
    @Transactional
    public void delete(String skillKey, String reason, boolean purge) {
        AuthenticatedClient actor = authContext.require();
        requireHuman(actor, "skill.delete");
        SkillRecord current = get(skillKey);
        if (reason == null || reason.isBlank()) {
            throw new IllegalArgumentException("deleting a skill has to say why");
        }

        if (purge) {
            boolean published = skills.listVersions(skillKey).stream()
                    .anyMatch(v -> v.status() == SkillRecord.Status.RELEASED
                            || v.listingStatus() == SkillRecord.ListingStatus.PUBLISHED);
            if (published) {
                throw new IllegalStateException("a skill that has been published cannot be purged; "
                        + "take it off the shelf instead");
            }
            if (!skills.installsOfSkill(skillKey).isEmpty()) {
                throw new IllegalStateException("a skill that is installed somewhere cannot be purged");
            }
            skills.deleteInstallsForSkill(skillKey);
            purgeVersions(skillKey);
            audit.record(actor, "skill.delete", "skill", current.skillId(), "allow", "PURGED",
                    "purged " + skillKey + ": " + reason,
                    AuditService.evidence("skillKey", skillKey));
            return;
        }

        if (current.listingStatus() == SkillRecord.ListingStatus.PUBLISHED
                || current.status() == SkillRecord.Status.RELEASED) {
            transition(current, SkillRecord.Status.DEPRECATED, SkillRecord.ListingStatus.UNLISTED, null,
                    actor, "skill.delete", reason);
        }
        int withdrawn = skills.deleteInstallsForSkill(current.skillKey());
        audit.record(actor, "skill.delete", "skill", current.skillId(), "allow", null,
                "removed " + skillKey + ": " + reason,
                AuditService.evidence("skillKey", skillKey, "installations", String.valueOf(withdrawn)));
    }

    // ------------------------------------------------------------------ reads

    public List<SkillRecord> list(String query, String source, String listingStatus, String status,
                                  String visibility, Integer deptId, int limit) {
        AuthenticatedClient actor = authContext.require();
        return skills.listMarket(query, source, listingStatus, status, visibility, deptId,
                deptOf(actor), actor.agentId(), limit);
    }

    public SkillRecord get(String skillKey) {
        SkillRecord skill = latest(skillKey);
        if (!maySee(authContext.require(), skill)) {
            // The market list is filtered; the detail has to be too, or the list is the only
            // thing standing between a department skill and the whole company.
            throw new NotAllowedException("skill " + skillKey + " is not visible to you");
        }
        return skill;
    }

    /**
     * Whether the caller may see this skill.
     *
     * <p>The same rule the market list applies, so that knowing a key does not get you past it.
     */
    private static boolean maySee(AuthenticatedClient actor, SkillRecord skill) {
        return switch (skill.visibility()) {
            case ORG -> true;
            case DEPT -> {
                Integer dept = skill.deptId();
                Integer actorDept = deptOf(actor);
                boolean sameDept = dept != null && dept.equals(actorDept);
                boolean director = actor.isDepartmentDirectorOf(dept);
                yield sameDept || director || actor.isSystemAdmin()
                        || (actor.isAgent() && actorDept != null && actorDept.equals(dept));
            }
            case PRIVATE -> {
                boolean own = isAuthor(actor, skill);
                yield own || actor.isSystemAdmin();
            }
        };
    }

    public List<SkillRecord> versions(String skillKey) {
        get(skillKey);
        return skills.listVersions(skillKey);
    }

    /** The newest version of a skill. */
    public SkillRecord latest(String skillKey) {
        return skills.findLatest(skillKey)
                .orElseThrow(() -> new SkillNotFound("no such skill: " + skillKey));
    }

    // ------------------------------------------------------------------ helpers

    /**
     * Builds the row for a version.
     *
     * <p>The digest is over the exact bytes that will be handed to the terminal, so the terminal
     * can check what it received against what the platform published.
     */
    private SkillRecord build(AuthenticatedClient actor, SkillCommand cmd, SkillDocument document,
                              SkillRecord.Visibility visibility, Integer deptId, int version,
                              Integer parentVersion, Instant now) {
        String content = cmd.content();
        String digest = Digests.sha256Hex(content.getBytes(StandardCharsets.UTF_8));
        List<Map<String, Object>> scripts = new ArrayList<>();
        if (cmd.scripts() != null) {
            for (ScriptContent script : cmd.scripts()) {
                if (script == null || script.name() == null || script.name().isBlank()) {
                    throw new IllegalArgumentException("a script needs a name");
                }
                if (script.name().contains("/") || script.name().contains("\\") || script.name().contains("..")) {
                    throw new IllegalArgumentException("a script name may not contain a path: " + script.name());
                }
                Map<String, Object> entry = new LinkedHashMap<>();
                entry.put("name", script.name());
                entry.put("path", "scripts/" + script.name());
                entry.put("digest", Digests.sha256Hex(
                        (script.content() == null ? "" : script.content()).getBytes(StandardCharsets.UTF_8)));
                entry.put("content", script.content() == null ? "" : script.content());
                scripts.add(entry);
            }
        }

        Map<String, Object> scope = new LinkedHashMap<>();
        scope.put("visibility", visibility.wire());
        scope.put("deptIds", deptId == null ? List.of() : List.of(deptId));
        scope.put("agentIds", agentIdOf(actor) == null ? List.of() : List.of(agentIdOf(actor)));

        Map<String, Object> definition = document.toDefinition();
        if (cmd.description() != null && !cmd.description().isBlank()) {
            definition.put("description", cmd.description().trim());
        }

        String publisher = cmd.publisher() != null && !cmd.publisher().isBlank()
                ? cmd.publisher()
                : (actor.isHuman() ? "human:" + actor.employeeId() : "agent:" + agentIdOf(actor));

        SkillRecord skill = new SkillRecord(
                Ids.newId(),
                cmd.skillKey(),
                version,
                parentVersion,
                cmd.name() != null && !cmd.name().isBlank() ? cmd.name() : document.name(),
                definition,
                sign(cmd.skillKey(), version, digest, visibility, deptId),
                actor.isAgent() ? agentIdOf(actor) : null,
                actor.isHuman() ? actor.employeeId() : null,
                null,
                SkillRecord.Status.CANDIDATE,
                0,
                scope,
                SkillRecord.Source.INTERNAL,
                null,
                null,
                publisher,
                deptId,
                SkillRecord.ListingStatus.DRAFT,
                visibility,
                content,
                digest,
                List.copyOf(scripts),
                0,
                actor.actorId(),
                now,
                now);
        return skill;
    }

    /** The signature over the facts that make a version what it is. */
    String sign(String skillKey, int version, String contentDigest, SkillRecord.Visibility visibility,
                Integer deptId) {
        String canonical = skillKey + "\n" + version + "\n" + contentDigest + "\n" + visibility.wire()
                + "\n" + (deptId == null ? "-" : deptId);
        byte[] mac = Digests.hmacSha256(signingKey, canonical.getBytes(StandardCharsets.UTF_8));
        return "hmac-sha256:" + Digests.hex(mac);
    }

    /** Checks a version's signature against the platform's own key. */
    public boolean verifySignature(SkillRecord skill) {
        String expected = sign(skill.skillKey(), skill.version(), skill.contentDigest(),
                skill.visibility(), skill.deptId());
        return Digests.constantTimeEquals(expected.getBytes(StandardCharsets.UTF_8),
                skill.signature().getBytes(StandardCharsets.UTF_8));
    }

    /**
     * One lifecycle step.
     *
     * <p>The update is conditional on the status it expected, so two reviewers clicking at the
     * same time cannot both win - the loser gets a conflict instead of a second decision.
     */
    private void transition(SkillRecord current, SkillRecord.Status to, SkillRecord.ListingStatus listing,
                            Integer rolloutPct, AuthenticatedClient actor, String op, String reason) {
        if (!isLegal(current.status(), to)) {
            audit.record(actor, op, "skill", current.skillId(), "deny", "ILLEGAL_SKILL_TRANSITION",
                    "illegal skill transition " + current.status().wire() + " -> " + to.wire(),
                    AuditService.evidence("skillKey", current.skillKey(),
                            "from", current.status().wire(), "to", to.wire()));
            throw new IllegalLifecycleException("illegal skill transition " + current.status().wire()
                    + " -> " + to.wire());
        }
        int updated = skills.updateLifecycle(current.skillId(), current.status(), to, listing, rolloutPct);
        if (updated == 0) {
            audit.record(actor, op, "skill", current.skillId(), "deny", "CONCURRENT_MODIFICATION",
                    "skill " + current.skillKey() + " changed state concurrently",
                    AuditService.evidence("skillKey", current.skillKey()));
            throw new ConcurrentModificationException("skill " + current.skillKey()
                    + " changed state concurrently");
        }
        audit.record(actor, op, "skill", current.skillId(), "allow", null, reason,
                AuditService.evidence("skillKey", current.skillKey(), "version", String.valueOf(current.version()),
                        "from", current.status().wire(), "to", to.wire(),
                        "listing", listing == null ? current.listingStatus().wire() : listing.wire()));
    }

    private static boolean isLegal(SkillRecord.Status from, SkillRecord.Status to) {
        return switch (from) {
            case CANDIDATE -> to == SkillRecord.Status.EVALUATING || to == SkillRecord.Status.DEPRECATED;
            case EVALUATING -> to == SkillRecord.Status.APPROVED || to == SkillRecord.Status.CANDIDATE
                    || to == SkillRecord.Status.DEPRECATED;
            case APPROVED -> to == SkillRecord.Status.RELEASED || to == SkillRecord.Status.CANDIDATE
                    || to == SkillRecord.Status.DEPRECATED;
            case GRAY -> to == SkillRecord.Status.RELEASED || to == SkillRecord.Status.ROLLED_BACK
                    || to == SkillRecord.Status.DEPRECATED;
            case RELEASED -> to == SkillRecord.Status.DEPRECATED || to == SkillRecord.Status.ROLLED_BACK;
            case DEPRECATED, ROLLED_BACK -> false;
        };
    }

    private void purgeVersions(String skillKey) {
        skills.listVersions(skillKey).forEach(v -> skills.deleteVersion(v.skillId()));
    }

    private static boolean isAuthor(AuthenticatedClient actor, SkillRecord skill) {
        if (actor.isHuman() && skill.authorHuman() != null) {
            return skill.authorHuman().equals(actor.employeeId());
        }
        if (actor.isAgent() && skill.authorAgent() != null) {
            return skill.authorAgent().equals(actor.agentId());
        }
        return false;
    }

    /**
     * The reviewer must not be the author.
     *
     * <p>Red-team R-02: the approver has to be the responsible person, not "anybody with a
     * console". A skill its own author approved would let an agent review itself.
     */
    private static void requireDifferentReviewer(AuthenticatedClient actor, SkillRecord skill) {
        if (skill.authorHuman() != null && skill.authorHuman().equals(actor.employeeId())) {
            throw new ReviewerIsTheAuthorException("the author of " + skill.skillKey()
                    + " may not review it: a skill reviewed by its own author is not reviewed");
        }
        if (skill.authorAgent() != null && skill.authorAgent().equals(actor.agentId())) {
            throw new ReviewerIsTheAuthorException("the author of " + skill.skillKey()
                    + " may not review it: a skill reviewed by its own author is not reviewed");
        }
    }

    private static void requireHuman(AuthenticatedClient actor, String op) {
        if (!actor.isHuman()) {
            throw new NotAHumanException(op + " requires a natural human, caller was " + actor.actorType()
                    + " (" + actor.clientId() + ")");
        }
    }

    private static Integer deptOf(AuthenticatedClient actor) {
        return actor.deptId();
    }

    /** The agent an actor speaks for, or {@code null} when it speaks for nobody. */
    private static String agentIdOf(AuthenticatedClient actor) {
        String agentId = actor.agentId();
        return agentId == null || agentId.isBlank() ? null : agentId;
    }

    /**
     * The visibility a skill is created with.
     *
     * <p>A digital employee may not create an organisation-wide skill: it pushes what it learned
     * to its own department, and a human decides whether the company should have it.
     */
    private static SkillRecord.Visibility resolveVisibility(String requested, AuthenticatedClient actor) {
        SkillRecord.Visibility visibility = requested == null || requested.isBlank()
                ? SkillRecord.Visibility.DEPT
                : SkillRecord.Visibility.fromWire(requested.trim());
        if (visibility == SkillRecord.Visibility.ORG && actor.isAgent()) {
            throw new NotAHumanException("a digital employee may not create an organisation-wide skill");
        }
        return visibility;
    }

    /** Canonical JSON of a skill's definition, for the audit evidence. */
    static String definitionJson(SkillRecord skill) {
        return Json.canonical(skill.definition());
    }

    // ------------------------------------------------------------------ failures

    public static class SkillNotFound extends RuntimeException {
        public SkillNotFound(String message) {
            super(message);
        }
    }

    public static class DuplicateSkillKeyException extends RuntimeException {
        public DuplicateSkillKeyException(String key) {
            super("skill_key already in use: " + key);
        }
    }

    public static class NotAHumanException extends RuntimeException {
        public NotAHumanException(String message) {
            super(message);
        }
    }

    public static class NotTheAuthorException extends RuntimeException {
        public NotTheAuthorException(String message) {
            super(message);
        }
    }

    public static class ReviewerIsTheAuthorException extends RuntimeException {
        public ReviewerIsTheAuthorException(String message) {
            super(message);
        }
    }

    public static class NotAllowedException extends RuntimeException {
        public NotAllowedException(String message) {
            super(message);
        }
    }

    public static class IllegalLifecycleException extends RuntimeException {
        public IllegalLifecycleException(String message) {
            super(message);
        }
    }

    public static class ConcurrentModificationException extends RuntimeException {
        public ConcurrentModificationException(String message) {
            super(message);
        }
    }
}
