package com.sems.util;

import java.util.regex.Pattern;

/**
 * Utility class for input validation and sanitization.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class ValidationUtil {
    
    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );
    
    // Phone number pattern (Malaysian format)
    private static final Pattern PHONE_PATTERN = Pattern.compile(
        "^(\\+?60|0)[0-9]{8,10}$"
    );
    
    /**
     * Private constructor to prevent instantiation
     */
    private ValidationUtil() {
    }
    
    /**
     * Check if a string is null or empty
     * 
     * @param str The string to check
     * @return true if null or empty, false otherwise
     */
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
    
    /**
     * Validate email address format
     * 
     * @param email The email address to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (isNullOrEmpty(email)) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }
    
    /**
     * Validate phone number format
     * 
     * @param phone The phone number to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidPhone(String phone) {
        if (isNullOrEmpty(phone)) {
            return false;
        }
        // Remove spaces and dashes for validation
        String cleanedPhone = phone.replaceAll("[\\s-]", "");
        return PHONE_PATTERN.matcher(cleanedPhone).matches();
    }
    
    /**
     * Sanitize user input to prevent XSS
     * 
     * @param input The input string to sanitize
     * @return Sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return "";
        }
        
        return input.trim()
                    .replaceAll("<", "&lt;")
                    .replaceAll(">", "&gt;")
                    .replaceAll("\"", "&quot;")
                    .replaceAll("'", "&#x27;")
                    .replaceAll("/", "&#x2F;");
    }
    
    /**
     * Validate course code format
     * 
     * @param courseCode The course code to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidCourseCode(String courseCode) {
        if (isNullOrEmpty(courseCode)) {
            return false;
        }
        // Course code should be alphanumeric and 5-20 characters
        return courseCode.matches("^[A-Z]{2,5}\\d{4}$");
    }
    
    /**
     * Validate credit hours
     * 
     * @param credits The credit hours to validate
     * @return true if valid (1-4), false otherwise
     */
    public static boolean isValidCredits(int credits) {
        return credits >= 1 && credits <= 4;
    }
    
    /**
     * Validate capacity
     * 
     * @param capacity The capacity to validate
     * @return true if valid (positive number), false otherwise
     */
    public static boolean isValidCapacity(int capacity) {
        return capacity > 0 && capacity <= 200;
    }
    
    /**
     * Validate grade
     * 
     * @param grade The grade to validate
     * @return true if valid grade format, false otherwise
     */
    public static boolean isValidGrade(String grade) {
        if (isNullOrEmpty(grade)) {
            return true; // Null grades are allowed (not yet graded)
        }
        
        // Valid grades: A, A-, B+, B, B-, C+, C, C-, D, F
        return grade.matches("^(A|A-|B\\+|B|B-|C\\+|C|C-|D|F)$");
    }
    
    /**
     * Validate age (for date of birth)
     * 
     * @param age The age to validate
     * @return true if age is between 16 and 100, false otherwise
     */
    public static boolean isValidAge(int age) {
        return age >= 16 && age <= 100;
    }

    /**
     * Validate password complexity:
     * - Minimum 6 characters
     * - At least one uppercase letter
     * - At least one lowercase letter
     * - At least one digit
     * - At least one special symbol
     * 
     * @param password The password to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidPassword(String password) {
        if (isNullOrEmpty(password) || password.length() < 6) {
            return false;
        }

        boolean hasUpper = password.matches(".*[A-Z].*");
        boolean hasLower = password.matches(".*[a-z].*");
        boolean hasDigit = password.matches(".*[0-9].*");
        boolean hasSymbol = password.matches(".*[!@#$%^&*(),.?\":{}|<>].*");

        return hasUpper && hasLower && hasDigit && hasSymbol;
    }
}
