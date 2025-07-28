package com.rental.controller;

import com.rental.entity.Expense;
import com.rental.service.ExpenseService;
import com.rental.util.DateUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

/**
 * Controller for expense management operations
 */
@Controller
@RequestMapping("/expenses")
@PreAuthorize("hasAnyRole('ADMIN', 'TECHNICAL')")
public class ExpenseController {

    @Autowired
    private ExpenseService expenseService;

    /**
     * List all expenses with pagination and search
     */
    @GetMapping
    public String listExpenses(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size,
                              @RequestParam(defaultValue = "expenseDate") String sort,
                              @RequestParam(defaultValue = "desc") String direction,
                              @RequestParam(required = false) String search,
                              @RequestParam(required = false) String category,
                              @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                              @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
                              Model model) {
        try {
            Sort.Direction sortDirection = "desc".equalsIgnoreCase(direction) ? 
                Sort.Direction.DESC : Sort.Direction.ASC;
            Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sort));
            
            Page<Expense> expenses = expenseService.searchExpensesWithFilters(
                search, category, startDate, endDate, pageable);
            
            model.addAttribute("expenses", expenses);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", expenses.getTotalPages());
            model.addAttribute("totalElements", expenses.getTotalElements());
            model.addAttribute("size", size);
            model.addAttribute("sort", sort);
            model.addAttribute("direction", direction);
            model.addAttribute("search", search);
            model.addAttribute("category", category);
            model.addAttribute("startDate", startDate);
            model.addAttribute("endDate", endDate);
            
            // Get distinct categories for filter
            List<String> categories = expenseService.getDistinctCategories();
            model.addAttribute("categories", categories);

            // Add DateUtils for JSP date formatting
            model.addAttribute("dateUtils", new DateUtils());

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error loading expenses: " + e.getMessage());
        }

        return "expenses/list";
    }

    /**
     * Show new expense form
     */
    @GetMapping("/new")
    public String showNewExpenseForm(Model model) {
        model.addAttribute("expense", new Expense());
        model.addAttribute("categories", expenseService.getDistinctCategories());
        model.addAttribute("isEdit", false);
        
        return "expenses/form";
    }

    /**
     * Show edit expense form
     */
    @GetMapping("/{id}/edit")
    public String showEditExpenseForm(@PathVariable long id, Model model) {
        try {
            Expense expense = expenseService.getExpenseById(id);
            model.addAttribute("expense", expense);
            model.addAttribute("categories", expenseService.getDistinctCategories());
            model.addAttribute("isEdit", true);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Expense not found: " + e.getMessage());
            return "redirect:/expenses";
        }
        
        return "expenses/form";
    }

    /**
     * Create new expense
     */
    @PostMapping
    public String createExpense(@Valid @ModelAttribute Expense expense,
                               @RequestParam(required = false) String expenseDateStr,
                               BindingResult result,
                               Model model,
                               RedirectAttributes redirectAttributes) {

        // Handle date conversion from string to timestamp
        if (expenseDateStr != null && !expenseDateStr.isEmpty()) {
            try {
                LocalDate date = LocalDate.parse(expenseDateStr);
                expense.setExpenseDate(date.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli());
            } catch (Exception e) {
                result.rejectValue("expenseDate", "error.expense", "Invalid date format");
            }
        }
        if (result.hasErrors()) {
            model.addAttribute("categories", expenseService.getDistinctCategories());
            model.addAttribute("isEdit", false);
            return "expenses/form";
        }
        
        try {
            expenseService.createExpense(expense);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Expense '" + expense.getName() + "' has been created successfully!");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error creating expense: " + e.getMessage());
            model.addAttribute("categories", expenseService.getDistinctCategories());
            model.addAttribute("isEdit", false);
            return "expenses/form";
        }
        
        return "redirect:/expenses";
    }

    /**
     * Update expense
     */
    @PostMapping("/{id}")
    public String updateExpense(@PathVariable long id,
                               @Valid @ModelAttribute Expense expense,
                               @RequestParam(required = false) String expenseDateStr,
                               BindingResult result,
                               Model model,
                               RedirectAttributes redirectAttributes) {

        // Handle date conversion from string to timestamp
        if (expenseDateStr != null && !expenseDateStr.isEmpty()) {
            try {
                LocalDate date = LocalDate.parse(expenseDateStr);
                expense.setExpenseDate(date.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli());
            } catch (Exception e) {
                result.rejectValue("expenseDate", "error.expense", "Invalid date format");
            }
        }
        if (result.hasErrors()) {
            model.addAttribute("categories", expenseService.getDistinctCategories());
            model.addAttribute("isEdit", true);
            return "expenses/form";
        }
        
        try {
            expense.setId(id);
            expenseService.updateExpense(expense);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Expense '" + expense.getName() + "' has been updated successfully!");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating expense: " + e.getMessage());
            model.addAttribute("categories", expenseService.getDistinctCategories());
            model.addAttribute("isEdit", true);
            return "expenses/form";
        }
        
        return "redirect:/expenses";
    }

    /**
     * Delete expense
     */
    @PostMapping("/{id}/delete")
    public String deleteExpense(@PathVariable long id, RedirectAttributes redirectAttributes) {
        try {
            Expense expense = expenseService.getExpenseById(id);
            expenseService.deleteExpense(id);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Expense '" + expense.getName() + "' has been deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Error deleting expense: " + e.getMessage());
        }
        
        return "redirect:/expenses";
    }
}
