package com.car.rental.web;

import com.car.rental.bookings.Bookings;
import com.car.rental.bookings.BookingsRepository;
import com.car.rental.car.Car;
import com.car.rental.car.CarRepository;
import com.car.rental.customer.IncomeUserRepository;
import com.car.rental.enums.BookingStatus;
import com.car.rental.enums.CarStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/")
public class ViewController {

    private final CarRepository carRepository;
    private final BookingsRepository bookingsRepository;
    private final IncomeUserRepository userRepository;

    public ViewController(CarRepository carRepository, BookingsRepository bookingsRepository,
            IncomeUserRepository userRepository) {
        this.carRepository = carRepository;
        this.bookingsRepository = bookingsRepository;
        this.userRepository = userRepository;
    }

    @GetMapping
    public ModelAndView home() {
        ModelAndView model = new ModelAndView();
        model.setViewName("index");
        return model;
    }

    @GetMapping("/login")
    public ModelAndView login() {
        ModelAndView model = new ModelAndView();
        model.setViewName("login");
        return model;
    }

    @GetMapping("/register")
    public ModelAndView register() {
        ModelAndView model = new ModelAndView();
        model.setViewName("register");
        return model;
    }

    @GetMapping("/carview")
    public ModelAndView carView() {
        ModelAndView model = new ModelAndView();
        model.setViewName("cars");

        // Add available cars count
        long availableCarsCount = carRepository.findByStatus(CarStatus.AVAILABLE).size();
        model.addObject("availableCarsCount", availableCarsCount);

        return model;
    }

    @GetMapping("/car1/{id}")
    public ModelAndView carDetails(@PathVariable Long id) {
        ModelAndView model = new ModelAndView();
        model.setViewName("car-details");

        Optional<Car> carOptional = carRepository.findById(id);
        if (carOptional.isPresent()) {
            model.addObject("car", carOptional.get());
        }

        return model;
    }

    @GetMapping("/dashboard")
    @PreAuthorize("hasRole('ADMIN') or hasRole('STAFF')")
    public ModelAndView dashboard() {
        ModelAndView model = new ModelAndView();
        model.setViewName("dashboard");

        // Add statistics for dashboard
        long totalCars = carRepository.count();
        long availableCars = carRepository.findByStatus(CarStatus.AVAILABLE).size();
        long totalUsers = userRepository.count();
        long totalBookings = bookingsRepository.count();
        long activeBookings = bookingsRepository.findByStatus(BookingStatus.ACTIVE).size();

        model.addObject("totalCars", totalCars);
        model.addObject("availableCars", availableCars);
        model.addObject("totalUsers", totalUsers);
        model.addObject("totalBookings", totalBookings);
        model.addObject("activeBookings", activeBookings);

        // Get recent bookings
        List<Bookings> recentBookings = bookingsRepository.findAll();
        model.addObject("recentBookings", recentBookings);

        return model;
    }

    @GetMapping("/bookings")
    @PreAuthorize("isAuthenticated()")
    public ModelAndView bookings() {
        ModelAndView model = new ModelAndView();
        model.setViewName("bookings");
        return model;
    }

    @GetMapping("/booking1/{id}")
    @PreAuthorize("isAuthenticated()")
    public ModelAndView bookingDetails(@PathVariable Long id) {
        ModelAndView model = new ModelAndView();
        model.setViewName("booking-details");

        Optional<Bookings> bookingOptional = bookingsRepository.findById(id);
        if (bookingOptional.isPresent()) {
            model.addObject("booking", bookingOptional.get());

            // Get car details
            Optional<Car> carOptional = carRepository.findById(bookingOptional.get().getCarId());
            carOptional.ifPresent(car -> model.addObject("car", car));
        }

        return model;
    }

    @GetMapping("/profile")
    @PreAuthorize("isAuthenticated()")
    public ModelAndView profile() {
        ModelAndView model = new ModelAndView();
        model.setViewName("profile");
        return model;
    }

    @GetMapping("/admin/users")
    @PreAuthorize("hasRole('ADMIN')")
    public ModelAndView users() {
        ModelAndView model = new ModelAndView();
        model.setViewName("users");
        return model;
    }

    @GetMapping("/admin/cars")
    @PreAuthorize("hasRole('ADMIN') or hasRole('STAFF')")
    public ModelAndView adminCars() {
        ModelAndView model = new ModelAndView();
        model.setViewName("admin-cars");
        return model;
    }

    @GetMapping("/test")
    public String test() {
        return "test";
    }
}
