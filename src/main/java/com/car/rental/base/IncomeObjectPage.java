package com.car.rental.base;


import java.util.List;

public class IncomeObjectPage<T> {

    private List<T> objectList;
    private long totalCount;

    public IncomeObjectPage() {

    }

    public IncomeObjectPage(List<T> objectList, long totalCount) {
        this.objectList = objectList;
        this.totalCount = totalCount;
    }

    public List<T> getObjectList() {
        return objectList;
    }

    public void setObjectList(List<T> objectList) {
        this.objectList = objectList;
    }

    public long getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }
}

