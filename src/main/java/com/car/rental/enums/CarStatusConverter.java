package com.car.rental.enums;

import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class CarStatusConverter extends AbstractEnumConverter<CarStatus> {
    public CarStatusConverter() {
        super(CarStatus.class);
    }
}
