package com.fuao.harness.platform.service;

import com.fuao.harness.platform.repo.AuditRepository;
import com.fuao.harness.platform.security.AuthContext;
import com.fuao.harness.platform.security.AuthenticatedClient;
import com.fuao.harness.protocol.Ids;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Single entry point for writing to the audit trail.
 *
 * <p>Every governance-relevant action goes through here so that "who did what" cannot be
 * accidentally omitted by a new endpoint, and so that denials are recorded in their own
 * transaction even when the caller's request rolls back.
 */
@Service
public class AuditService {

    private final AuditRepository audit;
    private final AuthContext authContext;

    public AuditService(AuditRepository audit, AuthContext authContext) {
        this.audit = audit;
        this.authContext = authContext;
    }

    public AuditRepository.AuditEntry record(AuthenticatedClient actor, String op, String objectType,
                                             String objectId, String outcome, String reasonCode,
                                             String reason, Map<String, Object> evidence) {
        return record(actor, Ids.newId(), op, objectType, objectId, outcome, reasonCode, reason, evidence, null);
    }

    public AuditRepository.AuditEntry record(AuthenticatedClient actor, String traceId, String op,
                                             String objectType, String objectId, String outcome,
                                             String reasonCode, String reason, Map<String, Object> evidence) {
        return record(actor, traceId, op, objectType, objectId, outcome, reasonCode, reason, evidence, null);
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public AuditRepository.AuditEntry record(AuthenticatedClient actor, String traceId, String op,
                                             String objectType, String objectId, String outcome,
                                             String reasonCode, String reason, Map<String, Object> evidence,
                                             String sourceIp) {
        return audit.append(actor, traceId, op, objectType, objectId, outcome, reasonCode, reason,
                evidence, sourceIp, Instant.now());
    }

    /** Convenience for callers that already hold the request's trace id. */
    public AuditRepository.AuditEntry recordInTrace(String traceId, String op, String objectType, String objectId,
                                                    String outcome, String reasonCode, String reason,
                                                    Map<String, Object> evidence) {
        return record(authContext.require(), traceId, op, objectType, objectId, outcome, reasonCode, reason,
                evidence, null);
    }

    public java.util.List<AuditRepository.AuditEntry> byTrace(String traceId) {
        return audit.byTrace(traceId);
    }

    public java.util.List<AuditRepository.AuditEntry> search(String objectType, String objectId, String outcome,
                                                             int limit) {
        return audit.search(objectType, objectId, outcome, limit);
    }

    /** @return the audit id of the first tampered entry, or null when the chain is intact */
    public String verifyChain() {
        return audit.verifyChain();
    }

    public static Map<String, Object> evidence(Object... keyValues) {
        Map<String, Object> m = new LinkedHashMap<>();
        for (int i = 0; i + 1 < keyValues.length; i += 2) {
            m.put(String.valueOf(keyValues[i]), keyValues[i + 1]);
        }
        return m;
    }
}