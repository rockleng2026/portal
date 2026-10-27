package com.fuao.harness.platform.web;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * The console is served from the same jar as the API, so a browser that cached the old
 * JavaScript would keep talking to a changed API - and the symptom is baffling: the panel
 * says "pending" while the terminal has already answered, because the polling request is
 * rejected and nobody says so.
 *
 * <p>So: the console's assets are never cached, and a request for it carries the build's
 * version so a stale page is obvious in the network tab.
 */
@Configuration
public class ConsoleWebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new HandlerInterceptor() {
            @Override
            public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                                    Object handler) {
                if (request.getRequestURI().startsWith("/console/")) {
                    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
                    response.setHeader("Pragma", "no-cache");
                    response.setDateHeader("Expires", 0);
                }
                return true;
            }
        }).addPathPatterns("/console/**");
    }
}
