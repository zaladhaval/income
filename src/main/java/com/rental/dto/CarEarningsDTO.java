package com.rental.dto;

import java.math.BigDecimal;

/**
 * DTO for car earnings data
 */
public class CarEarningsDTO {

    private String carName;
    private BigDecimal totalEarnings;

    // Default constructor
    public CarEarningsDTO() {}

    // Constructor with parameters
    public CarEarningsDTO(String carName, BigDecimal totalEarnings) {
        this.carName = carName;
        this.totalEarnings = totalEarnings;
    }

    // Getters and Setters
    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public BigDecimal getTotalEarnings() {
        return totalEarnings;
    }

    public void setTotalEarnings(BigDecimal totalEarnings) {
        this.totalEarnings = totalEarnings;
    }

    @Override
    public String toString() {
        return "CarEarningsDTO{" +
                "carName='" + carName + '\'' +
                ", totalEarnings=" + totalEarnings +
                '}';
    }
}
