package com.sems.controller.admin;

import com.sems.exception.DatabaseException;
import com.sems.exception.ValidationException;
import com.sems.model.Course;
import com.sems.model.User;
import com.sems.service.CourseService;

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
 * Servlet for managing courses.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/admin-courses")
public class AdminCourseServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(AdminCourseServlet.class.getName());
    private CourseService courseService;
    
    @Override
    public void init() throws ServletException {
        courseService = new CourseService();
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
            // Get all courses
            List<Course> courses = courseService.getAllCourses();
            request.setAttribute("courses", courses);
            
            // Forward to courses page
            request.getRequestDispatcher("/admin/courses.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading courses", e);
            request.setAttribute("error", "Error loading courses data");
            request.getRequestDispatcher("/admin/courses.jsp").forward(request, response);
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
        
        if ("add".equals(action)) {
            addCourse(request, response);
        } else if ("edit".equals(action)) {
            editCourse(request, response);
        } else if ("delete".equals(action)) {
            deleteCourse(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin-courses");
        }
    }
    
    private void addCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get course data from form
            String courseCode = request.getParameter("courseCode");
            String courseName = request.getParameter("courseName");
            int credits = Integer.parseInt(request.getParameter("credits"));
            String department = request.getParameter("department");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String instructor = request.getParameter("instructor");
            String schedule = request.getParameter("schedule");
            
            // Create course object
            Course course = new Course();
            course.setCourseCode(courseCode);
            course.setCourseName(courseName);
            course.setCredits(credits);
            course.setDepartment(department);
            course.setCapacity(capacity);
            course.setInstructor(instructor);
            course.setSchedule(schedule);
            
            // Save to database
            courseService.createCourse(course);
            
            // Redirect with success message
            response.sendRedirect(request.getContextPath() + "/admin-courses?success=Course added successfully");
            
        } catch (ValidationException e) {
            LOGGER.warning("Validation error adding course: " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Database error adding course", e);
            request.setAttribute("error", "Error adding course: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private void editCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement edit functionality
        response.sendRedirect(request.getContextPath() + "/admin-courses");
    }
    
    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement delete functionality
        response.sendRedirect(request.getContextPath() + "/admin-courses");
    }
}
