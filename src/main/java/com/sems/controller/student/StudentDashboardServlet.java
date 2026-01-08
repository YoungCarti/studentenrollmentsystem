package com.sems.controller.student;

import com.sems.exception.DatabaseException;
import com.sems.model.Enrollment;
import com.sems.model.Student;
import com.sems.model.User;
import com.sems.service.EnrollmentService;
import com.sems.service.StudentService;

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
 * Servlet for student dashboard display.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/student-dashboard")
public class StudentDashboardServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(StudentDashboardServlet.class.getName());
    private StudentService studentService;
    private EnrollmentService enrollmentService;
    
    @Override
    public void init() throws ServletException {
        studentService = new StudentService();
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
        
        try {
            User user = (User) session.getAttribute("user");
            Integer studentId = user.getStudentId();
            
            if (studentId == null) {
                request.setAttribute("error", "Student ID not found");
                request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
                return;
            }
            
            // Get student information
            Student student = studentService.getStudentById(studentId);
            
            // Get student's enrollments with course details
            List<Enrollment> enrollments = enrollmentService.getStudentCoursesWithDetails(studentId);
            
            // Set attributes for JSP
            request.setAttribute("student", student);
            request.setAttribute("enrollments", enrollments);
            request.setAttribute("totalEnrollments", enrollments.size());
            
            // Forward to dashboard page
            request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading student dashboard", e);
            request.setAttribute("error", "Error loading dashboard data");
            request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
        }
    }
}
