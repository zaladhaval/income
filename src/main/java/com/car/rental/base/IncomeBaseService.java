package com.car.rental.base;

import com.car.rental.callcontext.CallContext;

public interface IncomeBaseService<T extends IncomeBase, R extends IncomeBaseRest> {
    T create(CallContext callContext, R createRequest);
}
