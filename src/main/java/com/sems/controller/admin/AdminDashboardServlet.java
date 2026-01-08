package com.sems.controller.admin;

import com.sems.exception.DatabaseException;
import com.sems.service.CourseService;
import com.sems.service.EnrollmentService;
import com.sems.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for admin dashboard display.
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
    
    @Override
    public void init() throws ServletException {
        studentService = new StudentService();
        courseService = new CourseService();
        enrollmentService = new EnrollmentService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get dashboard statistics
            int totalStudents = studentService.getTotalStudents();
            int totalCourses = courseService.getTotalCourses();
            int totalEnrollments = enrollmentService.getTotalEnrollments();
            
            // Set attributes for JSP
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("totalCourses", totalCourses);
            request.setAttribute("totalEnrollments", totalEnrollments);
            
            // Forward to dashboard page
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading admin dashboard", e);
            request.setAttribute("error", "Error loading dashboard data");
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        }
    }
}
