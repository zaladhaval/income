package com.car.rental.base;

import com.car.rental.callcontext.CallContext;
import org.apache.commons.collections4.CollectionUtils;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public abstract class IncomeBaseRestOps<T extends IncomeBase, R extends IncomeBaseRest> {

    public R toGetResponse(CallContext callContext, T domainModel, boolean listCall) {
        R restModel = getRestConcreteType();
        restModel.setId(domainModel.getId());
        restModel.setName(domainModel.getName());
        restModel.setCreatedTime(domainModel.getCreatedTime());
        restModel.setUpdatedTime(domainModel.getUpdatedTime());
        restModel.setCreatedById(domainModel.getCreatedById());
        restModel.setUpdatedById(domainModel.getUpdatedById());
        return restModel;
    }

    public List<R> toRestList(CallContext callContext, List<T> domainModelList) {
        List<R> restList = null;
        if (CollectionUtils.isNotEmpty(domainModelList)) {
            restList = domainModelList.stream().map(m -> toGetResponse(callContext, m, true))
                    .filter(Objects::nonNull).collect(Collectors.toList());
        }
        return restList;
    }

    public <PR extends IncomeObjectPageRest<R>> PR toPageRest(CallContext callContext,
            IncomeObjectPage<T> domainPage, PR restPage) {
        restPage.setTotalCount(domainPage.getTotalCount());
        restPage.setObjectList(toRestList(callContext, domainPage.getObjectList()));
        return restPage;
    }

    protected abstract R getRestConcreteType();
}
