package com.car.rental.enums;

import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class BookingStatusConverter extends AbstractEnumConverter<BookingStatus> {
    public BookingStatusConverter() {
        super(BookingStatus.class);
    }
}
