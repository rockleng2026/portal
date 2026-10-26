package com.fuao.harness.policy;

import com.fuao.harness.protocol.event.ContentTrust;
import java.util.List;
import java.util.Set;

/**
 * Everything the policy engine needs to decide one capability call, and nothing else.
 *
 * <p>Being a plain record is a design choice: the decision must be reproducible from the
 * recorded values alone, which is what makes {@code harness_action} a real replay log
 * (01 §0 P4) rather than a summary.
 */
public record PolicyRequest(
        String agentId,
        String agentKey,
        String agentName,
        AgentState agentState,
        AutonomyLevel autonomyLevel,
        Integer deptId,
        String terminalId,
        CapabilityDescriptor capability,
        Scope requestedScope,
        ContentTrust contentTrust,
        /** Ids of untrusted sources the arguments were taken from; empty means "none". */
        Set<String> sourceRefs,
        ActorRef requestedBy,
        String planId,
        int stepSeq) {

    public PolicyRequest {
        sourceRefs = sourceRefs == null ? Set.of() : Set.copyOf(sourceRefs);
    }

    public static Builder builder() {
        return new Builder();
    }

    public static final class Builder {
        private String agentId;
        private String agentKey;
        private String agentName = "";
        private AgentState agentState = AgentState.ACTIVE;
        private AutonomyLevel autonomyLevel = AutonomyLevel.L0;
        private Integer deptId;
        private String terminalId;
        private CapabilityDescriptor capability;
        private Scope requestedScope = Scope.UNBOUNDED;
        private ContentTrust contentTrust = ContentTrust.TRUSTED;
        private Set<String> sourceRefs = Set.of();
        private ActorRef requestedBy;
        private String planId = "";
        private int stepSeq;

        public Builder agent(String id, String key, String name, AgentState state, AutonomyLevel level, Integer deptId) {
            this.agentId = id;
            this.agentKey = key;
            this.agentName = name;
            this.agentState = state;
            this.autonomyLevel = level;
            this.deptId = deptId;
            return this;
        }

        public Builder terminal(String id) {
            this.terminalId = id;
            return this;
        }

        public Builder capability(CapabilityDescriptor cap) {
            this.capability = cap;
            return this;
        }

        public Builder scope(Scope scope) {
            this.requestedScope = scope;
            return this;
        }

        public Builder content(ContentTrust trust, Set<String> refs) {
            this.contentTrust = trust;
            this.sourceRefs = refs;
            return this;
        }

        public Builder requestedBy(ActorRef actor) {
            this.requestedBy = actor;
            return this;
        }

        public Builder plan(String planId, int stepSeq) {
            this.planId = planId;
            this.stepSeq = stepSeq;
            return this;
        }

        public PolicyRequest build() {
            return new PolicyRequest(agentId, agentKey, agentName, agentState, autonomyLevel, deptId, terminalId,
                    capability, requestedScope, contentTrust, sourceRefs, requestedBy, planId, stepSeq);
        }
    }

    /**
     * The source references that cannot be traced back to a source.
     *
     * <p>For trusted content this is always empty. For untrusted content it lists every blank
     * reference, and it also reports "no reference at all" as one untraceable entry: content that
     * came from somewhere but cites nothing is precisely the case ADR-011 is about.
     */
    public List<String> untrustedSourcesWithoutRefs() {
        if (contentTrust.isTrusted()) {
            return List.of();
        }
        List<String> blank = sourceRefs.stream().filter(s -> s == null || s.isBlank()).toList();
        if (!blank.isEmpty()) {
            return blank;
        }
        if (sourceRefs.isEmpty()) {
            return List.of("<no source_ref>");
        }
        return List.of();
    }
}