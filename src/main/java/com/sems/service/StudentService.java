package com.sems.service;

import com.sems.dao.StudentDAO;
import com.sems.exception.DatabaseException;
import com.sems.exception.ValidationException;
import com.sems.model.Student;
import com.sems.util.ValidationUtil;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service class for Student-related business logic.
 * Handles validation and business rules for student operations.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class StudentService {
    
    private static final Logger LOGGER = Logger.getLogger(StudentService.class.getName());
    private final StudentDAO studentDAO;
    
    /**
     * Constructor
     */
    public StudentService() {
        this.studentDAO = new StudentDAO();
    }
    
    /**
     * Register a new student with validation
     * 
     * @param student Student object to register
     * @return The generated student ID
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public int registerStudent(Student student) throws ValidationException, DatabaseException {
        // Validate student data
        validateStudent(student);
        
        // Check for duplicate email
        Student existing = studentDAO.findByEmail(student.getEmail());
        if (existing != null) {
            throw new ValidationException("Email address already exists: " + student.getEmail());
        }
        
        // Set enrollment date if not set
        if (student.getEnrollmentDate() == null) {
            student.setEnrollmentDate(LocalDate.now());
        }
        
        // Create student
        int studentId = studentDAO.create(student);
        LOGGER.info("Successfully registered new student: " + student.getEmail());
        
        return studentId;
    }
    
    /**
     * Update an existing student
     * 
     * @param student Student object with updated data
     * @return true if update successful
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public boolean updateStudent(Student student) throws ValidationException, DatabaseException {
        // Validate student data
        validateStudent(student);
        
        // Check if student exists
        Student existing = studentDAO.findById(student.getStudentId());
        if (existing == null) {
            throw new ValidationException("Student not found with ID: " + student.getStudentId());
        }
        
        // Check for duplicate email (excluding current student)
        Student emailCheck = studentDAO.findByEmail(student.getEmail());
        if (emailCheck != null && emailCheck.getStudentId() != student.getStudentId()) {
            throw new ValidationException("Email address already exists: " + student.getEmail());
        }
        
        // Update student
        boolean updated = studentDAO.update(student);
        
        if (updated) {
            LOGGER.info("Successfully updated student: " + student.getStudentId());
        }
        
        return updated;
    }
    
    /**
     * Delete a student
     * 
     * @param studentId Student ID to delete
     * @return true if deletion successful
     * @throws DatabaseException if database operation fails
     */
    public boolean deleteStudent(int studentId) throws DatabaseException {
        Student student = studentDAO.findById(studentId);
        if (student == null) {
            return false;
        }
        
        boolean deleted = studentDAO.delete(studentId);
        
        if (deleted) {
            LOGGER.info("Successfully deleted student: " + studentId);
        }
        
        return deleted;
    }
    
    /**
     * Get a student by ID
     * 
     * @param studentId Student ID
     * @return Student object if found, null otherwise
     * @throws DatabaseException if database operation fails
     */
    public Student getStudentById(int studentId) throws DatabaseException {
        return studentDAO.findById(studentId);
    }
    
    /**
     * Get a student by email
     * 
     * @param email Email address
     * @return Student object if found, null otherwise
     * @throws DatabaseException if database operation fails
     */
    public Student getStudentByEmail(String email) throws DatabaseException {
        return studentDAO.findByEmail(email);
    }
    
    /**
     * Get all students
     * 
     * @return List of all students
     * @throws DatabaseException if database operation fails
     */
    public List<Student> getAllStudents() throws DatabaseException {
        return studentDAO.findAll();
    }
    
    /**
     * Search students by keyword
     * 
     * @param keyword Search keyword
     * @return List of matching students
     * @throws DatabaseException if database operation fails
     */
    public List<Student> searchStudents(String keyword) throws DatabaseException {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllStudents();
        }
        return studentDAO.searchStudents(keyword);
    }
    
    /**
     * Get total count of students
     * 
     * @return Total number of students
     * @throws DatabaseException if database operation fails
     */
    public int getTotalStudents() throws DatabaseException {
        return studentDAO.getCount();
    }
    
    /**
     * Get total count of students (alias for getTotalStudents)
     * 
     * @return Total number of students
     * @throws DatabaseException if database operation fails
     */
    public int getTotalStudentCount() throws DatabaseException {
        return getTotalStudents();
    }
    
    /**
     * Validate student data
     * 
     * @param student Student object to validate
     * @throws ValidationException if validation fails
     */
    private void validateStudent(Student student) throws ValidationException {
        if (student == null) {
            throw new ValidationException("Student object cannot be null");
        }
        
        // Validate first name
        if (ValidationUtil.isNullOrEmpty(student.getFirstName())) {
            throw new ValidationException("First name is required");
        }
        
        // Validate last name
        if (ValidationUtil.isNullOrEmpty(student.getLastName())) {
            throw new ValidationException("Last name is required");
        }
        
        // Validate email
        if (!ValidationUtil.isValidEmail(student.getEmail())) {
            throw new ValidationException("Invalid email address format");
        }
        
        // Validate date of birth
        if (student.getDob() == null) {
            throw new ValidationException("Date of birth is required");
        }
        
        // Validate age (must be at least 16 years old)
        LocalDate now = LocalDate.now();
        int age = Period.between(student.getDob(), now).getYears();
        
        if (!ValidationUtil.isValidAge(age)) {
            throw new ValidationException("Student must be between 16 and 100 years old");
        }
        
        // Validate phone number if provided
        if (student.getPhone() != null && !student.getPhone().trim().isEmpty()) {
            if (!ValidationUtil.isValidPhone(student.getPhone())) {
                throw new ValidationException("Invalid phone number format");
            }
        }
    }
}
