package com.rental.repository;

import com.rental.entity.Booking;
import com.rental.entity.Car;
import com.rental.entity.User;
import com.rental.enums.BookingStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * Repository interface for Booking entity
 */
@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    /**
     * Find bookings by customer
     */
    List<Booking> findByCustomer(User customer);

    /**
     * Find bookings by car
     */
    List<Booking> findByCar(Car car);

    /**
     * Find bookings by status
     */
    List<Booking> findByBookingStatus(BookingStatus status);

    /**
     * Find bookings by date range
     */
    @Query("SELECT b FROM Booking b WHERE b.startDate >= :startDate AND b.endDate <= :endDate")
    List<Booking> findByDateRange(@Param("startDate") long startDate, @Param("endDate") long endDate);

    /**
     * Find overlapping bookings for a car
     */
    @Query("SELECT b FROM Booking b WHERE b.car = :car AND "
            + "((b.startDate <= :endDate AND b.endDate >= :startDate)) AND "
            + "b.bookingStatus NOT IN ('CANCELLED', 'COMPLETED')")
    List<Booking> findOverlappingBookings(@Param("car") Car car, @Param("startDate") long startDate,
            @Param("endDate") long endDate);
  
    /**
     * Find bookings with search functionality
     */
    @Query("SELECT b FROM Booking b JOIN b.car c JOIN b.customer u WHERE "
            + "(c.name LIKE %:search% OR "
            + "u.name LIKE %:search% OR "
            + "CAST(b.bookingId AS string) LIKE %:search%)")
    Page<Booking> findBookingsWithSearch(@Param("search") String search, Pageable pageable);

    /**
     * Find bookings by customer with pagination
     */
    Page<Booking> findByCustomer(User customer, Pageable pageable);

    /**
     * Calculate total earnings (all time)
     */
    @Query("SELECT COALESCE(SUM(b.earningAmount), 0) FROM Booking b")
    BigDecimal calculateTotalEarnings();

    /**
     * Calculate monthly earnings
     */
    @Query("SELECT COALESCE(SUM(b.earningAmount), 0) FROM Booking b WHERE " +
           "b.startDate >= :startOfMonth AND b.startDate < :startOfNextMonth")
    BigDecimal calculateMonthlyEarnings(@Param("startOfMonth") long startOfMonth,
                                       @Param("startOfNextMonth") long startOfNextMonth);

    /**
     * Get earnings by car
     */
    @Query("SELECT c.name, COALESCE(SUM(b.earningAmount), 0) FROM Booking b "
            + "JOIN b.car c GROUP BY c.id, c.name ORDER BY SUM(b.earningAmount) DESC")
    List<Object[]> getEarningsByCar();

    /**
     * Get monthly car performance
     */
    @Query("SELECT c.name, COALESCE(SUM(b.earningAmount), 0) FROM Booking b " +
           "JOIN b.car c WHERE b.startDate >= :startOfMonth AND b.startDate < :startOfNextMonth " +
           "GROUP BY c.id, c.name ORDER BY SUM(b.earningAmount) DESC")
    List<Object[]> getMonthlyCarPerformance(@Param("startOfMonth") long startOfMonth,
                                           @Param("startOfNextMonth") long startOfNextMonth);

    /**
     * Find recent bookings
     */
    @Query("SELECT b FROM Booking b ORDER BY b.createdDate DESC")
    List<Booking> findRecentBookings(Pageable pageable);

    /**
     * Count bookings by status
     */
    long countByBookingStatus(BookingStatus status);

    /**
     * Find bookings by date range with pagination
     */
    @Query("SELECT b FROM Booking b WHERE " + "(:startDate IS NULL OR b.startDate >= :startDate) AND "
            + "(:endDate IS NULL OR b.endDate <= :endDate)")
    Page<Booking> findByDateRangeWithPagination(@Param("startDate") Long startDate,
            @Param("endDate") Long endDate, Pageable pageable);
}
