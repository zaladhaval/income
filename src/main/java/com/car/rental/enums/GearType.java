package com.car.rental.enums;

public enum GearType implements IncomeEnum {

    MANUAL(0),
    AUTOMATIC(1);

    private final int id;

    GearType(int id) {
        this.id = id;
    }

    @Override
    public int getId() {
        return id;
    }
}
