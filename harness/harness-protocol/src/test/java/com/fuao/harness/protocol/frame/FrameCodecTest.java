package com.fuao.harness.protocol.frame;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.EnumSet;
import org.junit.jupiter.api.Test;

class FrameCodecTest {

    private static final byte[] DEVICE_KEY = "device-secret-0123456789".getBytes(java.nio.charset.StandardCharsets.UTF_8);

    @Test
    void roundTripsAFrame() throws IOException {
        byte[] payload = "{\"cmd\":\"sys.info\"}".getBytes(java.nio.charset.StandardCharsets.UTF_8);
        Frame frame = Frame.of(FrameType.CMD,
                FrameFlags.encode(EnumSet.of(FrameFlags.Bit.ACK_REQUIRED, FrameFlags.Bit.URGENT)),
                42L, 0xDEADBEEFL, payload, null);

        ByteArrayOutputStream wire = new ByteArrayOutputStream();
        FrameCodec.write(wire, frame, DEVICE_KEY);

        Frame decoded = FrameCodec.read(new ByteArrayInputStream(wire.toByteArray()));
        assertEquals(FrameType.CMD, decoded.type());
        assertEquals(42L, decoded.seq());
        assertEquals(0xDEADBEEFL, decoded.nonce());
        assertArrayEquals(payload, decoded.payload());
        assertEquals(frame.flags(), decoded.flags());
        assertTrue(decoded.flagBits().contains(FrameFlags.Bit.ACK_REQUIRED));
        assertTrue(decoded.verifyMac(DEVICE_KEY));
    }

    @Test
    void headerLayoutMatchesTheDocument() {
        byte[] payload = "x".getBytes(java.nio.charset.StandardCharsets.UTF_8);
        Frame frame = Frame.of(FrameType.HEARTBEAT, 0, 1L, 2L, payload, null);
        byte[] out = FrameCodec.encode(frame, DEVICE_KEY);

        assertEquals(Frame.HEADER_LENGTH + 1 + Frame.HMAC_LENGTH, out.length);
        assertEquals(0x48, out[0] & 0xFF);
        assertEquals(0x4E, out[1] & 0xFF);
        assertEquals(1, out[2]);
        assertEquals(FrameType.HEARTBEAT.code(), out[3]);
        assertEquals(0, out[4]);
        assertEquals(1, Frame.readIntBE(out, 5));       // LENGTH big-endian
        assertEquals(1L, Frame.readLongBE(out, 9));      // SEQ big-endian
        assertEquals(2L, Frame.readLongBE(out, 17));     // NONCE
        assertEquals('x', out[Frame.HEADER_LENGTH]);
    }

    @Test
    void rejectsForeignTraffic() {
        byte[] garbage = new byte[64];
        IOException e = assertThrows(IOException.class,
                () -> FrameCodec.read(new ByteArrayInputStream(garbage)));
        assertTrue(e.getMessage().contains("magic"));
    }

    @Test
    void rejectsAbsurdDeclaredLengthBeforeAllocating() {
        ByteArrayOutputStream wire = new ByteArrayOutputStream();
        wire.write(0x48);
        wire.write(0x4E);
        wire.write(1);
        wire.write(FrameType.CMD.code());
        wire.write(0);
        byte[] length = new byte[4];
        Frame.writeIntBE(length, 0, FrameCodec.MAX_PAYLOAD_BYTES + 1);
        wire.writeBytes(length);
        wire.writeBytes(new byte[16]);

        IOException e = assertThrows(IOException.class,
                () -> FrameCodec.read(new ByteArrayInputStream(wire.toByteArray())));
        assertTrue(e.getMessage().contains("out of bounds"));
    }

    @Test
    void detectsTampering() throws IOException {
        byte[] payload = "{\"cmd\":\"sys.info\"}".getBytes(java.nio.charset.StandardCharsets.UTF_8);
        Frame frame = Frame.of(FrameType.CMD, 0, 7L, 8L, payload, null);
        byte[] wire = FrameCodec.encode(frame, DEVICE_KEY);

        wire[Frame.HEADER_LENGTH] ^= 0x01; // flip one payload bit
        Frame tampered = FrameCodec.read(new ByteArrayInputStream(wire));
        assertFalse(tampered.verifyMac(DEVICE_KEY), "payload tampering must fail the MAC");
    }

    @Test
    void macCoversTypeAndFlagsSoAFrameCannotBeRelabelled() {
        byte[] payload = "{}".getBytes(java.nio.charset.StandardCharsets.UTF_8);
        Frame cmd = Frame.of(FrameType.CMD, 0, 5L, 6L, payload, null);
        Frame relabelled = Frame.of(FrameType.EVENT, 0, 5L, 6L, payload, null);
        assertFalse(java.util.Arrays.equals(cmd.signedBytes(), relabelled.signedBytes()));
    }

    @Test
    void cleanEofReturnsNull() throws IOException {
        assertNull(FrameCodec.read(new ByteArrayInputStream(new byte[0])));
    }
}