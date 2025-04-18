package com.car.rental.customer;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class IncomeUserController {

    IncomeUserRepository incomeUserRepository;

    IncomeUserController(IncomeUserRepository incomeUserRepository) {
        this.incomeUserRepository = incomeUserRepository;
    }

    @PostMapping("/user")
    public void create(@RequestBody IncomeUser incomeUser) {
        incomeUserRepository.save(incomeUser);
    }
}
