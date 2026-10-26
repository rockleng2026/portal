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
        String s = scope.trim();
        if (s.endsWith("*")) {
            String prefix = s.substring(0, s.length() - 1);
            return path.startsWith(prefix);
        }
        return s.equals(path) || path.startsWith(s.endsWith("/") ? s : s + "/");
    }
}