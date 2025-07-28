package com.rental.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Controller for authentication related operations
 */
@Controller
public class AuthController {

    /**
     * Show login page
     */
    @GetMapping("/login")
    public String showLoginPage(@RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout, Model model) {

        if (error != null) {
            model.addAttribute("errorMessage", "Invalid email or password");
        }

        if (logout != null) {
            model.addAttribute("successMessage", "You have been successfully logged out");
        }

        return "login";
    }

    /**
     * Redirect root to dashboard
     */
    @GetMapping("/")
    public String redirectToDashboard() {
        return "redirect:/dashboard";
    }
}
