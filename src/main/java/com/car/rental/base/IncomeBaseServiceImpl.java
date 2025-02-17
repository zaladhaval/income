package com.car.rental.base;

import com.car.rental.callcontext.CallContext;
import org.apache.commons.lang3.StringUtils;

public abstract class IncomeBaseServiceImpl<T extends IncomeBase, R extends IncomeBaseRest>
        implements IncomeBaseService<T, R> {

    protected IncomeBaseRepository<T> repository;
    protected Class<T> domainClass;

    public IncomeBaseServiceImpl(IncomeBaseRepository<T> repository, Class<T> domainClass) {
        this.repository = repository;
        this.domainClass = domainClass;
    }

    protected T convertToDomain(CallContext callContext, R createRequest) {
        T domainModel = getDomainModel();
        if (StringUtils.isNotBlank(createRequest.getName())) {
            domainModel.setName(createRequest.getName().trim());
        }

        return domainModel;
    }

    protected abstract T getDomainModel();

    @Override
    public T create(CallContext callContext, R createRequest) {

        T concreteModel = convertToDomain(callContext, createRequest);

        long currentTime = System.currentTimeMillis();
        concreteModel.setCreatedTime(currentTime);
        concreteModel.setUpdatedTime(currentTime);

       /* IncomeUser currentUser = callContext.getUser();
        if (currentUser != null) {
            if (concreteModel.getCreatedById() == 0) {
                concreteModel.setCreatedById(currentUser.getId());
            }
        }*/
        concreteModel.setUpdatedById(concreteModel.getCreatedById());

        return repository.save(concreteModel);
    }
}
