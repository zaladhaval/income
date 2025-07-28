package com.rental.service;

import com.rental.entity.Car;
import com.rental.enums.FuelType;
import com.rental.enums.GearType;
import com.rental.repository.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Service class for Car entity operations
 */
@Service
@Transactional
public class CarService {

    @Autowired
    private CarRepository carRepository;

    /**
     * Create a new car
     */
    public Car createCar(Car car) {
        if (carRepository.existsByListingId(car.getListingId())) {
            throw new RuntimeException("Listing ID already exists");
        }
        
        car.setIsAvailable(true);
        return carRepository.save(car);
    }

    /**
     * Update an existing car
     */
    public Car updateCar(Car car) {
        Car existingCar = getCarById(car.getId());
        
        // Check if listing ID is being changed and if it already exists
        if (!existingCar.getListingId().equals(car.getListingId()) && 
            carRepository.existsByListingId(car.getListingId())) {
            throw new RuntimeException("Listing ID already exists");
        }
        
        existingCar.setName(car.getName());
        existingCar.setCompany(car.getCompany());
        existingCar.setColor(car.getColor());
        existingCar.setDateOfPurchase(car.getDateOfPurchase());
        existingCar.setFuelType(car.getFuelType());
        existingCar.setGearType(car.getGearType());
        existingCar.setListingId(car.getListingId());
        existingCar.setDescription(car.getDescription());
        existingCar.setIsAvailable(car.getIsAvailable());
        
        return carRepository.save(existingCar);
    }

    /**
     * Get car by ID
     */
    @Transactional(readOnly = true)
    public Car getCarById(long id) {
        return carRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Car not found with id: " + id));
    }

    /**
     * Get car by listing ID
     */
    @Transactional(readOnly = true)
    public Optional<Car> getCarByListingId(String listingId) {
        return carRepository.findByListingId(listingId);
    }

    /**
     * Get all cars
     */
    @Transactional(readOnly = true)
    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    /**
     * Get all cars with pagination
     */
    @Transactional(readOnly = true)
    public Page<Car> getAllCarsWithPagination(Pageable pageable) {
        return carRepository.findAll(pageable);
    }

    /**
     * Get available cars
     */
    @Transactional(readOnly = true)
    public List<Car> getAvailableCars() {
        return carRepository.findByIsAvailableTrue();
    }

    /**
     * Search cars with filters
     */
    @Transactional(readOnly = true)
    public Page<Car> searchCarsWithFilters(String search, FuelType fuelType, 
                                           GearType gearType, Boolean available, 
                                           Pageable pageable) {
        return carRepository.findCarsWithFilters(search, fuelType, gearType, available, pageable);
    }

    /**
     * Search cars by text
     */
    @Transactional(readOnly = true)
    public Page<Car> searchCars(String search, Pageable pageable) {
        if (search == null || search.trim().isEmpty()) {
            return getAllCarsWithPagination(pageable);
        }
        return carRepository.findCarsWithSearch(search.trim(), pageable);
    }

    /**
     * Get cars by fuel type
     */
    @Transactional(readOnly = true)
    public List<Car> getCarsByFuelType(FuelType fuelType) {
        return carRepository.findByFuelType(fuelType);
    }

    /**
     * Get cars by gear type
     */
    @Transactional(readOnly = true)
    public List<Car> getCarsByGearType(GearType gearType) {
        return carRepository.findByGearType(gearType);
    }

    /**
     * Delete car (soft delete by setting availability to false)
     */
    public void deleteCar(long id) {
        Car car = getCarById(id);
        car.setIsAvailable(false);
        carRepository.save(car);
    }

    /**
     * Hard delete car
     */
    public void hardDeleteCar(long id) {
        if (!carRepository.existsById(id)) {
            throw new RuntimeException("Car not found with id: " + id);
        }
        carRepository.deleteById(id);
    }

    /**
     * Set car availability
     */
    public void setCarAvailability(long id, boolean available) {
        Car car = getCarById(id);
        car.setIsAvailable(available);
        carRepository.save(car);
    }

    /**
     * Count total cars
     */
    @Transactional(readOnly = true)
    public long countTotalCars() {
        return carRepository.count();
    }

    /**
     * Count available cars
     */
    @Transactional(readOnly = true)
    public long countAvailableCars() {
        return carRepository.countByIsAvailableTrue();
    }

    /**
     * Count cars by fuel type
     */
    @Transactional(readOnly = true)
    public long countCarsByFuelType(FuelType fuelType) {
        return carRepository.countByFuelType(fuelType);
    }

    /**
     * Check if listing ID exists
     */
    @Transactional(readOnly = true)
    public boolean listingIdExists(String listingId) {
        return carRepository.existsByListingId(listingId);
    }

    /**
     * Get cars by company
     */
    @Transactional(readOnly = true)
    public List<Car> getCarsByCompany(String company) {
        return carRepository.findByCompanyContainingIgnoreCase(company);
    }
}
