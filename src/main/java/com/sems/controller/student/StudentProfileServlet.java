package com.sems.controller.student;

import com.sems.exception.DatabaseException;
import com.sems.model.Student;
import com.sems.model.User;
import com.sems.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for student profile display.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/student-profile")
public class StudentProfileServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(StudentProfileServlet.class.getName());
    private StudentService studentService;
    
    @Override
    public void init() throws ServletException {
        studentService = new StudentService();
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
                request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
                return;
            }
            
            // Get student information
            Student student = studentService.getStudentById(studentId);
            
            if (student == null) {
                request.setAttribute("error", "Student record not found");
            } else {
                request.setAttribute("student", student);
            }
            
            // Forward to profile page
            request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading student profile", e);
            request.setAttribute("error", "Error loading profile data");
            request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
        }
    }
}
