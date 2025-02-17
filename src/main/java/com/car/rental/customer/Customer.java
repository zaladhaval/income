package com.car.rental.customer;

import com.car.rental.base.IncomeBase;
import jakarta.persistence.Entity;

import java.io.Serial;

@Entity
public class Customer extends IncomeBase {

    @Serial
    private static final long serialVersionUID = -1352726589903722511L;

    private String name;

    private String contactNumber;

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String conatNumber) {
        this.contactNumber = conatNumber;
    }
}
