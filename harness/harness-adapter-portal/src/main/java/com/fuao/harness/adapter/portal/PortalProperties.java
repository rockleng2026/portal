package com.fuao.harness.adapter.portal;

import java.time.Duration;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Connection details for the portal database and for the portal's own API.
 *
 * <p>The database account must be <b>read only</b>. The adapter never writes to the portal: every
 * write goes through the portal's own API so that the portal's validation and cache refresh
 * still apply (01 §17.1, 01 §17.3).
 */
@ConfigurationProperties(prefix = "harness.portal")
public record PortalProperties(
        DataSource datasource,
        boolean syncEnabled,
        Duration syncInterval,
        String apiBaseUrl,
        String apiClientId,
        String apiSecret,
        boolean apiEnabled) {

    public record DataSource(String url, String username, String password) {
    }
}
