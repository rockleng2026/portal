package com.fuao.harness.platform.config;

import java.time.Duration;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "harness")
public record HarnessProperties(Security security, Terminal terminal, Bootstrap bootstrap, Federation federation) {

    public record Security(Duration clockSkew, Duration nonceTtl, Duration bindingCodeTtl) {
    }

    /**
     * @param heartbeatTimeout how often a terminal is expected to be heard from (03 §3.1: 10s
     *                         heartbeat, 30s timeout)
     * @param degradeAfter     how long a silent terminal keeps its authority before it is
     *                         demoted to read-only (red-team R-01: 15 minutes)
     */
    public record Terminal(Duration heartbeatTimeout, Duration degradeAfter) {
    }

    public record Bootstrap(String clientId, String secret, String humanClientId, String humanSecret,
                            Integer humanEmployeeId) {
    }

    public record Federation(String localFedId) {
    }
}