package com.rental.repository;

import com.rental.entity.User;
import com.rental.enums.UserType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository interface for User entity
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    /**
     * Find user by email
     */
    Optional<User> findByEmail(String email);

    /**
     * Find users by user type
     */
    List<User> findByUserType(UserType userType);

    /**
     * Find active users by user type
     */
    List<User> findByUserTypeAndIsActiveTrue(UserType userType);

    /**
     * Find users by name containing (case insensitive)
     */
    @Query("SELECT u FROM User u WHERE u.name LIKE %:name%")
    List<User> findByNameContainingIgnoreCase(@Param("name") String name);

    /**
     * Find customers with pagination and search
     */
    @Query("SELECT u FROM User u WHERE u.userType = 'CUSTOMER' AND " +
           "(u.name LIKE %:search% OR " +
           "u.email LIKE %:search% OR " +
           "u.contact LIKE %:search%)")
    Page<User> findCustomersWithSearch(@Param("search") String search, Pageable pageable);

    /**
     * Find all customers with pagination
     */
    Page<User> findByUserType(UserType userType, Pageable pageable);

    /**
     * Check if email exists
     */
    boolean existsByEmail(String email);

    /**
     * Find active users
     */
    List<User> findByIsActiveTrue();

    /**
     * Count users by type
     */
    long countByUserType(UserType userType);
}
