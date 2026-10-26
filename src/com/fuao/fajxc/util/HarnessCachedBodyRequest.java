package com.fuao.fajxc.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * A request whose body can be read twice.
 *
 * <p>The harness interceptor has to read the body to verify the signature; the action behind it
 * has to read the same body to do its work. Without this wrapper the second reader gets nothing,
 * and the failure shows up as "the client sent no parameters" - a misleading symptom for what is
 * really "we consumed the body".
 */
public class HarnessCachedBodyRequest extends HttpServletRequestWrapper {

    private final byte[] body;

    public HarnessCachedBodyRequest(HttpServletRequest request) throws IOException {
        super(request);
        this.body = readAll(request);
    }

    /** Java 5 source level: InputStream.readAllBytes() does not exist yet. */
    private static byte[] readAll(HttpServletRequest request) throws IOException {
        java.io.ByteArrayOutputStream out = new java.io.ByteArrayOutputStream();
        byte[] buffer = new byte[4096];
        int read;
        while ((read = request.getInputStream().read(buffer)) != -1) {
            out.write(buffer, 0, read);
        }
        return out.toByteArray();
    }

    public byte[] getBody() {
        return body;
    }

    @Override
    public ServletInputStream getInputStream() {
        final ByteArrayInputStream in = new ByteArrayInputStream(body);
        return new ServletInputStream() {
            @Override
            public int read() {
                return in.read();
            }
        };
    }

    @Override
    public BufferedReader getReader() {
        String encoding = getCharacterEncoding();
        try {
            return new BufferedReader(new InputStreamReader(new ByteArrayInputStream(body), encoding));
        } catch (UnsupportedEncodingException e) {
            try {
                return new BufferedReader(new InputStreamReader(new ByteArrayInputStream(body), "UTF-8"));
            } catch (UnsupportedEncodingException ignored) {
                throw new IllegalStateException("no usable charset", ignored);
            }
        }
    }
}
