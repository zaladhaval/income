package com.car.rental.car;

import com.car.rental.base.IncomeBaseRestOps;
import com.car.rental.callcontext.CallContext;
import org.springframework.stereotype.Component;

@Component
public class CarRestOps extends IncomeBaseRestOps<Car, CarRest> {

    @Override
    protected CarRest getRestConcreteType() {
        return new CarRest();
    }

    @Override
    public CarRest toGetResponse(CallContext callContext, Car domainModel, boolean listCall) {
        CarRest rest = super.toGetResponse(callContext, domainModel, listCall);
        rest.setStatusId(domainModel.getStatusId());
        rest.setDescription(domainModel.getDescription());
        rest.setPurchaseDate(domainModel.getPurchaseDate());
        rest.setCarNumber(domainModel.getCarNumber());
        rest.setBrandId(domainModel.getBrandId());
        rest.setModel(domainModel.getModel());
        rest.setColor(domainModel.getColor());
        rest.setEngineCC(domainModel.getEngineCC());
        rest.setFuelType(domainModel.getFuelType());
        rest.setGearType(domainModel.getGearType());
        return rest;
    }
}
