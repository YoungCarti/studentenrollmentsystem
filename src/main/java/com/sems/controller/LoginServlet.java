package com.sems.controller;

import com.sems.exception.AuthenticationException;
import com.sems.exception.DatabaseException;
import com.sems.model.User;
import com.sems.service.AuthenticationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for handling user login.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());
    private AuthenticationService authService;
    
    @Override
    public void init() throws ServletException {
        authService = new AuthenticationService();
    }
    
    /**
     * Display login page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If already logged in, redirect to appropriate dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectToDashboard(response, user);
            return;
        }
        
        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
    }
    
    /**
     * Process login form submission
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            // Authenticate user
            User user = authService.login(username, password);
            
            // Create new session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole().name());
            
            if (user.getStudentId() != null) {
                session.setAttribute("studentId", user.getStudentId());
            }
            
            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(1800);
            
            LOGGER.info("User logged in: " + username);
            
            // Redirect to appropriate dashboard
            redirectToDashboard(response, user);
            
        } catch (AuthenticationException e) {
            LOGGER.warning("Login failed for username: " + username);
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Database error during login", e);
            request.setAttribute("error", "System error. Please try again later.");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }
    
    /**
     * Redirect user to appropriate dashboard based on role
     */
    private void redirectToDashboard(HttpServletResponse response, User user) throws IOException {
        // Note: sendRedirect already includes the context path automatically for absolute paths
        if (user.getRole() == User.Role.ADMIN) {
            response.sendRedirect("admin-dashboard");
        } else {
            response.sendRedirect("student-dashboard");
        }
    }
}
