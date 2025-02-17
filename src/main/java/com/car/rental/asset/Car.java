package com.car.rental.asset;

import com.car.rental.base.IncomeBase;
import com.car.rental.enums.FuleType;
import com.car.rental.enums.GearType;
import jakarta.persistence.Entity;

import java.io.Serial;

@Entity
public class Car extends IncomeBase {

    @Serial
    private static final long serialVersionUID = -1352726589903722591L;

    private long statusId;

    private String displayName;

    private String description;

    private long purchaseDate;

    private String carNumber;

    private long brandId;

    private String model;

    private long year;

    private String color;

    private long engineCC;

    private FuleType fuelType;

    private GearType gearType;


    public long getStatusId() {
        return statusId;
    }

    public void setStatusId(long statusId) {
        this.statusId = statusId;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(long acquisitionDate) {
        this.purchaseDate = acquisitionDate;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public long getBrandId() {
        return brandId;
    }

    public void setBrandId(long brandId) {
        this.brandId = brandId;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public long getYear() {
        return year;
    }

    public void setYear(long year) {
        this.year = year;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public long getEngineCC() {
        return engineCC;
    }

    public void setEngineCC(long engineCC) {
        this.engineCC = engineCC;
    }

    public FuleType getFuelType() {
        return fuelType;
    }

    public void setFuelType(FuleType fuelType) {
        this.fuelType = fuelType;
    }

    public GearType getGearType() {
        return gearType;
    }

    public void setGearType(GearType gearType) {
        this.gearType = gearType;
    }
}
