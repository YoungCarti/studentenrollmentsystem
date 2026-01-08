package com.sems.service;

import com.sems.dao.CourseDAO;
import com.sems.exception.DatabaseException;
import com.sems.exception.ValidationException;
import com.sems.model.Course;
import com.sems.util.ValidationUtil;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service class for Course-related business logic.
 * Handles validation and business rules for course operations.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class CourseService {
    
    private static final Logger LOGGER = Logger.getLogger(CourseService.class.getName());
    private final CourseDAO courseDAO;
    
    /**
     * Constructor
     */
    public CourseService() {
        this.courseDAO = new CourseDAO();
    }
    
    /**
     * Create a new course with validation
     * 
     * @param course Course object to create
     * @return The generated course ID
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public int createCourse(Course course) throws ValidationException, DatabaseException {
        // Validate course data
        validateCourse(course);
        
        // Check for duplicate course code
        Course existing = courseDAO.findByCourseCode(course.getCourseCode());
        if (existing != null) {
            throw new ValidationException("Course code already exists: " + course.getCourseCode());
        }
        
        // Create course
        int courseId = courseDAO.create(course);
        LOGGER.info("Successfully created new course: " + course.getCourseCode());
        
        return courseId;
    }
    
    /**
     * Update an existing course
     * 
     * @param course Course object with updated data
     * @return true if update successful
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public boolean updateCourse(Course course) throws ValidationException, DatabaseException {
        // Validate course data
        validateCourse(course);
        
        // Check if course exists
        Course existing = courseDAO.findById(course.getCourseId());
        if (existing == null) {
            throw new ValidationException("Course not found with ID: " + course.getCourseId());
        }
        
        // Check for duplicate course code (excluding current course)
        Course codeCheck = courseDAO.findByCourseCode(course.getCourseCode());
        if (codeCheck != null && codeCheck.getCourseId() != course.getCourseId()) {
            throw new ValidationException("Course code already exists: " + course.getCourseCode());
        }
        
        // Update course
        boolean updated = courseDAO.update(course);
        
        if (updated) {
            LOGGER.info("Successfully updated course: " + course.getCourseId());
        }
        
        return updated;
    }
    
    /**
     * Delete a course
     * 
     * @param courseId Course ID to delete
     * @return true if deletion successful
     * @throws DatabaseException if database operation fails
     */
    public boolean deleteCourse(int courseId) throws DatabaseException {
        Course course = courseDAO.findById(courseId);
        if (course == null) {
            return false;
        }
        
        boolean deleted = courseDAO.delete(courseId);
        
        if (deleted) {
            LOGGER.info("Successfully deleted course: " + courseId);
        }
        
        return deleted;
    }
    
    /**
     * Get a course by ID
     * 
     * @param courseId Course ID
     * @return Course object if found, null otherwise
     * @throws DatabaseException if database operation fails
     */
    public Course getCourseById(int courseId) throws DatabaseException {
        return courseDAO.findById(courseId);
    }
    
    /**
     * Get a course by course code
     * 
     * @param courseCode Course code
     * @return Course object if found, null otherwise
     * @throws DatabaseException if database operation fails
     */
    public Course getCourseByCourseCode(String courseCode) throws DatabaseException {
        return courseDAO.findByCourseCode(courseCode);
    }
    
    /**
     * Get all courses
     * 
     * @return List of all courses
     * @throws DatabaseException if database operation fails
     */
    public List<Course> getAllCourses() throws DatabaseException {
        return courseDAO.findAll();
    }
    
    /**
     * Get courses by department
     * 
     * @param department Department name
     * @return List of courses in the department
     * @throws DatabaseException if database operation fails
     */
    public List<Course> getCoursesByDepartment(String department) throws DatabaseException {
        return courseDAO.findByDepartment(department);
    }
    
    /**
     * Get current enrollment count for a course
     * 
     * @param courseId Course ID
     * @return Number of students enrolled
     * @throws DatabaseException if database operation fails
     */
    public int getEnrollmentCount(int courseId) throws DatabaseException {
        return courseDAO.getEnrollmentCount(courseId);
    }
    
    /**
     * Get available seats for a course
     * 
     * @param courseId Course ID
     * @return Number of available seats
     * @throws DatabaseException if database operation fails
     */
    public int getAvailableSeats(int courseId) throws DatabaseException {
        return courseDAO.getAvailableSeats(courseId);
    }
    
    /**
     * Check if a course has available capacity
     * 
     * @param courseId Course ID
     * @return true if course has available seats, false otherwise
     * @throws DatabaseException if database operation fails
     */
    public boolean hasAvailableSeats(int courseId) throws DatabaseException {
        return getAvailableSeats(courseId) > 0;
    }
    
    /**
     * Get total count of courses
     * 
     * @return Total number of courses
     * @throws DatabaseException if database operation fails
     */
    public int getTotalCourses() throws DatabaseException {
        return courseDAO.getCount();
    }
    
    /**
     * Get active course count (alias for getTotalCourses)
     * 
     * @return Total number of active courses
     * @throws DatabaseException if database operation fails
     */
    public int getActiveCourseCount() throws DatabaseException {
        return getTotalCourses();
    }
    
    /**
     * Validate course data
     * 
     * @param course Course object to validate
     * @throws ValidationException if validation fails
     */
    private void validateCourse(Course course) throws ValidationException {
        if (course == null) {
            throw new ValidationException("Course object cannot be null");
        }
        
        // Validate course code
        if (ValidationUtil.isNullOrEmpty(course.getCourseCode())) {
            throw new ValidationException("Course code is required");
        }
        
        // Validate course name
        if (ValidationUtil.isNullOrEmpty(course.getCourseName())) {
            throw new ValidationException("Course name is required");
        }
        
        // Validate credits
        if (!ValidationUtil.isValidCredits(course.getCredits())) {
            throw new ValidationException("Credits must be between 1 and 4");
        }
        
        // Validate department
        if (ValidationUtil.isNullOrEmpty(course.getDepartment())) {
            throw new ValidationException("Department is required");
        }
        
        // Validate capacity
        if (!ValidationUtil.isValidCapacity(course.getCapacity())) {
            throw new ValidationException("Capacity must be a positive number (1-200)");
        }
    }
}
