package com.fuao.harness.protocol.frame;

/**
 * The command code table of the terminal control channel (03 §3.3).
 *
 * <p>Safety metadata lives in this table on purpose. The terminal must be able to refuse a
 * command <em>by itself</em>, even if the edge is compromised or a bug lets an unauthorised
 * frame through: {@link #requiredCapKey()}, {@link #minLevel()}, {@link #idempotent()} and
 * {@link #humanApproval()} are all locally checkable facts about the command, not policy
 * decisions the terminal is expected to trust the network for.
 *
 * <p>Codes are append-only; retired codes stay {@code reserved} (03 §10).
 */
public enum CommandCode {

    SYS_INFO(0x0101, "sys.info", Direction.EDGE_TO_TERMINAL, null, true, 0, false),
    SYS_EXEC(0x0102, "sys.exec", Direction.EDGE_TO_TERMINAL, "cap:ssh.exec", false, 3, false),
    FS_READ(0x0103, "fs.read", Direction.EDGE_TO_TERMINAL, "cap:file.read", true, 0, false),
    FS_WRITE(0x0104, "fs.write", Direction.EDGE_TO_TERMINAL, "cap:file.write", true, 2, false),
    FS_LIST(0x0105, "fs.list", Direction.EDGE_TO_TERMINAL, "cap:file.read", true, 0, false),
    FS_DELETE(0x0106, "fs.delete", Direction.EDGE_TO_TERMINAL, "cap:file.delete", false, 4, true),
    NET_HTTP(0x0110, "net.http", Direction.EDGE_TO_TERMINAL, "cap:http.request", true, 2, false),
    NET_UPLOAD(0x0111, "net.upload", Direction.EDGE_TO_TERMINAL, "cap:http.upload", true, 2, false),
    PROC_LIST(0x0120, "proc.list", Direction.EDGE_TO_TERMINAL, "cap:proc.list", true, 0, false),
    PROC_KILL(0x0121, "proc.kill", Direction.EDGE_TO_TERMINAL, "cap:proc.kill", false, 3, false),
    SCREEN_CAPTURE(0x0130, "screen.capture", Direction.EDGE_TO_TERMINAL, "cap:screen.capture", true, 2, false),
    INPUT_INJECT(0x0131, "input.inject", Direction.EDGE_TO_TERMINAL, "cap:input.inject", false, 4, true),
    APP_LAUNCH(0x0140, "app.launch", Direction.EDGE_TO_TERMINAL, "cap:app.launch", true, 2, false),
    MODEL_INFER(0x0150, "model.infer", Direction.EDGE_TO_TERMINAL, null, true, 0, false),
    MODEL_EMBED(0x0151, "model.embed", Direction.EDGE_TO_TERMINAL, null, true, 0, false),
    BROWSER_OPEN(0x0160, "browser.open", Direction.EDGE_TO_TERMINAL, "cap:browser.open", true, 2, false),
    SKILL_SYNC(0x0200, "skill.sync", Direction.EDGE_TO_TERMINAL, null, true, 0, false),
    EXP_SYNC(0x0201, "exp.sync", Direction.EDGE_TO_TERMINAL, null, true, 0, false),
    AGENT_SELF_REPORT(0x0300, "agent.self_report", Direction.TERMINAL_TO_EDGE, null, true, 0, false),
    CMD_STREAM(0x0310, "cmd.stream", Direction.EDGE_TO_TERMINAL, null, false, 3, false),
    REVOKE(0x0400, "revoke", Direction.EDGE_TO_TERMINAL, null, true, 3, false),
    UPGRADE(0x0500, "upgrade", Direction.EDGE_TO_TERMINAL, null, true, 3, false);

    private static final CommandCode[] BY_CODE = new CommandCode[0x10000];

    static {
        for (CommandCode c : values()) {
            BY_CODE[c.code] = c;
        }
    }

    private final int code;
    private final String commandName;
    private final Direction direction;
    private final String requiredCapKey;
    private final boolean idempotent;
    private final int minLevel;
    private final boolean humanApproval;

    CommandCode(int code, String commandName, Direction direction, String requiredCapKey,
                boolean idempotent, int minLevel, boolean humanApproval) {
        this.code = code;
        this.commandName = commandName;
        this.direction = direction;
        this.requiredCapKey = requiredCapKey;
        this.idempotent = idempotent;
        this.minLevel = minLevel;
        this.humanApproval = humanApproval;
    }

    public int code() {
        return code;
    }

    public String commandName() {
        return commandName;
    }

    public Direction direction() {
        return direction;
    }

    /** {@code cap_key} the terminal must hold, or {@code null} when the command needs none. */
    public String requiredCapKey() {
        return requiredCapKey;
    }

    /**
     * Whether the command may be replayed after a network failure. Non-idempotent commands
     * ({@code sys.exec}, {@code fs.delete}, {@code input.inject}) are never auto-retried -
     * they report the failure instead (03 §3.4).
     */
    public boolean idempotent() {
        return idempotent;
    }

    /** Minimum autonomy level required (01 §5.3). */
    public int minLevel() {
        return minLevel;
    }

    /** Whether the terminal additionally requires a fresh human approval token. */
    public boolean humanApproval() {
        return humanApproval;
    }

    public static CommandCode fromCode(int code) {
        CommandCode c = (code >= 0 && code < BY_CODE.length) ? BY_CODE[code] : null;
        if (c == null) {
            throw new IllegalArgumentException("unknown command code 0x" + Integer.toHexString(code));
        }
        return c;
    }

    public enum Direction {
        EDGE_TO_TERMINAL,
        TERMINAL_TO_EDGE
    }
}