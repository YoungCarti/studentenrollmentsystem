package com.sems.controller.admin;

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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for managing students.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/manage-students")
public class ManageStudentsServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(ManageStudentsServlet.class.getName());
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
        
        User user = (User) session.getAttribute("user");
        if (user.getRole() != User.Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Get all students
            List<Student> students = studentService.getAllStudents();
            request.setAttribute("students", students);
            
            // Forward to students page
            request.getRequestDispatcher("/admin/students.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading students", e);
            request.setAttribute("error", "Error loading students data");
            request.getRequestDispatcher("/admin/students.jsp").forward(request, response);
        }
    }
}
