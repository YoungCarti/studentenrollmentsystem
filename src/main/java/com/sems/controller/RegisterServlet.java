package com.sems.controller;

import com.sems.exception.DatabaseException;
import com.sems.exception.ValidationException;
import com.sems.model.Student;
import com.sems.model.User;
import com.sems.service.AuthenticationService;
import com.sems.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for handling student registration.
 * 
 * @author SEMS Team
 * @version 1.0
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());
    private StudentService studentService;
    private AuthenticationService authService;
    
    @Override
    public void init() throws ServletException {
        studentService = new StudentService();
        authService = new AuthenticationService();
    }
    
    /**
     * Display registration page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
    }
    
    /**
     * Process registration form submission
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get basic information
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Validate password match
            if (!password.equals(confirmPassword)) {
                throw new ValidationException("Passwords do not match");
            }
            
            // Validate password complexity
            if (!com.sems.util.ValidationUtil.isValidPassword(password)) {
                throw new ValidationException("Password must be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one symbol.");
            }
            
            // Auto-generate username from email (part before @)
            String username = email.substring(0, email.indexOf('@'));
            
            // Create student with default values for optional fields
            Student student = new Student();
            student.setFirstName(firstName);
            student.setLastName(lastName);
            student.setEmail(email);
            student.setDob(LocalDate.of(2000, 1, 1)); // Default DOB
            student.setEnrollmentDate(LocalDate.now());
            student.setPhone("000-0000000"); // Default phone
            student.setAddress("N/A"); // Default address
            
            int studentId = studentService.registerStudent(student);
            
            // Create user account
            authService.register(username, password, User.Role.STUDENT, studentId);
            
            LOGGER.info("New student registered: " + email);
            
            // Redirect to login page with success message
            response.sendRedirect(request.getContextPath() + "/login?registered=true");
            
        } catch (ValidationException e) {
            LOGGER.warning("Registration validation error: " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Database error during registration", e);
            request.setAttribute("error", "System error. Please try again later.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during registration", e);
            request.setAttribute("error", "An error occurred. Please check your input and try again.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }
}
