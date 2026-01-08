package com.sems.controller.admin;

import com.sems.exception.DatabaseException;
import com.sems.model.SystemActivity;
import com.sems.model.User;
import com.sems.service.CourseService;
import com.sems.service.EnrollmentService;
import com.sems.service.StudentService;
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
 * Servlet for admin dashboard display with real-time statistics.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(AdminDashboardServlet.class.getName());
    private StudentService studentService;
    private CourseService courseService;
    private EnrollmentService enrollmentService;
    private SystemActivityService activityService;
    
    @Override
    public void init() throws ServletException {
        studentService = new StudentService();
        courseService = new CourseService();
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
            // Get real-time statistics
            int totalStudents = studentService.getTotalStudentCount();
            int activeCourses = courseService.getActiveCourseCount();
            int pendingEnrollments = enrollmentService.getPendingEnrollmentsCount();
            int approvedEnrollments = enrollmentService.getApprovedEnrollmentsCount();
            
            // Get recent system activities (last 10)
            List<SystemActivity> recentActivities = activityService.getRecentActivities(10);
            
            // Set attributes for JSP
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("activeCourses", activeCourses);
            request.setAttribute("pendingEnrollments", pendingEnrollments);
            request.setAttribute("approvedEnrollments", approvedEnrollments);
            request.setAttribute("recentActivities", recentActivities);
            
            // Forward to dashboard
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading admin dashboard", e);
            request.setAttribute("error", "Error loading dashboard data");
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        }
    }
}
