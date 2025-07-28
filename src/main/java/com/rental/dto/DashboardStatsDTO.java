package com.rental.dto;

import java.math.BigDecimal;
import java.util.List;

/**
 * DTO for dashboard statistics
 */
public class DashboardStatsDTO {

    private BigDecimal totalEarnings;
    private BigDecimal monthlyEarnings;
    private BigDecimal monthlyExpenses;
    private BigDecimal netMonthlyProfit;
    private List<CarEarningsDTO> earningsByCar;
    private List<CarEarningsDTO> monthlyCarPerformance;
    private long totalCars;
    private long availableCars;
    private long totalCustomers;
    private long totalBookings;

    // Default constructor
    public DashboardStatsDTO() {
    }

    // Constructor with parameters
    public DashboardStatsDTO(BigDecimal totalEarnings, BigDecimal monthlyEarnings, BigDecimal monthlyExpenses,
            BigDecimal netMonthlyProfit) {
        this.totalEarnings = totalEarnings;
        this.monthlyEarnings = monthlyEarnings;
        this.monthlyExpenses = monthlyExpenses;
        this.netMonthlyProfit = netMonthlyProfit;
    }

    // Getters and Setters
    public BigDecimal getTotalEarnings() {
        return totalEarnings;
    }

    public void setTotalEarnings(BigDecimal totalEarnings) {
        this.totalEarnings = totalEarnings;
    }

    public BigDecimal getMonthlyEarnings() {
        return monthlyEarnings;
    }

    public void setMonthlyEarnings(BigDecimal monthlyEarnings) {
        this.monthlyEarnings = monthlyEarnings;
    }

    public BigDecimal getMonthlyExpenses() {
        return monthlyExpenses;
    }

    public void setMonthlyExpenses(BigDecimal monthlyExpenses) {
        this.monthlyExpenses = monthlyExpenses;
    }

    public BigDecimal getNetMonthlyProfit() {
        return netMonthlyProfit;
    }

    public void setNetMonthlyProfit(BigDecimal netMonthlyProfit) {
        this.netMonthlyProfit = netMonthlyProfit;
    }

    public List<CarEarningsDTO> getEarningsByCar() {
        return earningsByCar;
    }

    public void setEarningsByCar(List<CarEarningsDTO> earningsByCar) {
        this.earningsByCar = earningsByCar;
    }

    public List<CarEarningsDTO> getMonthlyCarPerformance() {
        return monthlyCarPerformance;
    }

    public void setMonthlyCarPerformance(List<CarEarningsDTO> monthlyCarPerformance) {
        this.monthlyCarPerformance = monthlyCarPerformance;
    }

    public long getTotalCars() {
        return totalCars;
    }

    public void setTotalCars(long totalCars) {
        this.totalCars = totalCars;
    }

    public long getAvailableCars() {
        return availableCars;
    }

    public void setAvailableCars(long availableCars) {
        this.availableCars = availableCars;
    }

    public long getTotalCustomers() {
        return totalCustomers;
    }

    public void setTotalCustomers(long totalCustomers) {
        this.totalCustomers = totalCustomers;
    }

    public long getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(long totalBookings) {
        this.totalBookings = totalBookings;
    }
}
