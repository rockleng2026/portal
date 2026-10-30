package com.fuao.harness.platform.service;

import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.ProxySelector;
import java.net.SocketAddress;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * The proxy the platform fetches third-party content through.
 *
 * <p>A company reaches the internet through a proxy, and the proxy is configured in the
 * environment ({@code https_proxy} and friends) - not in the JVM's system properties. curl
 * reads those variables; the JDK's HTTP client does not, so a client that is built without
 * saying anything connects straight out and hangs on the hosts the proxy exists for.
 *
 * <p>That is not a theoretical problem: the release assets of a GitHub tag are served from a
 * different host than the API, and only the second one is directly reachable. A catalogue
 * that points at a release asset would time out for ever, and the failure looks like the
 * registry being broken rather than the platform being unable to leave the building.
 *
 * <p>The rule is the one everybody else follows: the proxy is used for everything except the
 * hosts {@code no_proxy} names. The terminal's own control channel deliberately does the
 * opposite - a machine behind a corporate proxy must not route its signed requests through it
 * - but that is a decision about a *different* connection, and it is made there.
 */
final class EnvironmentProxySelector extends ProxySelector {

    private final List<Proxy> proxies;
    private final List<String> bypass;

    private EnvironmentProxySelector(List<Proxy> proxies, List<String> bypass) {
        this.proxies = proxies;
        this.bypass = bypass;
    }

    /**
     * The proxy the environment points at, or a selector that connects directly when there is
     * none.
     */
    static ProxySelector fromEnvironment() {
        String url = firstNonBlank(System.getenv("https_proxy"), System.getenv("HTTPS_PROXY"),
                System.getenv("http_proxy"), System.getenv("HTTP_PROXY"));
        List<String> bypass = split(firstNonBlank(System.getenv("no_proxy"), System.getenv("NO_PROXY")));
        if (url == null) {
            return new EnvironmentProxySelector(List.of(), bypass);
        }
        URI uri;
        try {
            uri = URI.create(url.contains("://") ? url : "http://" + url);
        } catch (IllegalArgumentException e) {
            return new EnvironmentProxySelector(List.of(), bypass);
        }
        String host = uri.getHost();
        if (host == null || host.isBlank()) {
            return new EnvironmentProxySelector(List.of(), bypass);
        }
        int port = uri.getPort() > 0 ? uri.getPort()
                : ("https".equalsIgnoreCase(uri.getScheme()) ? 443 : 80);
        Proxy proxy = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(host, port));
        return new EnvironmentProxySelector(List.of(proxy), bypass);
    }

    @Override
    public List<Proxy> select(URI uri) {
        if (proxies.isEmpty() || isBypassed(uri.getHost())) {
            return List.of(Proxy.NO_PROXY);
        }
        return proxies;
    }

    @Override
    public void connectFailed(URI uri, SocketAddress sa, java.io.IOException ioe) {
        // Nothing to do: the next attempt picks another proxy, and there is only one.
    }

    /** Whether the host is one of those that is reached directly. */
    private boolean isBypassed(String host) {
        if (host == null) {
            return false;
        }
        String lower = host.toLowerCase(Locale.ROOT);
        for (String rule : bypass) {
            if (rule.isEmpty()) {
                continue;
            }
            if (rule.startsWith(".")) {
                // ".example.com" covers the domain and everything under it.
                if (lower.endsWith(rule) || lower.equals(rule.substring(1))) {
                    return true;
                }
                continue;
            }
            if (lower.equals(rule)) {
                return true;
            }
            // "example.com" covers the domain and everything under it.
            if (lower.endsWith("." + rule)) {
                return true;
            }
        }
        return false;
    }

    private static String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value.trim();
            }
        }
        return null;
    }

    private static List<String> split(String value) {
        List<String> out = new ArrayList<>();
        if (value == null || value.isBlank()) {
            return out;
        }
        for (String part : value.split(",")) {
            String p = part.trim().toLowerCase(Locale.ROOT);
            if (!p.isEmpty()) {
                out.add(p);
            }
        }
        return out;
    }
}
