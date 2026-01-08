package com.sems.controller.student;

import com.sems.exception.DatabaseException;
import com.sems.model.AcademicCalendar;
import com.sems.model.Enrollment;
import com.sems.model.Student;
import com.sems.model.User;
import com.sems.service.AcademicCalendarService;
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
    private AcademicCalendarService calendarService;
    
    @Override
    public void init() throws ServletException {
        studentService = new StudentService();
        enrollmentService = new EnrollmentService();
        calendarService = new AcademicCalendarService();
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
            List<Enrollment> allEnrollments = enrollmentService.getStudentCoursesWithDetails(studentId);
            
            // Filter for approved enrollments only (for course count)
            long approvedCount = allEnrollments.stream()
                    .filter(e -> e.getStatus() == Enrollment.Status.APPROVED)
                    .count();
            
            // Calculate total credits from approved and completed enrollments
            int totalCredits = allEnrollments.stream()
                    .filter(e -> e.getStatus() == Enrollment.Status.APPROVED || 
                                e.getStatus() == Enrollment.Status.COMPLETED)
                    .mapToInt(Enrollment::getCredits)
                    .sum();
            
            // Calculate GPA from completed enrollments with grades
            double averageGpa = calculateGPA(allEnrollments);
            
            // Get academic calendar events
            List<AcademicCalendar> calendarEvents = calendarService.getAllEvents();
            
            // Set attributes for JSP
            request.setAttribute("student", student);
            request.setAttribute("enrollments", allEnrollments);
            request.setAttribute("totalEnrollments", approvedCount);
            request.setAttribute("totalCredits", totalCredits);
            request.setAttribute("averageGpa", String.format("%.2f", averageGpa));
            request.setAttribute("calendarEvents", calendarEvents);
            
            // Forward to dashboard page
            request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading student dashboard", e);
            request.setAttribute("error", "Error loading dashboard data");
            request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
        }
    }
    
    /**
     * Calculate GPA from completed enrollments
     */
    private double calculateGPA(List<Enrollment> enrollments) {
        List<Enrollment> completed = enrollments.stream()
                .filter(e -> e.getStatus() == Enrollment.Status.COMPLETED && e.getGrade() != null)
                .toList();
        
        if (completed.isEmpty()) {
            return 0.0;
        }
        
        double totalPoints = 0.0;
        int totalCredits = 0;
        
        for (Enrollment e : completed) {
            double gradePoint = convertGradeToPoint(e.getGrade());
            totalPoints += gradePoint * e.getCredits();
            totalCredits += e.getCredits();
        }
        
        return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
    }
    
    /**
     * Convert letter grade to grade point
     */
    private double convertGradeToPoint(String grade) {
        switch (grade) {
            case "A": return 4.0;
            case "A-": return 3.7;
            case "B+": return 3.3;
            case "B": return 3.0;
            case "B-": return 2.7;
            case "C+": return 2.3;
            case "C": return 2.0;
            case "C-": return 1.7;
            case "D": return 1.0;
            case "F": return 0.0;
            default: return 0.0;
        }
    }
}
