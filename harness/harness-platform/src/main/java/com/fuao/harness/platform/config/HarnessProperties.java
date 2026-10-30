package com.fuao.harness.platform.config;

import java.time.Duration;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "harness")
public record HarnessProperties(Security security, Terminal terminal, Bootstrap bootstrap,
                                Federation federation, Model model, Skill skill, Portal portal) {

    /**
     * @param encryptionKey the key the model credentials are encrypted with. When it is not set,
     *                       the key is derived from the bootstrap secret - a dedicated key is
     *                       better (it can be rotated on its own), but a fresh machine should
     *                       not be blocked from configuring a model.
     */
    public record Model(String encryptionKey) {
    }

    /**
     * @param signingKey the key skill versions are signed with. It proves the platform issued a
     *                   version; the terminal does not hold it and does not need it - the
     *                   terminal checks the content digest instead. Derived from the bootstrap
     *                   secret when it is not set.
     */
    public record Skill(String signingKey) {
    }

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

    /**
     * The portal this platform hires its digital employees into.
     *
     * <p>Without it the platform cannot onboard anybody, and the console says so instead of
     * asking the operator for an employee id nobody can look up.
     *
     * @param baseUrl  the portal's root, including the context path
     * @param clientId the client id the portal accepts
     * @param secret   the shared secret; the portal verifies the signature with it
     */
    public record Portal(String baseUrl, String clientId, String secret) {
    }
}