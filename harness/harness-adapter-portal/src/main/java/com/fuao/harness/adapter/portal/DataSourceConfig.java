package com.fuao.harness.adapter.portal;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.simple.JdbcClient;

/**
 * The two data sources this module talks to, and which is which.
 *
 * <p>Spring Boot's {@code DataSourceAutoConfiguration} only creates a data source when there is
 * none, so declaring the portal data source on its own would have silently replaced the harness
 * one - and every mirror write would have landed in the portal database. That is exactly the
 * mistake this class exists to prevent, so both are declared explicitly and the harness one is
 * marked primary.
 *
 * <ul>
 *   <li><b>harness</b> (primary): the harness library. The adapter writes the mirror tables and
 *       the dirty queue here.</li>
 *   <li><b>portal</b>: the legacy portal database, read only. The account must have
 *       INSERT/UPDATE/DELETE revoked, and the connection is additionally marked read only so a
 *       careless query fails instead of writing (01 §17.1).</li>
 * </ul>
 */
@Configuration
public class DataSourceConfig {

    @Bean
    @Primary
    public DataSource harnessDataSource(HarnessProperties properties) {
        return DataSourceBuilder.create()
                .url(properties.url())
                .username(properties.username())
                .password(properties.password())
                .build();
    }

    @Bean
    @Primary
    public JdbcClient jdbc(DataSource harnessDataSource) {
        return JdbcClient.create(harnessDataSource);
    }

    @Bean
    public DataSource portalDataSource(PortalProperties properties) {
        PortalProperties.DataSource config = properties.datasource();
        if (config == null || config.url() == null || config.url().isBlank()) {
            throw new IllegalStateException(
                    "harness.portal.datasource.url is required: the adapter has nothing to read without it");
        }
        return DataSourceBuilder.create()
                .url(config.url())
                .username(config.username())
                .password(config.password())
                .build();
    }

    @Bean
    public JdbcClient portalJdbc(@Qualifier("portalDataSource") DataSource portalDataSource) {
        return JdbcClient.create(portalDataSource);
    }
}
