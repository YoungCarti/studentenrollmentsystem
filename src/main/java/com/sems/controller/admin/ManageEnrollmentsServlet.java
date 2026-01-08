package com.sems.controller.admin;

import com.sems.exception.DatabaseException;
import com.sems.exception.ValidationException;
import com.sems.model.Enrollment;
import com.sems.model.User;
import com.sems.service.EnrollmentService;
import com.sems.service.SystemActivityService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for managing enrollment requests.
 * Handles approval and rejection of student enrollment requests.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/manage-enrollments")
public class ManageEnrollmentsServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(ManageEnrollmentsServlet.class.getName());
    private EnrollmentService enrollmentService;
    private SystemActivityService activityService;
    
    @Override
    public void init() throws ServletException {
        enrollmentService = new EnrollmentService();
        activityService = new SystemActivityService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user.getRole() != User.Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Get filter parameter
            String statusFilter = request.getParameter("status");
            
            List<Enrollment> enrollments;
            if ("PENDING".equals(statusFilter)) {
                enrollments = enrollmentService.getPendingEnrollments();
            } else if ("APPROVED".equals(statusFilter)) {
                enrollments = enrollmentService.getApprovedEnrollments();
            } else if ("REJECTED".equals(statusFilter)) {
                enrollments = enrollmentService.getRejectedEnrollments();
            } else {
                // Get all enrollments with student and course details
                enrollments = enrollmentService.getAllEnrollmentsWithDetails();
            }
            
            request.setAttribute("enrollments", enrollments);
            request.setAttribute("currentFilter", statusFilter != null ? statusFilter : "ALL");
            
            // Forward to enrollments page
            request.getRequestDispatcher("/admin/enrollments.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading enrollments", e);
            request.setAttribute("error", "Error loading enrollment data");
            request.getRequestDispatcher("/admin/enrollments.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user.getRole() != User.Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("approve".equals(action)) {
            approveEnrollment(request, response, user);
        } else if ("reject".equals(action)) {
            rejectEnrollment(request, response, user);
        } else {
            response.sendRedirect(request.getContextPath() + "/manage-enrollments");
        }
    }
    
    private void approveEnrollment(HttpServletRequest request, HttpServletResponse response, User admin)
            throws ServletException, IOException {
        
        try {
            int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
            
            // Approve the enrollment
            enrollmentService.approveEnrollment(enrollmentId);
            
            // Log activity
            activityService.logActivity(admin.getUserId(), "ADMIN", "APPROVE_ENROLLMENT", 
                "Approved enrollment ID: " + enrollmentId);
            
            LOGGER.info("Enrollment approved: " + enrollmentId + " by admin: " + admin.getUsername());
            
            // Redirect with success message
            response.sendRedirect(request.getContextPath() + "/manage-enrollments?success=Enrollment approved successfully");
            
        } catch (ValidationException e) {
            LOGGER.warning("Validation error approving enrollment: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manage-enrollments?error=" + e.getMessage());
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error approving enrollment", e);
            response.sendRedirect(request.getContextPath() + "/manage-enrollments?error=Error approving enrollment");
        }
    }
    
    private void rejectEnrollment(HttpServletRequest request, HttpServletResponse response, User admin)
            throws ServletException, IOException {
        
        try {
            int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
            String reason = request.getParameter("reason");
            
            if (reason == null || reason.trim().isEmpty()) {
                reason = "No reason provided";
            }
            
            // Reject the enrollment
            enrollmentService.rejectEnrollment(enrollmentId, reason);
            
            // Log activity
            activityService.logActivity(admin.getUserId(), "ADMIN", "REJECT_ENROLLMENT", 
                "Rejected enrollment ID: " + enrollmentId + " - Reason: " + reason);
            
            LOGGER.info("Enrollment rejected: " + enrollmentId + " by admin: " + admin.getUsername());
            
            // Redirect with success message
            response.sendRedirect(request.getContextPath() + "/manage-enrollments?success=Enrollment rejected");
            
        } catch (ValidationException e) {
            LOGGER.warning("Validation error rejecting enrollment: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manage-enrollments?error=" + e.getMessage());
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error rejecting enrollment", e);
            response.sendRedirect(request.getContextPath() + "/manage-enrollments?error=Error rejecting enrollment");
        }
    }
}
