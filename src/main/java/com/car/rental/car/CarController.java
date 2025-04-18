package com.car.rental.car;

import com.car.rental.base.IncomeController;
import com.car.rental.enums.CarStatus;
import com.car.rental.security.MessageResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/car")
public class CarController extends IncomeController {

    private final CarService carService;
    private final CarRestOps carRestOps;
    private final CarRepository carRepository;

    public CarController(CarService carService, CarRestOps carRestOps, CarRepository carRepository) {
        this.carService = carService;
        this.carRestOps = carRestOps;
        this.carRepository = carRepository;
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN') or hasRole('STAFF')")
    public ResponseEntity<?> createCar(@Valid @RequestBody CarRest carRest) {
        try {
            Car car = carService.create(null, carRest);
            return ResponseEntity.ok(buildGetResponse(null, carRestOps, car));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(new MessageResponse("Error creating car: " + e.getMessage()));
        }
    }

    @GetMapping
    public ResponseEntity<List<CarRest>> getAllCars(@RequestParam(required = false) String brand,
            @RequestParam(required = false) String model, @RequestParam(required = false) String color,
            @RequestParam(required = false) CarStatus status,
            @RequestParam(required = false) BigDecimal minDailyRate,
            @RequestParam(required = false) BigDecimal maxDailyRate,
            @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "id,asc") String[] sort) {

        try {
            List<Sort.Order> orders = new ArrayList<>();

            if (sort[0].contains(",")) {
                // sort=[field,direction]
                for (String sortOrder : sort) {
                    String[] _sort = sortOrder.split(",");
                    orders.add(new Sort.Order(getSortDirection(_sort[1]), _sort[0]));
                }
            } else {
                // sort=[field,direction]
                orders.add(new Sort.Order(getSortDirection(sort[1]), sort[0]));
            }

            Pageable pageable = PageRequest.of(page, size, Sort.by(orders));

            Page<Car> carsPage;

            // Build specifications for filtering
            Specification<Car> spec = Specification.where(null);

            if (brand != null && !brand.isEmpty()) {
                spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("brand")),
                        "%" + brand.toLowerCase() + "%"));
            }

            if (model != null && !model.isEmpty()) {
                spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("model")),
                        "%" + model.toLowerCase() + "%"));
            }

            if (color != null && !color.isEmpty()) {
                spec = spec.and((root, query, cb) -> cb.like(cb.lower(root.get("color")),
                        "%" + color.toLowerCase() + "%"));
            }

            if (status != null) {
                spec = spec.and((root, query, cb) -> cb.equal(root.get("status"), status));
            }

            if (minDailyRate != null) {
                spec = spec.and(
                        (root, query, cb) -> cb.greaterThanOrEqualTo(root.get("dailyRate"), minDailyRate));
            }

            if (maxDailyRate != null) {
                spec = spec.and(
                        (root, query, cb) -> cb.lessThanOrEqualTo(root.get("dailyRate"), maxDailyRate));
            }

            carsPage = carRepository.findAll(spec, pageable);

            List<Car> cars = carsPage.getContent();
            List<CarRest> carRests = new ArrayList<>();

            for (Car car : cars) {
                carRests.add(carRestOps.toGetResponse(null, car, true));
            }

            return ResponseEntity.ok(carRests);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new ArrayList<>());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getCarById(@PathVariable Long id) {
        Optional<Car> carOptional = carRepository.findById(id);

        if (carOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Car car = carOptional.get();
        return ResponseEntity.ok(carRestOps.toGetResponse(null, car, false));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('STAFF')")
    public ResponseEntity<?> updateCar(@PathVariable Long id, @Valid @RequestBody CarRest carRest) {
        Optional<Car> carOptional = carRepository.findById(id);

        if (carOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Car car = carOptional.get();

        // Update car properties
        car.setName(carRest.getName());
        car.setBrand(carRest.getBrand());
        car.setModel(carRest.getModel());
        car.setColor(carRest.getColor());
        car.setDescription(carRest.getDescription());
        car.setCarNumber(carRest.getCarNumber());
        car.setEngineCC(carRest.getEngineCC());
        car.setFuelType(carRest.getFuelType());
        car.setGearType(carRest.getGearType());
        car.setDailyRate(carRest.getDailyRate());
        car.setImageUrl(carRest.getImageUrl());
        car.setStatus(carRest.getStatus());

        Car updatedCar = carRepository.save(car);
        return ResponseEntity.ok(carRestOps.toGetResponse(null, updatedCar, false));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> deleteCar(@PathVariable Long id) {
        Optional<Car> carOptional = carRepository.findById(id);

        if (carOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        carRepository.deleteById(id);
        return ResponseEntity.ok(new MessageResponse("Car deleted successfully"));
    }

    @GetMapping("/available")
    public ResponseEntity<List<CarRest>> getAvailableCars() {
        List<Car> availableCars = carRepository.findByStatus(CarStatus.AVAILABLE);
        List<CarRest> carRests = new ArrayList<>();

        for (Car car : availableCars) {
            carRests.add(carRestOps.toGetResponse(null, car, true));
        }

        return ResponseEntity.ok(carRests);
    }

    private Sort.Direction getSortDirection(String direction) {
        if (direction.equals("desc")) {
            return Sort.Direction.DESC;
        }
        return Sort.Direction.ASC;
    }
}
