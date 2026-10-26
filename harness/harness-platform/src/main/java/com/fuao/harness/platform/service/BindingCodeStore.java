package com.fuao.harness.platform.service;

import java.time.Duration;

/**
 * One-time binding codes (03 §3.5: "binding_code, one-time, TTL 10min").
 *
 * <p>Backed by Redis in a real deployment so the code survives a restart of the console and is
 * consumed atomically; in tests by memory. Either way the contract is the same: an unknown or
 * already-used code redeems to {@code null} rather than to a terminal.
 */
public interface BindingCodeStore {

    String issue(String terminalId, Duration ttl);

    /** @return the terminal id the code was issued for, or {@code null} if unknown/expired/used */
    String redeem(String code);

    void revokeAllFor(String terminalId);
}