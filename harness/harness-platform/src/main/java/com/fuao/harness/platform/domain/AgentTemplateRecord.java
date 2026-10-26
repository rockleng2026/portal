package com.fuao.harness.platform.domain;

import java.util.List;

/** Row of {@code harness_agent_template} (see V3 seed migration, 01 §6.3). */
public record AgentTemplateRecord(
        String templateId,
        String templateKey,
        String name,
        String agentType,
        String domain,
        String description,
        int autonomyLevel,
        String modelId,
        String localModel,
        List<String> goals,
        List<String> skillRefs,
        Integer positionHint,
        List<String> capKeys,
        boolean builtIn) {
}