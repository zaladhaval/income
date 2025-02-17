package com.car.rental.base;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import org.apache.commons.collections4.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class IncomeObjectPageRest<R> {

    @JsonView(value = { FJV.GRes.class, FJV.Public.class })
    private List<R> objectList;

    @JsonView(value = { FJV.GRes.class, FJV.Public.class })
    private long totalCount;

    public IncomeObjectPageRest() {

    }

    public IncomeObjectPageRest(List<R> objectList, long totalCount) {
        super();
        this.objectList = objectList;
        this.totalCount = totalCount;
    }

    public List<R> getObjectList() {
        return objectList;
    }

    public void setObjectList(List<R> objectList) {
        this.objectList = objectList;
    }

    public long getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }

    public void addObjectList(Set<R> objectList) {
        if (CollectionUtils.isNotEmpty(objectList)) {
            if (this.objectList == null) {
                this.objectList = new ArrayList<>();
            }
            this.objectList.addAll(objectList);
        }
    }
}

