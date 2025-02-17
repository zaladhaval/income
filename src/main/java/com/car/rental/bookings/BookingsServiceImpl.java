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
        domain.setBookingId(createRequest.getBookingId());
        domain.setCustomerId(createRequest.getCustomerId());
        domain.setCarId(createRequest.getCarId());
        domain.setBookingStartDate(createRequest.getBookingStartDate());
        domain.setBookingEndDate(createRequest.getBookingEndDate());
        domain.setStatusId(createRequest.getStatusId());
        domain.setBookingAmount(createRequest.getBookingAmount());
        domain.setCreditedAmount(createRequest.getCreditedAmount());
        domain.setCreditedDate(createRequest.getCreditedDate());
        return domain;
    }

    @Override
    protected Bookings getDomainModel() {
        return new Bookings();
    }
}
