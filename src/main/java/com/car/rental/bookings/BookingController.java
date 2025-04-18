package com.car.rental.bookings;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BookingController {

    BookingsRepository bookingsRepository;

    public BookingController(BookingsRepository bookingsRepository) {
        this.bookingsRepository = bookingsRepository;
    }

    @PostMapping("/booking")
    public Bookings create(@RequestBody Bookings bookings) {
        Bookings bookings1 = bookingsRepository.save(bookings);
        return bookings1;
    }
}
