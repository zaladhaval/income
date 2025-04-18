package com.car.rental.bookings;

import com.car.rental.base.IncomeBaseServiceImpl;
import com.car.rental.callcontext.CallContext;
import org.springframework.stereotype.Service;

@Service
public class BookingsServiceImpl extends IncomeBaseServiceImpl<Bookings, BookingsRest>
        implements BookingsService {

    public BookingsServiceImpl(BookingsRepository repository) {
        super(repository, Bookings.class);
    }

    @Override
    protected Bookings convertToDomain(CallContext callContext, BookingsRest createRequest) {
        Bookings domain = super.convertToDomain(callContext, createRequest);
        domain.setBookingNumber(createRequest.getBookingNumber());
        domain.setCustomerId(createRequest.getCustomerId());
        domain.setCarId(createRequest.getCarId());
        domain.setPickupDate(createRequest.getPickupDate());
        domain.setReturnDate(createRequest.getReturnDate());
        domain.setStatus(createRequest.getStatus());
        domain.setTotalAmount(createRequest.getTotalAmount());
        domain.setPaidAmount(createRequest.getPaidAmount());
        domain.setPaymentDate(createRequest.getPaymentDate());
        domain.setPickupLocation(createRequest.getPickupLocation());
        domain.setReturnLocation(createRequest.getReturnLocation());
        domain.setNotes(createRequest.getNotes());
        return domain;
    }

    @Override
    protected Bookings getDomainModel() {
        return new Bookings();
    }
}
