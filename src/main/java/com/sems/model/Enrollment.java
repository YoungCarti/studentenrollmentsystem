package com.sems.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

/**
 * Enrollment entity representing a student's enrollment in a course.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class Enrollment implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /**
     * Enrollment status enumeration
     */
    public enum Status {
        PENDING, APPROVED, REJECTED, COMPLETED, DROPPED
    }
    
    private int enrollmentId;
    private int studentId;
    private int courseId;
    private LocalDate enrollmentDate;
    private String grade;
    private Status status;
    private String rejectionReason;
    
    // Optional fields for joined queries
    private String studentName;
    private String courseName;
    private String courseCode;
    private int credits;
    private String instructor;
    private String schedule;
    
    /**
     * Default constructor
     */
    public Enrollment() {
        this.status = Status.PENDING;
    }
    
    /**
     * Constructor without ID (for new enrollments)
     */
    public Enrollment(int studentId, int courseId, LocalDate enrollmentDate) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.enrollmentDate = enrollmentDate;
        this.status = Status.PENDING;
    }
    
    /**
     * Constructor with all fields
     */
    public Enrollment(int enrollmentId, int studentId, int courseId, 
                      LocalDate enrollmentDate, String grade, Status status) {
        this.enrollmentId = enrollmentId;
        this.studentId = studentId;
        this.courseId = courseId;
        this.enrollmentDate = enrollmentDate;
        this.grade = grade;
        this.status = status;
    }
    
    // Getters and Setters
    
    public int getEnrollmentId() {
        return enrollmentId;
    }
    
    public void setEnrollmentId(int enrollmentId) {
        this.enrollmentId = enrollmentId;
    }
    
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public int getCourseId() {
        return courseId;
    }
    
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    
    public LocalDate getEnrollmentDate() {
        return enrollmentDate;
    }
    
    public void setEnrollmentDate(LocalDate enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }
    
    public String getGrade() {
        return grade;
    }
    
    public void setGrade(String grade) {
        this.grade = grade;
    }
    
    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getCourseName() {
        return courseName;
    }
    
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
    
    public String getCourseCode() {
        return courseCode;
    }
    
    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }
    
    public String getRejectionReason() {
        return rejectionReason;
    }
    
    public void setRejectionReason(String rejectionReason) {
        this.rejectionReason = rejectionReason;
    }
    
    public int getCredits() {
        return credits;
    }
    
    public void setCredits(int credits) {
        this.credits = credits;
    }
    
    public String getInstructor() {
        return instructor;
    }
    
    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }
    
    public String getSchedule() {
        return schedule;
    }
    
    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }
    
    /**
     * Check if the enrollment is active (ENROLLED status)
     * @return true if active, false otherwise
     */
    public boolean isActive() {
        return status == Status.APPROVED;
    }
    
    /**
     * Check if the enrollment is pending approval
     * @return true if pending, false otherwise
     */
    public boolean isPending() {
        return status == Status.PENDING;
    }
    
    /**
     * Check if the enrollment was rejected
     * @return true if rejected, false otherwise
     */
    public boolean isRejected() {
        return status == Status.REJECTED;
    }
    
    /**
     * Check if the enrollment is completed
     * @return true if completed, false otherwise
     */
    public boolean isCompleted() {
        return status == Status.COMPLETED;
    }
    
    @Override
    public String toString() {
        return "Enrollment{" +
                "enrollmentId=" + enrollmentId +
                ", studentId=" + studentId +
                ", courseId=" + courseId +
                ", enrollmentDate=" + enrollmentDate +
                ", grade='" + grade + '\'' +
                ", status=" + status +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Enrollment that = (Enrollment) o;
        return enrollmentId == that.enrollmentId;
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(enrollmentId);
    }
}
