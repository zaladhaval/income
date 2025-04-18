package com.car.rental.bookings;

import com.car.rental.base.IncomeBaseRestOps;
import com.car.rental.callcontext.CallContext;
import org.springframework.stereotype.Component;

@Component
public class BookingsRestOps extends IncomeBaseRestOps<Bookings, BookingsRest> {

    @Override
    public BookingsRest toGetResponse(CallContext callContext, Bookings domainModel, boolean listCall) {
        BookingsRest rest = super.toGetResponse(callContext, domainModel, listCall);
        rest.setBookingNumber(domainModel.getBookingNumber());
        rest.setCustomerId(domainModel.getCustomerId());
        rest.setCarId(domainModel.getCarId());
        rest.setPickupDate(domainModel.getPickupDate());
        rest.setReturnDate(domainModel.getReturnDate());
        rest.setStatus(domainModel.getStatus());
        rest.setTotalAmount(domainModel.getTotalAmount());
        rest.setPaidAmount(domainModel.getPaidAmount());
        rest.setPaymentDate(domainModel.getPaymentDate());
        rest.setPickupLocation(domainModel.getPickupLocation());
        rest.setReturnLocation(domainModel.getReturnLocation());
        rest.setNotes(domainModel.getNotes());
        return rest;
    }

    @Override
    protected BookingsRest getRestConcreteType() {
        return new BookingsRest();
    }
}
