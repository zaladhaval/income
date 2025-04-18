package com.car.rental.security;

import com.car.rental.customer.IncomeUser;
import com.car.rental.customer.IncomeUserRepository;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component("userSecurity")
public class UserSecurity {
    
    private final IncomeUserRepository userRepository;
    
    public UserSecurity(IncomeUserRepository userRepository) {
        this.userRepository = userRepository;
    }
    
    public boolean isCurrentUser(Long userId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = authentication.getName();
        
        Optional<IncomeUser> userOptional = userRepository.findById(userId);
        if (userOptional.isEmpty()) {
            return false;
        }
        
        IncomeUser user = userOptional.get();
        return user.getUserName().equals(currentUsername);
    }
}
