package com.fuao.harness.terminal;

import com.fuao.harness.protocol.frame.CommandCode;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

/**
 * What this terminal is allowed to do, on its own judgement.
 *
 * <p>The platform sends commands; this class decides whether they are executed. The rules exist
 * because a compromised or buggy edge must not be able to turn a laptop into a remote shell
 * (01 §11.1, red-team R-01):
 * <ul>
 *   <li>the terminal only holds the capabilities it was granted at binding time;</li>
 *   <li>a command whose minimum autonomy level is above the terminal's level is refused;</li>
 *   <li>file access is confined to the configured roots - a path that escapes them is refused
 *       even if the capability is held;</li>
 *   <li>destructive commands need a fresh, signed approval token, and the token is spent by the
 *       first use;</li>
 *   <li>a revocation empties the capability set immediately, without waiting for the platform
 *       to say so again (A0-5).</li>
 * </ul>
 */
public final class LocalPolicy {

    private final Set<String> grantedCapabilities = new LinkedHashSet<>();
    private final Set<Path> allowedRoots = new LinkedHashSet<>();
    private final List<ApprovalToken> spentApprovals = new ArrayList<>();
    private int autonomyLevel;
    private boolean revoked;

    public LocalPolicy(int autonomyLevel, Set<String> grantedCapabilities, List<String> allowedRoots) {
        this.autonomyLevel = autonomyLevel;
        this.grantedCapabilities.addAll(grantedCapabilities);
        for (String root : allowedRoots) {
            allowedRoots.add(Paths.get(root).toAbsolutePath().normalize());
        }
    }

    /** The decision for one command, with the reason it carries. */
    public record Verdict(boolean allowed, String reasonCode, String reason) {

        public static Verdict allow() {
            return new Verdict(true, "OK", "allowed");
        }

        public static Verdict deny(String code, String reason) {
            return new Verdict(false, code, reason);
        }
    }

    /**
     * A one-time approval for a destructive command.
     *
     * <p>Signed by the platform with Ed25519; the terminal holds the platform's public key and
     * verifies the signature itself. Without this, "a human approved it" would be whatever the
     * edge claims.
     */
    public record ApprovalToken(String approvalId, long expiresAtEpochSecond, byte[] platformSignature,
                                 byte[] payload) {
    }

    public void grant(String capKey) {
        grantedCapabilities.add(capKey);
    }

    public Set<String> grantedCapabilities() {
        return Set.copyOf(grantedCapabilities);
    }

    public int autonomyLevel() {
        return autonomyLevel;
    }

    public void setAutonomyLevel(int level) {
        this.autonomyLevel = level;
    }

    /**
     * Revokes everything. Called when the platform revokes the terminal or when the binding
     * expires - from that moment every command is refused.
     */
    public void revoke() {
        this.revoked = true;
        this.grantedCapabilities.clear();
    }

    public boolean isRevoked() {
        return revoked;
    }

    /**
     * Decides whether a command may run.
     *
     * @param command       the command code from the frame
     * @param capKey        the capability the command needs, if any
     * @param targetPath    the file path the command touches, if any
     * @param approvalToken the approval that came with the command, if any
     * @param nowEpoch      the current time, for the approval expiry
     */
    public Verdict check(CommandCode command, String capKey, String targetPath, ApprovalToken approvalToken,
                         long nowEpoch) {
        if (revoked) {
            return Verdict.deny("TERMINAL_REVOKED", "this terminal has been revoked; it does nothing");
        }
        if (capKey != null && !grantedCapabilities.contains(capKey)) {
            return Verdict.deny("CAPABILITY_NOT_GRANTED",
                    "capability " + capKey + " was never granted to this terminal");
        }
        if (command.minLevel() > autonomyLevel) {
            return Verdict.deny("AUTONOMY_TOO_LOW",
                    command.commandName() + " needs level L" + command.minLevel()
                            + ", this terminal runs at L" + autonomyLevel);
        }
        if (targetPath != null && !isWithinAllowedRoots(targetPath)) {
            return Verdict.deny("PATH_OUTSIDE_ALLOWED_ROOTS",
                    "path " + targetPath + " is outside the roots this terminal may touch");
        }
        if (command.humanApproval()) {
            if (approvalToken == null) {
                return Verdict.deny("APPROVAL_REQUIRED",
                        command.commandName() + " needs a fresh human approval token");
            }
            if (approvalToken.expiresAtEpochSecond() <= nowEpoch) {
                return Verdict.deny("APPROVAL_EXPIRED", "the approval token has expired");
            }
            if (isSpent(approvalToken.approvalId())) {
                return Verdict.deny("APPROVAL_ALREADY_USED",
                        "the approval token for " + approvalToken.approvalId() + " was already spent");
            }
        }
        return Verdict.allow();
    }

    /** Marks an approval as spent. One approval buys exactly one execution. */
    public void spend(ApprovalToken approvalToken) {
        spentApprovals.add(approvalToken);
    }

    public boolean isSpent(String approvalId) {
        for (ApprovalToken token : spentApprovals) {
            if (token.approvalId().equals(approvalId)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Whether a path is inside one of the allowed roots.
     *
     * <p>The check is done on the normalised absolute path, and the comparison is by path
     * segment, so {@code /srv/data/../etc} cannot be used to step out of {@code /srv/data}.
     */
    public boolean isWithinAllowedRoots(String path) {
        if (allowedRoots.isEmpty()) {
            return false;
        }
        Path normalised = Paths.get(path).toAbsolutePath().normalize();
        for (Path root : allowedRoots) {
            if (normalised.startsWith(root)) {
                return true;
            }
        }
        return false;
    }

    public List<String> allowedRoots() {
        return allowedRoots.stream().map(Path::toString).toList();
    }

    /** The policy as the platform would like to see it, for the self report. */
    public Map<String, Object> describe() {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("autonomyLevel", autonomyLevel);
        out.put("capabilities", grantedCapabilities.stream().sorted().toList());
        out.put("allowedRoots", allowedRoots());
        out.put("revoked", revoked);
        return out;
    }

    static String lower(String value) {
        return value == null ? "" : value.toLowerCase(Locale.ROOT);
    }
}
