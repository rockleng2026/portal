package com.fuao.harness.adapter.portal;

import java.util.LinkedHashMap;
import java.util.Map;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

/**
 * The portal adapter.
 *
 * <p>It reads the portal organisation and mirrors it into the harness library. It never writes to
 * the portal, and it never decides anything about the business - it only makes the organisation
 * legible to the platform.
 */
@SpringBootApplication
@EnableConfigurationProperties({PortalProperties.class, HarnessProperties.class})
@EnableScheduling
public class PortalAdapterApplication {

    public static void main(String[] args) {
        SpringApplication.run(PortalAdapterApplication.class, args);
    }

    /**
     * The default mapping from a portal function point to a harness capability.
     *
     * <p>Empty on purpose: the mapping from "portal menu point 351" to "harness capability
     * cap:portal.mission.complete" is an organisational decision. Until somebody makes it, every
     * position binding is reported in the dirty queue instead of being guessed - a wrong guess
     * would hand an agent a capability nobody approved.
     */
    @Bean
    public PortalSyncService.CapabilityResolver capabilityResolver() {
        return new PortalSyncService.EmptyCapabilityResolver();
    }

    @Bean
    public PortalSyncScheduler portalSyncScheduler(PortalSyncService sync, PortalProperties properties) {
        return new PortalSyncScheduler(sync, properties);
    }

    /** Periodic sync, disabled unless {@code harness.portal.sync-enabled} is true. */
    public static class PortalSyncScheduler {

        private final PortalSyncService sync;
        private final PortalProperties properties;

        public PortalSyncScheduler(PortalSyncService sync, PortalProperties properties) {
            this.sync = sync;
            this.properties = properties;
        }

        @Scheduled(fixedDelayString = "${harness.portal.sync-interval-ms:600000}")
        public void run() {
            if (!properties.syncEnabled()) {
                return;
            }
            try {
                sync.sync();
            } catch (RuntimeException e) {
                org.slf4j.LoggerFactory.getLogger(PortalSyncScheduler.class)
                        .error("portal sync failed", e);
            }
        }
    }

    static Map<String, String> emptyCapabilities() {
        return new LinkedHashMap<>();
    }
}
