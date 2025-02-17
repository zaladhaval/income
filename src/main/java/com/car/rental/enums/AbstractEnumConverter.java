package com.car.rental.enums;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class AbstractEnumConverter<X extends IncomeEnum> implements AttributeConverter<X, Integer> {

    private final Class<? extends IncomeEnum> enumClazz;

    public AbstractEnumConverter(Class<? extends IncomeEnum> enumClazz) {
        this.enumClazz = enumClazz;
    }

    public Integer convertToDatabaseColumn(X attribute) {
        return attribute == null ? null : attribute.getId();
    }

    @SuppressWarnings("unchecked")
    public X convertToEntityAttribute(Integer dbData) {
        return dbData == null ? null : (X) toEnum(enumClazz, dbData);
    }

    public IncomeEnum toEnum(Class<? extends IncomeEnum> enumClazz, int id) {
        IncomeEnum[] oprEnumValues = enumClazz.getEnumConstants();
        for (IncomeEnum val : oprEnumValues) {
            if (val.getId() == id) {
                return val;
            }
        }
        return null;
    }

}

