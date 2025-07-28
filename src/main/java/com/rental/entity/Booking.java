package com.rental.entity;

import com.rental.enums.BookingStatus;
import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import org.hibernate.annotations.CreationTimestamp;

import java.math.BigDecimal;

/**
 * Entity representing a booking in the car rental system
 */
@Entity
@Table(name = "bookings")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "booking_id")
    private long bookingId;

    @NotNull(message = "Car is required")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "car_id", nullable = false)
    private Car car;

    @NotNull(message = "Customer is required")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id", nullable = false)
    private User customer;

    @NotNull(message = "Start date is required")
    @Column(name = "start_date", nullable = false)
    private long startDate;

    @NotNull(message = "End date is required")
    @Column(name = "end_date", nullable = false)
    private long endDate;

    @NotNull(message = "Earning amount is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Earning amount must be positive")
    @Column(name = "earning_amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal earningAmount;

    @Column(name = "total_earning", precision = 10, scale = 2)
    private BigDecimal totalEarning;

    @Column(name = "amount_credited_date")
    private long amountCreditedDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "booking_status", nullable = false)
    private BookingStatus bookingStatus = BookingStatus.PENDING;

    @CreationTimestamp
    @Column(name = "created_date", nullable = false, updatable = false)
    private long createdDate;

    // Default constructor
    public Booking() {
    }

    // Constructor with parameters
    public Booking(Car car, User customer, long startDate, long endDate, BigDecimal earningAmount,
            BookingStatus bookingStatus) {
        this.car = car;
        this.customer = customer;
        this.startDate = startDate;
        this.endDate = endDate;
        this.earningAmount = earningAmount;
        this.bookingStatus = bookingStatus;
        calculateTotalEarning();
    }

    // Method to calculate total earning (can be extended with additional logic)
    public void calculateTotalEarning() {
        if (earningAmount != null) {
            this.totalEarning = earningAmount;
        }
    }

    // Getters and Setters
    public long getBookingId() {
        return bookingId;
    }

    public void setBookingId(long bookingId) {
        this.bookingId = bookingId;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public long getStartDate() {
        return startDate;
    }

    public void setStartDate(long startDate) {
        this.startDate = startDate;
    }

    public long getEndDate() {
        return endDate;
    }

    public void setEndDate(long endDate) {
        this.endDate = endDate;
    }

    public BigDecimal getEarningAmount() {
        return earningAmount;
    }

    public void setEarningAmount(BigDecimal earningAmount) {
        this.earningAmount = earningAmount;
        calculateTotalEarning();
    }

    public BigDecimal getTotalEarning() {
        return totalEarning;
    }

    public void setTotalEarning(BigDecimal totalEarning) {
        this.totalEarning = totalEarning;
    }

    public long getAmountCreditedDate() {
        return amountCreditedDate;
    }

    public void setAmountCreditedDate(long amountCreditedDate) {
        this.amountCreditedDate = amountCreditedDate;
    }

    public BookingStatus getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(BookingStatus bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public long getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(long createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "Booking{" + "bookingId=" + bookingId + ", startDate=" + startDate + ", endDate=" + endDate
                + ", earningAmount=" + earningAmount + ", bookingStatus=" + bookingStatus + '}';
    }
}
