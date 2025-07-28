package com.rental.controller;

import com.rental.entity.Booking;
import com.rental.entity.User;
import com.rental.enums.UserType;
import com.rental.service.BookingService;
import com.rental.service.UserService;
import com.rental.util.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller for customer management operations (Admin only)
 */
@Controller
@RequestMapping("/customers")
@PreAuthorize("hasRole('ADMIN')")
public class CustomerController {

    @Autowired
    private UserService userService;

    @Autowired
    private BookingService bookingService;

    /**
     * List all customers with pagination and search
     */
    @GetMapping
    public String listCustomers(@RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "10") int size,
                               @RequestParam(defaultValue = "name") String sort,
                               @RequestParam(defaultValue = "asc") String direction,
                               @RequestParam(required = false) String search,
                               Model model) {
        try {
            Sort.Direction sortDirection = "desc".equalsIgnoreCase(direction) ? 
                Sort.Direction.DESC : Sort.Direction.ASC;
            Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sort));
            
            Page<User> customers = userService.searchCustomers(search, pageable);
            
            model.addAttribute("customers", customers);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", customers.getTotalPages());
            model.addAttribute("totalElements", customers.getTotalElements());
            model.addAttribute("size", size);
            model.addAttribute("sort", sort);
            model.addAttribute("direction", direction);
            model.addAttribute("search", search);

            // Add DateUtils for JSP date formatting
            model.addAttribute("dateUtils", new DateUtils());

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error loading customers: " + e.getMessage());
        }

        return "customers/list";
    }

    /**
     * Show customer details with booking history
     */
    @GetMapping("/{id}")
    public String showCustomer(@PathVariable long id, Model model) {
        try {
            User customer = userService.getUserById(id);
            
            // Verify this is a customer
            if (customer.getUserType() != UserType.CUSTOMER) {
                model.addAttribute("errorMessage", "User is not a customer");
                return "redirect:/customers";
            }
            
            // Get customer's booking history
            List<Booking> bookings = bookingService.getBookingsByCustomer(customer);
            
            model.addAttribute("customer", customer);
            model.addAttribute("customerBookings", bookings);

            // Add DateUtils for JSP date formatting
            model.addAttribute("dateUtils", new DateUtils());

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Customer not found: " + e.getMessage());
            return "redirect:/customers";
        }

        return "customers/detail";
    }

    /**
     * Deactivate customer
     */
    @PostMapping("/{id}/deactivate")
    public String deactivateCustomer(@PathVariable long id, Model model) {
        try {
            User customer = userService.getUserById(id);
            userService.deactivateUser(id);
            model.addAttribute("successMessage", 
                "Customer '" + customer.getName() + "' has been deactivated");
        } catch (Exception e) {
            model.addAttribute("errorMessage", 
                "Error deactivating customer: " + e.getMessage());
        }
        
        return "redirect:/customers";
    }

    /**
     * Activate customer
     */
    @PostMapping("/{id}/activate")
    public String activateCustomer(@PathVariable long id, Model model) {
        try {
            User customer = userService.getUserById(id);
            userService.activateUser(id);
            model.addAttribute("successMessage", 
                "Customer '" + customer.getName() + "' has been activated");
        } catch (Exception e) {
            model.addAttribute("errorMessage", 
                "Error activating customer: " + e.getMessage());
        }
        
        return "redirect:/customers";
    }
}
