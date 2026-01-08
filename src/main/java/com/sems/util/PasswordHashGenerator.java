package com.sems.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility to generate BCrypt password hashes for initial data.
 * Run this to get hashed passwords for sample_data.sql
 */
public class PasswordHashGenerator {
    public static void main(String[] args) {
        // Generate hashes for the accounts
        String[] passwords = {"admin123", "resh123", "student123"};
        
        System.out.println("Password Hashes:");
        System.out.println("================");
        
        for (String password : passwords) {
            String hash = BCrypt.hashpw(password, BCrypt.gensalt(10));
            System.out.println("Password: " + password);
            System.out.println("Hash: " + hash);
            System.out.println();
        }
    }
}
