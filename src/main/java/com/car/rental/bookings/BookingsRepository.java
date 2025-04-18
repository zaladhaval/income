package com.car.rental.bookings;

import com.car.rental.base.IncomeBaseRepository;
import com.car.rental.enums.BookingStatus;

import java.util.Date;
import java.util.List;

public interface BookingsRepository extends IncomeBaseRepository<Bookings> {
    List<Bookings> findByCustomerId(long customerId);
    List<Bookings> findByCarId(long carId);
    List<Bookings> findByStatus(BookingStatus status);
    List<Bookings> findByPickupDateBetween(Date start, Date end);
    List<Bookings> findByReturnDateBetween(Date start, Date end);
    List<Bookings> findByBookingNumber(String bookingNumber);
}
