package com.rental.entity;

import com.rental.enums.FuelType;
import com.rental.enums.GearType;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Entity representing a car in the rental system
 */
@Entity
@Table(name = "cars")
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotBlank(message = "Car name is required")
    @Size(max = 100, message = "Car name must not exceed 100 characters")
    @Column(nullable = false, length = 100)
    private String name;

    @NotBlank(message = "Company is required")
    @Size(max = 50, message = "Company name must not exceed 50 characters")
    @Column(nullable = false, length = 50)
    private String company;

    @NotBlank(message = "Color is required")
    @Size(max = 30, message = "Color must not exceed 30 characters")
    @Column(nullable = false, length = 30)
    private String color;

    @NotNull(message = "Date of purchase is required")
    @Column(name = "date_of_purchase", nullable = false)
    private long dateOfPurchase;

    @Enumerated(EnumType.STRING)
    @Column(name = "fuel_type", nullable = false)
    private FuelType fuelType;

    @Enumerated(EnumType.STRING)
    @Column(name = "gear_type", nullable = false)
    private GearType gearType;

    @NotBlank(message = "Listing ID is required")
    @Column(name = "listing_id", nullable = false, unique = true)
    private String listingId;

    @Size(max = 500, message = "Description must not exceed 500 characters")
    @Column(length = 500)
    private String description;

    @Column(name = "is_available", nullable = false)
    private boolean isAvailable = true;

    @CreationTimestamp
    @Column(name = "created_date", nullable = false, updatable = false)
    private long createdDate;

    // Default constructor
    public Car() {}

    // Constructor with parameters
    public Car(String name, String company, String color, long dateOfPurchase,
               FuelType fuelType, GearType gearType, String listingId, String description) {
        this.name = name;
        this.company = company;
        this.color = color;
        this.dateOfPurchase = dateOfPurchase;
        this.fuelType = fuelType;
        this.gearType = gearType;
        this.listingId = listingId;
        this.description = description;
        this.isAvailable = true;
    }

    // Getters and Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public long getDateOfPurchase() {
        return dateOfPurchase;
    }

    public void setDateOfPurchase(long dateOfPurchase) {
        this.dateOfPurchase = dateOfPurchase;
    }

    public FuelType getFuelType() {
        return fuelType;
    }

    public void setFuelType(FuelType fuelType) {
        this.fuelType = fuelType;
    }

    public GearType getGearType() {
        return gearType;
    }

    public void setGearType(GearType gearType) {
        this.gearType = gearType;
    }

    public String getListingId() {
        return listingId;
    }

    public void setListingId(String listingId) {
        this.listingId = listingId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean getIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public long getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(long createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "Car{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", company='" + company + '\'' +
                ", listingId='" + listingId + '\'' +
                ", isAvailable=" + isAvailable +
                '}';
    }
}
