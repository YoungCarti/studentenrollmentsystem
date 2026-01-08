package com.sems.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

/**
 * Student entity representing a student in the enrollment system.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class Student implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int studentId;
    private String firstName;
    private String lastName;
    private String email;
    private LocalDate dob;
    private LocalDate enrollmentDate;
    private String phone;
    private String address;
    
    /**
     * Default constructor
     */
    public Student() {
    }
    
    /**
     * Constructor with all fields except ID (for new students)
     */
    public Student(String firstName, String lastName, String email, LocalDate dob, 
                   LocalDate enrollmentDate, String phone, String address) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.dob = dob;
        this.enrollmentDate = enrollmentDate;
        this.phone = phone;
        this.address = address;
    }
    
    /**
     * Constructor with all fields (for existing students)
     */
    public Student(int studentId, String firstName, String lastName, String email, 
                   LocalDate dob, LocalDate enrollmentDate, String phone, String address) {
        this.studentId = studentId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.dob = dob;
        this.enrollmentDate = enrollmentDate;
        this.phone = phone;
        this.address = address;
    }
    
    // Getters and Setters
    
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public LocalDate getDob() {
        return dob;
    }
    
    public void setDob(LocalDate dob) {
        this.dob = dob;
    }
    
    public LocalDate getEnrollmentDate() {
        return enrollmentDate;
    }
    
    public void setEnrollmentDate(LocalDate enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    /**
     * Get full name of the student
     * @return Full name (firstName lastName)
     */
    public String getFullName() {
        return firstName + " " + lastName;
    }
    
    @Override
    public String toString() {
        return "Student{" +
                "studentId=" + studentId +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", dob=" + dob +
                ", enrollmentDate=" + enrollmentDate +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Student student = (Student) o;
        return studentId == student.studentId && 
               Objects.equals(email, student.email);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(studentId, email);
    }
}
