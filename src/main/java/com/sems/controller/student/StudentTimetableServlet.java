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
 * Servlet for displaying student timetable based on enrolled courses.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/student-timetable")
public class StudentTimetableServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(StudentTimetableServlet.class.getName());
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
        
        if (user.getRole() != User.Role.STUDENT || user.getStudentId() == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            Integer studentId = user.getStudentId();
            
            // Get student's approved enrollments with course details (including schedule)
            List<Enrollment> enrollments = enrollmentService.getStudentCoursesWithDetails(studentId);
            
            // Filter only approved enrollments for timetable
            List<Enrollment> approvedEnrollments = enrollments.stream()
                .filter(e -> e.getStatus() == Enrollment.Status.APPROVED || 
                           e.getStatus() == Enrollment.Status.COMPLETED)
                .collect(java.util.stream.Collectors.toList());
            
            request.setAttribute("enrollments", approvedEnrollments);
            
            // Forward to timetable page
            request.getRequestDispatcher("/student/timetable.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading timetable", e);
            request.setAttribute("error", "Error loading timetable data");
            request.getRequestDispatcher("/student/timetable.jsp").forward(request, response);
        }
    }
}
