package com.car.rental.asset;

import com.car.rental.base.IncomeController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CarController extends IncomeController {

    CarService carService;

    CarRestOps carRestOps;

    public CarController(CarService carService, CarRestOps carRestOps) {
        this.carService = carService;
        this.carRestOps = carRestOps;
    }

    @PostMapping("/car")
    private CarRest create(@RequestBody CarRest car) {
        Car request = carService.create(null, car);

        return buildGetResponse(null, carRestOps, request);
    }
}
