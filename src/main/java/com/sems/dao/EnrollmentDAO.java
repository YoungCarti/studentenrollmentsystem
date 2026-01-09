package com.sems.dao;

import com.sems.exception.DatabaseException;
import com.sems.model.Enrollment;
import com.sems.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Enrollment entity.
 * Handles all database operations related to enrollments.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class EnrollmentDAO {
    
    private static final Logger LOGGER = Logger.getLogger(EnrollmentDAO.class.getName());
    
    /**
     * Create a new enrollment
     * 
     * @param enrollment Enrollment object to create
     * @return The generated enrollment ID
     * @throws DatabaseException if creation fails
     */
    public int create(Enrollment enrollment) throws DatabaseException {
        String sql = "INSERT INTO enrollments (student_id, course_id, enrollment_date, grade, status) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, enrollment.getStudentId());
            stmt.setInt(2, enrollment.getCourseId());
            stmt.setDate(3, Date.valueOf(enrollment.getEnrollmentDate()));
            stmt.setString(4, enrollment.getGrade());
            stmt.setString(5, enrollment.getStatus().name());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new DatabaseException("Creating enrollment failed, no rows affected");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int enrollmentId = generatedKeys.getInt(1);
                    enrollment.setEnrollmentId(enrollmentId);
                    LOGGER.info("Created enrollment with ID: " + enrollmentId);
                    return enrollmentId;
                } else {
                    throw new DatabaseException("Creating enrollment failed, no ID obtained");
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating enrollment", e);
            throw new DatabaseException("Failed to create enrollment: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find an enrollment by ID
     * 
     * @param enrollmentId Enrollment ID to search for
     * @return Enrollment object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public Enrollment findById(int enrollmentId) throws DatabaseException {
        String sql = "SELECT * FROM enrollments WHERE enrollment_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, enrollmentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEnrollment(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding enrollment by ID", e);
            throw new DatabaseException("Failed to find enrollment: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find all enrollments for a student
     * 
     * @param studentId Student ID
     * @return List of enrollments for the student
     * @throws DatabaseException if query fails
     */
    public List<Enrollment> findByStudentId(int studentId) throws DatabaseException {
        String sql = "SELECT * FROM enrollments WHERE student_id = ? ORDER BY enrollment_date DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(mapResultSetToEnrollment(rs));
                }
            }
            
            return enrollments;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding enrollments by student ID", e);
            throw new DatabaseException("Failed to find enrollments: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find all enrollments for a course
     * 
     * @param courseId Course ID
     * @return List of enrollments for the course
     * @throws DatabaseException if query fails
     */
    public List<Enrollment> findByCourseId(int courseId) throws DatabaseException {
        String sql = "SELECT * FROM enrollments WHERE course_id = ? ORDER BY enrollment_date DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(mapResultSetToEnrollment(rs));
                }
            }
            
            return enrollments;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding enrollments by course ID", e);
            throw new DatabaseException("Failed to find enrollments: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get student's courses with detailed information (JOIN query)
     * 
     * @param studentId Student ID
     * @return List of enrollments with course details
     * @throws DatabaseException if query fails
     */
    public List<Enrollment> getStudentCoursesWithDetails(int studentId) throws DatabaseException {
        String sql = "SELECT e.*, c.course_code, c.course_name, c.credits, c.department, c.instructor, c.schedule " +
                     "FROM enrollments e " +
                     "JOIN courses c ON e.course_id = c.course_id " +
                     "WHERE e.student_id = ? " +
                     "ORDER BY e.enrollment_date DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Enrollment enrollment = mapResultSetToEnrollment(rs);
                    enrollment.setCourseCode(rs.getString("course_code"));
                    enrollment.setCourseName(rs.getString("course_name"));
                    enrollment.setCredits(rs.getInt("credits"));
                    enrollment.setInstructor(rs.getString("instructor"));
                    enrollment.setSchedule(rs.getString("schedule"));
                    enrollments.add(enrollment);
                }
            }
            
            return enrollments;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting student courses with details", e);
            throw new DatabaseException("Failed to get student courses: " + e.getMessage(), e);
        }
    }
    
    /**
     * Check if a student is already enrolled in a course
     * 
     * @param studentId Student ID
     * @param courseId Course ID
     * @return true if enrolled, false otherwise
     * @throws DatabaseException if query fails
     */
    public boolean checkEnrollmentExists(int studentId, int courseId) throws DatabaseException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND course_id = ? AND status IN ('PENDING', 'APPROVED')";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking enrollment conflict", e);
            throw new DatabaseException("Failed to check enrollment: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find an enrollment by student and course (regardless of status)
     * 
     * @param studentId Student ID
     * @param courseId Course ID
     * @return Enrollment object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public Enrollment findByStudentAndCourse(int studentId, int courseId) throws DatabaseException {
        String sql = "SELECT * FROM enrollments WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEnrollment(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding enrollment by student and course", e);
            throw new DatabaseException("Failed to find enrollment: " + e.getMessage(), e);
        }
    }
    
    /**
     * Update an existing enrollment
     * 
     * @param enrollment Enrollment object with updated data
     * @return true if update successful, false otherwise
     * @throws DatabaseException if update fails
     */
    public boolean update(Enrollment enrollment) throws DatabaseException {
        String sql = "UPDATE enrollments SET grade = ?, status = ? WHERE enrollment_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, enrollment.getGrade());
            stmt.setString(2, enrollment.getStatus().name());
            stmt.setInt(3, enrollment.getEnrollmentId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Updated enrollment ID: " + enrollment.getEnrollmentId());
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating enrollment", e);
            throw new DatabaseException("Failed to update enrollment: " + e.getMessage(), e);
        }
    }
    
    /**
     * Delete an enrollment by ID
     * 
     * @param enrollmentId Enrollment ID to delete
     * @return true if deletion successful, false otherwise
     * @throws DatabaseException if deletion fails
     */
    public boolean delete(int enrollmentId) throws DatabaseException {
        String sql = "DELETE FROM enrollments WHERE enrollment_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, enrollmentId);
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Deleted enrollment ID: " + enrollmentId);
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting enrollment", e);
            throw new DatabaseException("Failed to delete enrollment: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get total count of enrollments
     * 
     * @return Total number of enrollments
     * @throws DatabaseException if query fails
     */
    public int getCount() throws DatabaseException {
        String sql = "SELECT COUNT(*) FROM enrollments";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
            return 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollment count", e);
            throw new DatabaseException("Failed to get enrollment count: " + e.getMessage(), e);
        }
    }
    
    /**
     * Map ResultSet row to Enrollment object
     * 
     * @param rs ResultSet with current row
     * @return Enrollment object
     * @throws SQLException if mapping fails
     */
    private Enrollment mapResultSetToEnrollment(ResultSet rs) throws SQLException {
        Enrollment enrollment = new Enrollment();
        enrollment.setEnrollmentId(rs.getInt("enrollment_id"));
        enrollment.setStudentId(rs.getInt("student_id"));
        enrollment.setCourseId(rs.getInt("course_id"));
        
        Date enrollmentDate = rs.getDate("enrollment_date");
        if (enrollmentDate != null) {
            enrollment.setEnrollmentDate(enrollmentDate.toLocalDate());
        }
        
        enrollment.setGrade(rs.getString("grade"));
        enrollment.setStatus(Enrollment.Status.valueOf(rs.getString("status")));
        enrollment.setRejectionReason(rs.getString("rejection_reason"));
        
        return enrollment;
    }
    
    /**
     * Get all enrollments with student and course details (for admin view)
     * 
     * @return List of all enrollments with details
     * @throws DatabaseException if query fails
     */
    public List<Enrollment> getAllEnrollmentsWithDetails() throws DatabaseException {
        String sql = "SELECT e.*, " +
                     "CONCAT(s.first_name, ' ', s.last_name) as student_name, " +
                     "c.course_code, c.course_name, c.credits, c.instructor, c.schedule " +
                     "FROM enrollments e " +
                     "JOIN students s ON e.student_id = s.student_id " +
                     "JOIN courses c ON e.course_id = c.course_id " +
                     "ORDER BY e.created_at DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Enrollment enrollment = mapResultSetToEnrollment(rs);
                enrollment.setStudentName(rs.getString("student_name"));
                enrollment.setCourseCode(rs.getString("course_code"));
                enrollment.setCourseName(rs.getString("course_name"));
                enrollment.setCredits(rs.getInt("credits"));
                enrollment.setInstructor(rs.getString("instructor"));
                enrollment.setSchedule(rs.getString("schedule"));
                enrollments.add(enrollment);
            }
            
            return enrollments;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all enrollments with details", e);
            throw new DatabaseException("Failed to get enrollments: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get enrollments by status
     * 
     * @param status Enrollment status to filter by
     * @return List of enrollments with the specified status
     * @throws DatabaseException if query fails
     */
    public List<Enrollment> getEnrollmentsByStatus(Enrollment.Status status) throws DatabaseException {
        String sql = "SELECT e.*, " +
                     "CONCAT(s.first_name, ' ', s.last_name) as student_name, " +
                     "c.course_code, c.course_name " +
                     "FROM enrollments e " +
                     "JOIN students s ON e.student_id = s.student_id " +
                     "JOIN courses c ON e.course_id = c.course_id " +
                     "WHERE e.status = ? " +
                     "ORDER BY e.created_at DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status.name());
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Enrollment enrollment = mapResultSetToEnrollment(rs);
                    enrollment.setStudentName(rs.getString("student_name"));
                    enrollment.setCourseCode(rs.getString("course_code"));
                    enrollment.setCourseName(rs.getString("course_name"));
                    enrollments.add(enrollment);
                }
            }
            
            return enrollments;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollments by status", e);
            throw new DatabaseException("Failed to get enrollments: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get count of enrollments by status
     * 
     * @param status Enrollment status
     * @return Count of enrollments with that status
     * @throws DatabaseException if query fails
     */
    public int getCountByStatus(Enrollment.Status status) throws DatabaseException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE status = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status.name());
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            
            return 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollment count by status", e);
            throw new DatabaseException("Failed to get enrollment count: " + e.getMessage(), e);
        }
    }
    
    /**
     * Update enrollment status (for approval/rejection)
     * 
     * @param enrollmentId Enrollment ID
     * @param status New status
     * @param rejectionReason Reason for rejection (null if approving)
     * @return true if update successful
     * @throws DatabaseException if update fails
     */
    public boolean updateStatus(int enrollmentId, Enrollment.Status status, String rejectionReason) throws DatabaseException {
        String sql = "UPDATE enrollments SET status = ?, rejection_reason = ? WHERE enrollment_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status.name());
            stmt.setString(2, rejectionReason);
            stmt.setInt(3, enrollmentId);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Updated enrollment " + enrollmentId + " status to " + status);
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating enrollment status", e);
            throw new DatabaseException("Failed to update enrollment status: " + e.getMessage(), e);
        }
    }
}
