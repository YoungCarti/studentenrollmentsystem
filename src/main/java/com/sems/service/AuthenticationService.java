package com.sems.service;

import com.sems.dao.StudentDAO;
import com.sems.dao.UserDAO;
import com.sems.exception.AuthenticationException;
import com.sems.exception.DatabaseException;
import com.sems.exception.ValidationException;
import com.sems.model.Student;
import com.sems.model.User;
import com.sems.util.PasswordUtil;
import com.sems.util.ValidationUtil;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service class for Authentication and User Management.
 * Handles password hashing, authentication, and authorization.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class AuthenticationService {
    
    private static final Logger LOGGER = Logger.getLogger(AuthenticationService.class.getName());
    private final UserDAO userDAO;
    private final StudentDAO studentDAO;
    
    /**
     * Constructor
     */
    public AuthenticationService() {
        this.userDAO = new UserDAO();
        this.studentDAO = new StudentDAO();
    }
    
    /**
     * Authenticate a user with username/email and password
     * 
     * @param usernameOrEmail Username or Email address
     * @param password Plain text password
     * @return User object if authentication successful
     * @throws AuthenticationException if authentication fails
     * @throws DatabaseException if database operation fails
     */
    public User login(String usernameOrEmail, String password) throws AuthenticationException, DatabaseException {
        if (ValidationUtil.isNullOrEmpty(usernameOrEmail) || ValidationUtil.isNullOrEmpty(password)) {
            throw new AuthenticationException("Username/Email and password are required");
        }
        
        User user = null;
        
        // Check if input looks like an email
        if (ValidationUtil.isValidEmail(usernameOrEmail)) {
            // Try to find student by email first
            Student student = studentDAO.findByEmail(usernameOrEmail);
            if (student != null) {
                // Find user account associated with this student
                user = userDAO.findByStudentId(student.getStudentId());
            }
        }
        
        // If not found by email, try username
        if (user == null) {
            user = userDAO.findByUsername(usernameOrEmail);
        }
        
        if (user == null) {
            LOGGER.warning("Login attempt with non-existent username/email: " + usernameOrEmail);
            throw new AuthenticationException("Invalid username/email or password");
        }
        
        // Check if user is active
        if (!user.isActive()) {
            LOGGER.warning("Login attempt for inactive user: " + usernameOrEmail);
            throw new AuthenticationException("Account is inactive. Please contact administrator.");
        }
        
        // Verify password
        boolean passwordValid = PasswordUtil.verifyPassword(password, user.getPasswordHash());
        
        if (!passwordValid) {
            LOGGER.warning("Failed login attempt for user: " + usernameOrEmail);
            throw new AuthenticationException("Invalid username/email or password");
        }
        
        LOGGER.info("Successful login for user: " + usernameOrEmail + " (Role: " + user.getRole() + ")");
        
        return user;
    }
    
    /**
     * Register a new user account
     * 
     * @param username Username
     * @param password Plain text password
     * @param role User role (ADMIN or STUDENT)
     * @param studentId Student ID (required for STUDENT role, null for ADMIN)
     * @return The generated user ID
     * @throws ValidationException if validation fails
     * @throws DatabaseException if database operation fails
     */
    public int register(String username, String password, User.Role role, Integer studentId) 
            throws ValidationException, DatabaseException {
        
        // Validate inputs
        if (ValidationUtil.isNullOrEmpty(username)) {
            throw new ValidationException("Username is required");
        }
        
        if (!PasswordUtil.isValidPassword(password)) {
            throw new ValidationException("Password must be at least 6 characters");
        }
        
        // Check for duplicate username
        User existing = userDAO.findByUsername(username);
        if (existing != null) {
            throw new ValidationException("Username already exists: " + username);
        }
        
        // For STUDENT role, validate student_id exists and doesn't have a user account
        if (role == User.Role.STUDENT) {
            if (studentId == null) {
                throw new ValidationException("Student ID is required for student accounts");
            }
            
            Student student = studentDAO.findById(studentId);
            if (student == null) {
                throw new ValidationException("Student not found with ID: " + studentId);
            }
            
            // Check if student already has a user account
            User existingUser = userDAO.findByStudentId(studentId);
            if (existingUser != null) {
                throw new ValidationException("Student already has a user account");
            }
        }
        
        // Hash password
        String passwordHash = PasswordUtil.hashPassword(password);
        
        // Create user
        User user = new User(username, passwordHash, role, studentId);
        int userId = userDAO.create(user);
        
        LOGGER.info("Successfully registered new user: " + username + " (Role: " + role + ")");
        
        return userId;
    }
    
    /**
     * Change a user's password
     * 
     * @param userId User ID
     * @param oldPassword Current password
     * @param newPassword New password
     * @return true if password changed successfully
     * @throws ValidationException if validation fails
     * @throws AuthenticationException if old password is incorrect
     * @throws DatabaseException if database operation fails
     */
    public boolean changePassword(int userId, String oldPassword, String newPassword) 
            throws ValidationException, AuthenticationException, DatabaseException {
        
        // Validate new password
        if (!PasswordUtil.isValidPassword(newPassword)) {
            throw new ValidationException("New password must be at least 6 characters");
        }
        
        // Find user
        User user = userDAO.findById(userId);
        if (user == null) {
            throw new ValidationException("User not found");
        }
        
        // Verify old password
        boolean oldPasswordValid = PasswordUtil.verifyPassword(oldPassword, user.getPasswordHash());
        if (!oldPasswordValid) {
            throw new AuthenticationException("Current password is incorrect");
        }
        
        // Hash new password
        String newPasswordHash = PasswordUtil.hashPassword(newPassword);
        
        // Update password
        boolean updated = userDAO.changePassword(userId, newPasswordHash);
        
        if (updated) {
            LOGGER.info("Successfully changed password for user ID: " + userId);
        }
        
        return updated;
    }
    
    /**
     * Check if a user has a specific role
     * 
     * @param user User object
     * @param role Role to check
     * @return true if user has the role, false otherwise
     */
    public boolean hasRole(User user, User.Role role) {
        return user != null && user.getRole() == role;
    }
    
    /**
     * Check if user is an admin
     * 
     * @param user User object
     * @return true if user is admin, false otherwise
     */
    public boolean isAdmin(User user) {
        return hasRole(user, User.Role.ADMIN);
    }
    
    /**
     * Check if user is a student
     * 
     * @param user User object
     * @return true if user is student, false otherwise
     */
    public boolean isStudent(User user) {
        return hasRole(user, User.Role.STUDENT);
    }
    
    /**
     * Get user by ID
     * 
     * @param userId User ID
     * @return User object if found, null otherwise
     * @throws DatabaseException if database operation fails
     */
    public User getUserById(int userId) throws DatabaseException {
        return userDAO.findById(userId);
    }
    
    /**
     * Get user by username
     * 
     * @param username Username
     * @return User object if found, null otherwise
     * @throws DatabaseException if database operation fails
     */
    public User getUserByUsername(String username) throws DatabaseException {
        return userDAO.findByUsername(username);
    }
    
    /**
     * Deactivate a user account
     * 
     * @param userId User ID
     * @return true if successfully deactivated
     * @throws DatabaseException if database operation fails
     */
    public boolean deactivateUser(int userId) throws DatabaseException {
        User user = userDAO.findById(userId);
        if (user == null) {
            return false;
        }
        
        user.setActive(false);
        boolean updated = userDAO.update(user);
        
        if (updated) {
            LOGGER.info("Deactivated user ID: " + userId);
        }
        
        return updated;
    }
    
    /**
     * Activate a user account
     * 
     * @param userId User ID
     * @return true if successfully activated
     * @throws DatabaseException if database operation fails
     */
    public boolean activateUser(int userId) throws DatabaseException {
        User user = userDAO.findById(userId);
        if (user == null) {
            return false;
        }
        
        user.setActive(true);
        boolean updated = userDAO.update(user);
        
        if (updated) {
            LOGGER.info("Activated user ID: " + userId);
        }
        
        return updated;
    }
}
