package com.car.rental.base;

import com.fasterxml.jackson.annotation.JsonView;

import java.io.Serial;
import java.io.Serializable;

public class IncomeBaseRest implements Serializable {

    @Serial
    private static final long serialVersionUID = -1352726589923722591L;

    @JsonView({ FJV.UReq.class, FJV.GRes.class, FJV.Public.class })
    private long id;

    @JsonView({ FJV.CReq.class, FJV.UReq.class, FJV.GRes.class, FJV.Public.class })
    private String name;

    @JsonView({ FJV.GRes.class })
    private long createdById;

    @JsonView({ FJV.GRes.class })
    private long createdTime;

    @JsonView({ FJV.GRes.class })
    private long updatedById;

    @JsonView({ FJV.GRes.class })
    private long updatedTime;

    public void setId(long id) {
        this.id = id;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getCreatedById() {
        return createdById;
    }

    public void setCreatedById(long createdById) {
        this.createdById = createdById;
    }

    public long getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(long createdTime) {
        this.createdTime = createdTime;
    }

    public long getUpdatedById() {
        return updatedById;
    }

    public void setUpdatedById(long updatedById) {
        this.updatedById = updatedById;
    }

    public long getUpdatedTime() {
        return updatedTime;
    }

    public void setUpdatedTime(long updatedTime) {
        this.updatedTime = updatedTime;
    }
}
