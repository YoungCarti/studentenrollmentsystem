package com.sems.controller.admin;

import com.sems.exception.DatabaseException;
import com.sems.model.User;
import com.sems.service.CourseService;
import com.sems.service.EnrollmentService;
import com.sems.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for generating system reports and analytics.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/admin-reports")
public class ReportsServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(ReportsServlet.class.getName());
    private StudentService studentService;
    private CourseService courseService;
    private EnrollmentService enrollmentService;
    
    @Override
    public void init() throws ServletException {
        studentService = new StudentService();
        courseService = new CourseService();
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
        if (user.getRole() != User.Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Calculate statistics
            Map<String, Object> stats = new HashMap<>();
            
            // Basic counts
            stats.put("totalStudents", studentService.getTotalStudentCount());
            stats.put("totalCourses", courseService.getActiveCourseCount());
            stats.put("totalEnrollments", enrollmentService.getAllEnrollmentsWithDetails().size());
            
            // Enrollment status breakdown
            stats.put("pendingEnrollments", enrollmentService.getPendingEnrollmentsCount());
            stats.put("approvedEnrollments", enrollmentService.getApprovedEnrollmentsCount());
            
            // Pass all stats to JSP
            for (Map.Entry<String, Object> entry : stats.entrySet()) {
                request.setAttribute(entry.getKey(), entry.getValue());
            }
            
            // Forward to reports page
            request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error generating reports", e);
            request.setAttribute("error", "Error loading report data");
            request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
        }
    }
}
