package com.car.rental.enums;

public enum FuleType implements IncomeEnum {

    PETROL(0),
    DIESEL(1),
    EV(2),
    HYBRID(3);

    private final int id;

    FuleType(int id) {
        this.id = id;
    }

    @Override
    public int getId() {
        return id;
    }
}
