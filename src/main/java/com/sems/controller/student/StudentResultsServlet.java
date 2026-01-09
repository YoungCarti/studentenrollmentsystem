package com.sems.controller.student;

import com.sems.exception.DatabaseException;
import com.sems.model.Enrollment;
import com.sems.model.User;
import com.sems.service.EnrollmentService;

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
 * Servlet for student to view their academic results.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/student-results")
public class StudentResultsServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(StudentResultsServlet.class.getName());
    private EnrollmentService enrollmentService;
    
    @Override
    public void init() throws ServletException {
        enrollmentService = new EnrollmentService();
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
        if (user.getRole() != User.Role.STUDENT) {
            response.sendRedirect(request.getContextPath() + "/student-dashboard");
            return;
        }
        
        try {
            // Get student's transcript (completed courses with grades)
            Integer studentId = user.getStudentId();
            if (studentId == null) {
                request.setAttribute("error", "Student profile not found. Please contact administrator.");
                request.getRequestDispatcher("/student/results.jsp").forward(request, response);
                return;
            }
            
            List<Enrollment> results = enrollmentService.getStudentTranscript(studentId);
            request.setAttribute("results", results);
            
            // Forward to results page
            request.getRequestDispatcher("/student/results.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading student results", e);
            request.setAttribute("error", "Failed to load examination results. Please try again later.");
            request.getRequestDispatcher("/student/results.jsp").forward(request, response);
        }
    }
}
