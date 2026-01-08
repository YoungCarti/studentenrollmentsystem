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
 * Servlet for managing student results/grades.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/manage-results")
public class ManageResultsServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(ManageResultsServlet.class.getName());
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
            // Get all approved enrollments (courses students are taking)
            List<Enrollment> approvedEnrollments = enrollmentService.getApprovedEnrollments();
            request.setAttribute("enrollments", approvedEnrollments);
            
            // Forward to results page
            request.getRequestDispatcher("/admin/results.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading enrollments for grading", e);
            request.setAttribute("error", "Error loading enrollment data");
            request.getRequestDispatcher("/admin/results.jsp").forward(request, response);
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
        
        try {
            int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
            String grade = request.getParameter("grade");
            
            // Assign grade to enrollment
            enrollmentService.assignGrade(enrollmentId, grade);
            
            // Log activity
            activityService.logActivity(user.getUserId(), "ADMIN", "ASSIGN_GRADE", 
                "Assigned grade " + grade + " to enrollment ID: " + enrollmentId);
            
            LOGGER.info("Grade assigned: " + grade + " for enrollment: " + enrollmentId);
            
            // Redirect with success message
            response.sendRedirect(request.getContextPath() + "/manage-results?success=Grade assigned successfully");
            
        } catch (ValidationException e) {
            LOGGER.warning("Validation error assigning grade: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manage-results?error=" + e.getMessage());
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error assigning grade", e);
            response.sendRedirect(request.getContextPath() + "/manage-results?error=Error assigning grade");
        }
    }
}
