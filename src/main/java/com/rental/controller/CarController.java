package com.rental.controller;

import com.rental.entity.Car;
import com.rental.enums.FuelType;
import com.rental.enums.GearType;
import com.rental.service.CarService;
import com.rental.util.DateUtils;

import java.time.LocalDate;
import java.time.ZoneId;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller for car management operations
 */
@Controller
@RequestMapping("/cars")
@PreAuthorize("hasAnyRole('ADMIN', 'TECHNICAL')")
public class CarController {

    @Autowired
    private CarService carService;

    /**
     * List all cars with pagination and search
     */
    @GetMapping
    public String listCars(@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size, @RequestParam(defaultValue = "id") String sort,
            @RequestParam(defaultValue = "desc") String direction,
            @RequestParam(required = false) String search, @RequestParam(required = false) String fuelType,
            @RequestParam(required = false) String gearType,
            @RequestParam(required = false) Boolean available, Model model) {
        try {
            Sort.Direction sortDirection =
                    "desc".equalsIgnoreCase(direction) ? Sort.Direction.DESC : Sort.Direction.ASC;
            Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sort));

            FuelType fuelTypeEnum = null;
            if (fuelType != null && !fuelType.isEmpty()) {
                try {
                    fuelTypeEnum = FuelType.valueOf(fuelType);
                } catch (IllegalArgumentException e) {
                    // Invalid fuel type, ignore
                }
            }

            GearType gearTypeEnum = null;
            if (gearType != null && !gearType.isEmpty()) {
                try {
                    gearTypeEnum = GearType.valueOf(gearType);
                } catch (IllegalArgumentException e) {
                    // Invalid gear type, ignore
                }
            }

            Page<Car> cars =
                    carService.searchCarsWithFilters(search, fuelTypeEnum, gearTypeEnum, available, pageable);

            model.addAttribute("cars", cars);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", cars.getTotalPages());
            model.addAttribute("totalElements", cars.getTotalElements());
            model.addAttribute("size", size);
            model.addAttribute("sort", sort);
            model.addAttribute("direction", direction);
            model.addAttribute("search", search);
            model.addAttribute("fuelType", fuelType);
            model.addAttribute("gearType", gearType);
            model.addAttribute("available", available);

            // Add enum values for filters
            model.addAttribute("fuelTypes", FuelType.values());
            model.addAttribute("gearTypes", GearType.values());

            // Add DateUtils for JSP date formatting
            model.addAttribute("dateUtils", new DateUtils());

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error loading cars: " + e.getMessage());
        }

        return "cars/list";
    }

    /**
     * Show car details
     */
    @GetMapping("/{id}")
    public String showCar(@PathVariable long id, Model model) {
        try {
            Car car = carService.getCarById(id);
            model.addAttribute("car", car);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Car not found: " + e.getMessage());
            return "redirect:/cars";
        }

        // Add DateUtils for JSP date formatting
        model.addAttribute("dateUtils", new DateUtils());

        return "cars/detail";
    }

    /**
     * Show new car form
     */
    @GetMapping("/new")
    public String showNewCarForm(Model model) {
        model.addAttribute("car", new Car());
        model.addAttribute("fuelTypes", FuelType.values());
        model.addAttribute("gearTypes", GearType.values());
        model.addAttribute("isEdit", false);

        // Add DateUtils for JSP date formatting and conversion
        model.addAttribute("dateUtils", new DateUtils());

        return "cars/form";
    }

    /**
     * Show edit car form
     */
    @GetMapping("/{id}/edit")
    public String showEditCarForm(@PathVariable long id, Model model) {
        try {
            Car car = carService.getCarById(id);
            model.addAttribute("car", car);
            model.addAttribute("fuelTypes", FuelType.values());
            model.addAttribute("gearTypes", GearType.values());
            model.addAttribute("isEdit", true);

            // Add DateUtils for JSP date formatting and conversion
            model.addAttribute("dateUtils", new DateUtils());
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Car not found: " + e.getMessage());
            return "redirect:/cars";
        }

        return "cars/form";
    }

    /**
     * Create new car
     */
    @PostMapping
    public String createCar(@Valid @ModelAttribute Car car, @RequestParam(required = false) String dateOfPurchaseStr,
            BindingResult result, Model model, RedirectAttributes redirectAttributes) {

        // Handle date conversion from string to timestamp
        if (dateOfPurchaseStr != null && !dateOfPurchaseStr.isEmpty()) {
            try {
                LocalDate date = LocalDate.parse(dateOfPurchaseStr);
                car.setDateOfPurchase(date.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli());
            } catch (Exception e) {
                result.rejectValue("dateOfPurchase", "error.car", "Invalid date format");
            }
        }

        if (result.hasErrors()) {
            model.addAttribute("fuelTypes", FuelType.values());
            model.addAttribute("gearTypes", GearType.values());
            model.addAttribute("isEdit", false);
            model.addAttribute("dateUtils", new DateUtils());
            return "cars/form";
        }

        try {
            carService.createCar(car);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Car '" + car.getName() + "' has been created successfully!");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error creating car: " + e.getMessage());
            model.addAttribute("fuelTypes", FuelType.values());
            model.addAttribute("gearTypes", GearType.values());
            model.addAttribute("isEdit", false);
            model.addAttribute("dateUtils", new DateUtils());
            return "cars/form";
        }

        return "redirect:/cars";
    }

    /**
     * Update car
     */
    @PostMapping("/{id}")
    public String updateCar(@PathVariable long id, @Valid @ModelAttribute Car car,
            @RequestParam(required = false) String dateOfPurchaseStr, BindingResult result,
            Model model, RedirectAttributes redirectAttributes) {

        // Handle date conversion from string to timestamp
        if (dateOfPurchaseStr != null && !dateOfPurchaseStr.isEmpty()) {
            try {
                LocalDate date = LocalDate.parse(dateOfPurchaseStr);
                car.setDateOfPurchase(date.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli());
            } catch (Exception e) {
                result.rejectValue("dateOfPurchase", "error.car", "Invalid date format");
            }
        }

        if (result.hasErrors()) {
            model.addAttribute("fuelTypes", FuelType.values());
            model.addAttribute("gearTypes", GearType.values());
            model.addAttribute("isEdit", true);
            model.addAttribute("dateUtils", new DateUtils());
            return "cars/form";
        }

        try {
            car.setId(id);
            carService.updateCar(car);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Car '" + car.getName() + "' has been updated successfully!");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating car: " + e.getMessage());
            model.addAttribute("fuelTypes", FuelType.values());
            model.addAttribute("gearTypes", GearType.values());
            model.addAttribute("isEdit", true);
            model.addAttribute("dateUtils", new DateUtils());
            return "cars/form";
        }

        return "redirect:/cars";
    }

    /**
     * Delete car
     */
    @PostMapping("/{id}/delete")
    public String deleteCar(@PathVariable long id, RedirectAttributes redirectAttributes) {
        try {
            Car car = carService.getCarById(id);
            carService.deleteCar(id);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Car '" + car.getName() + "' has been deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting car: " + e.getMessage());
        }

        return "redirect:/cars";
    }

    /**
     * Toggle car availability
     */
    @PostMapping("/{id}/toggle-availability")
    public String toggleAvailability(@PathVariable long id, RedirectAttributes redirectAttributes) {
        try {
            Car car = carService.getCarById(id);
            carService.setCarAvailability(id, !car.getIsAvailable());

            String status = car.getIsAvailable() ? "unavailable" : "available";
            redirectAttributes.addFlashAttribute("successMessage",
                    "Car '" + car.getName() + "' is now " + status + "!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Error updating car availability: " + e.getMessage());
        }

        return "redirect:/cars";
    }
}
