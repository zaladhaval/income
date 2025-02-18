package com.car.rental.car;

import com.car.rental.base.IncomeBaseRest;
import com.car.rental.enums.FuleType;
import com.car.rental.enums.GearType;

import java.io.Serial;

public class CarRest extends IncomeBaseRest {

    @Serial
    private static final long serialVersionUID = -1352126589903722591L;

    private long statusId;

    private String description;

    private long purchaseDate;

    private String carNumber;

    private long brandId;

    private String model;

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
