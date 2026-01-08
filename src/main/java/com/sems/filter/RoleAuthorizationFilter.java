package com.sems.filter;

import com.sems.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter to enforce role-based access control.
 * Ensures admin pages are only accessible by admins and student pages by students.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebFilter({"/admin/*", "/student/*"})
public class RoleAuthorizationFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        HttpSession session = httpRequest.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            // No session, redirect to login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Check role-based access
        if (path.startsWith("/admin/")) {
            // Admin pages - require ADMIN role
            if (user.getRole() != User.Role.ADMIN) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, 
                    "Access denied. Admin privileges required.");
                return;
            }
        } else if (path.startsWith("/student/")) {
            // Student pages - require STUDENT role
            if (user.getRole() != User.Role.STUDENT) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, 
                    "Access denied. Student privileges required.");
                return;
            }
        }
        
        // User has appropriate role, allow access
        chain.doFilter(request, response);
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
