package com.sems.exception;

/**
 * Custom exception for authentication and authorization errors.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class AuthenticationException extends Exception {
    private static final long serialVersionUID = 1L;
    
    /**
     * Constructor with message
     * @param message Error message
     */
    public AuthenticationException(String message) {
        super(message);
    }
    
    /**
     * Constructor with message and cause
     * @param message Error message
     * @param cause The underlying cause
     */
    public AuthenticationException(String message, Throwable cause) {
        super(message, cause);
    }
}
