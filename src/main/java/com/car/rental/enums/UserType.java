package com.car.rental.enums;

public enum UserType implements EnumMarker {
    ADMIN(1, "Admin"),
    CUSTOMER(2, "Customer"),
    STAFF(3, "Staff");

    private final int id;
    private final String name;

    UserType(int id, String name) {
        this.id = id;
        this.name = name;
    }


    public int getId() {
        return id;
    }


    public String getName() {
        return name;
    }
}
