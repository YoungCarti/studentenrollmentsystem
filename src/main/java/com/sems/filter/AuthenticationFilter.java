package com.sems.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Filter to protect secured pages and require authentication.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    
    // List of public URLs that don't require authentication
    private static final List<String> PUBLIC_URLS = Arrays.asList(
        "/login",
        "/register",
        "/logout",
        "/css/",
        "/js/",
        "/images/"
    );
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Check if the requested path is public
        boolean isPublic = PUBLIC_URLS.stream().anyMatch(path::startsWith);
        
        if (isPublic) {
            // Public resource, allow access
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is authenticated
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (isLoggedIn) {
            // User is authenticated, allow access
            chain.doFilter(request, response);
        } else {
            // User is not authenticated, redirect to login
            httpResponse.sendRedirect(contextPath + "/login");
        }
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
