package com.rental.controller;

import com.rental.dto.DashboardStatsDTO;
import com.rental.entity.Booking;
import com.rental.service.DashboardService;
import com.rental.util.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

/**
 * Controller for dashboard operations
 */
@Controller
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    /**
     * Show dashboard page
     */
    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        try {
            // Get dashboard statistics for admin and technical users
            DashboardStatsDTO dashboardStats = dashboardService.getDashboardStats();
            model.addAttribute("dashboardStats", dashboardStats);
            
            // Get recent bookings
            List<Booking> recentBookings = dashboardService.getRecentBookings(5);
            model.addAttribute("recentBookings", recentBookings);
            
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error loading dashboard data: " + e.getMessage());
        }

        // Add DateUtils for JSP date formatting
        model.addAttribute("dateUtils", new DateUtils());

        return "dashboard";
    }

    /**
     * Get dashboard statistics (AJAX endpoint)
     */
    @GetMapping("/api/dashboard/stats")
    @PreAuthorize("hasAnyRole('ADMIN', 'TECHNICAL')")
    public String getDashboardStats(Model model) {
        try {
            DashboardStatsDTO stats = dashboardService.getDashboardStats();
            model.addAttribute("stats", stats);
            return "fragments/dashboard-stats";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error loading statistics: " + e.getMessage());
            return "error";
        }
    }
}
