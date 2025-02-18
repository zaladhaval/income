package com.car.rental.car;

import com.car.rental.base.IncomeController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CarController extends IncomeController {

    CarService carService;

    CarRestOps carRestOps;

    CarRepository carRepository;

    public CarController(CarService carService, CarRestOps carRestOps, CarRepository carRepository) {
        this.carService = carService;
        this.carRestOps = carRestOps;
        this.carRepository = carRepository;
    }

    @PostMapping("/car")
    private CarRest create(@RequestBody CarRest car) {
        Car request = carService.create(null, car);

        return buildGetResponse(null, carRestOps, request);
    }

    @GetMapping("/car")
    private List<Car> get() {
        return carRepository.findAll();
    }
}
