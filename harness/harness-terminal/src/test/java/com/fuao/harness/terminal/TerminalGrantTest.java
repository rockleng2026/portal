package com.fuao.harness.terminal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

/**
 * The grant file: the handover between the shell and the agent that runs on the same machine.
 *
 * <p>The file is written by the shell from the platform's answer and read by the agent. Two
 * runtimes, one authority, one file - and the format has to be exactly what the Rust agent
 * runtime expects, because that is the other side of the handover.
 */
class TerminalGrantTest {

    @Test
    void aGrantSurvivesTheRoundTrip() {
        TerminalGrant grant = new TerminalGrant("t1", "a1", 2,
                List.of("cap:fs.read", "cap:fs.write"), List.of(91), List.of("/srv/data"),
                "2026-10-26T12:00:00Z");

        Map<String, Object> map = grant.toMap();
        assertEquals("t1", map.get("terminalId"));
        assertEquals("a1", map.get("agentId"));
        assertEquals(2, map.get("autonomyLevel"));
        assertEquals(List.of(91), map.get("deptIds"));
        assertEquals(List.of("/srv/data"), map.get("allowedRoots"));
    }

    @Test
    void theFileIsWrittenAndReadBack(@TempDir Path dir) throws Exception {
        TerminalGrant grant = new TerminalGrant("t1", "a1", 3,
                List.of("cap:fs.read"), List.of(91), List.of("/srv/data"), "2026-10-26T12:00:00Z");

        Path file = TerminalGrant.fileOf(dir);
        grant.save(file);
        assertTrue(Files.exists(file));

        TerminalGrant read = TerminalGrant.read(file);
        assertNotNull(read);
        assertEquals("t1", read.terminalId());
        assertEquals(3, read.autonomyLevel());
        assertEquals(List.of("cap:fs.read"), read.capabilities());
        assertEquals(List.of("/srv/data"), read.allowedRoots());
        assertEquals(91, read.deptIds().get(0).intValue());
    }

    @Test
    void theFileIsNotReadableByOtherUsers(@TempDir Path dir) throws Exception {
        TerminalGrant grant = new TerminalGrant("t1", "a1", 1, List.of(), List.of(), List.of(), "now");
        Path file = TerminalGrant.fileOf(dir);
        grant.save(file);

        if (file.getFileSystem().supportedFileAttributeViews().contains("posix")) {
            var permissions = Files.getPosixFilePermissions(file);
            assertTrue(permissions.contains(java.nio.file.attribute.PosixFilePermission.OWNER_READ));
            assertFalse(permissions.contains(java.nio.file.attribute.PosixFilePermission.OTHERS_READ));
            assertFalse(permissions.contains(java.nio.file.attribute.PosixFilePermission.GROUP_READ));
        }
    }

    @Test
    void withoutAFileThereIsNoGrant(@TempDir Path dir) throws Exception {
        assertNull(TerminalGrant.read(TerminalGrant.fileOf(dir)));
    }

    @Test
    void aGrantIsBuiltFromThePlatformsAnswerAndTheDevicesRoots() {
        Map<String, Object> platformGrant = Map.of(
                "terminalId", "t9",
                "agentId", "a9",
                "autonomyLevel", "2",
                "capabilities", List.of("cap:fs.read", "cap:shell.exec"),
                "deptIds", List.of(93),
                "grantedAt", "2026-10-26T12:00:00Z");

        TerminalGrant grant = TerminalGrant.from(platformGrant, List.of("/srv/data"));
        assertEquals("t9", grant.terminalId());
        assertEquals(2, grant.autonomyLevel());
        assertEquals(List.of("cap:fs.read", "cap:shell.exec"), grant.capabilities());
        assertEquals(List.of(93), grant.deptIds());
        assertEquals(List.of("/srv/data"), grant.allowedRoots(),
                "the roots are the device's own decision; the platform says what, the device says where");
    }

    @Test
    void theFormatIsWhatTheRustAgentReads() {
        // The Rust runtime deserialises camelCase. If this changes, the two sides stop
        // talking to each other silently - so the names are pinned here.
        TerminalGrant grant = new TerminalGrant("t1", "a1", 2, List.of("cap:fs.read"), List.of(91),
                List.of("/srv/data"), "2026-10-26T12:00:00Z");
        Map<String, Object> map = grant.toMap();
        assertTrue(map.containsKey("terminalId"));
        assertTrue(map.containsKey("agentId"));
        assertTrue(map.containsKey("autonomyLevel"));
        assertTrue(map.containsKey("capabilities"));
        assertTrue(map.containsKey("deptIds"));
        assertTrue(map.containsKey("allowedRoots"));
        assertTrue(map.containsKey("grantedAt"));
    }
}
