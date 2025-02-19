package com.car.rental.bookings;

import com.car.rental.base.IncomeBaseRest;

import java.io.Serial;
import java.util.Date;

public class BookingsRest extends IncomeBaseRest {

    @Serial
    private static final long serialVersionUID = -1352726589921722591L;

    private String bookingId;

    private long customerId;

    private long carId;

    private Date bookingStartDate;

    private Date bookingEndDate;

    private long statusId;

    private double bookingAmount;

    private double creditedAmount;

    private Date creditedDate;

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(long customerId) {
        this.customerId = customerId;
    }

    public long getCarId() {
        return carId;
    }

    public void setCarId(long carId) {
        this.carId = carId;
    }

    public Date getBookingStartDate() {
        return bookingStartDate;
    }

    public void setBookingStartDate(Date bookingStartDate) {
        this.bookingStartDate = bookingStartDate;
    }

    public Date getBookingEndDate() {
        return bookingEndDate;
    }

    public void setBookingEndDate(Date bookingEndDate) {
        this.bookingEndDate = bookingEndDate;
    }

    public long getStatusId() {
        return statusId;
    }

    public void setStatusId(long statusId) {
        this.statusId = statusId;
    }

    public double getBookingAmount() {
        return bookingAmount;
    }

    public void setBookingAmount(double bookingAmount) {
        this.bookingAmount = bookingAmount;
    }

    public double getCreditedAmount() {
        return creditedAmount;
    }

    public void setCreditedAmount(double creditedAmount) {
        this.creditedAmount = creditedAmount;
    }

    public Date getCreditedDate() {
        return creditedDate;
    }

    public void setCreditedDate(Date creditedDate) {
        this.creditedDate = creditedDate;
    }
}
