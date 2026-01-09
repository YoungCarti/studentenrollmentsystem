package com.sems.service;

import com.sems.dao.CourseDAO;
import com.sems.dao.EnrollmentDAO;
import com.sems.dao.StudentDAO;
import com.sems.exception.DatabaseException;
import com.sems.exception.ValidationException;
import com.sems.model.Course;
import com.sems.model.Enrollment;
import com.sems.model.Student;
import com.sems.util.ValidationUtil;

import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service class for Enrollment-related business logic.
 * Handles enrollment validation, capacity checks, and conflict detection.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class EnrollmentService {
    
    private static final Logger LOGGER = Logger.getLogger(EnrollmentService.class.getName());
    private final EnrollmentDAO enrollmentDAO;
    private final StudentDAO studentDAO;
    private final CourseDAO courseDAO;
    
    /**
     * Constructor
     */
    public EnrollmentService() {
        this.enrollmentDAO = new EnrollmentDAO();
        this.studentDAO = new StudentDAO();
        this.courseDAO = new CourseDAO();
    }
    
    /**
     * Enroll a student in a course with validation and capacity checks
     * 
     * @param studentId Student ID
     * @param courseId Course ID
     * @return The generated enrollment ID
     * @throws ValidationException if validation or business rules fail
     * @throws DatabaseException if database operation fails
     */
    public int enrollStudent(int studentId, int courseId) throws ValidationException, DatabaseException {
        // Validate student exists
        Student student = studentDAO.findById(studentId);
        if (student == null) {
            throw new ValidationException("Student not found with ID: " + studentId);
        }
        
        // Validate course exists
        Course course = courseDAO.findById(courseId);
        if (course == null) {
            throw new ValidationException("Course not found with ID: " + courseId);
        }
        
        // Check for enrollment conflict (already enrolled in PENDING or APPROVED status)
        boolean alreadyEnrolled = enrollmentDAO.checkEnrollmentExists(studentId, courseId);
        if (alreadyEnrolled) {
            throw new ValidationException("Student is already enrolled in this course");
        }
        
        // Check course capacity
        int availableSeats = courseDAO.getAvailableSeats(courseId);
        if (availableSeats <= 0) {
            throw new ValidationException("Course is full. No available seats.");
        }
        
        // Create new enrollment with PENDING status (requires admin approval)
        Enrollment enrollment = new Enrollment(studentId, courseId, LocalDate.now());
        enrollment.setStatus(Enrollment.Status.PENDING);
        
        int enrollmentId = enrollmentDAO.create(enrollment);
        
        LOGGER.info(String.format("Student %d requested enrollment in course %d (PENDING approval)", studentId, courseId));
        
        return enrollmentId;
    }
    
    /**
     * Drop a course (DELETE enrollment from database)
     * 
     * @param enrollmentId Enrollment ID
     * @return true if successfully dropped
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public boolean dropCourse(int enrollmentId) throws ValidationException, DatabaseException {
        Enrollment enrollment = enrollmentDAO.findById(enrollmentId);
        
        if (enrollment == null) {
            throw new ValidationException("Enrollment not found with ID: " + enrollmentId);
        }
        
        if (enrollment.getStatus() != Enrollment.Status.APPROVED) {
            throw new ValidationException("Can only drop courses with APPROVED status");
        }
        
        // Delete the enrollment completely from database
        boolean deleted = enrollmentDAO.delete(enrollmentId);
        
        if (deleted) {
            LOGGER.info("Successfully deleted enrollment ID: " + enrollmentId);
        }
        
        return deleted;
    }
    
    /**
     * Update a student's grade for an enrollment
     * 
     * @param enrollmentId Enrollment ID
     * @param grade Grade to assign
     * @return true if successfully updated
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public boolean updateGrade(int enrollmentId, String grade) throws ValidationException, DatabaseException {
        Enrollment enrollment = enrollmentDAO.findById(enrollmentId);
        
        if (enrollment == null) {
            throw new ValidationException("Enrollment not found with ID: " + enrollmentId);
        }
        
        // Validate grade format
        if (!ValidationUtil.isValidGrade(grade)) {
            throw new ValidationException("Invalid grade format. Must be A, A-, B+, B, B-, C+, C, C-, D, or F");
        }
        
        enrollment.setGrade(grade);
        enrollment.setStatus(Enrollment.Status.COMPLETED);
        
        boolean updated = enrollmentDAO.update(enrollment);
        
        if (updated) {
            LOGGER.info(String.format("Updated grade for enrollment %d: %s", enrollmentId, grade));
        }
        
        return updated;
    }
    
    /**
     * Get all enrollments for a student
     * 
     * @param studentId Student ID
     * @return List of enrollments
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getStudentEnrollments(int studentId) throws DatabaseException {
        return enrollmentDAO.findByStudentId(studentId);
    }
    
    /**
     * Get student's courses with detailed information
     * 
     * @param studentId Student ID
     * @return List of enrollments with course details
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getStudentCoursesWithDetails(int studentId) throws DatabaseException {
        return enrollmentDAO.getStudentCoursesWithDetails(studentId);
    }
    
    /**
     * Get all enrollments for a course
     * 
     * @param courseId Course ID
     * @return List of enrollments
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getCourseEnrollments(int courseId) throws DatabaseException {
        return enrollmentDAO.findByCourseId(courseId);
    }
    
    /**
     * Get an enrollment by ID
     * 
     * @param enrollmentId Enrollment ID
     * @return Enrollment object if found, null otherwise
     * @throws DatabaseException if database operation fails
     */
    public Enrollment getEnrollmentById(int enrollmentId) throws DatabaseException {
        return enrollmentDAO.findById(enrollmentId);
    }
    
    /**
     * Delete an enrollment
     * 
     * @param enrollmentId Enrollment ID
     * @return true if deletion successful
     * @throws DatabaseException if database operation fails
     */
    public boolean deleteEnrollment(int enrollmentId) throws DatabaseException {
        boolean deleted = enrollmentDAO.delete(enrollmentId);
        
        if (deleted) {
            LOGGER.info("Successfully deleted enrollment: " + enrollmentId);
        }
        
        return deleted;
    }
    
    /**
     * Get total count of enrollments
     * 
     * @return Total number of enrollments
     * @throws DatabaseException if database operation fails
     */
    public int getTotalEnrollments() throws DatabaseException {
        return enrollmentDAO.getCount();
    }
    
    /**
     * Get student's transcript (completed courses with grades)
     * 
     * @param studentId Student ID
     * @return List of completed enrollments with grades
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getStudentTranscript(int studentId) throws DatabaseException {
        List<Enrollment> allEnrollments = enrollmentDAO.getStudentCoursesWithDetails(studentId);
        
        // Filter for completed courses only
        return allEnrollments.stream()
                .filter(Enrollment::isCompleted)
                .toList();
    }
    
    /**
     * Approve a pending enrollment
     * 
     * @param enrollmentId Enrollment ID to approve
     * @return true if successfully approved
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public boolean approveEnrollment(int enrollmentId) throws ValidationException, DatabaseException {
        Enrollment enrollment = enrollmentDAO.findById(enrollmentId);
        
        if (enrollment == null) {
            throw new ValidationException("Enrollment not found with ID: " + enrollmentId);
        }
        
        if (enrollment.getStatus() != Enrollment.Status.PENDING) {
            throw new ValidationException("Can only approve enrollments with PENDING status");
        }
        
        boolean updated = enrollmentDAO.updateStatus(enrollmentId, Enrollment.Status.APPROVED, null);
        
        if (updated) {
            LOGGER.info("Successfully approved enrollment ID: " + enrollmentId);
        }
        
        return updated;
    }
    
    /**
     * Reject a pending enrollment
     * 
     * @param enrollmentId Enrollment ID to reject
     * @param reason Reason for rejection
     * @return true if successfully rejected
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public boolean rejectEnrollment(int enrollmentId, String reason) throws ValidationException, DatabaseException {
        Enrollment enrollment = enrollmentDAO.findById(enrollmentId);
        
        if (enrollment == null) {
            throw new ValidationException("Enrollment not found with ID: " + enrollmentId);
        }
        
        if (enrollment.getStatus() != Enrollment.Status.PENDING) {
            throw new ValidationException("Can only reject enrollments with PENDING status");
        }
        
        boolean updated = enrollmentDAO.updateStatus(enrollmentId, Enrollment.Status.REJECTED, reason);
        
        if (updated) {
            LOGGER.info("Successfully rejected enrollment ID: " + enrollmentId + " with reason: " + reason);
        }
        
        return updated;
    }
    
    /**
     * Get all enrollments with student and course details (for admin)
     * 
     * @return List of all enrollments with details
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getAllEnrollmentsWithDetails() throws DatabaseException {
        return enrollmentDAO.getAllEnrollmentsWithDetails();
    }
    
    /**
     * Get enrollments by status
     * 
     * @param status Enrollment status
     * @return List of enrollments with that status
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getEnrollmentsByStatus(Enrollment.Status status) throws DatabaseException {
        return enrollmentDAO.getEnrollmentsByStatus(status);
    }
    
    /**
     * Get count of pending enrollments
     * \n      * @return Count of pending enrollments
     * @throws DatabaseException if database operation fails
     */
    public int getPendingEnrollmentsCount() throws DatabaseException {
        return enrollmentDAO.getCountByStatus(Enrollment.Status.PENDING);
    }
    
    /**
     * Get all pending enrollments with details
     * 
     * @return List of pending enrollments
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getPendingEnrollments() throws DatabaseException {
        return getEnrollmentsByStatus(Enrollment.Status.PENDING);
    }
    
    /**
     * Get all approved enrollments with details
     * 
     * @return List of approved enrollments
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getApprovedEnrollments() throws DatabaseException {
        return getEnrollmentsByStatus(Enrollment.Status.APPROVED);
    }
    
    /**
     * Get all rejected enrollments with details
     * 
     * @return List of rejected enrollments
     * @throws DatabaseException if database operation fails
     */
    public List<Enrollment> getRejectedEnrollments() throws DatabaseException {
        return getEnrollmentsByStatus(Enrollment.Status.REJECTED);
    }
    
    /**
     * Get count of approved enrollments
     * 
     * @return Count of approved enrollments
     * @throws DatabaseException if database operation fails
     */
    public int getApprovedEnrollmentsCount() throws DatabaseException {
        return enrollmentDAO.getCountByStatus(Enrollment.Status.APPROVED);
    }
    
    /**
     * Assign grade to an enrollment
     * 
     * @param enrollmentId Enrollment ID
     * @param grade Grade to assign (A, B+, etc.)
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public void assignGrade(int enrollmentId, String grade) throws ValidationException, DatabaseException {
        Enrollment enrollment = enrollmentDAO.findById(enrollmentId);
        
        if (enrollment == null) {
            throw new ValidationException("Enrollment not found");
        }
        
        if (enrollment.getStatus() != Enrollment.Status.APPROVED) {
            throw new ValidationException("Can only assign grades to approved enrollments");
        }
        
        // Validate grade
        if (grade == null || grade.trim().isEmpty()) {
            throw new ValidationException("Grade cannot be empty");
        }
        
        // Update enrollment with grade and mark as COMPLETED
        enrollment.setGrade(grade);
        enrollment.setStatus(Enrollment.Status.COMPLETED);
        enrollmentDAO.update(enrollment);
        
        LOGGER.info("Grade " + grade + " assigned to enrollment " + enrollmentId);
    }
}
