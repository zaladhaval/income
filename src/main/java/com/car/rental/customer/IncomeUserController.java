package com.car.rental.customer;

import com.car.rental.enums.UserType;
import com.car.rental.security.MessageResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/user")
public class IncomeUserController {

    private final IncomeUserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public IncomeUserController(IncomeUserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<List<UserDTO>> getAllUsers() {
        List<IncomeUser> users = userRepository.findAll();
        List<UserDTO> userDTOs = new ArrayList<>();

        for (IncomeUser user : users) {
            UserDTO dto = convertToDTO(user);
            userDTOs.add(dto);
        }

        return ResponseEntity.ok(userDTOs);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @userSecurity.isCurrentUser(#id)")
    public ResponseEntity<?> getUserById(@PathVariable Long id) {
        Optional<IncomeUser> userOptional = userRepository.findById(id);

        if (userOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        IncomeUser user = userOptional.get();
        UserDTO dto = convertToDTO(user);

        return ResponseEntity.ok(dto);
    }

    @GetMapping("/profile")
    public ResponseEntity<?> getCurrentUserProfile() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = authentication.getName();

        Optional<IncomeUser> userOptional = userRepository.findByUserName(currentUsername);

        if (userOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        IncomeUser user = userOptional.get();
        UserDTO dto = convertToDTO(user);

        return ResponseEntity.ok(dto);
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> createUser(@Valid @RequestBody UserCreateRequest userRequest) {
        // Check if username already exists
        if (userRepository.existsByUserName(userRequest.getUserName())) {
            return ResponseEntity.badRequest().body(new MessageResponse("Username is already taken"));
        }

        // Check if email already exists
        if (userRepository.existsByEmail(userRequest.getEmail())) {
            return ResponseEntity.badRequest().body(new MessageResponse("Email is already in use"));
        }

        // Create new user
        IncomeUser user = new IncomeUser();
        user.setName(userRequest.getName());
        user.setUserName(userRequest.getUserName());
        user.setEmail(userRequest.getEmail());
        user.setPassword(passwordEncoder.encode(userRequest.getPassword()));
        user.setContactNumber(userRequest.getContactNumber());
        user.setUserType(userRequest.getUserType());

        IncomeUser savedUser = userRepository.save(user);

        return ResponseEntity.ok(convertToDTO(savedUser));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @userSecurity.isCurrentUser(#id)")
    public ResponseEntity<?> updateUser(@PathVariable Long id, @Valid @RequestBody UserUpdateRequest userRequest) {
        Optional<IncomeUser> userOptional = userRepository.findById(id);

        if (userOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        IncomeUser user = userOptional.get();

        // Check if email is being changed and already exists
        if (!user.getEmail().equals(userRequest.getEmail()) &&
            userRepository.existsByEmail(userRequest.getEmail())) {
            return ResponseEntity.badRequest().body(new MessageResponse("Email is already in use"));
        }

        // Update user fields
        user.setName(userRequest.getName());
        user.setEmail(userRequest.getEmail());
        user.setContactNumber(userRequest.getContactNumber());

        // Only admin can change user type
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            user.setUserType(userRequest.getUserType());
        }

        // Update password if provided
        if (userRequest.getPassword() != null && !userRequest.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(userRequest.getPassword()));
        }

        IncomeUser updatedUser = userRepository.save(user);

        return ResponseEntity.ok(convertToDTO(updatedUser));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> deleteUser(@PathVariable Long id) {
        Optional<IncomeUser> userOptional = userRepository.findById(id);

        if (userOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        userRepository.deleteById(id);

        return ResponseEntity.ok(new MessageResponse("User deleted successfully"));
    }

    private UserDTO convertToDTO(IncomeUser user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setName(user.getName());
        dto.setUserName(user.getUserName());
        dto.setEmail(user.getEmail());
        dto.setContactNumber(user.getContactNumber());
        dto.setUserType(user.getUserType());
        dto.setEnabled(user.isEnabled());
        dto.setCreatedTime(user.getCreatedTime());
        dto.setUpdatedTime(user.getUpdatedTime());
        return dto;
    }
}
