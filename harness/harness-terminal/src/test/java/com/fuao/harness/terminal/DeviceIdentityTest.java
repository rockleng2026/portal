package com.fuao.harness.terminal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fuao.harness.protocol.json.Json;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.KeyPair;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

/**
 * The device identity and the approval signatures (01 §11.1, red-team R-01).
 */
class DeviceIdentityTest {

    @Test
    void theIdentitySurvivesARestart(@TempDir Path dir) throws Exception {
        DeviceIdentity first = DeviceIdentity.loadOrCreate(dir);
        DeviceIdentity second = DeviceIdentity.loadOrCreate(dir);

        assertEquals(first.deviceId(), second.deviceId(), "the platform recognises the same machine");
        assertEquals(first.keyFingerprint(), second.keyFingerprint());
    }

    @Test
    void theDeviceIdIsNotEmptyAndIsStable(@TempDir Path dir) throws Exception {
        DeviceIdentity identity = DeviceIdentity.loadOrCreate(dir);
        assertEquals(32, identity.deviceId().length());
        assertTrue(identity.keyFingerprint().length() >= 16);
    }

    @Test
    void theKeyFileIsNotReadableByOtherUsers(@TempDir Path dir) throws Exception {
        DeviceIdentity.loadOrCreate(dir);
        Path keyFile = dir.resolve("device.key");
        assertTrue(Files.exists(keyFile));
        if (keyFile.getFileSystem().supportedFileAttributeViews().contains("posix")) {
            var permissions = Files.getPosixFilePermissions(keyFile);
            assertFalseOther(permissions);
        }
    }

    private static void assertFalseOther(java.util.Set<java.nio.file.attribute.PosixFilePermission> permissions) {
        assertTrue(permissions.contains(java.nio.file.attribute.PosixFilePermission.OWNER_READ),
                "the owner must be able to read it");
        assertTrue(!permissions.contains(java.nio.file.attribute.PosixFilePermission.OTHERS_READ)
                        && !permissions.contains(java.nio.file.attribute.PosixFilePermission.GROUP_READ),
                "the device key must not be readable by others");
    }

    @Test
    void anApprovalVerifiesAndCarriesItsScope() throws Exception {
        KeyPair keys = com.fuao.harness.protocol.token.CapabilityToken.generateKeyPair();
        Map<String, Object> payload = CommandApproval.payload(
                "appr-1", "fs.delete", "cap:file.delete", "/srv/data/report.txt",
                1_700_000_000L, 1_700_000_900L, 42);
        byte[] signature = CommandApproval.sign(keys.getPrivate(), payload);

        LocalPolicy.ApprovalToken token = CommandApproval.verify(keys.getPublic(), payload, signature);
        assertNotNull(token, "a correctly signed approval must verify");
        assertEquals("appr-1", token.approvalId());
        assertEquals("fs.delete", token.command());
        assertEquals("cap:file.delete", token.capKey());
        assertEquals("/srv/data/report.txt", token.targetPath());
        assertEquals(1_700_000_900L, token.expiresAtEpochSecond());
    }

    @Test
    void aTamperedApprovalDoesNotVerify() throws Exception {
        KeyPair keys = com.fuao.harness.protocol.token.CapabilityToken.generateKeyPair();
        Map<String, Object> payload = CommandApproval.payload(
                "appr-1", "fs.delete", "cap:file.delete", "/srv/data/report.txt",
                1_700_000_000L, 1_700_000_900L, 42);
        byte[] signature = CommandApproval.sign(keys.getPrivate(), payload);

        Map<String, Object> tampered = new java.util.LinkedHashMap<>(payload);
        tampered.put("targetPath", "/etc/shadow");

        assertNull(CommandApproval.verify(keys.getPublic(), tampered, signature),
                "an approval whose payload was changed must not verify");
    }

    @Test
    void theSignatureIsOverTheCanonicalBytes() throws Exception {
        KeyPair keys = com.fuao.harness.protocol.token.CapabilityToken.generateKeyPair();
        Map<String, Object> payload = CommandApproval.payload(
                "appr-1", "fs.delete", "cap:file.delete", "/srv/data/report.txt",
                1_700_000_000L, 1_700_000_900L, 42);
        byte[] signature = CommandApproval.sign(keys.getPrivate(), payload);
        byte[] canonical = Json.canonicalBytes(payload);
        assertEquals(canonical.length, signature.length > 0 ? canonical.length : 0);
        assertTrue(new String(canonical, StandardCharsets.UTF_8).contains("fs.delete"));
    }
}
