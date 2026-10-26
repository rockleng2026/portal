package com.fuao.harness.adapter.portal;

import org.springframework.boot.context.properties.ConfigurationProperties;

/** Connection details of the harness library (the adapter's own database). */
@ConfigurationProperties(prefix = "spring.datasource")
public record HarnessProperties(String url, String username, String password) {
}
