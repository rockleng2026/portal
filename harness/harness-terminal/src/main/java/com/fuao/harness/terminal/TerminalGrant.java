package com.fuao.harness.terminal;

import com.fuao.harness.protocol.json.Json;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.PosixFilePermission;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * The grant: what this machine is allowed to do, according to the platform.
 *
 * <p>The platform holds the grants, so the platform is the only place that can answer the
 * question. The shell asks it over the signed API, writes the answer here, and the agent that
 * runs on the same machine reads the same file. There is no second copy of the authority to
 * drift out of date - and if the platform takes a capability away, the shell's next refresh
 * removes it from the file.
 *
 * <p>The file format is shared with the Rust agent runtime ({@code harness-terminal/}), so
 * both sides read the same bytes. It holds capabilities and the autonomy level, and <b>no</b>
 * approval tokens: an approval is signed for one command and travels with that command, so it
 * is never handed out in advance.
 */
public final class TerminalGrant {

    /** The file name inside the identity directory. */
    public static final String FILE_NAME = "grant.json";

    private final String terminalId;
    private final String agentId;
    private final int autonomyLevel;
    private final List<String> capabilities;
    private final List<Integer> deptIds;
    private final List<String> allowedRoots;
    private final String grantedAt;

    public TerminalGrant(String terminalId, String agentId, int autonomyLevel, List<String> capabilities,
                         List<Integer> deptIds, List<String> allowedRoots, String grantedAt) {
        this.terminalId = terminalId;
        this.agentId = agentId;
        this.autonomyLevel = autonomyLevel;
        this.capabilities = capabilities == null ? List.of() : List.copyOf(capabilities);
        this.deptIds = deptIds == null ? List.of() : List.copyOf(deptIds);
        this.allowedRoots = allowedRoots == null ? List.of() : List.copyOf(allowedRoots);
        this.grantedAt = grantedAt;
    }

    /** Where the grant lives on this machine. */
    public static Path fileOf(Path identityDirectory) {
        return identityDirectory.resolve(FILE_NAME);
    }

    /**
     * Builds the grant from the platform's answer and the device's own root whitelist.
     *
     * <p>The roots are a device decision: the platform says <em>what</em> may be done, the
     * device says <em>where</em>. The effective set is the intersection of both, which is
     * computed by the agent that enforces it.
     */
    public static TerminalGrant from(Map<String, Object> platformGrant, List<String> allowedRoots) {
        return new TerminalGrant(
                string(platformGrant, "terminalId"),
                string(platformGrant, "agentId"),
                integer(platformGrant, "autonomyLevel"),
                strings(platformGrant, "capabilities"),
                integers(platformGrant, "deptIds"),
                allowedRoots,
                string(platformGrant, "grantedAt"));
    }

    /** Writes the grant, owner-readable only. */
    public void save(Path file) throws IOException {
        Path parent = file.getParent();
        if (parent != null) {
            Files.createDirectories(parent);
            restrict(parent);
        }
        Files.writeString(file, new String(Json.canonicalBytes(toMap()), StandardCharsets.UTF_8),
                StandardCharsets.UTF_8);
        restrict(file);
    }

    /** Reads the grant, or {@code null} when there is none. */
    public static TerminalGrant read(Path file) throws IOException {
        if (!Files.exists(file)) {
            return null;
        }
        Object parsed = Json.parse(Files.readString(file, StandardCharsets.UTF_8));
        if (!(parsed instanceof Map)) {
            return null;
        }
        @SuppressWarnings("unchecked")
        Map<String, Object> map = (Map<String, Object>) parsed;
        return new TerminalGrant(
                string(map, "terminalId"),
                string(map, "agentId"),
                integer(map, "autonomyLevel"),
                strings(map, "capabilities"),
                integers(map, "deptIds"),
                strings(map, "allowedRoots"),
                string(map, "grantedAt"));
    }

    /** The grant as the agent runtime reads it. */
    public Map<String, Object> toMap() {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("terminalId", terminalId);
        out.put("agentId", agentId);
        out.put("autonomyLevel", autonomyLevel);
        out.put("capabilities", capabilities);
        out.put("deptIds", deptIds);
        out.put("allowedRoots", allowedRoots);
        out.put("grantedAt", grantedAt);
        return out;
    }

    public String terminalId() {
        return terminalId;
    }

    public String agentId() {
        return agentId;
    }

    public int autonomyLevel() {
        return autonomyLevel;
    }

    public List<String> capabilities() {
        return capabilities;
    }

    public List<Integer> deptIds() {
        return deptIds;
    }

    public List<String> allowedRoots() {
        return allowedRoots;
    }

    public String grantedAt() {
        return grantedAt;
    }

    /** The moment the grant was issued, when the platform said so. */
    public Instant grantedAtInstant() {
        try {
            return Instant.parse(grantedAt);
        } catch (RuntimeException e) {
            return Instant.EPOCH;
        }
    }

    private static void restrict(Path path) {
        try {
            if (!path.getFileSystem().supportedFileAttributeViews().contains("posix")) {
                return;
            }
            String mode = Files.isDirectory(path) ? "rwx------" : "rw-------";
            Files.setPosixFilePermissions(path,
                    java.nio.file.attribute.PosixFilePermissions.fromString(mode));
        } catch (IOException | UnsupportedOperationException e) {
            // Nothing to do: the platform can revoke the device at any time.
        }
    }

    private static String string(Map<String, Object> map, String key) {
        Object value = map.get(key);
        return value == null ? "" : String.valueOf(value);
    }

    private static int integer(Map<String, Object> map, String key) {
        Object value = map.get(key);
        if (value instanceof Number n) {
            return n.intValue();
        }
        try {
            return Integer.parseInt(String.valueOf(value));
        } catch (RuntimeException e) {
            return 0;
        }
    }

    private static List<String> strings(Map<String, Object> map, String key) {
        Object value = map.get(key);
        List<String> out = new ArrayList<>();
        if (value instanceof List<?> list) {
            for (Object item : list) {
                if (item != null) {
                    out.add(String.valueOf(item));
                }
            }
        }
        return out;
    }

    private static List<Integer> integers(Map<String, Object> map, String key) {
        Object value = map.get(key);
        List<Integer> out = new ArrayList<>();
        if (value instanceof List<?> list) {
            for (Object item : list) {
                if (item instanceof Number n) {
                    out.add(n.intValue());
                }
            }
        }
        return out;
    }
}
