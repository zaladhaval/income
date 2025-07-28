package com.rental.service;

import com.rental.entity.User;
import com.rental.enums.UserType;
import com.rental.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Service class for User entity operations and Spring Security integration
 */
@Service
@Transactional
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + email));

        if (!user.getIsActive()) {
            throw new UsernameNotFoundException("User account is inactive");
        }

        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_" + user.getUserType().name()));

        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .authorities(authorities)
                .accountExpired(false)
                .accountLocked(false)
                .credentialsExpired(false)
                .disabled(!user.getIsActive())
                .build();
    }

    /**
     * Create a new user
     */
    public User createUser(User user) {
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        
        // Encode password
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setIsActive(true);
        
        return userRepository.save(user);
    }

    /**
     * Update an existing user
     */
    public User updateUser(User user) {
        User existingUser = getUserById(user.getId());

        // Check if email is being changed and if it already exists
        if (!existingUser.getEmail().equals(user.getEmail()) &&
            userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already exists");
        }

        existingUser.setName(user.getName());
        existingUser.setContact(user.getContact());
        existingUser.setEmail(user.getEmail());
        existingUser.setUserType(user.getUserType());

        // Only update password if it's provided and different
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            existingUser.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        return userRepository.save(existingUser);
    }

    /**
     * Get user by ID
     */
    @Transactional(readOnly = true)
    public User getUserById(long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));
    }

    /**
     * Get user by email
     */
    @Transactional(readOnly = true)
    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    /**
     * Get all users
     */
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Get users by type
     */
    @Transactional(readOnly = true)
    public List<User> getUsersByType(UserType userType) {
        return userRepository.findByUserType(userType);
    }

    /**
     * Get active customers with pagination
     */
    @Transactional(readOnly = true)
    public Page<User> getCustomersWithPagination(Pageable pageable) {
        return userRepository.findByUserType(UserType.CUSTOMER, pageable);
    }

    /**
     * Search customers
     */
    @Transactional(readOnly = true)
    public Page<User> searchCustomers(String search, Pageable pageable) {
        if (search == null || search.trim().isEmpty()) {
            return getCustomersWithPagination(pageable);
        }
        return userRepository.findCustomersWithSearch(search.trim(), pageable);
    }

    /**
     * Deactivate user (soft delete)
     */
    public void deactivateUser(long id) {
        User user = getUserById(id);
        user.setIsActive(false);
        userRepository.save(user);
    }

    /**
     * Activate user
     */
    public void activateUser(long id) {
        User user = getUserById(id);
        user.setIsActive(true);
        userRepository.save(user);
    }

    /**
     * Count users by type
     */
    @Transactional(readOnly = true)
    public long countUsersByType(UserType userType) {
        return userRepository.countByUserType(userType);
    }

    /**
     * Check if email exists
     */
    @Transactional(readOnly = true)
    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }
}
