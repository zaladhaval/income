package com.rental.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * Utility class to generate BCrypt encoded passwords
 */
public class PasswordGenerator {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String password = "password123";
        String encodedPassword = encoder.encode(password);
        System.out.println("Original password: " + password);
        System.out.println("BCrypt encoded: " + encodedPassword);
        
        // Verify the encoding works
        boolean matches = encoder.matches(password, encodedPassword);
        System.out.println("Verification: " + matches);
    }
}
