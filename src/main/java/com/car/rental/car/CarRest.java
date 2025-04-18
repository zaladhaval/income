package com.car.rental.car;

import com.car.rental.base.IncomeBaseRest;
import com.car.rental.enums.CarStatus;
import com.car.rental.enums.FuleType;
import com.car.rental.enums.GearType;

import java.io.Serial;
import java.math.BigDecimal;

public class CarRest extends IncomeBaseRest {

    @Serial
    private static final long serialVersionUID = -1352126589903722591L;

    private CarStatus status;

    private String description;

    private long purchaseDate;

    private String carNumber;

    private String brand;

    private String model;

    private String color;

    private long engineCC;

    private FuleType fuelType;

    private GearType gearType;

    private BigDecimal dailyRate;

    private String imageUrl;


    public CarStatus getStatus() {
        return status;
    }

    public void setStatus(CarStatus status) {
        this.status = status;
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

    public void setPurchaseDate(long purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
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

    public BigDecimal getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(BigDecimal dailyRate) {
        this.dailyRate = dailyRate;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
