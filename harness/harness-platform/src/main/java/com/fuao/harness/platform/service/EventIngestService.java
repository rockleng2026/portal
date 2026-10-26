package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.EventRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import com.fuao.harness.protocol.event.ContentTrust;
import com.fuao.harness.protocol.event.EventEnvelope;
import com.fuao.harness.protocol.event.LatencyClass;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Event ingestion (01 §8.2, 03 §4, 03 §9).
 *
 * <p>Every trigger in the system lands here first - mail, chat, an {@code @} mention, a schedule,
 * a to-do, a patrol finding, an alert, a log line, a webhook - and the router hands it to an agent
 * afterwards. Keeping ingestion free of agent logic is what makes the dedup window and the
 * "untrusted content" marking trustworthy: they cannot depend on whichever agent is involved.
 */
@Service
public class EventIngestService {

    private final EventRepository events;
    private final AuditService audit;
    private final AuthContext authContext;

    public EventIngestService(EventRepository events, AuditService audit, AuthContext authContext) {
        this.events = events;
        this.audit = audit;
        this.authContext = authContext;
    }

    public record IngestCommand(
            String source,
            String eventType,
            String businessKey,
            LatencyClass latencyClass,
            int priority,
            ContentTrust contentTrust,
            String sourceRef,
            Map<String, Object> payload) {
    }

    @Transactional
    public EventRepository.IngestResult ingest(IngestCommand cmd) {
        AuthenticatedClient actor = authContext.current() != null
                ? authContext.current()
                : AuthenticatedClient.system("event-ingest");

        if (cmd.source() == null || cmd.source().isBlank()) {
            throw new IllegalArgumentException("source is required");
        }
        if (cmd.businessKey() == null || cmd.businessKey().isBlank()) {
            throw new IllegalArgumentException("businessKey is required: without a stable business identity "
                    + "the dedup window cannot collapse redeliveries (03 §4)");
        }
        LatencyClass cls = cmd.latencyClass() == null ? LatencyClass.BATCH : cmd.latencyClass();

        EventEnvelope envelope = EventEnvelope.create(
                cmd.source(),
                cmd.eventType(),
                cmd.businessKey(),
                cls,
                cmd.priority(),
                cmd.contentTrust() == null ? ContentTrust.UNTRUSTED : cmd.contentTrust(),
                cmd.sourceRef(),
                cmd.payload() == null ? Map.of() : cmd.payload(),
                Ids.newId(),
                Instant.now());

        EventRepository.IngestResult result = events.ingest(envelope);

        // 03 §4 rule 2 and red-team R-05: a suspected injection is not dispatched as work. The
        // event is kept (the facts are still facts), it is downgraded to a report, and the
        // management state is told about it.
        if (envelope.suspectedInjection()) {
            audit.record(actor, envelope.eventId(), "event.injection_detected", "event",
                    envelope.eventId(), "deny", "SUSPECTED_INJECTION",
                    "the content looks like an instruction to the agent, not a fact: "
                            + String.join("; ", envelope.injectionReasons()),
                    Map.of("source", envelope.source(),
                            "eventType", envelope.eventType(),
                            "fingerprint", envelope.fingerprint(),
                            "contentTrust", envelope.contentTrust().name(),
                            "downgradedTo", "L0_REPORT"));
        }

        audit.record(actor, envelope.eventId(), "event.ingest", "event",
                result.deduplicated() ? envelope.fingerprint() : envelope.eventId(),
                envelope.suspectedInjection() ? "deny" : "allow",
                result.deduplicated() ? "DEDUPED" : (envelope.suspectedInjection() ? "SUSPECTED_INJECTION" : null),
                cmd.source() + "/" + cmd.eventType(),
                Map.of("fingerprint", envelope.fingerprint(),
                        "eventWindow", envelope.eventWindow(),
                        "dedupCount", String.valueOf(result.dedupCount()),
                        "latencyClass", cls.wireName(),
                        "contentTrust", envelope.contentTrust().name(),
                        "status", envelope.suspectedInjection() ? "suspected" : "new",
                        "requiresAck", String.valueOf(envelope.requiresAcknowledgement())));

        return result;
    }

    public List<EventRepository.EventRow> poll(String status, int limit) {
        return events.poll(status, limit);
    }

    public void markDispatched(String eventId, String status) {
        events.markDispatched(eventId, status);
    }

    public long backlog(String status) {
        return events.backlog(status);
    }
}