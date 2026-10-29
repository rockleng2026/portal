package com.fuao.harness.platform;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

/**
 * The skill market (V11).
 *
 * <p>The market has one job and one danger. The job: let a department person or a digital
 * employee find a skill and put it on a machine. The danger: a skill that nobody looked at
 * reaching every machine in the company - "one agent's wrong best practice becomes everybody's
 * best practice" (02 §0).
 *
 * <p>So the tests below spend most of their time on the danger.
 */
class SkillMarketIT extends PlatformTestBase {

    private static final String OTHER_HUMAN_CLIENT = "harness-test-reviewer";
    private static final String OTHER_HUMAN_SECRET = "reviewer-secret-0123456789-abcd";
    private static final int OTHER_HUMAN_EMPLOYEE_ID = 9002;
    /** A plain employee of another department: no admin rights, so no way around the scope. */
    private static final String OUTSIDER_CLIENT = "harness-test-outsider";
    private static final String OUTSIDER_SECRET = "outsider-secret-0123456789-abc";
    private static final String AGENT_CLIENT = "harness-test-agent";
    private static final String AGENT_SECRET = "agent-secret-0123456789-abcdef";
    private static final int DEPT_ID = 42;
    private static final int OTHER_DEPT_ID = 77;

    private HttpServer registry;

    @BeforeEach
    void principals() throws Exception {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
        createPrincipal(HUMAN_CLIENT, HUMAN_SECRET, "human", HUMAN_EMPLOYEE_ID, "system_admin", DEPT_ID);
        createPrincipal(OTHER_HUMAN_CLIENT, OTHER_HUMAN_SECRET, "human", OTHER_HUMAN_EMPLOYEE_ID,
                "system_admin", OTHER_DEPT_ID);
        createPrincipal(OUTSIDER_CLIENT, OUTSIDER_SECRET, "human", OTHER_HUMAN_EMPLOYEE_ID + 1,
                "employee", OTHER_DEPT_ID);
    }

    @AfterEach
    void stopRegistry() {
        if (registry != null) {
            registry.stop(0);
            registry = null;
        }
    }

    // ------------------------------------------------------------------ the happy path

    @Test
    void aSkillIsWrittenReviewedPublishedAndInstalled() throws Exception {
        String key = "release-check-" + UUID.randomUUID().toString().substring(0, 8);

        // Somebody writes it. It is a candidate: nothing may install it yet.
        String payload = body(Map.of(
                "skillKey", key,
                "description", "how to cut a release",
                "content", skillDocument("release-check", "how to cut a release")));
        MockHttpServletRequestBuilder create = post("/api/harness/skill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsHuman("POST", "/api/harness/skill", create, payload);
        mvc.perform(create)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("candidate"))
                .andExpect(jsonPath("$.listingStatus").value("draft"))
                .andExpect(jsonPath("$.version").value(1))
                .andExpect(jsonPath("$.contentDigest").isNotEmpty());

        // It cannot be installed while it is a candidate.
        String early = body(Map.of("skillKey", key, "targetType", "dept",
                "targetId", String.valueOf(DEPT_ID)));
        MockHttpServletRequestBuilder earlyInstall = post("/api/harness/skill/install")
                .contentType(MediaType.APPLICATION_JSON)
                .content(early);
        signAsHuman("POST", "/api/harness/skill/install", earlyInstall, early);
        mvc.perform(earlyInstall).andExpect(status().isBadRequest());

        // The author hands it over for review.
        String reason = body(Map.of("reason", "ready for review"));
        MockHttpServletRequestBuilder submit = post("/api/harness/skill/" + key + "/submit")
                .contentType(MediaType.APPLICATION_JSON)
                .content(reason);
        signAsHuman("POST", "/api/harness/skill/" + key + "/submit", submit, reason);
        mvc.perform(submit).andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("evaluating"));

        // The author may not review it. A skill reviewed by its own author is not reviewed.
        String selfReason = body(Map.of("reason", "looks fine to me"));
        MockHttpServletRequestBuilder selfApprove = post("/api/harness/skill/" + key + "/approve")
                .contentType(MediaType.APPLICATION_JSON)
                .content(selfReason);
        signAsHuman("POST", "/api/harness/skill/" + key + "/approve", selfApprove, selfReason);
        mvc.perform(selfApprove).andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("REVIEWER_IS_THE_AUTHOR"));

        // Somebody else reviews it.
        String approveReason = body(Map.of("reason", "read it, it is fine"));
        MockHttpServletRequestBuilder approve = post("/api/harness/skill/" + key + "/approve")
                .contentType(MediaType.APPLICATION_JSON)
                .content(approveReason);
        signAs(OTHER_HUMAN_CLIENT, OTHER_HUMAN_SECRET, "POST", "/api/harness/skill/" + key + "/approve",
                approve, approveReason);
        mvc.perform(approve).andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("approved"));

        // Publishing puts it on the shelf.
        String publishReason = body(Map.of("reason", "the sales department wants it"));
        MockHttpServletRequestBuilder publish = post("/api/harness/skill/" + key + "/publish")
                .contentType(MediaType.APPLICATION_JSON)
                .content(publishReason);
        signAsHuman("POST", "/api/harness/skill/" + key + "/publish", publish, publishReason);
        mvc.perform(publish).andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("released"))
                .andExpect(jsonPath("$.listingStatus").value("published"));

        // Now it can be installed.
        String install = body(Map.of(
                "skillKey", key,
                "targetType", "dept",
                "targetId", String.valueOf(DEPT_ID),
                "reason", "the release checklist"));
        MockHttpServletRequestBuilder installRequest = post("/api/harness/skill/install")
                .contentType(MediaType.APPLICATION_JSON)
                .content(install);
        signAsHuman("POST", "/api/harness/skill/install", installRequest, install);
        mvc.perform(installRequest).andExpect(status().isOk())
                .andExpect(jsonPath("$.skillKey").value(key))
                .andExpect(jsonPath("$.version").value(1));

        // And the market shows it.
        MockHttpServletRequestBuilder list = get("/api/harness/skill");
        signAsHuman("GET", "/api/harness/skill", list, "");
        String listed = mvc.perform(list).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        assertTrue(listed.contains(key), "a published skill must be visible in the market");
    }

    // ------------------------------------------------------------------ who may write

    @Test
    void aServiceAccountCannotWriteASkill() throws Exception {
        String payload = body(Map.of(
                "skillKey", "svc-skill-" + UUID.randomUUID().toString().substring(0, 8),
                "content", skillDocument("svc", "a service account wrote this")));
        MockHttpServletRequestBuilder request = post("/api/harness/skill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsService("POST", "/api/harness/skill", request, payload);
        mvc.perform(request).andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"));
    }

    @Test
    void aDigitalEmployeeMayPushItsOwnSkillButNotForTheWholeCompany() throws Exception {
        String agentId = seedAgent("agent:skill:" + UUID.randomUUID().toString().substring(0, 8),
                AGENT_OWNER_EMPLOYEE_ID, DEPT_ID, 0);
        createAgentPrincipal(AGENT_CLIENT, AGENT_SECRET, agentId, DEPT_ID);

        // Its own department: fine.
        String deptPayload = body(Map.of(
                "skillKey", "agent-skill-" + UUID.randomUUID().toString().substring(0, 8),
                "visibility", "dept",
                "content", skillDocument("agent-skill", "what the agent learned")));
        MockHttpServletRequestBuilder deptSkill = post("/api/harness/skill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(deptPayload);
        signAs(AGENT_CLIENT, AGENT_SECRET, "POST", "/api/harness/skill", deptSkill, deptPayload);
        mvc.perform(deptSkill).andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("candidate"))
                .andExpect(jsonPath("$.authorAgent").value(agentId));

        // The whole company: not its call.
        String orgPayload = body(Map.of(
                "skillKey", "agent-org-" + UUID.randomUUID().toString().substring(0, 8),
                "visibility", "org",
                "content", skillDocument("agent-org", "for everybody")));
        MockHttpServletRequestBuilder orgSkill = post("/api/harness/skill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(orgPayload);
        signAs(AGENT_CLIENT, AGENT_SECRET, "POST", "/api/harness/skill", orgSkill, orgPayload);
        mvc.perform(orgSkill).andExpect(status().isForbidden());
    }

    @Test
    void aDigitalEmployeeMayNotReviewItsOwnSkill() throws Exception {
        String agentId = seedAgent("agent:review:" + UUID.randomUUID().toString().substring(0, 8),
                AGENT_OWNER_EMPLOYEE_ID, DEPT_ID, 0);
        createAgentPrincipal(AGENT_CLIENT, AGENT_SECRET, agentId, DEPT_ID);
        String key = "agent-review-" + UUID.randomUUID().toString().substring(0, 8);

        String payload = body(Map.of("skillKey", key,
                "content", skillDocument("agent-review", "the agent wrote this")));
        MockHttpServletRequestBuilder create = post("/api/harness/skill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAs(AGENT_CLIENT, AGENT_SECRET, "POST", "/api/harness/skill", create, payload);
        mvc.perform(create).andExpect(status().isOk());

        // A machine cannot approve anything at all.
        String reason = body(Map.of("reason", "trust me"));
        MockHttpServletRequestBuilder approve = post("/api/harness/skill/" + key + "/approve")
                .contentType(MediaType.APPLICATION_JSON)
                .content(reason);
        signAs(AGENT_CLIENT, AGENT_SECRET, "POST", "/api/harness/skill/" + key + "/approve", approve, reason);
        mvc.perform(approve).andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"));
    }

    // ------------------------------------------------------------------ versions

    @Test
    void editingASkillMakesANewVersionAndKeepsTheOld() throws Exception {
        String key = "versioned-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "first version");

        String payload = body(Map.of(
                "skillKey", key,
                "content", skillDocument("versioned", "second version")));
        MockHttpServletRequestBuilder update = put("/api/harness/skill/" + key)
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsHuman("PUT", "/api/harness/skill/" + key, update, payload);
        mvc.perform(update).andExpect(status().isOk())
                .andExpect(jsonPath("$.version").value(2))
                .andExpect(jsonPath("$.parentVersion").value(1));

        MockHttpServletRequestBuilder versions = get("/api/harness/skill/" + key + "/versions");
        signAsHuman("GET", "/api/harness/skill/" + key + "/versions", versions, "");
        mvc.perform(versions).andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2));
    }

    // ------------------------------------------------------------------ the frontier

    @Test
    void aDepartmentSkillIsInvisibleToAnotherDepartment() throws Exception {
        String key = "dept-only-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "the sales department's own procedure");

        MockHttpServletRequestBuilder otherDept = get("/api/harness/skill");
        signAs(OTHER_HUMAN_CLIENT, OTHER_HUMAN_SECRET, "GET", "/api/harness/skill", otherDept, "");
        String listed = mvc.perform(otherDept).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        assertFalse(listed.contains(key),
                "a department skill must not show up in another department's market");

        MockHttpServletRequestBuilder ownDept = get("/api/harness/skill");
        signAsHuman("GET", "/api/harness/skill", ownDept, "");
        String mine = mvc.perform(ownDept).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        assertTrue(mine.contains(key),
                "a department skill must show up in its own department's market");
    }

    @Test
    void knowingTheKeyDoesNotGetYouPastTheVisibility() throws Exception {
        String key = "hidden-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "the sales department's own procedure");

        // The list is filtered - and so is the detail. Otherwise the list would be the only
        // thing standing between a department skill and the whole company.
        MockHttpServletRequestBuilder detail = get("/api/harness/skill/" + key);
        signAs(OUTSIDER_CLIENT, OUTSIDER_SECRET, "GET", "/api/harness/skill/" + key, detail, "");
        mvc.perform(detail).andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("SKILL_NOT_ALLOWED"));

        MockHttpServletRequestBuilder ownDetail = get("/api/harness/skill/" + key);
        signAsHuman("GET", "/api/harness/skill/" + key, ownDetail, "");
        mvc.perform(ownDetail).andExpect(status().isOk())
                .andExpect(jsonPath("$.content").isNotEmpty());
    }

    @Test
    void aSkillWithoutFrontmatterIsRefused() throws Exception {
        String payload = body(Map.of(
                "skillKey", "broken-" + UUID.randomUUID().toString().substring(0, 8),
                "content", "no frontmatter here, the terminal would not load this"));
        MockHttpServletRequestBuilder request = post("/api/harness/skill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsHuman("POST", "/api/harness/skill", request, payload);
        mvc.perform(request).andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.error.code").value("MALFORMED_SKILL"));
    }

    // ------------------------------------------------------------------ the external market

    @Test
    void aSkillPulledFromARegistryLandsAsACandidateThatNobodyMayInstall() throws Exception {
        int port = startRegistry();
        String registryKey = "fake-" + UUID.randomUUID().toString().substring(0, 8);

        String register = body(Map.of(
                "registryKey", registryKey,
                "name", "the upstream registry",
                "searchUrl", "http://127.0.0.1:" + port + "/search?q={query}&limit={limit}",
                "packageUrl", "http://127.0.0.1:" + port + "/package?p={package}"));
        MockHttpServletRequestBuilder registerRequest = post("/api/harness/skill/registry")
                .contentType(MediaType.APPLICATION_JSON)
                .content(register);
        signAsHuman("POST", "/api/harness/skill/registry", registerRequest, register);
        mvc.perform(registerRequest).andExpect(status().isOk());

        // Searching shows what the registry knows about.
        String search = body(Map.of("registryKey", registryKey, "query", "release"));
        MockHttpServletRequestBuilder searchRequest = post("/api/harness/skill/registry/search")
                .contentType(MediaType.APPLICATION_JSON)
                .content(search);
        signAsHuman("POST", "/api/harness/skill/registry/search", searchRequest, search);
        String found = mvc.perform(searchRequest).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        assertTrue(found.contains("owner/repo@release-check"),
                "the registry search must return the package reference: " + found);

        // Pulling it in puts it in the market - as a candidate.
        String pull = body(Map.of(
                "registryKey", registryKey,
                "packageRef", "owner/repo@release-check",
                "deptId", DEPT_ID));
        MockHttpServletRequestBuilder pullRequest = post("/api/harness/skill/pull")
                .contentType(MediaType.APPLICATION_JSON)
                .content(pull);
        signAsHuman("POST", "/api/harness/skill/pull", pullRequest, pull);
        mvc.perform(pullRequest).andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("candidate"))
                .andExpect(jsonPath("$.listingStatus").value("draft"))
                .andExpect(jsonPath("$.source").value("external"))
                .andExpect(jsonPath("$.sourceRef").value("owner/repo@release-check"));

        String install = body(Map.of("skillKey", "ext-owner-repo-release-check", "targetType", "dept",
                "targetId", String.valueOf(DEPT_ID)));
        MockHttpServletRequestBuilder installRequest = post("/api/harness/skill/install")
                .contentType(MediaType.APPLICATION_JSON)
                .content(install);
        signAsHuman("POST", "/api/harness/skill/install", installRequest, install);
        mvc.perform(installRequest).andExpect(status().isBadRequest());
    }

    @Test
    void pullingFromARegistryNeedsAHuman() throws Exception {
        String pull = body(Map.of("registryKey", "svc-registry",
                "packageRef", "owner/repo@release-check"));
        MockHttpServletRequestBuilder request = post("/api/harness/skill/pull")
                .contentType(MediaType.APPLICATION_JSON)
                .content(pull);
        signAsService("POST", "/api/harness/skill/pull", request, pull);
        mvc.perform(request).andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error.code").value("HUMAN_REQUIRED"));
    }

    // ------------------------------------------------------------------ deployment

    @Test
    void aTerminalFetchesTheSkillsItsDepartmentInstalled() throws Exception {
        String key = "terminal-skill-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "the procedure the terminal runs");
        publishAsOtherHuman(key);

        String terminalId = registerTerminal();
        String install = body(Map.of("skillKey", key, "targetType", "dept",
                "targetId", String.valueOf(DEPT_ID)));
        MockHttpServletRequestBuilder installRequest = post("/api/harness/skill/install")
                .contentType(MediaType.APPLICATION_JSON)
                .content(install);
        signAsHuman("POST", "/api/harness/skill/install", installRequest, install);
        mvc.perform(installRequest).andExpect(status().isOk());

        MockHttpServletRequestBuilder fetch = get("/api/harness/terminal/" + terminalId + "/skills");
        signAsHuman("GET", "/api/harness/terminal/" + terminalId + "/skills", fetch, "");
        String payload = mvc.perform(fetch).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        assertTrue(payload.contains("\"digest\""),
                "the terminal needs the digest to check what it received: " + payload);
        assertTrue(payload.contains("release-check"),
                "the terminal must receive the skill's content: " + payload);
    }

    @Test
    void aDigitalEmployeeMayOnlyInstallForItself() throws Exception {
        String agentId = seedAgent("agent:install:" + UUID.randomUUID().toString().substring(0, 8),
                AGENT_OWNER_EMPLOYEE_ID, DEPT_ID, 0);
        String otherAgentId = seedAgent("agent:other:" + UUID.randomUUID().toString().substring(0, 8),
                AGENT_OWNER_EMPLOYEE_ID, DEPT_ID, 0);
        createAgentPrincipal(AGENT_CLIENT, AGENT_SECRET, agentId, DEPT_ID);

        String key = "agent-install-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "a procedure everybody may use");
        publishAsOtherHuman(key);

        String other = body(Map.of("skillKey", key, "targetType", "agent", "targetId", otherAgentId));
        MockHttpServletRequestBuilder otherRequest = post("/api/harness/skill/install")
                .contentType(MediaType.APPLICATION_JSON)
                .content(other);
        signAs(AGENT_CLIENT, AGENT_SECRET, "POST", "/api/harness/skill/install", otherRequest, other);
        mvc.perform(otherRequest).andExpect(status().isForbidden());

        String self = body(Map.of("skillKey", key, "targetType", "agent", "targetId", agentId));
        MockHttpServletRequestBuilder selfRequest = post("/api/harness/skill/install")
                .contentType(MediaType.APPLICATION_JSON)
                .content(self);
        signAs(AGENT_CLIENT, AGENT_SECRET, "POST", "/api/harness/skill/install", selfRequest, self);
        mvc.perform(selfRequest).andExpect(status().isOk());
    }

    @Test
    void takingASkillOffTheShelfWithdrawsItsInstallations() throws Exception {
        String key = "withdrawn-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "a procedure that turns out to be wrong");
        publishAsOtherHuman(key);

        String install = body(Map.of("skillKey", key, "targetType", "dept",
                "targetId", String.valueOf(DEPT_ID)));
        MockHttpServletRequestBuilder installRequest = post("/api/harness/skill/install")
                .contentType(MediaType.APPLICATION_JSON)
                .content(install);
        signAsHuman("POST", "/api/harness/skill/install", installRequest, install);
        mvc.perform(installRequest).andExpect(status().isOk());

        String reason = body(Map.of("reason", "it was wrong and we found out"));
        MockHttpServletRequestBuilder unlist = post("/api/harness/skill/" + key + "/unlist")
                .contentType(MediaType.APPLICATION_JSON)
                .content(reason);
        signAsHuman("POST", "/api/harness/skill/" + key + "/unlist", unlist, reason);
        mvc.perform(unlist).andExpect(status().isOk())
                .andExpect(jsonPath("$.listingStatus").value("unlisted"))
                .andExpect(jsonPath("$.status").value("deprecated"));

        Integer left = jdbc.sql("SELECT COUNT(*) FROM harness_skill_install WHERE skill_key = :key")
                .param("key", key).query(Integer.class).single();
        assertEquals(0, left, "a skill that left the shelf must not stay installed");

        // The versions stay, so a rollback is still possible.
        Integer versions = jdbc.sql("SELECT COUNT(*) FROM harness_skill WHERE skill_key = :key")
                .param("key", key).query(Integer.class).single();
        assertEquals(1, versions, "the versions must survive a withdrawal");
    }

    @Test
    void deletingASkillThatWasPublishedOnlyTakesItOffTheShelf() throws Exception {
        String key = "deleted-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "a procedure");
        publishAsOtherHuman(key);

        MockHttpServletRequestBuilder purge = delete("/api/harness/skill/" + key)
                .param("reason", "it is no longer needed")
                .param("purge", "true");
        signAsHuman("DELETE", "/api/harness/skill/" + key, purge, "");
        mvc.perform(purge).andExpect(status().isBadRequest());

        MockHttpServletRequestBuilder soft = delete("/api/harness/skill/" + key)
                .param("reason", "it is no longer needed");
        signAsHuman("DELETE", "/api/harness/skill/" + key, soft, "");
        mvc.perform(soft).andExpect(status().isOk());
    }

    // ------------------------------------------------------------------ the trail

    @Test
    void everyMarketActionLeavesATrail() throws Exception {
        String key = "audited-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "a procedure");
        publishAsOtherHuman(key);

        List<String> ops = jdbc.sql("SELECT DISTINCT op FROM harness_audit WHERE object_type = 'skill' "
                        + "AND JSON_EXTRACT(evidence, '$.skillKey') = :key")
                .param("key", key).query(String.class).list();
        assertTrue(ops.contains("skill.create"), "the market actions must be auditable, found: " + ops);
        assertTrue(ops.contains("skill.publish"), "the market actions must be auditable, found: " + ops);
    }

    @Test
    void aPublishedSkillCarriesThePlatformsSignature() throws Exception {
        String key = "signed-" + UUID.randomUUID().toString().substring(0, 8);
        createAsHuman(key, "a procedure");

        String signature = jdbc.sql("SELECT signature FROM harness_skill WHERE skill_key = :key")
                .param("key", key).query(String.class).single();
        assertTrue(signature.startsWith("hmac-sha256:"),
                "a skill must carry the platform's signature, found: " + signature);

        // And the signature must be the one the platform would compute itself: a row whose
        // signature does not check out is a row somebody changed.
        com.fuao.harness.platform.repo.SkillRepository repository =
                applicationContext.getBean(com.fuao.harness.platform.repo.SkillRepository.class);
        com.fuao.harness.platform.domain.SkillRecord skill = repository.findLatest(key).orElseThrow();
        com.fuao.harness.platform.service.SkillMarketService market =
                applicationContext.getBean(com.fuao.harness.platform.service.SkillMarketService.class);
        assertTrue(market.verifySignature(skill), "the platform must recognise its own signature");
    }

    // ------------------------------------------------------------------ helpers

    private void createAsHuman(String key, String description) throws Exception {
        String payload = body(Map.of(
                "skillKey", key,
                "description", description,
                "content", skillDocument("release-check", description)));
        MockHttpServletRequestBuilder request = post("/api/harness/skill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(payload);
        signAsHuman("POST", "/api/harness/skill", request, payload);
        mvc.perform(request).andExpect(status().isOk());
    }

    private void publishAsOtherHuman(String key) throws Exception {
        String submit = body(Map.of("reason", "ready"));
        MockHttpServletRequestBuilder submitRequest = post("/api/harness/skill/" + key + "/submit")
                .contentType(MediaType.APPLICATION_JSON)
                .content(submit);
        signAsHuman("POST", "/api/harness/skill/" + key + "/submit", submitRequest, submit);
        mvc.perform(submitRequest).andExpect(status().isOk());

        String approve = body(Map.of("reason", "read it"));
        MockHttpServletRequestBuilder approveRequest = post("/api/harness/skill/" + key + "/approve")
                .contentType(MediaType.APPLICATION_JSON)
                .content(approve);
        signAs(OTHER_HUMAN_CLIENT, OTHER_HUMAN_SECRET, "POST", "/api/harness/skill/" + key + "/approve",
                approveRequest, approve);
        mvc.perform(approveRequest).andExpect(status().isOk());

        String publish = body(Map.of("reason", "the department wants it"));
        MockHttpServletRequestBuilder publishRequest = post("/api/harness/skill/" + key + "/publish")
                .contentType(MediaType.APPLICATION_JSON)
                .content(publish);
        signAsHuman("POST", "/api/harness/skill/" + key + "/publish", publishRequest, publish);
        mvc.perform(publishRequest).andExpect(status().isOk());
    }

    /**
     * A terminal, bound to a digital employee of the department.
     *
     * <p>The binding is what makes the department's skills reach the machine: a terminal belongs
     * to the department of the agent it speaks for.
     */
    private String registerTerminal() throws Exception {
        String agentKey = "agent:skills:" + UUID.randomUUID().toString().substring(0, 8);
        seedAgent(agentKey, AGENT_OWNER_EMPLOYEE_ID, DEPT_ID, 0);

        String hello = body(Map.of("deviceId", "device-skill-" + UUID.randomUUID(),
                "os", "linux", "agentVersion", "0.1.0"));
        MockHttpServletRequestBuilder request = post("/api/harness/terminal/hello")
                .contentType(MediaType.APPLICATION_JSON)
                .content(hello);
        signAsService("POST", "/api/harness/terminal/hello", request, hello);
        String response = mvc.perform(request).andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        Map<String, Object> parsed = parse(response);
        String terminalId = String.valueOf(parsed.get("terminalId"));
        String bindingCode = String.valueOf(parsed.get("bindingCode"));

        String bind = body(Map.of("bindingCode", bindingCode, "agentKey", agentKey));
        MockHttpServletRequestBuilder bindRequest = post("/api/harness/terminal/bind")
                .contentType(MediaType.APPLICATION_JSON)
                .content(bind);
        signAsHuman("POST", "/api/harness/terminal/bind", bindRequest, bind);
        mvc.perform(bindRequest).andExpect(status().isOk());
        return terminalId;
    }

    /** A SKILL.md the terminal would load. */
    private static String skillDocument(String name, String description) {
        return "---\n"
                + "name: " + name + "\n"
                + "description: " + description + "\n"
                + "tools: exec\n"
                + "---\n"
                + "\n"
                + "# " + name + "\n"
                + "\n"
                + "1. run the tests\n"
                + "2. check the changelog\n";
    }

    /**
     * A stand-in for an upstream registry.
     *
     * <p>It answers the two calls the platform makes, in the shape pi-web's registry answers in.
     */
    private int startRegistry() throws IOException {
        registry = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
        registry.createContext("/search", exchange -> {
            String answer = "{\"skills\":[{\"id\":\"release-check\",\"name\":\"release-check\","
                    + "\"source\":\"owner/repo\",\"installs\":42}]}";
            respond(exchange, answer);
        });
        registry.createContext("/package", exchange -> {
            String answer = "{\"name\":\"release-check\",\"description\":\"how to cut a release\","
                    + "\"content\":\"" + skillDocument("release-check", "how to cut a release")
                            .replace("\n", "\\n") + "\"}";
            respond(exchange, answer);
        });
        registry.start();
        return registry.getAddress().getPort();
    }

    private static void respond(HttpExchange exchange, String answer) throws IOException {
        byte[] bytes = answer.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().add("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, bytes.length);
        try (OutputStream out = exchange.getResponseBody()) {
            out.write(bytes);
        }
    }
}
