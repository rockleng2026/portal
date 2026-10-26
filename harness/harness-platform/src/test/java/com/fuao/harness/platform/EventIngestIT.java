package com.fuao.harness.platform;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.LinkedHashMap;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

/**
 * The event bus: dedup windows and the trust marking (03 §4, 04 §2.2 A0-7).
 */
class EventIngestIT extends PlatformTestBase {

    @BeforeEach
    void principals() {
        createPrincipal(SERVICE_CLIENT, SERVICE_SECRET, "service", null);
    }

    private MockHttpServletRequestBuilder ingest(Map<String, Object> payload) throws Exception {
        String body = body(payload);
        MockHttpServletRequestBuilder request = post("/api/harness/event")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body);
        signAsService("POST", "/api/harness/event", request, body);
        return request;
    }

    private Map<String, Object> alert(String businessKey) {
        String node = businessKey.split(":")[2];
        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("source", "alert");
        payload.put("eventType", "cdn.5xx.spike");
        payload.put("businessKey", businessKey);
        payload.put("latencyClass", "nearline");
        payload.put("contentTrust", "untrusted");
        payload.put("payload", Map.of("node", node, "status", 502));
        return payload;
    }

    @Test
    void aThousandIdenticalAlertsCollapseIntoOneRowWithACounter() throws Exception {
        String key = "alert:cdn:node-7:502";

        mvc.perform(ingest(alert(key)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.deduplicated").value(false));

        for (int i = 0; i < 999; i++) {
            mvc.perform(ingest(alert(key))).andExpect(status().isOk());
        }

        Integer rows = jdbc.sql("SELECT COUNT(*) FROM harness_event WHERE fingerprint = "
                        + "(SELECT fingerprint FROM harness_event ORDER BY received_at DESC LIMIT 1)")
                .query(Integer.class).single();
        Integer count = jdbc.sql("SELECT MAX(dedup_count) FROM harness_event").query(Integer.class).single();

        assertEquals(rows, 1, "1000 identical triggers must produce exactly one row (A0-7)");
        assertEquals(count, 1000, "the counter must reflect every arrival (A0-7)");
    }

    @Test
    void theSameTriggerInAnotherWindowIsNotDeduplicated() throws Exception {
        String key = "alert:cdn:node-12:502";

        mvc.perform(ingest(alert(key)))
                .andExpect(jsonPath("$.deduplicated").value(false))
                .andExpect(jsonPath("$.dedupCount").value(1));

        jdbc.sql("UPDATE harness_event SET event_window = 'an-earlier-window' "
                + "WHERE source = 'alert' AND JSON_UNQUOTE(JSON_EXTRACT(payload, '$.node')) = 'node-12'")
                .update();

        mvc.perform(ingest(alert(key)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.deduplicated").value(false));

        Integer rows = jdbc.sql("SELECT COUNT(*) FROM harness_event "
                        + "WHERE source = 'alert' AND JSON_UNQUOTE(JSON_EXTRACT(payload, '$.node')) = 'node-12'")
                .query(Integer.class).single();
        assertEquals(rows, 2, "a different window is a different event, not a duplicate");
    }

    @Test
    void eventsWithoutABusinessKeyAreRefused() throws Exception {
        Map<String, Object> payload = alert("alert:cdn:node-13:502");
        payload.remove("businessKey");

        mvc.perform(ingest(payload))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.error.message").value(
                        org.hamcrest.Matchers.containsString("businessKey")));
    }

    @Test
    void contentFromOutsideDefaultsToUntrusted() throws Exception {
        Map<String, Object> payload = alert("alert:cdn:node-9:500");
        payload.remove("contentTrust");

        mvc.perform(ingest(payload)).andExpect(status().isOk());

        String trust = jdbc.sql("SELECT content_trust FROM harness_event "
                        + "WHERE source = 'alert' ORDER BY received_at DESC LIMIT 1")
                .query(String.class).single();
        assertEquals(trust, "untrusted", "content of unknown provenance must default to untrusted (ADR-011)");
    }

    @Test
    void realtimeEventsAskForAnAcknowledgement() throws Exception {
        Map<String, Object> payload = alert("alert:cdn:node-10:503");
        payload.put("latencyClass", "realtime");

        mvc.perform(ingest(payload))
                .andExpect(jsonPath("$.acknowledgementRequired").value(true));
    }

    @Test
    void thePollingFallbackReturnsUndispatchedEvents() throws Exception {
        mvc.perform(ingest(alert("alert:cdn:node-11:504"))).andExpect(status().isOk());

        MockHttpServletRequestBuilder poll = get("/api/harness/event/poll").param("status", "new");
        signAsService("GET", "/api/harness/event/poll", poll, "");

        mvc.perform(poll)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    @Test
    void theAuditChainDetectsAnEditedRow() throws Exception {
        mvc.perform(ingest(alert("alert:chain:check"))).andExpect(status().isOk());

        MockHttpServletRequestBuilder verify = get("/api/harness/audit/verify");
        signAsService("GET", "/api/harness/audit/verify", verify, "");
        mvc.perform(verify).andExpect(status().isOk()).andExpect(jsonPath("$.intact").value(true));

        jdbc.sql("UPDATE harness_audit SET reason = 'quietly rewritten' "
                + "WHERE outcome = 'allow' ORDER BY at DESC LIMIT 1").update();

        MockHttpServletRequestBuilder verifyAgain = get("/api/harness/audit/verify");
        signAsService("GET", "/api/harness/audit/verify", verifyAgain, "");
        String intact = mvc.perform(verifyAgain)
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        if (intact.contains("\"intact\":true")) {
            throw new AssertionError("rewriting history must be detectable, even by a database administrator");
        }
    }

    private static void assertEquals(Object actual, Object expected, String message) {
        if (!String.valueOf(actual).equals(String.valueOf(expected))) {
            throw new AssertionError(message + ": expected " + expected + " but was " + actual);
        }
    }
}