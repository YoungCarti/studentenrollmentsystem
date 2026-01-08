package com.sems.model;

import java.io.Serializable;
import java.util.Objects;

/**
 * User entity for authentication and authorization.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /**
     * User role enumeration
     */
    public enum Role {
        ADMIN, STUDENT
    }
    
    private int userId;
    private String username;
    private String passwordHash;
    private Role role;
    private Integer studentId;  // Nullable - only for STUDENT role
    private boolean isActive;
    
    /**
     * Default constructor
     */
    public User() {
        this.isActive = true;
    }
    
    /**
     * Constructor for new user (without ID)
     */
    public User(String username, String passwordHash, Role role, Integer studentId) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
        this.studentId = studentId;
        this.isActive = true;
    }
    
    /**
     * Constructor with all fields
     */
    public User(int userId, String username, String passwordHash, Role role, 
                Integer studentId, boolean isActive) {
        this.userId = userId;
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
        this.studentId = studentId;
        this.isActive = isActive;
    }
    
    // Getters and Setters
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPasswordHash() {
        return passwordHash;
    }
    
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public Role getRole() {
        return role;
    }
    
    public void setRole(Role role) {
        this.role = role;
    }
    
    public Integer getStudentId() {
        return studentId;
    }
    
    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    /**
     * Check if user is an admin
     * @return true if admin, false otherwise
     */
    public boolean isAdmin() {
        return role == Role.ADMIN;
    }
    
    /**
     * Check if user is a student
     * @return true if student, false otherwise
     */
    public boolean isStudent() {
        return role == Role.STUDENT;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", role=" + role +
                ", studentId=" + studentId +
                ", isActive=" + isActive +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return userId == user.userId && 
               Objects.equals(username, user.username);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(userId, username);
    }
}
