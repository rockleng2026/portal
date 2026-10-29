package com.fuao.harness.platform.security;

import com.fuao.harness.platform.security.ClientAuthenticator.AuthenticationException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Authenticates every {@code /api/harness/**} call and publishes the caller for the request.
 *
 * <p>This filter is the whole reason harness never enters portal's cookie session model
 * (01 §2.1 结论 B, 01 §17.2): portal authenticates people with a reversible cookie password and
 * resolves permissions by scraping the request URL. Reusing that for machine identities would put
 * a digital employee's full organisation authority behind a leaked cookie.
 */
@Component
public class AuthFilter extends OncePerRequestFilter {

    private static final Logger log = LoggerFactory.getLogger(AuthFilter.class);

    private final ClientAuthenticator authenticator;
    private final AuthContext authContext;

    public AuthFilter(ClientAuthenticator authenticator, AuthContext authContext) {
        this.authenticator = authenticator;
        this.authContext = authContext;
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        // Every path under /api/harness/ is authenticated. There is no carve-out: an endpoint
        // that must not be reachable without a signature does not belong under this prefix.
        return !request.getRequestURI().startsWith("/api/harness/");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {
        try {
            // The signature covers the body, so we must read it here - and then hand the controller
            // a request that can still be read from (CachedBodyHttpServletRequest).
            CachedBodyHttpServletRequest cached = new CachedBodyHttpServletRequest(request);

            // The signed path is request.getRequestURI() - the path WITHOUT the query string.
            // A client that signs the query along with it gets BAD_SIGNATURE, and the query
            // itself is not covered by the signature (it selects, it does not authorise).
            AuthenticatedClient client = authenticator.authenticate(
                    request.getHeader(ClientAuthenticator.HEADER_CLIENT),
                    request.getHeader(ClientAuthenticator.HEADER_TIMESTAMP),
                    request.getHeader(ClientAuthenticator.HEADER_NONCE),
                    request.getHeader(ClientAuthenticator.HEADER_SIGNATURE),
                    request.getMethod(),
                    request.getRequestURI(),
                    cached.body());

            String scope = client.apiScope();
            if (scope != null && !scope.isBlank() && !withinScope(scope, request.getRequestURI())) {
                throw new AuthenticationException(403, "SCOPE_NOT_ALLOWED",
                        "client " + client.clientId() + " may not call " + request.getRequestURI());
            }
            // A device account may only speak for the device it is bound to. Until it has
            // registered, the only thing it may do is register.
            if (client.isTerminal()) {
                String bound = client.terminalId();
                String asked = terminalIdOf(request.getRequestURI());
                boolean registering = request.getRequestURI().endsWith("/api/harness/terminal/hello");
                if (bound == null || bound.isBlank()) {
                    if (!registering) {
                        throw new AuthenticationException(403, "NOT_YOUR_TERMINAL",
                                "client " + client.clientId() + " has not registered a terminal yet");
                    }
                } else if (asked != null && !asked.equals(bound)) {
                    throw new AuthenticationException(403, "NOT_YOUR_TERMINAL",
                            "client " + client.clientId() + " may only speak for its own terminal");
                }
            }

            authContext.set(client);
            chain.doFilter(cached, response);
        } catch (AuthenticationException e) {
            log.warn("auth rejected: code={} path={} reason={}", e.code(), request.getRequestURI(), e.getMessage());
            response.setStatus(e.status());
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"error\":{\"code\":\"" + e.code() + "\",\"message\":\"" + e.getMessage() + "\"}}");
        } finally {
            authContext.clear();
        }
    }

    /**
     * Whether a path is inside a principal's {@code api_scope}.
     *
     * <p>The scope is a path <em>prefix</em> (V2: {@code api_scope} = "允许的路径前缀"). A scope
     * ending in {@code *} matches everything below it; a scope without {@code *} must match the
     * path exactly or be a path prefix of it. Comparing a wildcard scope for equality - which is
     * what this used to do - would hand every endpoint to a principal that was only meant to have
     * one.
     */
    static boolean withinScope(String scope, String path) {
        // A principal may have several prefixes: "/api/harness/terminal/*,/api/harness/tasks/*".
        for (String part : scope.split(",")) {
            String s = part.trim();
            if (s.isEmpty()) {
                continue;
            }
            if (s.endsWith("*")) {
                if (path.startsWith(s.substring(0, s.length() - 1))) {
                    return true;
                }
            } else if (s.equals(path) || path.startsWith(s.endsWith("/") ? s : s + "/")) {
                return true;
            }
        }
        return false;
    }

    /** The terminal id a path names, if it names one: /api/harness/terminal/{id}/... */
    static String terminalIdOf(String path) {
        String marker = "/api/harness/terminal/";
        int start = path.indexOf(marker);
        if (start < 0) {
            return null;
        }
        String rest = path.substring(start + marker.length());
        int slash = rest.indexOf('/');
        String id = slash < 0 ? rest : rest.substring(0, slash);
        return id.isEmpty() ? null : id;
    }
}