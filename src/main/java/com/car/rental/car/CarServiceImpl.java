package com.car.rental.car;

import com.car.rental.base.IncomeBaseServiceImpl;
import com.car.rental.callcontext.CallContext;
import org.springframework.stereotype.Service;

@Service
public class CarServiceImpl extends IncomeBaseServiceImpl<Car, CarRest> implements CarService {

    public CarServiceImpl(CarRepository carRepository) {
        super(carRepository, Car.class);
    }

    @Override
    protected Car getDomainModel() {
        return new Car();
    }

    @Override
    protected Car convertToDomain(CallContext callContext, CarRest createRequest) {
        Car domain = super.convertToDomain(callContext, createRequest);
        domain.setStatus(createRequest.getStatus());
        domain.setDescription(createRequest.getDescription());
        domain.setPurchaseDate(createRequest.getPurchaseDate());
        domain.setCarNumber(createRequest.getCarNumber());
        domain.setBrand(createRequest.getBrand());
        domain.setModel(createRequest.getModel());
        domain.setColor(createRequest.getColor());
        domain.setEngineCC(createRequest.getEngineCC());
        domain.setFuelType(createRequest.getFuelType());
        domain.setGearType(createRequest.getGearType());
        domain.setDailyRate(createRequest.getDailyRate());
        domain.setImageUrl(createRequest.getImageUrl());
        return domain;
    }
}
