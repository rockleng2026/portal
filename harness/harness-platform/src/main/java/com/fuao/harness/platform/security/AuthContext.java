package com.fuao.harness.platform.security;

import org.springframework.stereotype.Component;

/** Request-scoped holder for the authenticated caller. */
@Component
public class AuthContext {

    private static final ThreadLocal<AuthenticatedClient> CURRENT = new ThreadLocal<>();

    public void set(AuthenticatedClient client) {
        CURRENT.set(client);
    }

    public void clear() {
        CURRENT.remove();
    }

    public AuthenticatedClient require() {
        AuthenticatedClient client = CURRENT.get();
        if (client == null) {
            throw new IllegalStateException("no authenticated client on this request");
        }
        return client;
    }

    public AuthenticatedClient current() {
        return CURRENT.get();
    }
}