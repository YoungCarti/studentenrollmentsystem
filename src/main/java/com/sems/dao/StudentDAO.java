package com.sems.dao;

import com.sems.exception.DatabaseException;
import com.sems.model.Student;
import com.sems.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Student entity.
 * Handles all database operations related to students.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class StudentDAO {
    
    private static final Logger LOGGER = Logger.getLogger(StudentDAO.class.getName());
    
    /**
     * Create a new student in the database
     * 
     * @param student Student object to create
     * @return The generated student ID
     * @throws DatabaseException if creation fails
     */
    public int create(Student student) throws DatabaseException {
        String sql = "INSERT INTO students (first_name, last_name, email, dob, enrollment_date, phone, address) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setString(3, student.getEmail());
            stmt.setDate(4, Date.valueOf(student.getDob()));
            stmt.setDate(5, Date.valueOf(student.getEnrollmentDate()));
            stmt.setString(6, student.getPhone());
            stmt.setString(7, student.getAddress());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new DatabaseException("Creating student failed, no rows affected");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int studentId = generatedKeys.getInt(1);
                    student.setStudentId(studentId);
                    LOGGER.info("Created student with ID: " + studentId);
                    return studentId;
                } else {
                    throw new DatabaseException("Creating student failed, no ID obtained");
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating student", e);
            throw new DatabaseException("Failed to create student: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find a student by ID
     * 
     * @param studentId Student ID to search for
     * @return Student object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public Student findById(int studentId) throws DatabaseException {
        String sql = "SELECT * FROM students WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStudent(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding student by ID", e);
            throw new DatabaseException("Failed to find student: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find a student by email address
     * 
     * @param email Email address to search for
     * @return Student object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public Student findByEmail(String email) throws DatabaseException {
        String sql = "SELECT * FROM students WHERE email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStudent(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding student by email", e);
            throw new DatabaseException("Failed to find student by email: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get all students
     * 
     * @return List of all students
     * @throws DatabaseException if query fails
     */
    public List<Student> findAll() throws DatabaseException {
        String sql = "SELECT * FROM students ORDER BY last_name, first_name";
        List<Student> students = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
            
            LOGGER.info("Retrieved " + students.size() + " students");
            return students;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all students", e);
            throw new DatabaseException("Failed to retrieve students: " + e.getMessage(), e);
        }
    }
    
    /**
     * Search students by name or email
     * 
     * @param keyword Search keyword
     * @return List of matching students
     * @throws DatabaseException if query fails
     */
    public List<Student> searchStudents(String keyword) throws DatabaseException {
        String sql = "SELECT * FROM students WHERE " +
                     "first_name LIKE ? OR last_name LIKE ? OR email LIKE ? " +
                     "ORDER BY last_name, first_name";
        List<Student> students = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    students.add(mapResultSetToStudent(rs));
                }
            }
            
            return students;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching students", e);
            throw new DatabaseException("Failed to search students: " + e.getMessage(), e);
        }
    }
    
    /**
     * Update an existing student
     * 
     * @param student Student object with updated data
     * @return true if update successful, false otherwise
     * @throws DatabaseException if update fails
     */
    public boolean update(Student student) throws DatabaseException {
        String sql = "UPDATE students SET first_name = ?, last_name = ?, email = ?, " +
                     "dob = ?, phone = ?, address = ? WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setString(3, student.getEmail());
            stmt.setDate(4, Date.valueOf(student.getDob()));
            stmt.setString(5, student.getPhone());
            stmt.setString(6, student.getAddress());
            stmt.setInt(7, student.getStudentId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Updated student ID: " + student.getStudentId());
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating student", e);
            throw new DatabaseException("Failed to update student: " + e.getMessage(), e);
        }
    }
    
    /**
     * Delete a student by ID
     * 
     * @param studentId Student ID to delete
     * @return true if deletion successful, false otherwise
     * @throws DatabaseException if deletion fails
     */
    public boolean delete(int studentId) throws DatabaseException {
        String sql = "DELETE FROM students WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Deleted student ID: " + studentId);
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting student", e);
            throw new DatabaseException("Failed to delete student: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get total count of students
     * 
     * @return Total number of students
     * @throws DatabaseException if query fails
     */
    public int getCount() throws DatabaseException {
        String sql = "SELECT COUNT(*) FROM students";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
            return 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting student count", e);
            throw new DatabaseException("Failed to get student count: " + e.getMessage(), e);
        }
    }
    
    /**
     * Map ResultSet row to Student object
     * 
     * @param rs ResultSet with current row
     * @return Student object
     * @throws SQLException if mapping fails
     */
    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentId(rs.getInt("student_id"));
        student.setFirstName(rs.getString("first_name"));
        student.setLastName(rs.getString("last_name"));
        student.setEmail(rs.getString("email"));
        
        Date dob = rs.getDate("dob");
        if (dob != null) {
            student.setDob(dob.toLocalDate());
        }
        
        Date enrollmentDate = rs.getDate("enrollment_date");
        if (enrollmentDate != null) {
            student.setEnrollmentDate(enrollmentDate.toLocalDate());
        }
        
        student.setPhone(rs.getString("phone"));
        student.setAddress(rs.getString("address"));
        
        return student;
    }
}
