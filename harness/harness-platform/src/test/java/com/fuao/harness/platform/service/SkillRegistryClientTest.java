package com.fuao.harness.platform.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fuao.harness.platform.repo.SkillRepository;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.util.List;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * The registry client speaks three protocols, and the protocols are the ones that are really
 * out there - not the ones we would have invented.
 *
 * <p>So this test runs a small HTTP server on the loopback and serves the three shapes a
 * registry can answer with:
 *
 * <ul>
 *   <li>the search shape: {@code {"skills":[...]}} (skills.sh) and {@code {"data":[...]}} (its
 *       documented v1 API);</li>
 *   <li>the snapshot shape: {@code {"files":[{"path","contents"}]}};</li>
 *   <li>the catalogue shape: RFC 8615's {@code index.json}, in both the v0.2.0 form (an
 *       artefact with a digest) and the older one (a list of files).</li>
 * </ul>
 */
class SkillRegistryClientTest {

    private HttpServer server;
    private String base;

    @BeforeEach
    void startServer() throws IOException {
        server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
        server.start();
        base = "http://127.0.0.1:" + server.getAddress().getPort();
    }

    @AfterEach
    void stopServer() {
        server.stop(0);
    }

    private void serve(String path, String body) {
        server.createContext(path, exchange -> respond(exchange, body));
    }

    private static void respond(HttpExchange exchange, String body) throws IOException {
        byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().add("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, bytes.length);
        try (OutputStream out = exchange.getResponseBody()) {
            out.write(bytes);
        }
    }

    private static String skillMd(String name) {
        return "---\nname: " + name + "\ndescription: what it is for\n---\n\n1. do the thing\n";
    }

    private SkillRepository.RegistryRow searchRegistry() {
        return new SkillRepository.RegistryRow("id", "fake", "fake", "search",
                base + "/search?q={query}&limit={limit}", base + "/download/{package}",
                null, null, true, "human:1", java.time.Instant.now(), java.time.Instant.now());
    }

    private SkillRepository.RegistryRow catalogRegistry() {
        return new SkillRepository.RegistryRow("id", "fake", "fake", "catalog",
                null, null, base + "/.well-known/agent-skills/index.json", null,
                true, "human:1", java.time.Instant.now(), java.time.Instant.now());
    }

    // ------------------------------------------------------------------ search

    @Test
    void readsTheSearchShapeSkillsShUses() {
        serve("/search", "{\"skills\":[{\"id\":\"owner/repo/release-check\",\"source\":\"owner/repo\","
                + "\"name\":\"release-check\",\"installs\":42}]}");

        List<SkillRegistryClient.RegistrySkill> found =
                new SkillRegistryClient().search(searchRegistry(), "release", 10);

        assertEquals(1, found.size());
        assertEquals("release-check", found.get(0).name());
        assertEquals(42, found.get(0).installs());
        // The stable id is the reference: it is how the documented APIs say to build the
        // address of a single skill.
        assertEquals("owner/repo/release-check", found.get(0).packageRef());
    }

    @Test
    void readsTheDataShapeTheDocumentedApiUses() {
        serve("/search", "{\"data\":[{\"id\":\"owner/repo/react-native\",\"slug\":\"react-native\","
                + "\"name\":\"React Native\",\"source\":\"owner/repo\",\"installs\":3842}],\"count\":1}");

        List<SkillRegistryClient.RegistrySkill> found =
                new SkillRegistryClient().search(searchRegistry(), "react", 10);

        assertEquals(1, found.size());
        assertEquals("React Native", found.get(0).name());
        assertEquals("owner/repo/react-native", found.get(0).packageRef());
    }

    // ------------------------------------------------------------------ pull

    @Test
    void readsTheSnapshotShape() {
        String md = skillMd("release-check");
        serve("/download/owner/repo/release-check",
                "{\"files\":[{\"path\":\"SKILL.md\",\"contents\":" + quote(md)
                        + "},{\"path\":\"scripts/check.sh\",\"contents\":\"#!/bin/sh\\n\"}],\"hash\":\"abc\"}");

        SkillRegistryClient.PulledPackage pulled =
                new SkillRegistryClient().pull(searchRegistry(), "owner/repo/release-check");

        assertEquals(md, pulled.content());
        assertEquals("release-check", pulled.name());
        assertEquals(1, pulled.scripts().size());
        // The file keeps the path the skill gave it; the name is only its last segment.
        assertEquals("scripts/check.sh", pulled.scripts().get(0).path());
        assertEquals("check.sh", pulled.scripts().get(0).name());
    }

    @Test
    void keepsTheRegistrysSecurityVerdict() {
        String md = skillMd("release-check");
        serve("/download/owner/repo/release-check",
                "{\"files\":[{\"path\":\"SKILL.md\",\"contents\":" + quote(md) + "}]}");
        serve("/audit/owner/repo/release-check",
                "{\"id\":\"owner/repo/release-check\",\"audits\":[{\"provider\":\"Socket\",\"status\":\"pass\","
                        + "\"summary\":\"No alerts\",\"riskLevel\":\"LOW\",\"auditedAt\":\"2026-04-15\"},"
                        + "{\"provider\":\"Snyk\",\"status\":\"warn\",\"summary\":\"Review recommended\","
                        + "\"riskLevel\":\"MEDIUM\"}]}");

        SkillRepository.RegistryRow registry = new SkillRepository.RegistryRow(
                "id", "fake", "fake", "search", base + "/search?q={query}&limit={limit}",
                base + "/download/{package}", null, base + "/audit/{package}",
                true, "human:1", java.time.Instant.now(), java.time.Instant.now());

        SkillRegistryClient.PulledPackage pulled =
                new SkillRegistryClient().pull(registry, "owner/repo/release-check");

        assertEquals(2, pulled.audit().get("scanners"));
        // One scanner shouting is enough reason for a reviewer to read it twice.
        assertEquals("warn", pulled.audit().get("verdict"));
    }

    // ------------------------------------------------------------------ catalogue

    @Test
    void readsACatalogueAndFiltersItLocally() {
        serve("/.well-known/agent-skills/index.json",
                "{\"skills\":[{\"name\":\"ui-taste\",\"description\":\"Give your coding agent better UI taste\","
                        + "\"files\":[\"SKILL.md\"]},"
                        + "{\"name\":\"ios-design\",\"description\":\"Design and review iOS UI/UX\","
                        + "\"files\":[\"SKILL.md\"]}]}");

        List<SkillRegistryClient.RegistrySkill> found =
                new SkillRegistryClient().search(catalogRegistry(), "ios", 10);

        assertEquals(1, found.size());
        assertEquals("ios-design", found.get(0).name());
    }

    @Test
    void pullsTheOlderCatalogueFormFileByFile() {
        serve("/.well-known/agent-skills/index.json",
                "{\"skills\":[{\"name\":\"ui-taste\",\"description\":\"better UI taste\","
                        + "\"files\":[\"SKILL.md\",\"reference/audit.md\"]}]}");
        serve("/.well-known/agent-skills/ui-taste/SKILL.md", skillMd("ui-taste"));
        serve("/.well-known/agent-skills/ui-taste/reference/audit.md", "# the audit");

        SkillRegistryClient.PulledPackage pulled =
                new SkillRegistryClient().pull(catalogRegistry(), "ui-taste");

        assertTrue(pulled.content().contains("name: ui-taste"));
        assertEquals(1, pulled.scripts().size());
        assertEquals("reference/audit.md", pulled.scripts().get(0).path());
        assertEquals("audit.md", pulled.scripts().get(0).name());
    }

    @Test
    void pullsTheNewerCatalogueFormAndChecksItsDigest() {
        String md = skillMd("deploy-to-vercel");
        String digest = "sha256:" + com.fuao.harness.protocol.Digests.sha256Hex(md);
        serve("/.well-known/agent-skills/index.json",
                "{\"$schema\":\"https://schemas.agentskills.io/discovery/0.2.0/schema.json\",\"skills\":["
                        + "{\"name\":\"deploy-to-vercel\",\"description\":\"ship it\",\"type\":\"skill-md\","
                        + "\"url\":\"" + base + "/artifacts/deploy-to-vercel.md\",\"digest\":\"" + digest + "\"}]}");
        serve("/artifacts/deploy-to-vercel.md", md);

        SkillRegistryClient.PulledPackage pulled =
                new SkillRegistryClient().pull(catalogRegistry(), "deploy-to-vercel");

        assertEquals(md, pulled.content());
    }

    @Test
    void refusesAnArtefactThatDoesNotMatchItsDigest() {
        serve("/.well-known/agent-skills/index.json",
                "{\"skills\":[{\"name\":\"deploy-to-vercel\",\"description\":\"ship it\",\"type\":\"skill-md\","
                        + "\"url\":\"" + base + "/artifacts/deploy-to-vercel.md\","
                        + "\"digest\":\"sha256:" + "0".repeat(64) + "\"}]}");
        serve("/artifacts/deploy-to-vercel.md", skillMd("deploy-to-vercel"));

        IllegalStateException failure = assertThrows(IllegalStateException.class,
                () -> new SkillRegistryClient().pull(catalogRegistry(), "deploy-to-vercel"));
        assertTrue(failure.getMessage().contains("digest"));
    }

    @Test
    void refusesACatalogueFileThatClimbsOutOfTheSkill() {
        serve("/.well-known/agent-skills/index.json",
                "{\"skills\":[{\"name\":\"evil\",\"description\":\"x\",\"files\":[\"SKILL.md\",\"../../etc/passwd\"]}]}");
        serve("/.well-known/agent-skills/evil/SKILL.md", skillMd("evil"));

        IllegalStateException failure = assertThrows(IllegalStateException.class,
                () -> new SkillRegistryClient().pull(catalogRegistry(), "evil"));
        assertTrue(failure.getMessage().contains("unsafe path"));
    }

    @Test
    void aRegistryWithoutAnAddressSaysSo() {
        SkillRepository.RegistryRow broken = new SkillRepository.RegistryRow(
                "id", "broken", "broken", "search", null, null, null, null,
                true, "human:1", java.time.Instant.now(), java.time.Instant.now());
        IllegalStateException failure = assertThrows(IllegalStateException.class,
                () -> new SkillRegistryClient().search(broken, "x", 10));
        assertNotNull(failure.getMessage());
    }

    private static String quote(String text) {
        StringBuilder sb = new StringBuilder("\"");
        for (char c : text.toCharArray()) {
            switch (c) {
                case '"' -> sb.append("\\\"");
                case '\\' -> sb.append("\\\\");
                case '\n' -> sb.append("\\n");
                case '\r' -> sb.append("\\r");
                case '\t' -> sb.append("\\t");
                default -> sb.append(c);
            }
        }
        return sb.append('"').toString();
    }

}
