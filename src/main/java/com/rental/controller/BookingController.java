package com.rental.controller;

import com.rental.entity.Booking;
import com.rental.entity.Car;
import com.rental.entity.User;
import com.rental.enums.BookingStatus;
import com.rental.enums.UserType;
import com.rental.service.BookingService;
import com.rental.service.CarService;
import com.rental.service.UserService;
import com.rental.util.DateUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

/**
 * Controller for booking management operations
 */
@Controller
@RequestMapping("/bookings")
@PreAuthorize("hasAnyRole('ADMIN', 'TECHNICAL')")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private CarService carService;

    @Autowired
    private UserService userService;

    /**
     * List all bookings with pagination and search
     */
    @GetMapping
    public String listBookings(@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "bookingId") String sort,
            @RequestParam(defaultValue = "desc") String direction,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            Model model) {
        try {
            Sort.Direction sortDirection =
                    "desc".equalsIgnoreCase(direction) ? Sort.Direction.DESC : Sort.Direction.ASC;
            Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sort));

            Page<Booking> bookings;
            if (startDate != null || endDate != null) {
                bookings = bookingService.getBookingsByDateRangeWithPagination(startDate, endDate, pageable);
            } else if (search != null && !search.trim().isEmpty()) {
                bookings = bookingService.searchBookings(search, pageable);
            } else {
                bookings = bookingService.getAllBookingsWithPagination(pageable);
            }

            model.addAttribute("bookings", bookings);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", bookings.getTotalPages());
            model.addAttribute("totalElements", bookings.getTotalElements());
            model.addAttribute("size", size);
            model.addAttribute("sort", sort);
            model.addAttribute("direction", direction);
            model.addAttribute("search", search);
            model.addAttribute("startDate", startDate);
            model.addAttribute("endDate", endDate);

            // Add booking statuses for filter
            model.addAttribute("bookingStatuses", BookingStatus.values());

            // Add DateUtils for JSP date formatting
            model.addAttribute("dateUtils", new DateUtils());

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error loading bookings: " + e.getMessage());
        }

        return "bookings/list";
    }

    /**
     * Show booking details
     */
    @GetMapping("/{id}")
    public String showBooking(@PathVariable long id, Model model) {
        try {
            Booking booking = bookingService.getBookingById(id);
            model.addAttribute("booking", booking);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Booking not found: " + e.getMessage());
            return "redirect:/bookings";
        }

        // Add DateUtils for JSP date formatting
        model.addAttribute("dateUtils", new DateUtils());

        return "bookings/detail";
    }

    /**
     * Show new booking form
     */
    @GetMapping("/new")
    public String showNewBookingForm(Model model) {
        model.addAttribute("booking", new Booking());

        // Get available cars and customers
        List<Car> availableCars = carService.getAvailableCars();
        List<User> customers = userService.getUsersByType(UserType.CUSTOMER);

        model.addAttribute("cars", availableCars);
        model.addAttribute("customers", customers);
        model.addAttribute("bookingStatuses", BookingStatus.values());
        model.addAttribute("isEdit", false);

        // Add DateUtils for JSP date formatting
        model.addAttribute("dateUtils", new DateUtils());

        return "bookings/form";
    }

    /**
     * Show edit booking form
     */
    @GetMapping("/{id}/edit")
    public String showEditBookingForm(@PathVariable long id, Model model) {
        try {
            Booking booking = bookingService.getBookingById(id);
            model.addAttribute("booking", booking);

            // Get all cars and customers for editing
            List<Car> cars = carService.getAllCars();
            List<User> customers = userService.getUsersByType(UserType.CUSTOMER);

            model.addAttribute("cars", cars);
            model.addAttribute("customers", customers);
            model.addAttribute("bookingStatuses", BookingStatus.values());
            model.addAttribute("isEdit", true);

            // Add DateUtils for JSP date formatting
            model.addAttribute("dateUtils", new DateUtils());
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Booking not found: " + e.getMessage());
            return "redirect:/bookings";
        }

        return "bookings/form";
    }

    /**
     * Create new booking
     */
    @PostMapping
    public String createBooking(@Valid @ModelAttribute Booking booking, BindingResult result,
            @RequestParam long carId, @RequestParam long customerId, Model model,
            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("cars", carService.getAvailableCars());
            model.addAttribute("customers", userService.getUsersByType(UserType.CUSTOMER));
            model.addAttribute("bookingStatuses", BookingStatus.values());
            model.addAttribute("isEdit", false);
            return "bookings/form";
        }

        try {
            // Set car and customer
            Car car = carService.getCarById(carId);
            User customer = userService.getUserById(customerId);
            booking.setCar(car);
            booking.setCustomer(customer);

            bookingService.createBooking(booking);
            redirectAttributes.addFlashAttribute("successMessage", "Booking has been created successfully!");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error creating booking: " + e.getMessage());
            model.addAttribute("cars", carService.getAvailableCars());
            model.addAttribute("customers", userService.getUsersByType(UserType.CUSTOMER));
            model.addAttribute("bookingStatuses", BookingStatus.values());
            model.addAttribute("isEdit", false);
            return "bookings/form";
        }

        return "redirect:/bookings";
    }

    /**
     * Update booking
     */
    @PostMapping("/{id}")
    public String updateBooking(@PathVariable long id, @Valid @ModelAttribute Booking booking,
            BindingResult result, @RequestParam long carId, @RequestParam long customerId, Model model,
            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("cars", carService.getAllCars());
            model.addAttribute("customers", userService.getUsersByType(UserType.CUSTOMER));
            model.addAttribute("bookingStatuses", BookingStatus.values());
            model.addAttribute("isEdit", true);
            return "bookings/form";
        }

        try {
            // Set car and customer
            Car car = carService.getCarById(carId);
            User customer = userService.getUserById(customerId);
            booking.setBookingId(id);
            booking.setCar(car);
            booking.setCustomer(customer);

            bookingService.updateBooking(booking);
            redirectAttributes.addFlashAttribute("successMessage", "Booking has been updated successfully!");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating booking: " + e.getMessage());
            model.addAttribute("cars", carService.getAllCars());
            model.addAttribute("customers", userService.getUsersByType(UserType.CUSTOMER));
            model.addAttribute("bookingStatuses", BookingStatus.values());
            model.addAttribute("isEdit", true);
            return "bookings/form";
        }

        return "redirect:/bookings";
    }

    /**
     * Update booking status
     */
    @PostMapping("/{id}/status")
    public String updateBookingStatus(@PathVariable long id, @RequestParam BookingStatus status,
            RedirectAttributes redirectAttributes) {
        try {
            bookingService.updateBookingStatus(id, status);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Booking status has been updated to " + status.getDisplayName());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Error updating booking status: " + e.getMessage());
        }

        return "redirect:/bookings";
    }

    /**
     * Delete booking
     */
    @PostMapping("/{id}/delete")
    public String deleteBooking(@PathVariable long id, RedirectAttributes redirectAttributes) {
        try {
            bookingService.deleteBooking(id);
            redirectAttributes.addFlashAttribute("successMessage", "Booking has been deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting booking: " + e.getMessage());
        }

        return "redirect:/bookings";
    }

    /**
     * Check car availability (AJAX endpoint)
     */
    @GetMapping("/check-availability")
    @ResponseBody
    public String checkCarAvailability(@RequestParam long carId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        try {
            Car car = carService.getCarById(carId);
            boolean available = bookingService.isCarAvailable(car, startDate, endDate);
            return available ? "available" : "not_available";
        } catch (Exception e) {
            return "error";
        }
    }
}
