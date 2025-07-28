package com.rental.service;

import com.rental.dto.CarEarningsDTO;
import com.rental.entity.Booking;
import com.rental.entity.Car;
import com.rental.entity.User;
import com.rental.enums.BookingStatus;
import com.rental.repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class for Booking entity operations
 */
@Service
@Transactional
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private CarService carService;

    @Autowired
    private UserService userService;

    /**
     * Create a new booking
     */
    public Booking createBooking(Booking booking) {
        // Date validation removed as per requirements

        // Check for overlapping bookings
        List<Booking> overlappingBookings =
                findOverlappingBookings(booking.getCar(), booking.getStartDate(), booking.getEndDate());

        if (!overlappingBookings.isEmpty()) {
            throw new RuntimeException("Car is not available for the selected dates");
        }

        booking.setBookingStatus(BookingStatus.PENDING);
        booking.calculateTotalEarning();

        return bookingRepository.save(booking);
    }

    /**
     * Update an existing booking
     */
    public void updateBooking(Booking booking) {
        Booking existingBooking = getBookingById(booking.getBookingId());

        // Date validation removed as per requirements

        // Check for overlapping bookings (excluding current booking)
        List<Booking> overlappingBookings = findOverlappingBookings(booking.getCar(), booking.getStartDate(),
                booking.getEndDate()).stream().filter(b -> b.getBookingId() != booking.getBookingId())
                .toList();

        if (!overlappingBookings.isEmpty()) {
            throw new RuntimeException("Car is not available for the selected dates");
        }

        existingBooking.setCar(booking.getCar());
        existingBooking.setCustomer(booking.getCustomer());
        existingBooking.setStartDate(booking.getStartDate());
        existingBooking.setEndDate(booking.getEndDate());
        existingBooking.setEarningAmount(booking.getEarningAmount());
        existingBooking.setBookingStatus(booking.getBookingStatus());
        existingBooking.setAmountCreditedDate(booking.getAmountCreditedDate());
        existingBooking.calculateTotalEarning();

        bookingRepository.save(existingBooking);
    }

    /**
     * Get booking by ID
     */
    @Transactional(readOnly = true)
    public Booking getBookingById(long id) {
        return bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));
    }

    /**
     * Get all bookings
     */
    @Transactional(readOnly = true)
    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    /**
     * Get all bookings with pagination
     */
    @Transactional(readOnly = true)
    public Page<Booking> getAllBookingsWithPagination(Pageable pageable) {
        return bookingRepository.findAll(pageable);
    }

    /**
     * Search bookings
     */
    @Transactional(readOnly = true)
    public Page<Booking> searchBookings(String search, Pageable pageable) {
        if (search == null || search.trim().isEmpty()) {
            return getAllBookingsWithPagination(pageable);
        }
        return bookingRepository.findBookingsWithSearch(search.trim(), pageable);
    }

    /**
     * Get bookings by customer
     */
    @Transactional(readOnly = true)
    public List<Booking> getBookingsByCustomer(User customer) {
        return bookingRepository.findByCustomer(customer);
    }

    /**
     * Get bookings by customer with pagination
     */
    @Transactional(readOnly = true)
    public Page<Booking> getBookingsByCustomerWithPagination(User customer, Pageable pageable) {
        return bookingRepository.findByCustomer(customer, pageable);
    }

    /**
     * Get bookings by car
     */
    @Transactional(readOnly = true)
    public List<Booking> getBookingsByCar(Car car) {
        return bookingRepository.findByCar(car);
    }

    /**
     * Get bookings by status
     */
    @Transactional(readOnly = true)
    public List<Booking> getBookingsByStatus(BookingStatus status) {
        return bookingRepository.findByBookingStatus(status);
    }

    /**
     * Get bookings by date range
     */
    @Transactional(readOnly = true)
    public List<Booking> getBookingsByDateRange(LocalDate startDate, LocalDate endDate) {
        long startTimestamp = startDate != null ?
                startDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli() :
                0;
        long endTimestamp = endDate != null ?
                endDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli() :
                Long.MAX_VALUE;
        return findBookingsByDateRange(startTimestamp, endTimestamp);
    }

    /**
     * Get bookings by date range (using timestamps)
     */
    @Transactional(readOnly = true)
    public List<Booking> findBookingsByDateRange(long startDate, long endDate) {
        return bookingRepository.findAll().stream()
                .filter(b -> b.getStartDate() >= startDate && b.getEndDate() <= endDate)
                .collect(Collectors.toList());
    }

    /**
     * Get bookings by date range with pagination
     */
    @Transactional(readOnly = true)
    public Page<Booking> getBookingsByDateRangeWithPagination(LocalDate startDate, LocalDate endDate,
            Pageable pageable) {
        // For now, return all bookings with pagination - can be optimized later
        return bookingRepository.findAll(pageable);
    }

    /**
     * Update booking status
     */
    public Booking updateBookingStatus(long bookingId, BookingStatus status) {
        Booking booking = getBookingById(bookingId);
        booking.setBookingStatus(status);

        // Set amount credited date when status is completed
        if (status == BookingStatus.COMPLETED && booking.getAmountCreditedDate() == 0) {
            booking.setAmountCreditedDate(System.currentTimeMillis());
        }

        return bookingRepository.save(booking);
    }

    /**
     * Delete booking
     */
    public void deleteBooking(long id) {
        if (!bookingRepository.existsById(id)) {
            throw new RuntimeException("Booking not found with id: " + id);
        }
        bookingRepository.deleteById(id);
    }

    /**
     * Calculate total earnings
     */
    @Transactional(readOnly = true)
    public BigDecimal calculateTotalEarnings() {
        return bookingRepository.calculateTotalEarnings();
    }

    /**
     * Calculate monthly earnings
     */
    @Transactional(readOnly = true)
    public BigDecimal calculateMonthlyEarnings(int year, int month) {
        // Convert year/month to timestamps
        LocalDate startOfMonth = LocalDate.of(year, month, 1);
        LocalDate startOfNextMonth = startOfMonth.plusMonths(1);

        long startTimestamp = startOfMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        long endTimestamp = startOfNextMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();

        return bookingRepository.calculateMonthlyEarnings(startTimestamp, endTimestamp);
    }

    /**
     * Get earnings by car
     */
    @Transactional(readOnly = true)
    public List<CarEarningsDTO> getEarningsByCar() {
        List<Object[]> results = bookingRepository.getEarningsByCar();
        return results.stream().map(result -> new CarEarningsDTO((String) result[0], (BigDecimal) result[1]))
                .collect(Collectors.toList());
    }

    /**
     * Get monthly car performance
     */
    @Transactional(readOnly = true)
    public List<CarEarningsDTO> getMonthlyCarPerformance(int year, int month) {
        // Convert year/month to timestamps
        LocalDate startOfMonth = LocalDate.of(year, month, 1);
        LocalDate startOfNextMonth = startOfMonth.plusMonths(1);

        long startTimestamp = startOfMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        long endTimestamp = startOfNextMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();

        List<Object[]> results = bookingRepository.getMonthlyCarPerformance(startTimestamp, endTimestamp);
        return results.stream().map(result -> new CarEarningsDTO((String) result[0], (BigDecimal) result[1]))
                .collect(Collectors.toList());
    }

    /**
     * Get recent bookings
     */
    @Transactional(readOnly = true)
    public List<Booking> getRecentBookings(int limit) {
        return bookingRepository.findRecentBookings(PageRequest.of(0, limit));
    }

    /**
     * Count bookings by status
     */
    @Transactional(readOnly = true)
    public long countBookingsByStatus(BookingStatus status) {
        return bookingRepository.countByBookingStatus(status);
    }

    /**
     * Count total bookings
     */
    @Transactional(readOnly = true)
    public long countTotalBookings() {
        return bookingRepository.count();
    }

    /**
     * Check car availability for date range
     */
    @Transactional(readOnly = true)
    public boolean isCarAvailable(Car car, LocalDate startDate, LocalDate endDate) {
        long startTimestamp = startDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        long endTimestamp = endDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        List<Booking> overlappingBookings = findOverlappingBookings(car, startTimestamp, endTimestamp);
        return overlappingBookings.isEmpty();
    }

    /**
     * Find overlapping bookings for a car (using timestamps)
     */
    @Transactional(readOnly = true)
    public List<Booking> findOverlappingBookings(Car car, long startDate, long endDate) {
        return bookingRepository.findByCar(car).stream()
                .filter(b -> b.getBookingStatus() != BookingStatus.CANCELLED
                        && b.getBookingStatus() != BookingStatus.COMPLETED)
                .filter(b -> !(b.getEndDate() <= startDate || b.getStartDate() >= endDate))
                .collect(Collectors.toList());
    }
}
