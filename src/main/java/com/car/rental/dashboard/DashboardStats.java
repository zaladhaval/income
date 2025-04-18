package com.car.rental.dashboard;

import java.math.BigDecimal;
import java.util.Map;

public class DashboardStats {
    private long totalCars;
    private long availableCars;
    private long totalCustomers;
    private long totalBookings;
    private long activeBookings;
    private BigDecimal totalRevenue;
    private Map<String, BigDecimal> monthlyRevenue;
    private Map<String, Long> popularCarModels;

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

    public long getActiveBookings() {
        return activeBookings;
    }

    public void setActiveBookings(long activeBookings) {
        this.activeBookings = activeBookings;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public Map<String, BigDecimal> getMonthlyRevenue() {
        return monthlyRevenue;
    }

    public void setMonthlyRevenue(Map<String, BigDecimal> monthlyRevenue) {
        this.monthlyRevenue = monthlyRevenue;
    }

    public Map<String, Long> getPopularCarModels() {
        return popularCarModels;
    }

    public void setPopularCarModels(Map<String, Long> popularCarModels) {
        this.popularCarModels = popularCarModels;
    }
}
