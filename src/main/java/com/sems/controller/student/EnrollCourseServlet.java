package com.sems.controller.student;

import com.sems.exception.DatabaseException;
import com.sems.exception.ValidationException;
import com.sems.model.Course;
import com.sems.model.Enrollment;
import com.sems.model.User;
import com.sems.service.CourseService;
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
 * Servlet for student course enrollment.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/enroll-course")
public class EnrollCourseServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(EnrollCourseServlet.class.getName());
    private CourseService courseService;
    private EnrollmentService enrollmentService;
    private SystemActivityService activityService;
    
    @Override
    public void init() throws ServletException {
        courseService = new CourseService();
        enrollmentService = new EnrollmentService();
        activityService = new SystemActivityService();
    }
    
    /**
     * Display available courses
     */
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
            
            // Get all available courses
            List<Course> allCourses = courseService.getAllCourses();
            
            // Get student's enrollments
            List<Enrollment> enrollments = new java.util.ArrayList<>();
            if (studentId != null) {
                enrollments = enrollmentService.getStudentCoursesWithDetails(studentId);
                
                // Filter out courses student is already enrolled in (PENDING, APPROVED, COMPLETED)
                java.util.Set<Integer> enrolledCourseIds = new java.util.HashSet<>();
                for (Enrollment e : enrollments) {
                    if (e.getStatus() == Enrollment.Status.PENDING || 
                        e.getStatus() == Enrollment.Status.APPROVED ||
                        e.getStatus() == Enrollment.Status.COMPLETED) {
                        enrolledCourseIds.add(e.getCourseId());
                    }
                }
                
                // Filter available courses
                List<Course> availableCourses = new java.util.ArrayList<>();
                for (Course c : allCourses) {
                    if (!enrolledCourseIds.contains(c.getCourseId())) {
                        availableCourses.add(c);
                    }
                }
                
                request.setAttribute("courses", availableCourses);
                request.setAttribute("enrollments", enrollments);
            } else {
                request.setAttribute("courses", allCourses);
            }
            
            request.getRequestDispatcher("/student/courses.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading courses", e);
            request.setAttribute("error", "Error loading courses");
            request.getRequestDispatcher("/student/courses.jsp").forward(request, response);
        }
    }
    
    /**
     * Process enrollment
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
                throw new ValidationException("Student ID not found");
            }
            
            String action = request.getParameter("action");
            
            if ("enroll".equals(action)) {
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                enrollmentService.enrollStudent(studentId, courseId);
                
                // Log activity
                activityService.logActivity(user.getUserId(), "STUDENT", "ENROLL_COURSE", 
                    "Enrolled in course ID: " + courseId);
                
                request.setAttribute("success", "Successfully enrolled in course");
                
            } else if ("drop".equals(action)) {
                int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
                LOGGER.info("DROP ACTION RECEIVED - Enrollment ID: " + enrollmentId + " by student: " + studentId);
                enrollmentService.dropCourse(enrollmentId);
                LOGGER.info("DROP ACTION COMPLETED - Enrollment ID: " + enrollmentId);
                
                // Log activity
                activityService.logActivity(user.getUserId(), "STUDENT", "DROP_COURSE", 
                    "Dropped enrollment ID: " + enrollmentId);
                
                request.setAttribute("success", "Successfully dropped course");
            }
            
            // Redirect to avoid form resubmission
            response.sendRedirect(request.getContextPath() + "/enroll-course");
            
        } catch (ValidationException e) {
            LOGGER.warning("Enrollment validation error: " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Database error during enrollment", e);
            request.setAttribute("error", "System error. Please try again later.");
            doGet(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid request parameters");
            doGet(request, response);
        }
    }
}
