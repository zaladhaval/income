package com.rental.repository;

import com.rental.entity.Car;
import com.rental.enums.FuelType;
import com.rental.enums.GearType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository interface for Car entity
 */
@Repository
public interface CarRepository extends JpaRepository<Car, Long> {

    /**
     * Find car by listing ID
     */
    Optional<Car> findByListingId(String listingId);

    /**
     * Find available cars
     */
    List<Car> findByIsAvailableTrue();
 
    /**
     * Find cars by fuel type
     */
    List<Car> findByFuelType(FuelType fuelType);

    /**
     * Find cars by gear type
     */
    List<Car> findByGearType(GearType gearType);

    /**
     * Find cars with search functionality
     */
    @Query("SELECT c FROM Car c WHERE " + "(LOWER(c.name) LIKE LOWER(CONCAT('%', :search, '%')) OR "
            + "LOWER(c.company) LIKE LOWER(CONCAT('%', :search, '%')) OR "
            + "LOWER(c.listingId) LIKE LOWER(CONCAT('%', :search, '%')))")
    Page<Car> findCarsWithSearch(@Param("search") String search, Pageable pageable);

    /**
     * Find cars with filters
     */
    @Query("SELECT c FROM Car c WHERE "
            + "(:search IS NULL OR c.name LIKE %:search% OR c.company LIKE %:search%) AND "
            + "(:fuelType IS NULL OR c.fuelType = :fuelType) AND "
            + "(:gearType IS NULL OR c.gearType = :gearType) AND "
            + "(:available IS NULL OR c.isAvailable = :available)")
    Page<Car> findCarsWithFilters(@Param("search") String search, @Param("fuelType") FuelType fuelType,
            @Param("gearType") GearType gearType, @Param("available") Boolean available, Pageable pageable);

    /**
     * Check if listing ID exists
     */
    boolean existsByListingId(String listingId);

    /**
     * Find cars by company
     */
    List<Car> findByCompanyContainingIgnoreCase(String company);

    /**
     * Count available cars
     */
    long countByIsAvailableTrue();

    /**
     * Count cars by fuel type
     */
    long countByFuelType(FuelType fuelType);

    /**
     * Find cars by availability status with pagination
     */
    Page<Car> findByIsAvailable(Boolean isAvailable, Pageable pageable);
}
