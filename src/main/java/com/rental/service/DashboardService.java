package com.rental.service;

import com.rental.dto.CarEarningsDTO;
import com.rental.dto.DashboardStatsDTO;
import com.rental.entity.Booking;
import com.rental.enums.UserType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * Service class for dashboard analytics and statistics
 */
@Service
@Transactional(readOnly = true)
public class DashboardService {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private ExpenseService expenseService;

    @Autowired
    private CarService carService;

    @Autowired
    private UserService userService;

    /**
     * Get comprehensive dashboard statistics
     */
    public DashboardStatsDTO getDashboardStats() {
        LocalDate now = LocalDate.now();
        int currentYear = now.getYear();
        int currentMonth = now.getMonthValue();

        // Calculate earnings and expenses
        BigDecimal totalEarnings = bookingService.calculateTotalEarnings();
        BigDecimal monthlyEarnings = bookingService.calculateMonthlyEarnings(currentYear, currentMonth);
        BigDecimal monthlyExpenses = expenseService.calculateMonthlyExpenses(currentYear, currentMonth);
        BigDecimal netMonthlyProfit = monthlyEarnings.subtract(monthlyExpenses);

        // Create dashboard stats DTO
        DashboardStatsDTO stats =
                new DashboardStatsDTO(totalEarnings, monthlyEarnings, monthlyExpenses, netMonthlyProfit);

        // Set car earnings data
        stats.setEarningsByCar(bookingService.getEarningsByCar());
        stats.setMonthlyCarPerformance(bookingService.getMonthlyCarPerformance(currentYear, currentMonth));

        // Set counts
        stats.setTotalCars(carService.countTotalCars());
        stats.setAvailableCars(carService.countAvailableCars());
        stats.setTotalCustomers(userService.countUsersByType(UserType.CUSTOMER));
        stats.setTotalBookings(bookingService.countTotalBookings());

        return stats;
    }

    /**
     * Get total earnings (all time)
     */
    public BigDecimal getTotalEarnings() {
        return bookingService.calculateTotalEarnings();
    }

    /**
     * Get monthly earnings for current month
     */
    public BigDecimal getCurrentMonthlyEarnings() {
        LocalDate now = LocalDate.now();
        return bookingService.calculateMonthlyEarnings(now.getYear(), now.getMonthValue());
    }

    /**
     * Get monthly earnings for specific month
     */
    public BigDecimal getMonthlyEarnings(int year, int month) {
        return bookingService.calculateMonthlyEarnings(year, month);
    }

    /**
     * Get monthly expenses for current month
     */
    public BigDecimal getCurrentMonthlyExpenses() {
        LocalDate now = LocalDate.now();
        return expenseService.calculateMonthlyExpenses(now.getYear(), now.getMonthValue());
    }

    /**
     * Get monthly expenses for specific month
     */
    public BigDecimal getMonthlyExpenses(int year, int month) {
        return expenseService.calculateMonthlyExpenses(year, month);
    }

    /**
     * Get net monthly profit for current month
     */
    public BigDecimal getCurrentNetMonthlyProfit() {
        BigDecimal earnings = getCurrentMonthlyEarnings();
        BigDecimal expenses = getCurrentMonthlyExpenses();
        return earnings.subtract(expenses);
    }

    /**
     * Get net monthly profit for specific month
     */
    public BigDecimal getNetMonthlyProfit(int year, int month) {
        BigDecimal earnings = getMonthlyEarnings(year, month);
        BigDecimal expenses = getMonthlyExpenses(year, month);
        return earnings.subtract(expenses);
    }

    /**
     * Get earnings by car (all time)
     */
    public List<CarEarningsDTO> getEarningsByCar() {
        return bookingService.getEarningsByCar();
    }

    /**
     * Get monthly car performance for current month
     */
    public List<CarEarningsDTO> getCurrentMonthlyCarPerformance() {
        LocalDate now = LocalDate.now();
        return bookingService.getMonthlyCarPerformance(now.getYear(), now.getMonthValue());
    }

    /**
     * Get monthly car performance for specific month
     */
    public List<CarEarningsDTO> getMonthlyCarPerformance(int year, int month) {
        return bookingService.getMonthlyCarPerformance(year, month);
    }

    /**
     * Get recent bookings
     */
    public List<Booking> getRecentBookings(int limit) {
        return bookingService.getRecentBookings(limit);
    }

    /**
     * Get recent bookings (default 5)
     */
    public List<Booking> getRecentBookings() {
        return getRecentBookings(5);
    }

    /**
     * Get system overview statistics
     */
    public DashboardStatsDTO getSystemOverview() {
        DashboardStatsDTO overview = new DashboardStatsDTO();

        overview.setTotalCars(carService.countTotalCars());
        overview.setAvailableCars(carService.countAvailableCars());
        overview.setTotalCustomers(userService.countUsersByType(UserType.CUSTOMER));
        overview.setTotalBookings(bookingService.countTotalBookings());
        overview.setTotalEarnings(bookingService.calculateTotalEarnings());

        return overview;
    }

    /**
     * Check if user has access to dashboard analytics
     */
    public boolean hasAnalyticsAccess(String userType) {
        return "ADMIN".equals(userType) || "TECHNICAL".equals(userType);
    }
}
