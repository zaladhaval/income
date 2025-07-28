package com.rental.enums;

/**
 * Enum representing different types of users in the car rental system
 */
public enum UserType {
    ADMIN("Admin"),
    TECHNICAL("Technical"),
    CUSTOMER("Customer");

    private final String displayName;

    UserType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
