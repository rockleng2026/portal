package com.fuao.harness.protocol.frame;

/** Frame types of the terminal<->edge control channel (03 §3.2). */
public enum FrameType {

    HELLO(0x01),
    HELLO_ACK(0x02),
    HEARTBEAT(0x03),
    HEARTBEAT_ACK(0x04),
    CMD(0x05),
    CMD_ACK(0x06),
    RESULT(0x07),
    RESULT_ACK(0x08),
    EVENT(0x09),
    FILE_REQ(0x0A),
    FILE_OFFER(0x0B),
    ERROR(0x0C),
    REVOKE(0x0D),
    UPGRADE(0x0E);

    private static final FrameType[] BY_CODE = new FrameType[256];

    static {
        for (FrameType t : values()) {
            BY_CODE[t.code] = t;
        }
    }

    private final int code;

    FrameType(int code) {
        this.code = code;
    }

    public int code() {
        return code;
    }

    public static FrameType fromCode(int code) {
        FrameType t = (code >= 0 && code < 256) ? BY_CODE[code] : null;
        if (t == null) {
            throw new IllegalArgumentException("unknown frame type 0x" + Integer.toHexString(code));
        }
        return t;
    }
}