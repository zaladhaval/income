package com.car.rental.bookings;

import com.car.rental.base.IncomeBaseRestOps;
import com.car.rental.callcontext.CallContext;
import org.springframework.stereotype.Component;

@Component
public class BookingsRestOps extends IncomeBaseRestOps<Bookings, BookingsRest> {

    @Override
    public BookingsRest toGetResponse(CallContext callContext, Bookings domainModel, boolean listCall) {
        BookingsRest rest = super.toGetResponse(callContext, domainModel, listCall);
        rest.setBookingId(domainModel.getBookingId());
        rest.setCustomerId(domainModel.getCustomerId());
        rest.setCarId(domainModel.getCarId());
        rest.setBookingStartDate(domainModel.getBookingStartDate());
        rest.setBookingEndDate(domainModel.getBookingEndDate());
        rest.setStatusId(domainModel.getStatusId());
        rest.setBookingAmount(domainModel.getBookingAmount());
        rest.setCreditedAmount(domainModel.getCreditedAmount());
        rest.setCreditedDate(domainModel.getCreditedDate());
        return rest;
    }

    @Override
    protected BookingsRest getRestConcreteType() {
        return new BookingsRest();
    }
}
