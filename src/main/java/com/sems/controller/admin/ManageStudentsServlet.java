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
import java.time.LocalDate;
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
        
        try {
            switch (action) {
                case "add":
                    addStudent(request);
                    request.setAttribute("success", "Student added successfully!");
                    break;
                case "edit":
                    editStudent(request);
                    request.setAttribute("success", "Student updated successfully!");
                    break;
                case "delete":
                    deleteStudent(request);
                    request.setAttribute("success", "Student deleted successfully!");
                    break;
                default:
                    request.setAttribute("error", "Invalid action");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error performing action: " + action, e);
            request.setAttribute("error", e.getMessage());
        }
        
        // Reload students and forward back to the page
        doGet(request, response);
    }
    
    private void addStudent(HttpServletRequest request) throws Exception {
        Student student = new Student();
        student.setFirstName(request.getParameter("firstName"));
        student.setLastName(request.getParameter("lastName"));
        student.setEmail(request.getParameter("email"));
        student.setDob(LocalDate.parse(request.getParameter("dob")));
        student.setPhone(request.getParameter("phone"));
        student.setAddress(request.getParameter("address"));
        student.setEnrollmentDate(LocalDate.now());
        
        studentService.registerStudent(student);
    }
    
    private void editStudent(HttpServletRequest request) throws Exception {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        Student student = studentService.getStudentById(studentId);
        
        if (student == null) {
            throw new Exception("Student not found");
        }
        
        student.setFirstName(request.getParameter("firstName"));
        student.setLastName(request.getParameter("lastName"));
        student.setEmail(request.getParameter("email"));
        student.setDob(LocalDate.parse(request.getParameter("dob")));
        student.setPhone(request.getParameter("phone"));
        student.setAddress(request.getParameter("address"));
        
        studentService.updateStudent(student);
    }
    
    private void deleteStudent(HttpServletRequest request) throws Exception {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        boolean deleted = studentService.deleteStudent(studentId);
        
        if (!deleted) {
            throw new Exception("Failed to delete student");
        }
    }
}
