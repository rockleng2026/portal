package com.fuao.harness.platform.service;

import com.fuao.harness.platform.domain.PolicyInputs;
import com.fuao.harness.platform.domain.SkillRecord;
import com.fuao.harness.platform.repo.AgentRepository;
import com.fuao.harness.platform.repo.SkillRepository;
import com.fuao.harness.platform.repo.TerminalRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Pulling a skill out of the market and putting it on a machine (V11).
 *
 * <p>Browsing the market is free. Installing is a decision with a name on it, so it leaves a
 * trail: who put what, on which machine, and why.
 *
 * <p>Two rules hold everywhere:
 * <ul>
 *   <li><b>Only a published skill can be installed.</b> A candidate is a proposal. A skill that
 *       nobody reviewed must not reach a machine, whoever asks for it (01 §8.1.3.4).</li>
 *   <li><b>The visibility decides who may install it.</b> An organisation skill goes anywhere; a
 *       department skill goes to that department; a private skill goes to its author.</li>
 * </ul>
 *
 * <p>Installing a skill grants <em>nothing</em>. The skill is content: it tells the agent what to
 * do, and every action the agent takes still goes through the policy engine (02 R-05). The
 * capability grants of the target are untouched by this service.
 */
@Service
public class SkillInstallService {

    private final SkillRepository skills;
    private final AgentRepository agents;
    private final TerminalRepository terminals;
    private final AuditService audit;
    private final AuthContext authContext;

    public SkillInstallService(SkillRepository skills, AgentRepository agents, TerminalRepository terminals,
                               AuditService audit, AuthContext authContext) {
        this.skills = skills;
        this.agents = agents;
        this.terminals = terminals;
        this.audit = audit;
        this.authContext = authContext;
    }

    /** Where a skill is being put. */
    public enum TargetType {
        AGENT("agent"),
        TERMINAL("terminal"),
        DEPT("dept");

        private final String wire;

        TargetType(String wire) {
            this.wire = wire;
        }

        public String wire() {
            return wire;
        }

        public static TargetType fromWire(String s) {
            for (TargetType t : values()) {
                if (t.wire.equalsIgnoreCase(s)) {
                    return t;
                }
            }
            throw new IllegalArgumentException("unknown install target: " + s);
        }
    }

    /**
     * Installs a skill onto a target.
     *
     * <p>Installing an older version on purpose is allowed - that is how a rollback works
     * (04 A2-2: five minutes, and no re-download) - but the version has to be a real one.
     */
    @Transactional
    public SkillRepository.InstallRow install(String skillKey, TargetType targetType, String targetId,
                                             Integer version, String reason) {
        AuthenticatedClient actor = authContext.require();
        SkillRecord skill = version == null
                ? skills.findLatest(skillKey).orElseThrow(
                        () -> new SkillMarketService.SkillNotFound("no such skill: " + skillKey))
                : skills.findVersion(skillKey, version).orElseThrow(
                        () -> new SkillMarketService.SkillNotFound("no such skill version: "
                                + skillKey + "@v" + version));

        if (skill.status() != SkillRecord.Status.RELEASED
                || skill.listingStatus() != SkillRecord.ListingStatus.PUBLISHED) {
            audit.record(actor, "skill.install", "skill", skill.skillId(), "deny", "SKILL_NOT_PUBLISHED",
                    "skill " + skillKey + " is " + skill.status().wire() + " and cannot be installed",
                    AuditService.evidence("skillKey", skillKey, "version", String.valueOf(skill.version()),
                            "targetType", targetType.wire(), "targetId", targetId));
            throw new IllegalStateException("skill " + skillKey + " is not published: "
                    + skill.status().wire() + "/" + skill.listingStatus().wire());
        }

        Integer targetDept = deptOfTarget(targetType, targetId);
        requireMayInstall(actor, skill, targetType, targetId, targetDept);

        Instant now = Instant.now();
        SkillRepository.InstallRow existing = skills.findInstall(targetType.wire(), targetId, skillKey)
                .orElse(null);
        String status = existing == null ? "installed" : "updated";
        if (existing == null) {
            skills.insertInstall(Ids.newId(), skill.skillId(), skillKey, skill.version(),
                    targetType.wire(), targetId, targetDept, status, actor.actorId(), reason, now);
        } else {
            skills.updateInstall(existing.installId(), skill.version(), status, actor.actorId(), reason, now);
        }
        skills.incrementInstallCount(skill.skillId());

        SkillRepository.InstallRow row = skills.findInstall(targetType.wire(), targetId, skillKey).orElseThrow();
        audit.record(actor, "skill.install", "skill", skill.skillId(), "allow", null,
                reason == null ? "installed " + skillKey + " v" + skill.version() : reason,
                AuditService.evidence("skillKey", skillKey, "version", String.valueOf(skill.version()),
                        "targetType", targetType.wire(), "targetId", targetId, "installId", row.installId()));
        return row;
    }

    /** Takes a skill off a target. */
    @Transactional
    public void uninstall(String installId, String reason) {
        AuthenticatedClient actor = authContext.require();
        SkillRepository.InstallRow row = skills.findInstallById(installId)
                .orElseThrow(() -> new SkillMarketService.SkillNotFound("no such installation: " + installId));
        requireMayInstall(actor, latestOf(row), TargetType.fromWire(row.targetType()), row.targetId(),
                row.deptId());
        skills.deleteInstall(installId);
        audit.record(actor, "skill.uninstall", "skill", row.skillId(), "allow", null,
                reason == null ? "removed " + row.skillKey() : reason,
                AuditService.evidence("skillKey", row.skillKey(), "installId", installId,
                        "targetType", row.targetType(), "targetId", row.targetId()));
    }

    /** The installations of one target. */
    public List<SkillRepository.InstallRow> installsOf(String targetType, String targetId, Integer deptId,
                                                      int limit) {
        return skills.listInstalls(targetType, targetId, deptId, limit);
    }

    /**
     * What a target should have on disk.
     *
     * <p>A skill reaches a machine by three roads, and the most specific one wins: installed on
     * the terminal itself, installed for the agent the terminal speaks for, or installed for the
     * department both of them belong to. That is why a department installs a skill once and every
     * machine of that department ends up carrying it.
     *
     * <p>The payload carries the content, the digest and the signature. The terminal writes the
     * content and checks the digest; the signature is there for the record - the terminal has no
     * copy of the signing key, and giving it one would let a compromised machine mint skills.
     */
    public List<Map<String, Object>> payloadFor(String targetType, String targetId) {
        List<SkillRepository.InstallRow> rows = new ArrayList<>();
        rows.addAll(skills.listInstalls(targetType, targetId, null, 500));

        Integer deptId = null;
        String agentId = null;
        if (TargetType.TERMINAL.wire().equals(targetType)) {
            PolicyInputs.TerminalRow terminal = terminals.findById(targetId).orElse(null);
            agentId = terminal == null ? null : terminal.agentId();
        } else if (TargetType.AGENT.wire().equals(targetType)) {
            agentId = targetId;
        }
        if (agentId != null) {
            deptId = agents.lookupForPolicy(agentId)
                    .map(a -> a.deptId() == null ? null : a.deptId())
                    .orElse(null);
        }
        if (deptId == null && TargetType.DEPT.wire().equals(targetType)) {
            deptId = parseDept(targetId);
        }
        if (agentId != null) {
            rows.addAll(skills.listInstalls(TargetType.AGENT.wire(), agentId, null, 500));
        }
        if (deptId != null) {
            rows.addAll(skills.listInstalls(TargetType.DEPT.wire(), String.valueOf(deptId), null, 500));
        }

        // The most specific road wins: a skill installed on the terminal itself beats the one
        // installed for its agent, which beats the department's.
        Map<String, SkillRepository.InstallRow> chosen = new LinkedHashMap<>();
        for (SkillRepository.InstallRow row : rows) {
            if ("removed".equals(row.status()) || "failed".equals(row.status())) {
                continue;
            }
            SkillRepository.InstallRow existing = chosen.get(row.skillKey());
            if (existing == null || specificity(row.targetType()) > specificity(existing.targetType())) {
                chosen.put(row.skillKey(), row);
            }
        }

        List<Map<String, Object>> out = new ArrayList<>();
        for (SkillRepository.InstallRow row : chosen.values()) {
            SkillRecord skill = skills.findVersion(row.skillKey(), row.version()).orElse(null);
            if (skill == null) {
                continue;
            }
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("skillId", skill.skillId());
            m.put("skillKey", skill.skillKey());
            m.put("version", skill.version());
            m.put("name", skill.name());
            m.put("description", skill.definition().get("description"));
            m.put("content", skill.content());
            m.put("digest", skill.contentDigest());
            m.put("signature", skill.signature());
            m.put("scripts", skill.scripts());
            m.put("installId", row.installId());
            m.put("installedFor", row.targetType());
            out.add(m);
        }
        return out;
    }

    /** How direct a road is: the closer to the machine, the stronger. */
    private static int specificity(String targetType) {
        return switch (targetType) {
            case "terminal" -> 3;
            case "agent" -> 2;
            default -> 1;
        };
    }

    // ------------------------------------------------------------------ authorisation

    /**
     * Who may put this skill on this target.
     *
     * <p>The visibility of the skill decides the reach; the caller's identity decides whether it
     * may act for the target.
     */
    private void requireMayInstall(AuthenticatedClient actor, SkillRecord skill, TargetType targetType,
                                   String targetId, Integer targetDept) {
        // A digital employee may install for itself, and for nothing else.
        if (actor.isAgent()) {
            if (targetType != TargetType.AGENT || !targetId.equals(actor.agentId())) {
                throw new NotAllowedException("a digital employee may only install a skill for itself, caller was "
                        + actor.actorType() + " (" + actor.clientId() + ")");
            }
            if (skill.visibility() == SkillRecord.Visibility.PRIVATE
                    && !targetId.equals(skill.authorAgent())) {
                throw new NotAllowedException("a private skill belongs to its author");
            }
            if (skill.visibility() == SkillRecord.Visibility.DEPT
                    && skill.deptId() != null && targetDept != null
                    && !skill.deptId().equals(targetDept)) {
                throw new NotAllowedException("a department skill stays inside its department");
            }
            return;
        }

        if (!actor.isHuman()) {
            throw new NotAllowedException("skill.install requires a natural human or a digital employee, caller was "
                    + actor.actorType() + " (" + actor.clientId() + ")");
        }

        if (skill.visibility() == SkillRecord.Visibility.PRIVATE) {
            boolean own = skill.authorHuman() != null && skill.authorHuman().equals(actor.employeeId());
            if (!own && !actor.isSystemAdmin()) {
                throw new NotAllowedException("a private skill belongs to its author");
            }
        }
        if (skill.visibility() == SkillRecord.Visibility.DEPT && skill.deptId() != null) {
            boolean sameDept = targetDept != null && skill.deptId().equals(targetDept);
            boolean admin = actor.isSystemAdmin();
            boolean director = actor.isDepartmentDirectorOf(skill.deptId());
            if (!sameDept && !admin && !director) {
                throw new NotAllowedException("a department skill stays inside its department");
            }
        }
    }

    /** The department a target belongs to. */
    private Integer deptOfTarget(TargetType targetType, String targetId) {
        return switch (targetType) {
            case DEPT -> parseDept(targetId);
            case AGENT -> agents.lookupForPolicy(targetId)
                    .map(a -> a.deptId() == null ? null : a.deptId())
                    .orElseThrow(() -> new NotAllowedException("no such agent: " + targetId));
            case TERMINAL -> terminals.findById(targetId)
                    .map(t -> t.agentId() == null ? null
                            : agents.lookupForPolicy(t.agentId())
                                    .map(a -> a.deptId() == null ? null : a.deptId())
                                    .orElse(null))
                    .orElseThrow(() -> new NotAllowedException("no such terminal: " + targetId));
        };
    }

    private static Integer parseDept(String targetId) {
        try {
            return Integer.valueOf(targetId);
        } catch (NumberFormatException e) {
            throw new NotAllowedException("a department target is a department id, not '" + targetId + "'");
        }
    }

    private SkillRecord latestOf(SkillRepository.InstallRow row) {
        return skills.findVersion(row.skillKey(), row.version()).orElseThrow(
                () -> new SkillMarketService.SkillNotFound("no such skill: " + row.skillKey()));
    }

    /** Raised when the caller may not do what it asked for. */
    public static class NotAllowedException extends RuntimeException {
        public NotAllowedException(String message) {
            super(message);
        }
    }
}
