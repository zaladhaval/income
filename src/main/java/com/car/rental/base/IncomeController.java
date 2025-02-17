package com.car.rental.base;

import com.car.rental.callcontext.CallContext;

public abstract class IncomeController {

    protected <T extends IncomeBase, R extends IncomeBaseRest> R buildGetResponse(CallContext callContext,
            IncomeBaseRestOps<T, R> restOps, T domainObj) {
        if (domainObj == null) {
            throw new RuntimeException("OBJECT_NOT_EXIST");
        }
        return restOps.toGetResponse(callContext, domainObj, false);
    }
}
