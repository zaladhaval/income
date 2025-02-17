package com.car.rental.customer;

import com.car.rental.base.IncomeBase;
import com.car.rental.enums.UserType;
import jakarta.persistence.Entity;

import java.io.Serial;

@Entity
public class IncomeUser extends IncomeBase {

    @Serial
    private static final long serialVersionUID = -1352726589903722511L;

    private String contactNumber;

    private UserType userType;

    private String userName;

    private String password;

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String conatNumber) {
        this.contactNumber = conatNumber;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
