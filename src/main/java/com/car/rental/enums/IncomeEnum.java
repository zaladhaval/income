package com.car.rental.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public interface IncomeEnum {

    public default String getEnumName() {
        return getClass().getSimpleName();
    }

    public int getId();

    @JsonValue
    public default String toValue() {
        return ((Enum<?>) this).name().toLowerCase();
    }

    @SuppressWarnings("unchecked")
    @JsonCreator
    public default <T extends Enum<T> & IncomeEnum> T forValue(String value) {
        if (value != null) {
            String values = value.toUpperCase();
            try {
                return Enum.valueOf((Class<T>) this.getClass(), values);
            } catch (Exception e) {
                //ignoreException
            }
        }
        return null;
    }

    public default String getTranslationKey() {
        return this.getEnumName().toLowerCase() + "." + this.toValue();
    }

}
