package com.car.rental.bookings;

import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotNull;

import java.util.Date;

public class BookingRequest {
    
    @NotNull(message = "Car ID is required")
    private Long carId;
    
    @NotNull(message = "Pickup date is required")
    @Future(message = "Pickup date must be in the future")
    private Date pickupDate;
    
    @NotNull(message = "Return date is required")
    @Future(message = "Return date must be in the future")
    private Date returnDate;
    
    private String pickupLocation;
    
    private String returnLocation;
    
    private String notes;

    public Long getCarId() {
        return carId;
    }

    public void setCarId(Long carId) {
        this.carId = carId;
    }

    public Date getPickupDate() {
        return pickupDate;
    }

    public void setPickupDate(Date pickupDate) {
        this.pickupDate = pickupDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getReturnLocation() {
        return returnLocation;
    }

    public void setReturnLocation(String returnLocation) {
        this.returnLocation = returnLocation;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
