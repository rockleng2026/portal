package com.fuao.fajxc.interceptor;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.interceptor.Interceptor;

import com.fuao.fajxc.util.HarnessCachedBodyRequest;
import com.fuao.fajxc.util.HarnessHmac;
import com.fuao.fajxc.util.HarnessJson;

/**
 * Authenticates calls to the harness API namespace (/api/harness/**).
 *
 * <p>This is a completely separate identity system from the portal's. Portal humans are
 * identified by a reversible cookie password and their authority is resolved by scraping the
 * request URL (01 ¡ì2.1 conclusion B). A digital employee must never travel on that machinery:
 * a leaked cookie would otherwise be the loss of a whole organisation's authority. So the
 * harness namespace speaks HMAC service-account authentication and never touches the cookie
 * session (ADR-004).
 *
 * <p>Checks, in order, with the cheapest first:
 * <ol>
 *   <li>all four headers present;</li>
 *   <li>client id equals the one configured for this portal;</li>
 *   <li>timestamp inside the configured clock skew;</li>
 *   <li>nonce not seen before (replay protection, per node - see the class note in the
 *       configuration file);</li>
 *   <li>HMAC signature matches.</li>
 * </ol>
 *
 * <p>A rejected call never reaches the action, and the rejection is written to the log with a
 * stable marker so the platform's audit trail and the portal's log can be correlated.
 */
public class HarnessApiInterceptor implements Interceptor {

    private static final Logger logger = Logger.getLogger(HarnessApiInterceptor.class);

    public static final String HEADER_CLIENT = "X-Harness-Client";
    public static final String HEADER_TIMESTAMP = "X-Harness-Timestamp";
    public static final String HEADER_NONCE = "X-Harness-Nonce";
    public static final String HEADER_SIGNATURE = "X-Harness-Signature";

    private static final String CONFIG_RESOURCE = "/WEB-INF/props/harness-api.properties";
    private static final String SECURITY_MARKER = "[HARNESS-SECURITY]";

    private String clientId;
    private String secret;
    private long clockSkewSeconds;
    private long nonceTtlSeconds;
    private boolean enabled;
    private volatile boolean configured;

    /**
     * Nonces already seen, per node. A portal cluster would need a shared store here; the
     * configuration file says so explicitly rather than leaving a silent multi-node hole.
     */
    private final Map<String, Long> seenNonces = new HashMap<String, Long>();

    /**
     * Loads the configuration.
     *
     * <p>Struts calls {@code init()} while it builds the configuration, which is before the
     * servlet context exists - so the context is not available here and the configuration is
     * loaded lazily on the first request instead. The file lives under {@code /WEB-INF}, where
     * only the application may read it.
     */
    public void init() {
        configured = false;
    }

    public void destroy() {
        synchronized (seenNonces) {
            seenNonces.clear();
        }
    }

    /**
     * Reads the configuration once, on the first call.
     *
     * <p>The namespace stays closed until the file has been read: "the file is missing" and "the
     * namespace is off" must not be confused with "the namespace is on".
     */
    private synchronized void ensureConfigured() {
        if (configured) {
            return;
        }
        configured = true;
        Properties properties = new Properties();
        InputStream in = null;
        try {
            ServletContext context = ServletActionContext.getServletContext();
            if (context != null) {
                in = context.getResourceAsStream(CONFIG_RESOURCE);
            }
            if (in == null) {
                logger.error(SECURITY_MARKER + " cannot read " + CONFIG_RESOURCE
                        + "; the harness API namespace stays closed");
            } else {
                properties.load(in);
            }
        } catch (IOException e) {
            logger.error(SECURITY_MARKER + " cannot read " + CONFIG_RESOURCE + ": " + e.getMessage());
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException ignored) {
                    // nothing useful to do
                }
            }
        }
        clientId = properties.getProperty("harness.api.clientId", "");
        secret = properties.getProperty("harness.api.secret", "");
        clockSkewSeconds = parseLong(properties.getProperty("harness.api.clockSkewSeconds"), 300);
        nonceTtlSeconds = parseLong(properties.getProperty("harness.api.nonceTtlSeconds"), 300);
        enabled = "true".equalsIgnoreCase(properties.getProperty("harness.api.enabled", "false"));
        if (enabled && secret.length() < 24) {
            enabled = false;
            logger.error(SECURITY_MARKER + " harness API enabled but the shared secret is shorter than 24 "
                    + "characters; the namespace stays closed");
        }
        if (enabled && clientId.length() == 0) {
            enabled = false;
            logger.error(SECURITY_MARKER + " harness API enabled but no client id is configured; "
                    + "the namespace stays closed");
        }
        if (enabled) {
            logger.info("harness API namespace enabled for client '" + clientId + "'");
        } else {
            logger.warn("harness API namespace is disabled: every /api/harness/** call is refused");
        }
    }

    public String intercept(com.opensymphony.xwork2.ActionInvocation invocation) throws Exception {
        ensureConfigured();

        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();

        if (!enabled) {
            return reject(request, response, invocation, 503, "HARNESS_API_DISABLED",
                    "the harness API namespace is not enabled on this portal");
        }

        HarnessCachedBodyRequest cached = new HarnessCachedBodyRequest(request);
        String client = request.getHeader(HEADER_CLIENT);
        String timestamp = request.getHeader(HEADER_TIMESTAMP);
        String nonce = request.getHeader(HEADER_NONCE);
        String signature = request.getHeader(HEADER_SIGNATURE);

        if (client == null || timestamp == null || nonce == null || signature == null) {
            return reject(request, response, invocation, 401, "MISSING_CREDENTIALS",
                    "all of " + HEADER_CLIENT + ", " + HEADER_TIMESTAMP + ", " + HEADER_NONCE + ", "
                            + HEADER_SIGNATURE + " are required");
        }
        if (!clientId.equals(client)) {
            return reject(request, response, invocation, 403, "UNKNOWN_CLIENT",
                    "unknown client: " + client);
        }

        long sentAt;
        try {
            sentAt = Long.parseLong(timestamp.trim());
        } catch (NumberFormatException e) {
            return reject(request, response, invocation, 400, "BAD_TIMESTAMP",
                    HEADER_TIMESTAMP + " must be unix seconds");
        }
        long now = System.currentTimeMillis() / 1000L;
        if (Math.abs(now - sentAt) > clockSkewSeconds) {
            return reject(request, response, invocation, 401, "CLOCK_SKEW",
                    "timestamp is outside the " + clockSkewSeconds + "s window");
        }

        String key = HarnessHmac.deriveKey(secret);
        if (!HarnessHmac.verify(key, signature, request.getMethod(), request.getRequestURI(),
                timestamp, nonce, cached.getBody())) {
            return reject(request, response, invocation, 401, "BAD_SIGNATURE",
                    "signature does not match");
        }
        // The nonce is only claimed once the signature is proven. Claiming it first would let
        // anybody burn a nonce that a legitimate client is about to use.
        if (!claimNonce(nonce)) {
            return reject(request, response, invocation, 401, "NONCE_REPLAY",
                    "nonce already used");
        }

        // Hand the still-readable body to the rest of the chain: the interceptor consumed the
        // input stream to verify the signature, so without this the action sees an empty
        // request and reports "no parameters" for a call that did carry them.
        ServletActionContext.getContext().put(ServletActionContext.HTTP_REQUEST, cached);
        Map parsed = HarnessJson.parseObject(cached.getBody());
        if (parsed != null) {
            cached.setAttribute("harness.parameters", parsed);
        }
        return invocation.invoke();
    }

    private boolean claimNonce(String nonce) {
        long now = System.currentTimeMillis();
        synchronized (seenNonces) {
            Iterator<Map.Entry<String, Long>> it = seenNonces.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry<String, Long> entry = it.next();
                if (entry.getValue().longValue() < now) {
                    it.remove();
                }
            }
            Long previous = seenNonces.get(nonce);
            if (previous != null && previous.longValue() >= now) {
                return false;
            }
            seenNonces.put(nonce, Long.valueOf(now + nonceTtlSeconds * 1000L));
            return true;
        }
    }

    /**
     * Refuses the call. The response body is left empty on purpose: the platform reads the status
     * code and the marker in the log, and an error body here would have to be parsed by a client
     * that is a Struts action, not a JSON API.
     */
    private String reject(HttpServletRequest request, HttpServletResponse response,
                          com.opensymphony.xwork2.ActionInvocation invocation, int status, String code,
                          String message) throws IOException {
        logger.warn(SECURITY_MARKER + " rejected " + request.getRequestURI() + " code=" + code + " client="
                + request.getHeader(HEADER_CLIENT) + " remote=" + request.getRemoteAddr() + " reason=" + message);
        response.setStatus(status);

        Object action = invocation.getAction();
        if (action instanceof com.fuao.fajxc.action.harness.HarnessApiAction) {
            // The json result renders the body, so the interceptor only sets the status and the
            // error payload. Writing the body here as well would produce two documents.
            ((com.fuao.fajxc.action.harness.HarnessApiAction) action).setError(code, message);
        } else {
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(HarnessJson.of("error", errorBody(code, message)));
            response.getWriter().flush();
        }
        return "harnessRejected";
    }

    private static HarnessJson.HarnessMap errorBody(String code, String message) {
        HarnessJson.HarnessMap error = new HarnessJson.HarnessMap();
        error.put("code", code);
        error.put("message", message);
        return error;
    }

    private static long parseLong(String value, long fallback) {
        try {
            return Long.parseLong(value.trim());
        } catch (Exception e) {
            return fallback;
        }
    }
}
