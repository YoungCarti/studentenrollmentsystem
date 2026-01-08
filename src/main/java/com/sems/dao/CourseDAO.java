package com.sems.dao;

import com.sems.exception.DatabaseException;
import com.sems.model.Course;
import com.sems.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Course entity.
 * Handles all database operations related to courses.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class CourseDAO {
    
    private static final Logger LOGGER = Logger.getLogger(CourseDAO.class.getName());
    
    /**
     * Create a newcourse in the database
     * 
     * @param course Course object to create
     * @return The generated course ID
     * @throws DatabaseException if creation fails
     */
    public int create(Course course) throws DatabaseException {
        String sql = "INSERT INTO courses (course_code, course_name, credits, department, capacity, semester, description, instructor, schedule) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, course.getCourseCode());
            stmt.setString(2, course.getCourseName());
            stmt.setInt(3, course.getCredits());
            stmt.setString(4, course.getDepartment());
            stmt.setInt(5, course.getCapacity());
            stmt.setString(6, course.getSemester());
            stmt.setString(7, course.getDescription());
            stmt.setString(8, course.getInstructor());
            stmt.setString(9, course.getSchedule());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new DatabaseException("Creating course failed, no rows affected");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int courseId = generatedKeys.getInt(1);
                    course.setCourseId(courseId);
                    LOGGER.info("Created course with ID: " + courseId);
                    return courseId;
                } else {
                    throw new DatabaseException("Creating course failed, no ID obtained");
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating course", e);
            throw new DatabaseException("Failed to create course: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find a course by ID
     * 
     * @param courseId Course ID to search for
     * @return Course object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public Course findById(int courseId) throws DatabaseException {
        String sql = "SELECT * FROM courses WHERE course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCourse(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding course by ID", e);
            throw new DatabaseException("Failed to find course: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find a course by course code
     * 
     * @param courseCode Course code to search for
     * @return Course object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public Course findByCourseCode(String courseCode) throws DatabaseException {
        String sql = "SELECT * FROM courses WHERE course_code = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, courseCode);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCourse(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding course by code", e);
            throw new DatabaseException("Failed to find course by code: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get all courses
     * 
     * @return List of all courses
     * @throws DatabaseException if query fails
     */
    public List<Course> findAll() throws DatabaseException {
        String sql = "SELECT * FROM courses ORDER BY course_code";
        List<Course> courses = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                courses.add(mapResultSetToCourse(rs));
            }
            
            LOGGER.info("Retrieved " + courses.size() + " courses");
            return courses;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all courses", e);
            throw new DatabaseException("Failed to retrieve courses: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find courses by department
     * 
     * @param department Department name
     * @return List of courses in the department
     * @throws DatabaseException if query fails
     */
    public List<Course> findByDepartment(String department) throws DatabaseException {
        String sql = "SELECT * FROM courses WHERE department = ? ORDER BY course_code";
        List<Course> courses = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, department);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapResultSetToCourse(rs));
                }
            }
            
            return courses;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding courses by department", e);
            throw new DatabaseException("Failed to find courses by department: " + e.getMessage(), e);
        }
    }
    
    /**
     * Update an existing course
     * 
     * @param course Course object with updated data
     * @return true if update successful, false otherwise
     * @throws DatabaseException if update fails
     */
    public boolean update(Course course) throws DatabaseException {
        String sql = "UPDATE courses SET course_code = ?, course_name = ?, credits = ?, " +
                     "department = ?, capacity = ?, semester = ?, description = ?, instructor = ?, schedule = ? WHERE course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, course.getCourseCode());
            stmt.setString(2, course.getCourseName());
            stmt.setInt(3, course.getCredits());
            stmt.setString(4, course.getDepartment());
            stmt.setInt(5, course.getCapacity());
            stmt.setString(6, course.getSemester());
            stmt.setString(7, course.getDescription());
            stmt.setString(8, course.getInstructor());
            stmt.setString(9, course.getSchedule());
            stmt.setInt(10, course.getCourseId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Updated course ID: " + course.getCourseId());
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating course", e);
            throw new DatabaseException("Failed to update course: " + e.getMessage(), e);
        }
    }
    
    /**
     * Delete a course by ID
     * 
     * @param courseId Course ID to delete
     * @return true if deletion successful, false otherwise
     * @throws DatabaseException if deletion fails
     */
    public boolean delete(int courseId) throws DatabaseException {
        String sql = "DELETE FROM courses WHERE course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Deleted course ID: " + courseId);
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting course", e);
            throw new DatabaseException("Failed to delete course: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get the current enrollment count for a course
     * 
     * @param courseId Course ID
     * @return Number of students enrolled
     * @throws DatabaseException if query fails
     */
    public int getEnrollmentCount(int courseId) throws DatabaseException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE course_id = ? AND status = 'APPROVED'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            
            return 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollment count", e);
            throw new DatabaseException("Failed to get enrollment count: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get available seats for a course
     * 
     * @param courseId Course ID
     * @return Number of available seats
     * @throws DatabaseException if query fails
     */
    public int getAvailableSeats(int courseId) throws DatabaseException {
        Course course = findById(courseId);
        if (course == null) {
            throw new DatabaseException("Course not found");
        }
        
        int enrolledCount = getEnrollmentCount(courseId);
        return course.getCapacity() - enrolledCount;
    }
    
    /**
     * Get total count of courses
     * 
     * @return Total number of courses
     * @throws DatabaseException if query fails
     */
    public int getCount() throws DatabaseException {
        String sql = "SELECT COUNT(*) FROM courses";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
            return 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting course count", e);
            throw new DatabaseException("Failed to get course count: " + e.getMessage(), e);
        }
    }
    
    /**
     * Map ResultSet row to Course object
     * 
     * @param rs ResultSet with current row
     * @return Course object
     * @throws SQLException if mapping fails
     */
    private Course mapResultSetToCourse(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setCourseId(rs.getInt("course_id"));
        course.setCourseCode(rs.getString("course_code"));
        course.setCourseName(rs.getString("course_name"));
        course.setCredits(rs.getInt("credits"));
        course.setDepartment(rs.getString("department"));
        course.setCapacity(rs.getInt("capacity"));
        course.setSemester(rs.getString("semester"));
        course.setDescription(rs.getString("description"));
        course.setInstructor(rs.getString("instructor"));
        course.setSchedule(rs.getString("schedule"));
        
        return course;
    }
}
