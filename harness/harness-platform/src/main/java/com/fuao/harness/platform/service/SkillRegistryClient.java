package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.SkillRepository;
import com.fuao.harness.protocol.Digests;
import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * The client for an upstream skill registry.
 *
 * <p>Three protocols are in the wild, and the client speaks all three - because the registry
 * row is data, not code, and the point of registering a registry is that it works:
 *
 * <ol>
 *   <li><b>Search</b> - the registry answers a query and hands back package references.
 *       skills.sh is the one pi-web uses: {@code GET /api/search?q={query}&limit={limit}}
 *       answers {@code {"skills":[{"id","source","name","installs"}]}}, and the package is
 *       fetched from {@code GET /api/download/{owner}/{repo}/{slug}}, which answers
 *       {@code {"files":[{"path","contents"}],"hash"}}.
 *
 *   <li><b>Catalog</b> - the registry publishes everything at a well-known address and the
 *       reader filters it locally. This is RFC 8615 applied to skills:
 *       {@code https://<host>/.well-known/agent-skills/index.json}. Two shapes are published:
 *       v0.2.0 ({@code name, description, type, url, digest}) and the older one
 *       ({@code name, description, files[]}), whose files live at
 *       {@code https://<host>/.well-known/agent-skills/<skill>/<path>}.
 *
 *   <li><b>Audit</b> - the registry says whether anybody has checked the skill. skills.sh
 *       publishes the verdicts of several scanners without a token. That answer is worth
 *       keeping: it lands in the skill's evaluation result, so the reviewer sees what the
 *       scanners said before they decide.
 * </ol>
 *
 * <p>Everything a registry hands out is third-party text. It is written into the market as a
 * <em>candidate</em> and cannot be installed before a human who is not its author has read it
 * (02 D-09, R-18). Nothing here grants anything.
 */
@Service
public class SkillRegistryClient {

    private static final Logger log = LoggerFactory.getLogger(SkillRegistryClient.class);

    /** A hard cap on what the platform will read from a third party. */
    private static final int MAX_BODY_BYTES = 2 * 1024 * 1024;

    private static final Duration TIMEOUT = Duration.ofSeconds(20);

    private final HttpClient http;

    public SkillRegistryClient() {
        this.http = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .followRedirects(HttpClient.Redirect.NORMAL)
                // The proxy the environment points at. Without this the client connects
                // straight out and hangs on the hosts a corporate proxy exists for.
                .proxy(EnvironmentProxySelector.fromEnvironment())
                .build();
    }

    // ------------------------------------------------------------------ the entries

    /** One skill a registry knows about. */
    public record RegistrySkill(String id, String name, String description, String source,
                                String packageRef, String url, String digest,
                                Integer installs, List<String> files) {
    }

    /** What the registry gave us about a package. */
    public record PulledPackage(String packageRef, String name, String description, String content,
                                List<SkillMarketService.ScriptContent> scripts,
                                Map<String, Object> audit) {
    }

    // ------------------------------------------------------------------ search

    /**
     * Searches a registry.
     *
     * @return what the registry knows about the query
     */
    public List<RegistrySkill> search(SkillRepository.RegistryRow registry, String query, int limit) {
        if (query == null || query.isBlank()) {
            throw new IllegalArgumentException("query is required");
        }
        List<RegistrySkill> found = "catalog".equals(registry.kind())
                ? searchCatalog(registry, query.trim(), limit)
                : searchRemote(registry, query.trim(), limit);
        log.info("registry {} returned {} skills for '{}'", registry.registryKey(), found.size(), query);
        return found;
    }

    /** A registry that answers a query. */
    private List<RegistrySkill> searchRemote(SkillRepository.RegistryRow registry, String query, int limit) {
        if (registry.searchUrl() == null || registry.searchUrl().isBlank()) {
            throw new IllegalStateException("registry " + registry.registryKey() + " has no search url");
        }
        String url = registry.searchUrl()
                .replace("{query}", URLEncoder.encode(query, StandardCharsets.UTF_8))
                .replace("{limit}", String.valueOf(limit));
        Object parsed = parseJsonOrText(get(url, registry.registryKey()));
        List<Object> entries = entriesOf(parsed);
        List<RegistrySkill> out = new ArrayList<>();
        for (Object item : entries) {
            if (!(item instanceof Map<?, ?> entry)) {
                continue;
            }
            RegistrySkill skill = toSkill(entry);
            if (skill != null) {
                out.add(skill);
            }
            if (out.size() >= limit) {
                break;
            }
        }
        return out;
    }

    /**
     * A registry that publishes a catalogue.
     *
     * <p>There is no query to send - the catalogue is the whole answer - so the filtering
     * happens here. The words of the query are matched against the name and the description,
     * and a skill whose name matches exactly always comes first: a person who typed the name
     * wants that one.
     */
    private List<RegistrySkill> searchCatalog(SkillRepository.RegistryRow registry, String query, int limit) {
        Object parsed = parseJsonOrText(get(catalogUrl(registry), registry.registryKey()));
        List<Object> entries = entriesOf(parsed);
        String needle = query.toLowerCase(Locale.ROOT);
        List<RegistrySkill> matches = new ArrayList<>();
        List<RegistrySkill> exact = new ArrayList<>();
        for (Object item : entries) {
            if (!(item instanceof Map<?, ?> entry)) {
                continue;
            }
            RegistrySkill skill = toSkill(entry);
            if (skill == null) {
                continue;
            }
            String name = skill.name() == null ? "" : skill.name().toLowerCase(Locale.ROOT);
            String description = skill.description() == null ? "" : skill.description().toLowerCase(Locale.ROOT);
            if (name.equals(needle)) {
                exact.add(skill);
            } else if (name.contains(needle) || description.contains(needle)) {
                matches.add(skill);
            }
        }
        List<RegistrySkill> out = new ArrayList<>(exact);
        for (RegistrySkill skill : matches) {
            if (out.size() >= limit) {
                break;
            }
            out.add(skill);
        }
        return out.size() > limit ? out.subList(0, limit) : out;
    }

    // ------------------------------------------------------------------ pull

    /**
     * Fetches a package's content.
     *
     * @return the SKILL.md, the files that travel with it, and the registry's security verdict
     */
    public PulledPackage pull(SkillRepository.RegistryRow registry, String packageRef) {
        if (packageRef == null || packageRef.isBlank()) {
            throw new IllegalArgumentException("package is required");
        }
        String reference = packageRef.trim();

        if ("catalog".equals(registry.kind())) {
            return pullFromCatalog(registry, reference);
        }
        if (registry.packageUrl() == null || registry.packageUrl().isBlank()) {
            throw new IllegalStateException("registry " + registry.registryKey() + " has no package url");
        }
        String url = registry.packageUrl().replace("{package}", encodePath(reference));
        Object parsed = parseJsonOrText(get(url, registry.registryKey()));
        PulledPackage pulled = toPackage(reference, parsed);
        return withAudit(registry, pulled, reference);
    }

    /**
     * Fetches a skill out of a catalogue.
     *
     * <p>The catalogue is read again to find the entry: the address of a skill's files is
     * derived from where the catalogue lives, and the newer shape carries the address of the
     * artefact itself.
     */
    private PulledPackage pullFromCatalog(SkillRepository.RegistryRow registry, String packageRef) {
        Object parsed = parseJsonOrText(get(catalogUrl(registry), registry.registryKey()));
        Map<?, ?> entry = null;
        for (Object item : entriesOf(parsed)) {
            if (!(item instanceof Map<?, ?> candidate)) {
                continue;
            }
            RegistrySkill skill = toSkill(candidate);
            if (skill == null) {
                continue;
            }
            if (packageRef.equals(skill.packageRef()) || packageRef.equals(skill.name())
                    || packageRef.equals(skill.id())) {
                entry = candidate;
                break;
            }
        }
        if (entry == null) {
            throw new IllegalStateException("the registry " + registry.registryKey()
                    + " does not publish a skill called " + packageRef);
        }

        RegistrySkill skill = toSkill(entry);
        // The newer shape carries the artefact's own address and a digest to check it against.
        String artifactUrl = skill.url();
        if (artifactUrl != null && !artifactUrl.isBlank()) {
            String absolute = resolve(catalogUrl(registry), artifactUrl);
            byte[] bytes = getBytes(absolute, registry.registryKey());
            String digest = skill.digest();
            if (digest != null && !digest.isBlank()) {
                String actual = "sha256:" + Digests.sha256Hex(bytes);
                if (!actual.equalsIgnoreCase(digest)) {
                    throw new IllegalStateException("the artefact of " + packageRef
                            + " does not match the digest the registry published (expected "
                            + digest + ", got " + actual + ")");
                }
            }
            String text = new String(bytes, StandardCharsets.UTF_8);
            PulledPackage pulled = toPackage(packageRef, text);
            return withAudit(registry, pulled, packageRef);
        }

        // The older shape: the files live next to the catalogue, under the skill's name.
        String base = catalogBase(registry);
        List<String> files = skill.files() == null ? List.of() : skill.files();
        String skillMd = base + "/" + encodePath(skill.name()) + "/SKILL.md";
        String content = new String(getBytes(skillMd, registry.registryKey()), StandardCharsets.UTF_8);

        List<SkillMarketService.ScriptContent> scripts = new ArrayList<>();
        for (String file : files) {
            if (file == null || file.equalsIgnoreCase("SKILL.md")) {
                continue;
            }
            if (file.contains("..") || file.startsWith("/") || file.contains("\\")) {
                // A path that climbs out of the skill's own directory is not a file of the
                // skill. It is an attempt to write somewhere else.
                throw new IllegalStateException("the registry " + registry.registryKey()
                        + " publishes a file with an unsafe path: " + file);
            }
            String fileUrl = base + "/" + encodePath(skill.name()) + "/" + encodePath(file);
            scripts.add(new SkillMarketService.ScriptContent(file,
                    new String(getBytes(fileUrl, registry.registryKey()), StandardCharsets.UTF_8)));
        }
        PulledPackage pulled = new PulledPackage(packageRef, skill.name(), skill.description(), content,
                List.copyOf(scripts), Map.of());
        return withAudit(registry, pulled, packageRef);
    }

    /**
     * The registry's security verdict, if it publishes one.
     *
     * <p>This is the answer to "has anybody looked at this skill?". skills.sh publishes the
     * verdicts of several scanners without a token, and it is worth keeping next to the skill
     * rather than throwing away.
     */
    private PulledPackage withAudit(SkillRepository.RegistryRow registry, PulledPackage pulled,
                                    String packageRef) {
        if (registry.auditUrl() == null || registry.auditUrl().isBlank()) {
            return pulled;
        }
        String url = registry.auditUrl().replace("{package}", encodePath(packageRef));
        try {
            Object parsed = parseJsonOrText(get(url, registry.registryKey()));
            if (parsed instanceof Map<?, ?> map) {
                return new PulledPackage(pulled.packageRef(), pulled.name(), pulled.description(),
                        pulled.content(), pulled.scripts(), toAudit(map));
            }
        } catch (RuntimeException e) {
            // No verdict is not a failed pull: the skill still has to be reviewed by a human.
            log.warn("registry {} has no verdict for {}: {}", registry.registryKey(), packageRef, e.getMessage());
        }
        return pulled;
    }

    private Map<String, Object> toAudit(Map<?, ?> map) {
        Map<String, Object> audit = new LinkedHashMap<>();
        Object audits = map.get("audits");
        if (audits instanceof List<?> list) {
            List<Map<String, Object>> verdicts = new ArrayList<>();
            for (Object item : list) {
                if (item instanceof Map<?, ?> verdict) {
                    Map<String, Object> v = new LinkedHashMap<>();
                    v.put("provider", String.valueOf(verdict.get("provider")));
                    v.put("status", String.valueOf(verdict.get("status")));
                    v.put("summary", String.valueOf(verdict.get("summary")));
                    v.put("riskLevel", String.valueOf(verdict.get("riskLevel")));
                    v.put("auditedAt", String.valueOf(verdict.get("auditedAt")));
                    verdicts.add(v);
                }
            }
            audit.put("audits", verdicts);
            // The worst verdict decides the summary: one scanner screaming is enough reason
            // for a reviewer to read it twice.
            boolean anyFail = verdicts.stream().anyMatch(v -> "fail".equals(v.get("status")));
            boolean anyWarn = verdicts.stream().anyMatch(v -> "warn".equals(v.get("status")));
            audit.put("verdict", anyFail ? "fail" : anyWarn ? "warn" : verdicts.isEmpty() ? "unknown" : "pass");
            audit.put("scanners", verdicts.size());
        }
        return audit;
    }

    // ------------------------------------------------------------------ parsing

    /** The list of entries in a registry's answer, whatever it calls the list. */
    private static List<Object> entriesOf(Object parsed) {
        if (parsed instanceof List<?> list) {
            return new ArrayList<>(list);
        }
        if (parsed instanceof Map<?, ?> map) {
            for (String key : new String[]{"skills", "data", "results", "items"}) {
                if (map.get(key) instanceof List<?> list) {
                    return new ArrayList<>(list);
                }
            }
        }
        return List.of();
    }

    /** One entry, in the shape every registry agrees on. */
    private static RegistrySkill toSkill(Map<?, ?> entry) {
        String name = string(entry.get("name"));
        String slug = string(entry.get("slug"));
        String source = string(entry.get("source"));
        String id = string(entry.get("id"));
        if (name == null || name.isBlank()) {
            name = slug;
        }
        if (name == null || name.isBlank()) {
            return null;
        }
        // The reference is the registry's own stable id when it has one - that is how the
        // documented APIs say to build the address of a single skill. Otherwise it is the
        // "<source>@<name>" form the skills CLI uses.
        String packageRef;
        if (id != null && id.contains("/")) {
            packageRef = id;
        } else if (source != null && !source.isBlank()) {
            packageRef = source + "@" + name;
        } else {
            packageRef = name;
        }
        List<String> files = new ArrayList<>();
        if (entry.get("files") instanceof List<?> list) {
            for (Object file : list) {
                if (file instanceof String s) {
                    files.add(s);
                }
            }
        }
        Integer installs = entry.get("installs") instanceof Number n ? n.intValue() : null;
        return new RegistrySkill(id, name, string(entry.get("description")), source, packageRef,
                string(entry.get("url")), string(entry.get("digest")), installs, List.copyOf(files));
    }

    /**
     * A package, in the shapes the registries use.
     *
     * <p>Plain text is the SKILL.md itself. The JSON forms carry either the text in a
     * {@code content} field or a list of files - and a list of files is what the snapshot API
     * answers, where the SKILL.md is the entry whose path is {@code SKILL.md}.
     */
    private PulledPackage toPackage(String packageRef, Object parsed) {
        if (parsed instanceof Map<?, ?> map) {
            if (map.get("files") instanceof List<?> list) {
                String content = null;
                String name = null;
                List<SkillMarketService.ScriptContent> scripts = new ArrayList<>();
                for (Object item : list) {
                    if (!(item instanceof Map<?, ?> file)) {
                        continue;
                    }
                    String path = string(file.get("path"));
                    String contents = string(file.get("contents"));
                    if (path == null || contents == null) {
                        continue;
                    }
                    if (path.equalsIgnoreCase("SKILL.md") || path.toLowerCase(Locale.ROOT).endsWith("/skill.md")) {
                        content = contents;
                        name = frontmatterName(contents);
                        continue;
                    }
                    scripts.add(new SkillMarketService.ScriptContent(path, contents));
                }
                if (content == null) {
                    throw new IllegalStateException("the package " + packageRef + " has no SKILL.md");
                }
                return new PulledPackage(packageRef, name, null, content, List.copyOf(scripts), Map.of());
            }
            String content = string(map.get("content"));
            if (content == null) {
                content = string(map.get("skill"));
            }
            if (content != null) {
                List<SkillMarketService.ScriptContent> scripts = new ArrayList<>();
                if (map.get("scripts") instanceof List<?> list) {
                    for (Object item : list) {
                        if (item instanceof Map<?, ?> script) {
                            String scriptName = string(script.get("name"));
                            if (scriptName != null && !scriptName.isBlank()) {
                                scripts.add(new SkillMarketService.ScriptContent(scriptName,
                                        stringOrEmpty(script.get("content"))));
                            }
                        }
                    }
                }
                return new PulledPackage(packageRef, frontmatterName(content),
                        string(map.get("description")), content, List.copyOf(scripts), Map.of());
            }
            throw new IllegalStateException("the package " + packageRef + " has no content");
        }
        if (parsed instanceof String text) {
            return new PulledPackage(packageRef, frontmatterName(text), null, text, List.of(), Map.of());
        }
        throw new IllegalStateException("the package " + packageRef + " is in a shape the platform cannot read");
    }

    /** The name a skill gives itself in its frontmatter. */
    private static String frontmatterName(String content) {
        if (content == null) {
            return null;
        }
        String trimmed = content.stripLeading();
        if (!trimmed.startsWith("---")) {
            return null;
        }
        String rest = trimmed.replaceFirst("^-{3,}", "");
        int end = rest.indexOf("\n---");
        if (end < 0) {
            return null;
        }
        for (String line : rest.substring(0, end).split("\n")) {
            String l = line.trim();
            if (l.startsWith("name:")) {
                String value = l.substring("name:".length()).strip();
                if (value.length() >= 2
                        && ((value.startsWith("\"") && value.endsWith("\""))
                            || (value.startsWith("'") && value.endsWith("'")))) {
                    value = value.substring(1, value.length() - 1);
                }
                return value;
            }
        }
        return null;
    }

    /** The catalogue's address. */
    private static String catalogUrl(SkillRepository.RegistryRow registry) {
        if (registry.catalogUrl() == null || registry.catalogUrl().isBlank()) {
            throw new IllegalStateException("registry " + registry.registryKey() + " has no catalog url");
        }
        return registry.catalogUrl();
    }

    /**
     * The address the catalogue's files live at.
     *
     * <p>{@code https://<host>/.well-known/agent-skills/index.json} means the files are at
     * {@code https://<host>/.well-known/agent-skills/<skill>/<path>}.
     */
    private static String catalogBase(SkillRepository.RegistryRow registry) {
        String url = catalogUrl(registry);
        int slash = url.lastIndexOf('/');
        return slash < 0 ? url : url.substring(0, slash);
    }

    /** Resolves a relative address against a base. */
    private static String resolve(String base, String reference) {
        try {
            return URI.create(base).resolve(reference).toString();
        } catch (IllegalArgumentException e) {
            return reference;
        }
    }

    /** Encodes a path, keeping the slashes that separate the segments. */
    private static String encodePath(String reference) {
        String[] parts = reference.split("/");
        List<String> encoded = new ArrayList<>();
        for (String part : parts) {
            encoded.add(URLEncoder.encode(part, StandardCharsets.UTF_8).replace("+", "%20"));
        }
        return String.join("/", encoded);
    }

    private static String string(Object value) {
        return value instanceof String s ? s : null;
    }

    private static String stringOrEmpty(Object value) {
        String s = string(value);
        return s == null ? "" : s;
    }

    // ------------------------------------------------------------------ http

    private Object parseJsonOrText(String body) {
        String trimmed = body.stripLeading();
        if (trimmed.startsWith("{") || trimmed.startsWith("[")) {
            try {
                return com.fuao.harness.protocol.json.Json.parse(body);
            } catch (RuntimeException e) {
                log.warn("the registry's answer is not JSON: {}", e.getMessage());
            }
        }
        return body;
    }

    private String get(String url, String registryKey) {
        return new String(getBytes(url, registryKey), StandardCharsets.UTF_8);
    }

    private byte[] getBytes(String url, String registryKey) {
        URI uri;
        try {
            uri = URI.create(url);
        } catch (IllegalArgumentException e) {
            throw new IllegalStateException("registry " + registryKey + " has a malformed url: " + url);
        }
        if (!"https".equalsIgnoreCase(uri.getScheme())) {
            // A registry that is reached over plain http can be rewritten on the way, and the
            // content it serves becomes a skill. Loopback is allowed so a test registry can run
            // next to the platform.
            boolean loopback = "http".equalsIgnoreCase(uri.getScheme())
                    && ("127.0.0.1".equals(uri.getHost()) || "localhost".equals(uri.getHost())
                        || "::1".equals(uri.getHost()));
            if (!loopback) {
                throw new IllegalStateException("registry " + registryKey
                        + " must be reached over https: " + url);
            }
        }

        HttpRequest request = HttpRequest.newBuilder(uri)
                .timeout(TIMEOUT)
                .header("Accept", "application/json, text/plain, text/markdown")
                .header("User-Agent", "harness-skill-market/1")
                .GET()
                .build();
        try {
            HttpResponse<byte[]> response = http.send(request, HttpResponse.BodyHandlers.ofByteArray());
            if (response.statusCode() / 100 != 2) {
                throw new IllegalStateException("registry " + registryKey + " answered HTTP "
                        + response.statusCode());
            }
            byte[] body = response.body();
            if (body.length > MAX_BODY_BYTES) {
                throw new IllegalStateException("registry " + registryKey + " sent "
                        + body.length + " bytes, more than the " + MAX_BODY_BYTES + " the platform reads");
            }
            return body;
        } catch (IOException e) {
            throw new IllegalStateException("registry " + registryKey + " did not answer: " + e.getMessage(), e);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IllegalStateException("the call to registry " + registryKey + " was interrupted", e);
        }
    }

    /** The registry's view of a skill, for the console. */
    public static Map<String, Object> describe(RegistrySkill skill) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("id", skill.id());
        m.put("name", skill.name());
        m.put("description", skill.description());
        m.put("source", skill.source());
        m.put("package", skill.packageRef());
        m.put("url", skill.url());
        m.put("installs", skill.installs());
        return m;
    }
}
