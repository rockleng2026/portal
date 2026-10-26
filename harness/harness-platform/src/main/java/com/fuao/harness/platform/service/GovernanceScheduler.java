package com.fuao.harness.platform.service;

import com.fuao.harness.platform.config.HarnessProperties;
import com.fuao.harness.platform.repo.TerminalRepository;
import java.time.Duration;
import java.time.Instant;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * The jobs that make the governance rules true without anybody asking.
 *
 * <p>Two of them exist because a rule that only works when somebody remembers to run it is not
 * a rule:
 * <ul>
 *   <li><b>Terminal degradation</b> (red-team R-01, acceptance A0-6): a terminal that has not
 *       heartbeated for 15 minutes loses its authority. The heartbeat is 10s and the TCP timeout
 *       is 30s (03 §3.1), so "still online" has to be a maintained fact, not an assumption.</li>
 *   <li><b>Approval expiry</b> (04 §8.3): an escalation nobody answered for more than a day is
 *       closed by the system, not left pending forever. A pending row that never expires is a
 *       queue of decisions that quietly disappear from the dashboard.</li>
 * </ul>
 */
@Component
public class GovernanceScheduler {

    private static final Logger log = LoggerFactory.getLogger(GovernanceScheduler.class);

    private final TerminalRepository terminals;
    private final ApprovalService approvals;
    private final Duration degradeAfter;

    public GovernanceScheduler(TerminalRepository terminals, ApprovalService approvals,
                               HarnessProperties properties) {
        this.terminals = terminals;
        this.approvals = approvals;
        this.degradeAfter = properties.terminal().degradeAfter() == null
                ? Duration.ofMinutes(15)
                : properties.terminal().degradeAfter();
    }

    @Scheduled(fixedDelayString = "${harness.scheduler.terminal-scan-ms:60000}")
    public void degradeSilentTerminals() {
        int degraded;
        try {
            degraded = terminals.markStaleOffline(Instant.now().minus(degradeAfter));
        } catch (RuntimeException e) {
            log.warn("terminal degradation scan failed: {}", e.getMessage());
            return;
        }
        if (degraded > 0) {
            log.info("degraded {} terminal(s) to read-only after {} without a heartbeat", degraded, degradeAfter);
        }
    }

    @Scheduled(fixedDelayString = "${harness.scheduler.approval-expiry-ms:300000}")
    public void expireApprovals() {
        try {
            int expired = approvals.expireOverdue();
            if (expired > 0) {
                log.info("expired {} approval(s) that nobody decided in time", expired);
            }
        } catch (RuntimeException e) {
            log.warn("approval expiry scan failed: {}", e.getMessage());
        }
    }

    /** Exposed for the dashboard: how long a silent device keeps its authority. */
    public Duration degradeAfter() {
        return degradeAfter;
    }

    static Map<String, String> describe(Duration d) {
        return Map.of("degradeAfter", String.valueOf(d));
    }
}
