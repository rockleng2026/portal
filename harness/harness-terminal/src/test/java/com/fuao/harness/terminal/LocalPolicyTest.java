package com.fuao.harness.terminal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fuao.harness.protocol.frame.CommandCode;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.junit.jupiter.api.Test;

/**
 * The terminal's own refusal rules (red-team R-01).
 *
 * <p>These are the tests that matter most in this module: the platform may be wrong, the edge
 * may be compromised, the network may be hostile - and the terminal still refuses what it was
 * not authorised to do.
 */
class LocalPolicyTest {

    private static final long NOW = 1_700_000_000L;

    private LocalPolicy policy() {
        // L4 on purpose: fs.delete requires L4 (03 §3.3), and the point of these tests is the
        // refusal rules that come after the level check.
        return new LocalPolicy(4, Set.of("cap:file.read", "cap:file.write", "cap:file.delete", "cap:input.inject"),
                List.of("/srv/data"));
    }

    @Test
    void constructionDoesNotBlowUpOnItsOwnRoots() {
        // The constructor used to add to the list it was iterating over: a guaranteed
        // ConcurrentModificationException on the very first use.
        LocalPolicy p = policy();
        assertEquals(List.of("/srv/data"), p.allowedRoots());
    }

    @Test
    void aCapabilityThatWasNeverGrantedIsRefused() {
        LocalPolicy.Verdict verdict = policy().check(CommandCode.SYS_EXEC, "cap:ssh.exec", null, null, NOW);
        assertFalse(verdict.allowed());
        assertEquals("CAPABILITY_NOT_GRANTED", verdict.reasonCode());
    }

    @Test
    void aCommandAboveTheTerminalsLevelIsRefused() {
        LocalPolicy p = new LocalPolicy(1, Set.of("cap:proc.kill"), List.of("/srv/data"));
        LocalPolicy.Verdict verdict = p.check(CommandCode.PROC_KILL, "cap:proc.kill", null, null, NOW);
        assertFalse(verdict.allowed());
        assertEquals("AUTONOMY_TOO_LOW", verdict.reasonCode());
    }

    @Test
    void aPathOutsideTheRootsIsRefusedEvenWithTheCapability() {
        LocalPolicy.Verdict verdict = policy().check(CommandCode.FS_READ, "cap:file.read",
                "/etc/passwd", null, NOW);
        assertFalse(verdict.allowed());
        assertEquals("PATH_OUTSIDE_ALLOWED_ROOTS", verdict.reasonCode());
    }

    @Test
    void aPathCannotEscapeTheRootsWithDotSegments() {
        LocalPolicy.Verdict verdict = policy().check(CommandCode.FS_READ, "cap:file.read",
                "/srv/data/../../etc/passwd", null, NOW);
        assertFalse(verdict.allowed());
        assertEquals("PATH_OUTSIDE_ALLOWED_ROOTS", verdict.reasonCode());
    }

    @Test
    void aDestructiveCommandNeedsAnApproval() {
        LocalPolicy.Verdict verdict = policy().check(CommandCode.FS_DELETE, "cap:file.delete",
                "/srv/data/report.txt", null, NOW);
        assertFalse(verdict.allowed());
        assertEquals("APPROVAL_REQUIRED", verdict.reasonCode());
    }

    @Test
    void anExpiredApprovalIsRefused() {
        LocalPolicy.ApprovalToken token = new LocalPolicy.ApprovalToken("appr-1", NOW - 1,
                new byte[0], new byte[0], "fs.delete", "cap:file.delete", "/srv/data/report.txt");
        LocalPolicy.Verdict verdict = policy().check(CommandCode.FS_DELETE, "cap:file.delete",
                "/srv/data/report.txt", token, NOW);
        assertFalse(verdict.allowed());
        assertEquals("APPROVAL_EXPIRED", verdict.reasonCode());
    }

    @Test
    void oneApprovalBuysOneExecution() {
        LocalPolicy p = policy();
        LocalPolicy.ApprovalToken token = new LocalPolicy.ApprovalToken("appr-1", NOW + 60,
                new byte[0], new byte[0], "fs.delete", "cap:file.delete", "/srv/data/report.txt");
        assertTrue(p.check(CommandCode.FS_DELETE, "cap:file.delete", "/srv/data/report.txt", token, NOW).allowed());
        p.spend(token);
        LocalPolicy.Verdict second = p.check(CommandCode.FS_DELETE, "cap:file.delete",
                "/srv/data/report.txt", token, NOW);
        assertFalse(second.allowed());
        assertEquals("APPROVAL_ALREADY_USED", second.reasonCode());
    }

    @Test
    void anApprovalIsBoundToTheCommandItWasGivenFor() {
        // An approval for fs.delete must not authorise proc.kill, and an approval for one file
        // must not authorise another one.
        LocalPolicy.ApprovalToken token = new LocalPolicy.ApprovalToken("appr-1", NOW + 60,
                new byte[0], new byte[0], "fs.delete", "cap:file.delete", "/srv/data/report.txt");

        LocalPolicy.Verdict otherFile = policy().check(CommandCode.FS_DELETE, "cap:file.delete",
                "/srv/data/other.txt", token, NOW);
        assertFalse(otherFile.allowed());
        assertEquals("APPROVAL_SCOPE_MISMATCH", otherFile.reasonCode());

        LocalPolicy.Verdict otherCommand = policy().check(CommandCode.INPUT_INJECT, "cap:input.inject",
                null, token, NOW);
        assertFalse(otherCommand.allowed());
        assertEquals("APPROVAL_SCOPE_MISMATCH", otherCommand.reasonCode());
    }

    @Test
    void aRevokedTerminalDoesNothingAtAll() {
        LocalPolicy p = policy();
        p.revoke();
        LocalPolicy.Verdict verdict = p.check(CommandCode.FS_READ, "cap:file.read", "/srv/data/a.txt",
                null, NOW);
        assertFalse(verdict.allowed());
        assertEquals("TERMINAL_REVOKED", verdict.reasonCode());
        assertTrue(p.grantedCapabilities().isEmpty(), "a revoked terminal holds nothing");
    }

    @Test
    void thePolicyCanBeDescribedForThePlatform() {
        Map<String, Object> described = policy().describe();
        assertEquals(4, described.get("autonomyLevel"));
        assertEquals(List.of("/srv/data"), described.get("allowedRoots"));
        assertNotEquals(null, described.get("capabilities"));
    }
}
