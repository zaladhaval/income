package com.car.rental.bookings;

import com.car.rental.car.Car;
import com.car.rental.car.CarRepository;
import com.car.rental.car.CarService;
import com.car.rental.customer.IncomeUser;
import com.car.rental.customer.IncomeUserRepository;
import com.car.rental.enums.BookingStatus;
import com.car.rental.enums.CarStatus;
import com.car.rental.security.MessageResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.*;

@RestController
@RequestMapping("/booking")
public class BookingController {

    private final BookingsRepository bookingsRepository;
    private final BookingsService bookingsService;
    private final BookingsRestOps bookingsRestOps;
    private final CarRepository carRepository;
    private final IncomeUserRepository userRepository;

    public BookingController(BookingsRepository bookingsRepository, BookingsService bookingsService,
                            BookingsRestOps bookingsRestOps, CarRepository carRepository,
                            IncomeUserRepository userRepository) {
        this.bookingsRepository = bookingsRepository;
        this.bookingsService = bookingsService;
        this.bookingsRestOps = bookingsRestOps;
        this.carRepository = carRepository;
        this.userRepository = userRepository;
    }

    @PostMapping
    public ResponseEntity<?> createBooking(@Valid @RequestBody BookingRequest bookingRequest) {
        // Check if car exists and is available
        Optional<Car> carOptional = carRepository.findById(bookingRequest.getCarId());
        if (carOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new MessageResponse("Car not found"));
        }

        Car car = carOptional.get();
        if (car.getStatus() != CarStatus.AVAILABLE) {
            return ResponseEntity.badRequest().body(new MessageResponse("Car is not available for booking"));
        }

        // Get current user
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = authentication.getName();
        Optional<IncomeUser> userOptional = userRepository.findByUserName(currentUsername);
        if (userOptional.isEmpty()) {
            return ResponseEntity.badRequest().body(new MessageResponse("User not found"));
        }

        IncomeUser user = userOptional.get();

        // Calculate booking duration and amount
        Date pickupDate = bookingRequest.getPickupDate();
        Date returnDate = bookingRequest.getReturnDate();

        if (pickupDate.after(returnDate)) {
            return ResponseEntity.badRequest().body(new MessageResponse("Pickup date cannot be after return date"));
        }

        LocalDateTime pickupDateTime = pickupDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        LocalDateTime returnDateTime = returnDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();

        long days = ChronoUnit.DAYS.between(pickupDateTime, returnDateTime);
        if (days < 1) days = 1; // Minimum 1 day rental

        BigDecimal totalAmount = car.getDailyRate().multiply(BigDecimal.valueOf(days));

        // Create booking
        Bookings booking = new Bookings();
        booking.setBookingNumber(generateBookingNumber());
        booking.setCustomerId(user.getId());
        booking.setCarId(car.getId());
        booking.setPickupDate(pickupDate);
        booking.setReturnDate(returnDate);
        booking.setStatus(BookingStatus.PENDING);
        booking.setTotalAmount(totalAmount);
        booking.setPickupLocation(bookingRequest.getPickupLocation());
        booking.setReturnLocation(bookingRequest.getReturnLocation());
        booking.setNotes(bookingRequest.getNotes());
        booking.setName("Booking for " + car.getName());

        // Update car status
        car.setStatus(CarStatus.BOOKED);
        carRepository.save(car);

        // Save booking
        Bookings savedBooking = bookingsRepository.save(booking);

        return ResponseEntity.ok(bookingsRestOps.toGetResponse(null, savedBooking, false));
    }

    @GetMapping
    public List<BookingsRest> getAllBookings() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = authentication.getName();
        Optional<IncomeUser> userOptional = userRepository.findByUserName(currentUsername);

        if (userOptional.isEmpty()) {
            return Collections.emptyList();
        }

        IncomeUser user = userOptional.get();
        List<Bookings> bookings;

        // Admin and staff can see all bookings
        switch (user.getUserType()) {
            case ADMIN, STAFF -> bookings = bookingsRepository.findAll();
            case CUSTOMER -> bookings = bookingsRepository.findByCustomerId(user.getId());
            default -> bookings = Collections.emptyList();
        }

        List<BookingsRest> result = new ArrayList<>();
        for (Bookings booking : bookings) {
            BookingsRest bookingRest = bookingsRestOps.toGetResponse(null, booking, true);

            // Add car and customer names
            Optional<Car> carOptional = carRepository.findById(booking.getCarId());
            carOptional.ifPresent(car -> bookingRest.setCarName(car.getName()));

            Optional<IncomeUser> customerOptional = userRepository.findById(booking.getCustomerId());
            customerOptional.ifPresent(customer -> bookingRest.setCustomerName(customer.getName()));

            result.add(bookingRest);
        }

        return result;
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getBooking(@PathVariable Long id) {
        Optional<Bookings> bookingOptional = bookingsRepository.findById(id);
        if (bookingOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Bookings booking = bookingOptional.get();
        BookingsRest bookingRest = bookingsRestOps.toGetResponse(null, booking, false);

        // Add car and customer names
        Optional<Car> carOptional = carRepository.findById(booking.getCarId());
        carOptional.ifPresent(car -> bookingRest.setCarName(car.getName()));

        Optional<IncomeUser> customerOptional = userRepository.findById(booking.getCustomerId());
        customerOptional.ifPresent(customer -> bookingRest.setCustomerName(customer.getName()));

        return ResponseEntity.ok(bookingRest);
    }

    @PutMapping("/{id}/status")
    @PreAuthorize("hasRole('ADMIN') or hasRole('STAFF')")
    public ResponseEntity<?> updateBookingStatus(@PathVariable Long id, @RequestBody BookingStatusRequest statusRequest) {
        Optional<Bookings> bookingOptional = bookingsRepository.findById(id);
        if (bookingOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Bookings booking = bookingOptional.get();
        BookingStatus newStatus = statusRequest.getStatus();

        // Handle car status changes based on booking status
        Optional<Car> carOptional = carRepository.findById(booking.getCarId());
        if (carOptional.isPresent()) {
            Car car = carOptional.get();

            switch (newStatus) {
                case CONFIRMED -> car.setStatus(CarStatus.BOOKED);
                case ACTIVE -> car.setStatus(CarStatus.BOOKED);
                case COMPLETED, CANCELLED -> car.setStatus(CarStatus.AVAILABLE);
                default -> {}
            }

            carRepository.save(car);
        }

        booking.setStatus(newStatus);
        bookingsRepository.save(booking);

        return ResponseEntity.ok(bookingsRestOps.toGetResponse(null, booking, false));
    }

    @PutMapping("/{id}/payment")
    @PreAuthorize("hasRole('ADMIN') or hasRole('STAFF')")
    public ResponseEntity<?> recordPayment(@PathVariable Long id, @RequestBody PaymentRequest paymentRequest) {
        Optional<Bookings> bookingOptional = bookingsRepository.findById(id);
        if (bookingOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Bookings booking = bookingOptional.get();
        booking.setPaidAmount(paymentRequest.getAmount());
        booking.setPaymentDate(new Date());

        // If fully paid, update status to confirmed
        if (booking.getPaidAmount().compareTo(booking.getTotalAmount()) >= 0 &&
            booking.getStatus() == BookingStatus.PENDING) {
            booking.setStatus(BookingStatus.CONFIRMED);

            // Update car status
            Optional<Car> carOptional = carRepository.findById(booking.getCarId());
            if (carOptional.isPresent()) {
                Car car = carOptional.get();
                car.setStatus(CarStatus.BOOKED);
                carRepository.save(car);
            }
        }

        bookingsRepository.save(booking);

        return ResponseEntity.ok(bookingsRestOps.toGetResponse(null, booking, false));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> deleteBooking(@PathVariable Long id) {
        Optional<Bookings> bookingOptional = bookingsRepository.findById(id);
        if (bookingOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Bookings booking = bookingOptional.get();

        // Release the car if it was booked
        Optional<Car> carOptional = carRepository.findById(booking.getCarId());
        if (carOptional.isPresent()) {
            Car car = carOptional.get();
            if (car.getStatus() == CarStatus.BOOKED) {
                car.setStatus(CarStatus.AVAILABLE);
                carRepository.save(car);
            }
        }

        bookingsRepository.delete(booking);

        return ResponseEntity.ok(new MessageResponse("Booking deleted successfully"));
    }

    private String generateBookingNumber() {
        return "BK" + System.currentTimeMillis() + "-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}
