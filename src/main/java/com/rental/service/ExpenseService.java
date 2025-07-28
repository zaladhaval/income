package com.rental.service;

import com.rental.entity.Expense;
import com.rental.repository.ExpenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

/**
 * Service class for Expense entity operations
 */
@Service
@Transactional
public class ExpenseService {

    @Autowired
    private ExpenseRepository expenseRepository;

    /**
     * Create a new expense
     */
    public Expense createExpense(Expense expense) {
        return expenseRepository.save(expense);
    }

    /**
     * Update an existing expense
     */
    public Expense updateExpense(Expense expense) {
        Expense existingExpense = getExpenseById(expense.getId());
        
        existingExpense.setName(expense.getName());
        existingExpense.setDescription(expense.getDescription());
        existingExpense.setExpenseDate(expense.getExpenseDate());
        existingExpense.setAmount(expense.getAmount());
        existingExpense.setCategory(expense.getCategory());
        
        return expenseRepository.save(existingExpense);
    }

    /**
     * Get expense by ID
     */
    @Transactional(readOnly = true)
    public Expense getExpenseById(long id) {
        return expenseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Expense not found with id: " + id));
    }

    /**
     * Get all expenses
     */
    @Transactional(readOnly = true)
    public List<Expense> getAllExpenses() {
        return expenseRepository.findAll();
    }

    /**
     * Get all expenses with pagination
     */
    @Transactional(readOnly = true)
    public Page<Expense> getAllExpensesWithPagination(Pageable pageable) {
        return expenseRepository.findAll(pageable);
    }

    /**
     * Search expenses with filters
     */
    @Transactional(readOnly = true)
    public Page<Expense> searchExpensesWithFilters(String search, String category,
                                                   LocalDate startDate, LocalDate endDate,
                                                   Pageable pageable) {
        Long startTimestamp = startDate != null ? startDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli() : null;
        Long endTimestamp = endDate != null ? endDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli() : null;
        return expenseRepository.findExpensesWithFilters(search, category, startTimestamp, endTimestamp, pageable);
    }

    /**
     * Search expenses by text
     */
    @Transactional(readOnly = true)
    public Page<Expense> searchExpenses(String search, Pageable pageable) {
        if (search == null || search.trim().isEmpty()) {
            return getAllExpensesWithPagination(pageable);
        }
        return expenseRepository.findExpensesWithSearch(search.trim(), pageable);
    }

    /**
     * Get expenses by category
     */
    @Transactional(readOnly = true)
    public List<Expense> getExpensesByCategory(String category) {
        return expenseRepository.findByCategory(category);
    }

    /**
     * Get expenses by category with pagination
     */
    @Transactional(readOnly = true)
    public Page<Expense> getExpensesByCategoryWithPagination(String category, Pageable pageable) {
        return expenseRepository.findByCategory(category, pageable);
    }

    /**
     * Get expenses by date range
     */
    @Transactional(readOnly = true)
    public List<Expense> getExpensesByDateRange(LocalDate startDate, LocalDate endDate) {
        long startTimestamp = startDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        long endTimestamp = endDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        return expenseRepository.findByDateRange(startTimestamp, endTimestamp);
    }

    /**
     * Get expenses by date range with pagination
     */
    @Transactional(readOnly = true)
    public Page<Expense> getExpensesByDateRangeWithPagination(LocalDate startDate,
                                                               LocalDate endDate,
                                                               Pageable pageable) {
        Long startTimestamp = startDate != null ? startDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli() : null;
        Long endTimestamp = endDate != null ? endDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli() : null;
        return expenseRepository.findByDateRangeWithPagination(startTimestamp, endTimestamp, pageable);
    }

    /**
     * Get expenses by month and year
     */
    @Transactional(readOnly = true)
    public List<Expense> getExpensesByMonthAndYear(int year, int month) {
        LocalDate startOfMonth = LocalDate.of(year, month, 1);
        LocalDate startOfNextMonth = startOfMonth.plusMonths(1);

        long startTimestamp = startOfMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        long endTimestamp = startOfNextMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();

        return expenseRepository.findByMonthAndYear(startTimestamp, endTimestamp);
    }

    /**
     * Delete expense
     */
    public void deleteExpense(long id) {
        if (!expenseRepository.existsById(id)) {
            throw new RuntimeException("Expense not found with id: " + id);
        }
        expenseRepository.deleteById(id);
    }

    /**
     * Calculate total expenses by date range
     */
    @Transactional(readOnly = true)
    public BigDecimal calculateTotalExpensesByDateRange(LocalDate startDate, LocalDate endDate) {
        long startTimestamp = startDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        long endTimestamp = endDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        return expenseRepository.calculateTotalExpensesByDateRange(startTimestamp, endTimestamp);
    }

    /**
     * Calculate monthly expenses
     */
    @Transactional(readOnly = true)
    public BigDecimal calculateMonthlyExpenses(int year, int month) {
        LocalDate startOfMonth = LocalDate.of(year, month, 1);
        LocalDate startOfNextMonth = startOfMonth.plusMonths(1);

        long startTimestamp = startOfMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        long endTimestamp = startOfNextMonth.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();

        return expenseRepository.calculateMonthlyExpenses(startTimestamp, endTimestamp);
    }

    /**
     * Get distinct categories
     */
    @Transactional(readOnly = true)
    public List<String> getDistinctCategories() {
        return expenseRepository.findDistinctCategories();
    }

    /**
     * Get expense summary by category
     */
    @Transactional(readOnly = true)
    public List<Object[]> getExpenseSummaryByCategory() {
        return expenseRepository.getExpenseSummaryByCategory();
    }

    /**
     * Count expenses by category
     */
    @Transactional(readOnly = true)
    public long countExpensesByCategory(String category) {
        return expenseRepository.countByCategory(category);
    }

    /**
     * Count total expenses
     */
    @Transactional(readOnly = true)
    public long countTotalExpenses() {
        return expenseRepository.count();
    }
}
