package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.SkillRepository;
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
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
/**
 * The client for an upstream skill registry - the pi-web idea (search a registry, install a
 * package) applied to the company's own market.
 *
 * <p>pi-web searches {@code skills.sh} and installs a package with {@code npx skills add}. The
 * platform cannot shell out to a package manager on a server, so it speaks the registry's HTTP
 * API directly and does the one thing that matters: it puts the third-party content into the
 * market as a <em>candidate</em>. Nothing a registry serves can reach a machine without a human
 * having read it first (02 D-09: cross-organisation sharing needs explicit authorisation, a
 * signature and an isolated workspace - not automatic discovery).
 *
 * <p>Two endpoints per registry, both configured as templates:
 * <ul>
 *   <li>{@code search_url} with {@code {query}} and {@code {limit}} - answers
 *       {@code {"skills":[{"id","name","source","installs"}]}};</li>
 *   <li>{@code package_url} with {@code {package}} - answers the SKILL.md itself, as plain text
 *       or as {@code {"name","description","content","scripts":[...]}}.</li>
 * </ul>
 */
@Service
public class SkillRegistryClient {

    private static final Logger log = LoggerFactory.getLogger(SkillRegistryClient.class);

    /** A hard cap on what the platform will read from a third party. */
    private static final int MAX_BODY_BYTES = 512 * 1024;

    private static final Duration TIMEOUT = Duration.ofSeconds(20);

    private final HttpClient http;

    public SkillRegistryClient() {
        this.http = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .followRedirects(HttpClient.Redirect.NORMAL)
                .build();
    }

    /** One skill an upstream registry knows about. */
    public record RegistrySkill(String id, String name, String source, String packageRef, String url,
                                Integer installs) {
    }

    /**
     * Searches a registry.
     *
     * @return what the registry knows about the query, newest-known first
     */
    public List<RegistrySkill> search(SkillRepository.RegistryRow registry, String query, int limit) {
        if (registry.searchUrl() == null || registry.searchUrl().isBlank()) {
            throw new IllegalStateException("registry " + registry.registryKey() + " has no search url");
        }
        String url = registry.searchUrl()
                .replace("{query}", URLEncoder.encode(query, StandardCharsets.UTF_8))
                .replace("{limit}", String.valueOf(limit));
        String body = get(url, registry.registryKey());

        List<RegistrySkill> out = new ArrayList<>();
        Object parsed = com.fuao.harness.protocol.json.Json.parse(body);
        if (!(parsed instanceof Map<?, ?> map)) {
            return out;
        }
        Object skills = map.get("skills");
        if (!(skills instanceof List<?> list)) {
            return out;
        }
        for (Object item : list) {
            if (!(item instanceof Map<?, ?> entry)) {
                continue;
            }
            String name = string(entry.get("name"));
            String source = string(entry.get("source"));
            String id = string(entry.get("id"));
            if (name == null || name.isBlank() || (source == null && id == null)) {
                continue;
            }
            // The same reference pi-web builds: "<source>@<name>", falling back to the id.
            String packageRef = (source != null && !source.isBlank() ? source : id) + "@" + name;
            out.add(new RegistrySkill(id, name, source, packageRef, string(entry.get("url")),
                    entry.get("installs") instanceof Number n ? n.intValue() : null));
        }
        return out;
    }

    /**
     * Fetches a package's content.
     *
     * @return the SKILL.md text, the description and the scripts the package ships
     */
    public PulledPackage pull(SkillRepository.RegistryRow registry, String packageRef) {
        if (registry.packageUrl() == null || registry.packageUrl().isBlank()) {
            throw new IllegalStateException("registry " + registry.registryKey() + " has no package url");
        }
        String url = registry.packageUrl().replace("{package}", URLEncoder.encode(packageRef, StandardCharsets.UTF_8));
        String body = get(url, registry.registryKey());
        log.info("pulled {} from registry {}", packageRef, registry.registryKey());

        String content = body;
        String description = null;
        String name = null;
        List<SkillMarketService.ScriptContent> scripts = new ArrayList<>();

        String trimmed = body.stripLeading();
        if (trimmed.startsWith("{")) {
            Object parsed = com.fuao.harness.protocol.json.Json.parse(body);
            if (parsed instanceof Map<?, ?> map) {
                content = string(map.get("content"));
                if (content == null) {
                    content = string(map.get("skill"));
                }
                if (content == null) {
                    throw new IllegalStateException("the registry's package for " + packageRef
                            + " has no content");
                }
                description = string(map.get("description"));
                name = string(map.get("name"));
                Object rawScripts = map.get("scripts");
                if (rawScripts instanceof List<?> list) {
                    for (Object item : list) {
                        if (item instanceof Map<?, ?> script) {
                            String scriptName = string(script.get("name"));
                            String scriptBody = string(script.get("content"));
                            if (scriptName != null && !scriptName.isBlank()) {
                                scripts.add(new SkillMarketService.ScriptContent(scriptName,
                                        scriptBody == null ? "" : scriptBody));
                            }
                        }
                    }
                }
            }
        }
        return new PulledPackage(packageRef, name, description, content, List.copyOf(scripts));
    }

    /** What a registry gave us about a package. */
    public record PulledPackage(String packageRef, String name, String description, String content,
                                List<SkillMarketService.ScriptContent> scripts) {
    }

    private String get(String url, String registryKey) {
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
                .header("Accept", "application/json, text/plain")
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
            return new String(body, StandardCharsets.UTF_8);
        } catch (IOException e) {
            throw new IllegalStateException("registry " + registryKey + " did not answer: " + e.getMessage(), e);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IllegalStateException("the call to registry " + registryKey + " was interrupted", e);
        }
    }

    private static String string(Object value) {
        return value instanceof String s ? s : null;
    }

    /** The registry's view of a skill, for the console. */
    public static Map<String, Object> describe(RegistrySkill skill) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("id", skill.id());
        m.put("name", skill.name());
        m.put("source", skill.source());
        m.put("package", skill.packageRef());
        m.put("url", skill.url());
        m.put("installs", skill.installs());
        return m;
    }
}
