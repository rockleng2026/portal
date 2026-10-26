package com.fuao.harness.platform.config;

import java.time.Duration;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "harness")
public record HarnessProperties(Security security, Terminal terminal, Bootstrap bootstrap, Federation federation) {

    public record Security(Duration clockSkew, Duration nonceTtl, Duration bindingCodeTtl) {
    }

    public record Terminal(Duration heartbeatTimeout) {
    }

    public record Bootstrap(String clientId, String secret) {
    }

    public record Federation(String localFedId) {
    }
}