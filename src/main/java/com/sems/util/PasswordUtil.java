package com.sems.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for password hashing and verification using BCrypt.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class PasswordUtil {
    
    // BCrypt workload factor (number of rounds)
    private static final int WORKLOAD = 10;
    
    /**
     * Private constructor to prevent instantiation
     */
    private PasswordUtil() {
    }
    
    /**
     * Hash a plain text password using BCrypt
     * 
     * @param plainPassword The plain text password to hash
     * @return The BCrypt hashed password
     * @throws IllegalArgumentException if password is null or empty
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        
        String salt = BCrypt.gensalt(WORKLOAD);
        return BCrypt.hashpw(plainPassword, salt);
    }
    
    /**
     * Verify a plain text password against a hashed password
     * 
     * @param plainPassword The plain text password to verify
     * @param hashedPassword The stored hashed password
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || plainPassword.trim().isEmpty()) {
            return false;
        }
        
        if (hashedPassword == null || hashedPassword.trim().isEmpty()) {
            return false;
        }
        
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            // Invalid hash format
            return false;
        }
    }
    
    /**
     * Check if a password meets minimum security requirements
     * 
     * @param password The password to validate
     * @return true if password meets requirements, false otherwise
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 6) {
            return false;
        }
        
        // Password must be at least 6 characters
        // Can add more complex requirements here (uppercase, numbers, special chars)
        return true;
    }
}
