package com.car.rental.enums;

public enum CarStatus implements IncomeEnum {
    AVAILABLE(1, "Available"),
    BOOKED(2, "Booked"),
    MAINTENANCE(3, "Under Maintenance"),
    OUT_OF_SERVICE(4, "Out of Service");

    private final int id;
    private final String name;

    CarStatus(int id, String name) {
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
