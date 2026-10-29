package com.fuao.harness.platform.web;

import com.fuao.harness.platform.domain.SkillRecord;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.platform.service.SkillInstallService;
import com.fuao.harness.platform.service.SkillMarketService;
import com.fuao.harness.platform.service.SkillRegistryClient;
import com.fuao.harness.platform.service.SkillRegistryService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * The skill market (V11).
 *
 * <p>Four doors, and they are deliberately different:
 *
 * <table>
 *   <caption>Who may do what</caption>
 *   <tr><td>browse</td><td>everybody, filtered by what the caller may see</td></tr>
 *   <tr><td>write</td><td>a natural human, or the digital employee that wrote it</td></tr>
 *   <tr><td>review and publish</td><td>a natural human who did not write it</td></tr>
 *   <tr><td>install</td><td>a natural human in the target's department, or the digital employee
 *       itself</td></tr>
 * </table>
 *
 * <p>The rules are enforced in the services, not here - a REST filter is too easy to forget when
 * a new endpoint is added.
 */
@RestController
@RequestMapping("/api/harness")
public class SkillController {

    private final SkillMarketService market;
    private final SkillRegistryService registries;
    private final SkillInstallService installs;
    private final AuthContext authContext;

    public SkillController(SkillMarketService market, SkillRegistryService registries,
                           SkillInstallService installs, AuthContext authContext) {
        this.market = market;
        this.registries = registries;
        this.installs = installs;
        this.authContext = authContext;
    }

    // ------------------------------------------------------------------ the market

    public record ScriptRequest(@NotBlank String name, String content) {
    }

    public record SkillRequest(
            @NotBlank String skillKey,
            String name,
            String description,
            @NotBlank String content,
            String visibility,
            Integer deptId,
            String publisher,
            List<ScriptRequest> scripts) {
    }

    public record ReasonRequest(@NotBlank String reason) {
    }

    /** What the market shows about a skill. */
    public record SkillView(
            String skillId,
            String skillKey,
            int version,
            Integer parentVersion,
            String name,
            String description,
            String status,
            String listingStatus,
            String visibility,
            String source,
            String sourceRef,
            String publisher,
            Integer deptId,
            String authorAgent,
            Integer authorHuman,
            String createdBy,
            int installCount,
            int rolloutPct,
            String contentDigest,
            String signature,
            Map<String, Object> definition,
            List<Map<String, Object>> scripts,
            Instant createdAt,
            Instant updatedAt) {

        static SkillView of(SkillRecord s) {
            Object description = s.definition() == null ? null : s.definition().get("description");
            return new SkillView(
                    s.skillId(), s.skillKey(), s.version(), s.parentVersion(), s.name(),
                    description instanceof String d ? d : null,
                    s.status().wire(), s.listingStatus().wire(), s.visibility().wire(),
                    s.source().wire(), s.sourceRef(), s.publisher(), s.deptId(),
                    s.authorAgent(), s.authorHuman(), s.createdBy(),
                    s.installCount(), s.rolloutPct(), s.contentDigest(), s.signature(),
                    s.definition(), s.scripts(), s.createdAt(), s.updatedAt());
        }
    }

    /** A skill with its history and its text. */
    public record SkillDetailView(SkillView skill, List<SkillView> versions, String content) {
    }

    @GetMapping("/skill")
    public List<SkillView> list(@RequestParam(required = false) String q,
                                @RequestParam(required = false) String source,
                                @RequestParam(required = false) String listingStatus,
                                @RequestParam(required = false) String status,
                                @RequestParam(required = false) String visibility,
                                @RequestParam(required = false) Integer deptId,
                                @RequestParam(defaultValue = "100") int limit) {
        return market.list(q, source, listingStatus, status, visibility, deptId, limit).stream()
                .map(SkillView::of)
                .toList();
    }

    @GetMapping("/skill/{skillKey}")
    public SkillDetailView get(@PathVariable String skillKey) {
        SkillRecord current = market.get(skillKey);
        return new SkillDetailView(
                SkillView.of(current),
                market.versions(skillKey).stream().map(SkillView::of).toList(),
                current.content());
    }

    @PostMapping("/skill")
    public SkillView create(@Valid @RequestBody SkillRequest request) {
        return SkillView.of(market.create(new SkillMarketService.SkillCommand(
                request.skillKey(), request.name(), request.description(), request.content(),
                request.visibility(), request.deptId(), request.publisher(), scripts(request))));
    }

    @PutMapping("/skill/{skillKey}")
    public SkillView update(@PathVariable String skillKey, @Valid @RequestBody SkillRequest request) {
        return SkillView.of(market.update(skillKey, new SkillMarketService.SkillCommand(
                request.skillKey() == null || request.skillKey().isBlank() ? skillKey : request.skillKey(),
                request.name(), request.description(), request.content(), request.visibility(),
                request.deptId(), request.publisher(), scripts(request))));
    }

    /**
     * Takes the skill off the shelf.
     *
     * <p>{@code purge=true} removes the versions outright, and is only allowed for a skill that
     * was never published and is installed nowhere - the audit trail points at released skills,
     * and a deleted row cannot be replayed.
     */
    @DeleteMapping("/skill/{skillKey}")
    public Map<String, Object> delete(@PathVariable String skillKey,
                                       @RequestParam(required = false) String reason,
                                       @RequestParam(defaultValue = "false") boolean purge) {
        market.delete(skillKey, reason, purge);
        return Maps.of("skillKey", skillKey, "purged", purge);
    }

    @PostMapping("/skill/{skillKey}/submit")
    public SkillView submit(@PathVariable String skillKey, @RequestBody(required = false) ReasonRequest request) {
        return SkillView.of(market.submit(skillKey, request == null ? null : request.reason()));
    }

    @PostMapping("/skill/{skillKey}/approve")
    public SkillView approve(@PathVariable String skillKey, @RequestBody(required = false) ReasonRequest request) {
        return SkillView.of(market.approve(skillKey, request == null ? null : request.reason()));
    }

    @PostMapping("/skill/{skillKey}/reject")
    public SkillView reject(@PathVariable String skillKey, @RequestBody(required = false) ReasonRequest request) {
        return SkillView.of(market.reject(skillKey, request == null ? null : request.reason()));
    }

    @PostMapping("/skill/{skillKey}/publish")
    public SkillView publish(@PathVariable String skillKey, @RequestBody(required = false) ReasonRequest request) {
        return SkillView.of(market.publish(skillKey, request == null ? null : request.reason()));
    }

    @PostMapping("/skill/{skillKey}/unlist")
    public SkillView unlist(@PathVariable String skillKey, @RequestBody(required = false) ReasonRequest request) {
        return SkillView.of(market.unlist(skillKey, request == null ? null : request.reason()));
    }

    @GetMapping("/skill/{skillKey}/versions")
    public List<SkillView> versions(@PathVariable String skillKey) {
        return market.versions(skillKey).stream().map(SkillView::of).toList();
    }

    // ------------------------------------------------------------------ upstream registries

    public record RegistryRequest(@NotBlank String registryKey, String name, @NotBlank String searchUrl,
                                  @NotBlank String packageUrl) {
    }

    public record SearchRequest(@NotBlank String registryKey, @NotBlank String query,
                                 Integer limit) {
    }

    public record PullRequest(@NotBlank String registryKey, @NotBlank String packageRef, String skillKey,
                              Integer deptId, String visibility) {
    }

    @GetMapping("/skill/registry")
    public List<Map<String, Object>> listRegistries() {
        return SkillRegistryService.describe(registries.list());
    }

    @PostMapping("/skill/registry")
    public Map<String, Object> registerRegistry(@Valid @RequestBody RegistryRequest request) {
        SkillRepositoryRegistryView view = SkillRepositoryRegistryView.of(registries.register(
                request.registryKey(), request.name(), request.searchUrl(), request.packageUrl()));
        return Maps.of("registryKey", view.registryKey(), "name", view.name(),
                "searchUrl", view.searchUrl(), "packageUrl", view.packageUrl(), "enabled", view.enabled());
    }

    /** A registry row, flattened for the console. */
    public record SkillRepositoryRegistryView(String registryKey, String name, String searchUrl,
                                              String packageUrl, boolean enabled) {

        static SkillRepositoryRegistryView of(com.fuao.harness.platform.repo.SkillRepository.RegistryRow r) {
            return new SkillRepositoryRegistryView(r.registryKey(), r.name(), r.searchUrl(), r.packageUrl(),
                    r.enabled());
        }
    }

    @PostMapping("/skill/registry/search")
    public List<Map<String, Object>> searchRegistry(@Valid @RequestBody SearchRequest request) {
        return registries.search(request.registryKey(), request.query(),
                        request.limit() == null ? 20 : request.limit()).stream()
                .map(SkillRegistryClient::describe)
                .toList();
    }

    /**
     * Pulls a package out of an upstream registry into the market.
     *
     * <p>It lands as a candidate. Nothing external is installed anywhere until a human has read
     * it.
     */
    @PostMapping("/skill/pull")
    public SkillView pull(@Valid @RequestBody PullRequest request) {
        SkillRecord.Visibility visibility = request.visibility() == null || request.visibility().isBlank()
                ? SkillRecord.Visibility.DEPT
                : SkillRecord.Visibility.fromWire(request.visibility().trim());
        return SkillView.of(registries.pull(request.registryKey(), request.packageRef(), request.skillKey(),
                request.deptId(), visibility));
    }

    // ------------------------------------------------------------------ installation

    public record InstallRequest(@NotBlank String skillKey, @NotBlank String targetType,
                                 @NotBlank String targetId, Integer version, String reason) {
    }

    public record InstallView(String installId, String skillKey, int version, String targetType,
                              String targetId, Integer deptId, String status, String installedBy,
                              String reason, Instant createdAt, Instant updatedAt) {

        static InstallView of(com.fuao.harness.platform.repo.SkillRepository.InstallRow r) {
            return new InstallView(r.installId(), r.skillKey(), r.version(), r.targetType(), r.targetId(),
                    r.deptId(), r.status(), r.installedBy(), r.reason(), r.createdAt(), r.updatedAt());
        }
    }

    @GetMapping("/skill/install")
    public List<InstallView> listInstalls(@RequestParam(required = false) String targetType,
                                          @RequestParam(required = false) String targetId,
                                          @RequestParam(required = false) Integer deptId,
                                          @RequestParam(defaultValue = "200") int limit) {
        return installs.installsOf(targetType, targetId, deptId, limit).stream()
                .map(InstallView::of)
                .toList();
    }

    @PostMapping("/skill/install")
    public InstallView install(@Valid @RequestBody InstallRequest request) {
        return InstallView.of(installs.install(request.skillKey(),
                SkillInstallService.TargetType.fromWire(request.targetType()), request.targetId(),
                request.version(), request.reason()));
    }

    @DeleteMapping("/skill/install/{installId}")
    public Map<String, Object> uninstall(@PathVariable String installId,
                                         @RequestParam(required = false) String reason) {
        installs.uninstall(installId, reason);
        return Maps.of("installId", installId, "removed", true);
    }

    // ------------------------------------------------------------------ delivery

    /**
     * The skills a terminal should have on disk.
     *
     * <p>A terminal may only ask for its own. The filter already refuses that, but the service
     * checks it again - a check that lives in one place is a check that can be tested.
     */
    @GetMapping("/terminal/{terminalId}/skills")
    public List<Map<String, Object>> terminalSkills(@PathVariable String terminalId) {
        AuthenticatedClient actor = authContext.require();
        if (actor.isTerminal() && !terminalId.equals(actor.terminalId())) {
            throw new SkillInstallService.NotAllowedException(
                    "a terminal may only fetch its own skills, caller asked for " + terminalId);
        }
        return installs.payloadFor("terminal", terminalId);
    }

    /** The skills a digital employee has installed for itself. */
    @GetMapping("/agent/{agentId}/skills")
    public List<Map<String, Object>> agentSkills(@PathVariable String agentId) {
        AuthenticatedClient actor = authContext.require();
        if (actor.isAgent() && !agentId.equals(actor.agentId())) {
            throw new SkillInstallService.NotAllowedException(
                    "a digital employee may only fetch its own skills, caller asked for " + agentId);
        }
        return installs.payloadFor("agent", agentId);
    }
    private static List<SkillMarketService.ScriptContent> scripts(SkillRequest request) {
        if (request.scripts() == null) {
            return List.of();
        }
        return request.scripts().stream()
                .map(s -> new SkillMarketService.ScriptContent(s.name(), s.content()))
                .toList();
    }
}
