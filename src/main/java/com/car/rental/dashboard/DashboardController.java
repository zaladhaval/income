package com.car.rental.dashboard;

import com.car.rental.bookings.Bookings;
import com.car.rental.bookings.BookingsRepository;
import com.car.rental.car.Car;
import com.car.rental.car.CarRepository;
import com.car.rental.customer.IncomeUser;
import com.car.rental.customer.IncomeUserRepository;
import com.car.rental.enums.BookingStatus;
import com.car.rental.enums.CarStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/dashboard")
@PreAuthorize("hasRole('ADMIN') or hasRole('STAFF')")
public class DashboardController {

    private final BookingsRepository bookingsRepository;
    private final CarRepository carRepository;
    private final IncomeUserRepository userRepository;

    public DashboardController(BookingsRepository bookingsRepository, CarRepository carRepository,
                              IncomeUserRepository userRepository) {
        this.bookingsRepository = bookingsRepository;
        this.carRepository = carRepository;
        this.userRepository = userRepository;
    }

    @GetMapping("/stats")
    public ResponseEntity<DashboardStats> getDashboardStats() {
        DashboardStats stats = new DashboardStats();
        
        // Count total cars
        stats.setTotalCars(carRepository.count());
        
        // Count available cars
        stats.setAvailableCars(carRepository.findByStatus(CarStatus.AVAILABLE).size());
        
        // Count total customers
        stats.setTotalCustomers(userRepository.count());
        
        // Count total bookings
        stats.setTotalBookings(bookingsRepository.count());
        
        // Count active bookings
        stats.setActiveBookings(bookingsRepository.findByStatus(BookingStatus.ACTIVE).size());
        
        // Calculate total revenue
        List<Bookings> completedBookings = bookingsRepository.findByStatus(BookingStatus.COMPLETED);
        BigDecimal totalRevenue = completedBookings.stream()
                .map(Bookings::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        stats.setTotalRevenue(totalRevenue);
        
        // Calculate monthly revenue
        Map<String, BigDecimal> monthlyRevenue = new HashMap<>();
        LocalDate now = LocalDate.now();
        
        for (int i = 0; i < 6; i++) {
            LocalDate monthStart = now.minusMonths(i).withDayOfMonth(1);
            LocalDate monthEnd = monthStart.plusMonths(1);
            
            Date startDate = Date.from(monthStart.atStartOfDay(ZoneId.systemDefault()).toInstant());
            Date endDate = Date.from(monthEnd.atStartOfDay(ZoneId.systemDefault()).toInstant());
            
            List<Bookings> monthBookings = bookingsRepository.findByReturnDateBetween(startDate, endDate)
                    .stream()
                    .filter(b -> b.getStatus() == BookingStatus.COMPLETED)
                    .collect(Collectors.toList());
            
            BigDecimal revenue = monthBookings.stream()
                    .map(Bookings::getTotalAmount)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            monthlyRevenue.put(monthStart.getMonth().toString(), revenue);
        }
        stats.setMonthlyRevenue(monthlyRevenue);
        
        // Get popular car models
        Map<String, Long> carModelCount = new HashMap<>();
        List<Bookings> allBookings = bookingsRepository.findAll();
        
        for (Bookings booking : allBookings) {
            Optional<Car> carOptional = carRepository.findById(booking.getCarId());
            if (carOptional.isPresent()) {
                Car car = carOptional.get();
                String model = car.getBrand() + " " + car.getModel();
                carModelCount.put(model, carModelCount.getOrDefault(model, 0L) + 1);
            }
        }
        
        // Sort by count and get top 5
        Map<String, Long> topCarModels = carModelCount.entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .limit(5)
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (e1, e2) -> e1,
                        LinkedHashMap::new
                ));
        
        stats.setPopularCarModels(topCarModels);
        
        return ResponseEntity.ok(stats);
    }
    
    @GetMapping("/recent-bookings")
    public ResponseEntity<List<RecentBookingDTO>> getRecentBookings() {
        // Get 10 most recent bookings
        List<Bookings> recentBookings = bookingsRepository.findAll();
        recentBookings.sort(Comparator.comparing(Bookings::getCreatedTime).reversed());
        
        List<RecentBookingDTO> recentBookingDTOs = new ArrayList<>();
        int count = 0;
        
        for (Bookings booking : recentBookings) {
            if (count >= 10) break;
            
            RecentBookingDTO dto = new RecentBookingDTO();
            dto.setId(booking.getId());
            dto.setBookingNumber(booking.getBookingNumber());
            dto.setStatus(booking.getStatus());
            dto.setTotalAmount(booking.getTotalAmount());
            dto.setPickupDate(booking.getPickupDate());
            dto.setReturnDate(booking.getReturnDate());
            
            // Get car details
            Optional<Car> carOptional = carRepository.findById(booking.getCarId());
            carOptional.ifPresent(car -> dto.setCarName(car.getBrand() + " " + car.getModel()));
            
            // Get customer details
            Optional<IncomeUser> userOptional = userRepository.findById(booking.getCustomerId());
            userOptional.ifPresent(user -> dto.setCustomerName(user.getName()));
            
            recentBookingDTOs.add(dto);
            count++;
        }
        
        return ResponseEntity.ok(recentBookingDTOs);
    }
}
