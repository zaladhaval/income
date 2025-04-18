package com.car.rental.bookings;

import com.car.rental.enums.BookingStatus;
import jakarta.validation.constraints.NotNull;

public class BookingStatusRequest {
    
    @NotNull(message = "Status is required")
    private BookingStatus status;

    public BookingStatus getStatus() {
        return status;
    }

    public void setStatus(BookingStatus status) {
        this.status = status;
    }
}
