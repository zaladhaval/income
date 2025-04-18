package com.car.rental.enums;

public enum BookingStatus implements IncomeEnum {
    PENDING(1, "Pending"),
    CONFIRMED(2, "Confirmed"),
    ACTIVE(3, "Active"),
    COMPLETED(4, "Completed"),
    CANCELLED(5, "Cancelled");

    private final int id;
    private final String name;

    BookingStatus(int id, String name) {
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
