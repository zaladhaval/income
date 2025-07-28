package com.rental.enums;

/**
 * Enum representing different gear types for cars
 */
public enum GearType {
    MANUAL("Manual"),
    AUTOMATIC("Automatic");

    private final String displayName;

    GearType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
