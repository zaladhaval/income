package com.car.rental.customer;

import com.car.rental.base.IncomeBaseRepository;

import java.util.Optional;

public interface IncomeUserRepository extends IncomeBaseRepository<IncomeUser> {
    Optional<IncomeUser> findByUserName(String userName);
    Optional<IncomeUser> findByEmail(String email);
    boolean existsByUserName(String userName);
    boolean existsByEmail(String email);
}
