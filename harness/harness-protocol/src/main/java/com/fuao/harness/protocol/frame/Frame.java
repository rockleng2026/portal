package com.fuao.harness.protocol.frame;

import java.util.Arrays;
import java.util.Objects;
import java.util.Set;

/**
 * One control-channel frame (03 §3.2).
 *
 * <pre>
 *  0               1               2               3
 *  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
 * +-------------------------------+-------------------------------+
 * |          MAGIC 0x484E ('HN')   |          VERSION (1B)         |
 * +-------------------------------+-------------------------------+
 * |          TYPE (1B)             |          FLAGS (1B)           |
 * +-------------------------------+-------------------------------+
 * |                        LENGTH (4B, uint32 BE)                  |
 * +---------------------------------------------------------------+
 * |                        SEQ (8B, uint64 BE)                     |
 * +---------------------------------------------------------------+
 * |                        NONCE (8B)                              |
 * +---------------------------------------------------------------+
 * |                        PAYLOAD (LENGTH bytes)                  |
 * +---------------------------------------------------------------+
 * |                        HMAC-SHA256 (32B)                       |
 * +---------------------------------------------------------------+
 * </pre>
 */
public final class Frame {

    public static final byte MAGIC_HI = 0x48; // 'H'
    public static final byte MAGIC_LO = 0x4E; // 'N'
    public static final byte VERSION = 0x01;

    /** header = magic(2) + version(1) + type(1) + flags(1) + length(4) + seq(8) + nonce(8) */
    public static final int HEADER_LENGTH = 25;
    public static final int HMAC_LENGTH = 32;

    private final byte version;
    private final FrameType type;
    private final int flags;
    private final long seq;
    private final long nonce;
    private final byte[] payload;
    private final byte[] mac;

    public Frame(byte version, FrameType type, int flags, long seq, long nonce, byte[] payload, byte[] mac) {
        this.version = version;
        this.type = Objects.requireNonNull(type, "type");
        this.flags = flags;
        this.seq = seq;
        this.nonce = nonce;
        this.payload = payload == null ? new byte[0] : payload.clone();
        this.mac = mac == null ? new byte[0] : mac.clone();
    }

    public static Frame of(FrameType type, int flags, long seq, long nonce, byte[] payload, byte[] mac) {
        return new Frame(VERSION, type, flags, seq, nonce, payload, mac);
    }

    public byte version() {
        return version;
    }

    public FrameType type() {
        return type;
    }

    public int flags() {
        return flags;
    }

    public Set<FrameFlags.Bit> flagBits() {
        return FrameFlags.decode(flags);
    }

    public long seq() {
        return seq;
    }

    public long nonce() {
        return nonce;
    }

    public byte[] payload() {
        return payload.clone();
    }

    public byte[] mac() {
        return mac.clone();
    }

    /** Total wire size of this frame. */
    public int wireLength() {
        return HEADER_LENGTH + payload.length + mac.length;
    }

    /**
     * The exact bytes covered by the MAC. Errata E-05: 03 §3.1 only names
     * {@code HMAC(seq, nonce, payload)}; we additionally bind type, flags, length and magic
     * so an attacker cannot re-label a {@code CMD} frame as something harmless or truncate
     * the payload. Both sides use this method, so the wire contract is well defined.
     */
    public byte[] signedBytes() {
        byte[] out = new byte[HEADER_LENGTH + payload.length];
        out[0] = MAGIC_HI;
        out[1] = MAGIC_LO;
        out[2] = version;
        out[3] = (byte) type.code();
        out[4] = (byte) flags;
        writeIntBE(out, 5, payload.length);
        writeLongBE(out, 9, seq);
        writeLongBE(out, 17, nonce);
        System.arraycopy(payload, 0, out, HEADER_LENGTH, payload.length);
        return out;
    }

    /** Recomputes the MAC over {@link #signedBytes()}. */
    public byte[] computeMac(byte[] deviceKey) {
        return com.fuao.harness.protocol.Digests.hmacSha256(deviceKey, signedBytes());
    }

    /** Verifies the MAC in constant time. */
    public boolean verifyMac(byte[] deviceKey) {
        return mac.length == HMAC_LENGTH
                && com.fuao.harness.protocol.Digests.constantTimeEquals(mac, computeMac(deviceKey));
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Frame f)) {
            return false;
        }
        return version == f.version && type == f.type && flags == f.flags && seq == f.seq
                && nonce == f.nonce && Arrays.equals(payload, f.payload) && Arrays.equals(mac, f.mac);
    }

    @Override
    public int hashCode() {
        return Objects.hash(version, type, flags, seq, nonce, Arrays.hashCode(payload), Arrays.hashCode(mac));
    }

    @Override
    public String toString() {
        return "Frame[type=" + type + ", flags=0x" + Integer.toHexString(flags)
                + ", seq=" + seq + ", nonce=" + nonce + ", payload=" + payload.length + "B]";
    }

    static void writeIntBE(byte[] buf, int off, int v) {
        buf[off] = (byte) (v >>> 24);
        buf[off + 1] = (byte) (v >>> 16);
        buf[off + 2] = (byte) (v >>> 8);
        buf[off + 3] = (byte) v;
    }

    static void writeLongBE(byte[] buf, int off, long v) {
        for (int i = 0; i < 8; i++) {
            buf[off + i] = (byte) (v >>> (56 - 8 * i));
        }
    }

    static int readIntBE(byte[] buf, int off) {
        return ((buf[off] & 0xFF) << 24) | ((buf[off + 1] & 0xFF) << 16)
                | ((buf[off + 2] & 0xFF) << 8) | (buf[off + 3] & 0xFF);
    }

    static long readLongBE(byte[] buf, int off) {
        long v = 0;
        for (int i = 0; i < 8; i++) {
            v = (v << 8) | (buf[off + i] & 0xFFL);
        }
        return v;
    }
}