package com.fuao.harness.platform.web;

import com.fuao.harness.platform.repo.EventRepository;
import com.fuao.harness.platform.service.EventIngestService;
import com.fuao.harness.protocol.event.ContentTrust;
import com.fuao.harness.protocol.event.LatencyClass;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Event bus endpoints (03 §9).
 *
 * <p>{@code POST /event} is the single door every trigger uses, and it is the one endpoint where
 * a caller gets to declare how much the platform should trust its content: {@code contentTrust}
 * defaults to untrusted, because a body that arrived from a mailbox, a chat group or a web page
 * is data until proven otherwise (ADR-011).
 */
@RestController
@RequestMapping("/api/harness")
public class EventController {

    private final EventIngestService ingest;

    public EventController(EventIngestService ingest) {
        this.ingest = ingest;
    }

    public record EventRequest(
            @NotBlank String source,
            @NotBlank String eventType,
            @NotBlank String businessKey,
            String latencyClass,
            Integer priority,
            String contentTrust,
            String sourceRef,
            Map<String, Object> payload) {
    }

    public record EventResponse(String eventId, String fingerprint, String eventWindow, boolean deduplicated,
                                int dedupCount, long windowStartEpoch, boolean acknowledgementRequired) {
    }

    @PostMapping("/event")
    public EventResponse ingestEvent(@RequestBody EventRequest request) {
        LatencyClass cls = request.latencyClass() == null
                ? LatencyClass.BATCH
                : LatencyClass.fromWireName(request.latencyClass());
        ContentTrust trust = request.contentTrust() == null
                ? ContentTrust.UNTRUSTED
                : ContentTrust.valueOf(request.contentTrust().toUpperCase(Locale.ROOT));

        EventIngestService.IngestCommand command = new EventIngestService.IngestCommand(
                request.source(), request.eventType(), request.businessKey(), cls,
                request.priority() == null ? 5 : request.priority(), trust, request.sourceRef(), request.payload());
        EventRepository.IngestResult result = ingest.ingest(command);

        return new EventResponse(result.eventId(), result.fingerprint(), result.eventWindow(),
                result.deduplicated(), result.dedupCount(), result.windowStartEpoch(), cls.requiresAck());
    }

    @GetMapping("/event/poll")
    public List<Map<String, Object>> poll(@RequestParam(defaultValue = "new") String status,
                                          @RequestParam(defaultValue = "50") int limit) {
        return ingest.poll(status, limit).stream()
                .map(e -> Maps.of(
                        "eventId", e.eventId(),
                        "source", e.source(),
                        "eventType", e.eventType(),
                        "latencyClass", e.latencyClass(),
                        "priority", e.priority(),
                        "contentTrust", e.contentTrust(),
                        "sourceRef", e.sourceRef() == null ? "" : e.sourceRef(),
                        "dedupCount", e.dedupCount(),
                        "status", e.status(),
                        "receivedAt", e.receivedAt().toString(),
                        "payload", e.payload()))
                .toList();
    }
}