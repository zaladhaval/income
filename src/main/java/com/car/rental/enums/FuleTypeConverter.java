package com.car.rental.enums;

import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class FuleTypeConverter extends AbstractEnumConverter<FuleType> {

    public FuleTypeConverter() {
        super(FuleType.class);
    }

}
