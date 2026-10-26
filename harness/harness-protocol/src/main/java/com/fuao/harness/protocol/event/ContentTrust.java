package com.fuao.harness.protocol.event;

/**
 * Trust level of the content carried by an event (03 §4, 01 §16).
 *
 * <p>This is the single most important field on the bus. Content that came from a human,
 * a mail server or another AI is <em>data</em>, never an instruction: {@link #UNTRUSTED}
 * content may end up as a fact in a report, but it may not become a tool argument without a
 * traceable {@code source_ref} (ADR-011, red-team R-03).
 */
public enum ContentTrust {

    /** Produced by the platform itself (scheduler, policy engine, platform operator). */
    TRUSTED,

    /** Came from outside: mail body, chat message, web page, uploaded document, model output. */
    UNTRUSTED;

    public boolean isTrusted() {
        return this == TRUSTED;
    }
}