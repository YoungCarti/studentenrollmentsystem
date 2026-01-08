package com.sems.model;

import java.io.Serializable;
import java.util.Objects;

/**
 * Course entity representing a course in the enrollment system.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class Course implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int courseId;
    private String courseCode;
    private String courseName;
    private int credits;
    private String department;
    private int capacity;
    private String semester;
    private String description;
    private String instructor;
    private String schedule;
    
    /**
     * Default constructor
     */
    public Course() {
    }
    
    /**
     * Constructor without ID (for new courses)
     */
    public Course(String courseCode, String courseName, int credits, String department, 
                  int capacity, String semester, String description, String instructor, String schedule) {
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.credits = credits;
        this.department = department;
        this.capacity = capacity;
        this.semester = semester;
        this.description = description;
        this.instructor = instructor;
        this.schedule = schedule;
    }
    
    /**
     * Constructor with all fields (for existing courses)
     */
    public Course(int courseId, String courseCode, String courseName, int credits, 
                  String department, int capacity, String semester, String description,
                  String instructor, String schedule) {
        this.courseId = courseId;
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.credits = credits;
        this.department = department;
        this.capacity = capacity;
        this.semester = semester;
        this.description = description;
        this.instructor = instructor;
        this.schedule = schedule;
    }
    
    // Getters and Setters
    
    public int getCourseId() {
        return courseId;
    }
    
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    
    public String getCourseCode() {
        return courseCode;
    }
    
    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }
    
    public String getCourseName() {
        return courseName;
    }
    
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
    
    public int getCredits() {
        return credits;
    }
    
    public void setCredits(int credits) {
        this.credits = credits;
    }
    
    public String getDepartment() {
        return department;
    }
    
    public void setDepartment(String department) {
        this.department = department;
    }
    
    public int getCapacity() {
        return capacity;
    }
    
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
    
    public String getSemester() {
        return semester;
    }
    
    public void setSemester(String semester) {
        this.semester = semester;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
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
    
    @Override
    public String toString() {
        return "Course{" +
                "courseId=" + courseId +
                ", courseCode='" + courseCode + '\'' +
                ", courseName='" + courseName + '\'' +
                ", credits=" + credits +
                ", department='" + department + '\'' +
                ", capacity=" + capacity +
                ", semester='" + semester + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Course course = (Course) o;
        return courseId == course.courseId && 
               Objects.equals(courseCode, course.courseCode);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(courseId, courseCode);
    }
}
