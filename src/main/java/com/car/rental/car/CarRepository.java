package com.car.rental.car;

import com.car.rental.base.IncomeBaseRepository;
import com.car.rental.enums.CarStatus;

import java.math.BigDecimal;
import java.util.List;

public interface CarRepository extends IncomeBaseRepository<Car> {
    List<Car> findByStatus(CarStatus status);
    List<Car> findByBrandContainingIgnoreCase(String brand);
    List<Car> findByModelContainingIgnoreCase(String model);
    List<Car> findByColorContainingIgnoreCase(String color);
    List<Car> findByDailyRateBetween(BigDecimal min, BigDecimal max);
    List<Car> findByBrandAndModel(String brand, String model);
}
