package com.rental.repository;

import com.rental.entity.Expense;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * Repository interface for Expense entity
 */
@Repository
public interface ExpenseRepository extends JpaRepository<Expense, Long> {

    /**
     * Find expenses by category
     */
    List<Expense> findByCategory(String category);

    /**
     * Find expenses by date range
     */
    @Query("SELECT e FROM Expense e WHERE e.expenseDate >= :startDate AND e.expenseDate <= :endDate")
    List<Expense> findByDateRange(@Param("startDate") long startDate,
            @Param("endDate") long endDate);

    /**
     * Find expenses with search functionality
     */
    @Query("SELECT e FROM Expense e WHERE " + "(e.name LIKE %:search% OR "
            + "e.description LIKE %:search% OR "
            + "e.category LIKE %:search%)")
    Page<Expense> findExpensesWithSearch(@Param("search") String search, Pageable pageable);

    /**
     * Find expenses with filters
     */
    @Query("SELECT e FROM Expense e WHERE "
            + "(:search IS NULL OR e.name LIKE %:search% OR e.description LIKE %:search%) AND "
            + "(:category IS NULL OR e.category = :category) AND "
            + "(:startDate IS NULL OR e.expenseDate >= :startDate) AND "
            + "(:endDate IS NULL OR e.expenseDate <= :endDate)")
    Page<Expense> findExpensesWithFilters(@Param("search") String search, @Param("category") String category,
            @Param("startDate") Long startDate, @Param("endDate") Long endDate, Pageable pageable);

    /**
     * Calculate total expenses for a date range
     */
    @Query("SELECT COALESCE(SUM(e.amount), 0) FROM Expense e WHERE "
            + "e.expenseDate >= :startDate AND e.expenseDate <= :endDate")
    BigDecimal calculateTotalExpensesByDateRange(@Param("startDate") long startDate,
            @Param("endDate") long endDate);

    /**
     * Calculate monthly expenses
     */
    @Query("SELECT COALESCE(SUM(e.amount), 0) FROM Expense e WHERE " +
           "e.expenseDate >= :startOfMonth AND e.expenseDate < :startOfNextMonth")
    BigDecimal calculateMonthlyExpenses(@Param("startOfMonth") long startOfMonth,
                                       @Param("startOfNextMonth") long startOfNextMonth);

    /**
     * Get distinct categories
     */
    @Query("SELECT DISTINCT e.category FROM Expense e WHERE e.category IS NOT NULL ORDER BY e.category")
    List<String> findDistinctCategories();

    /**
     * Find expenses by month and year
     */
    @Query("SELECT e FROM Expense e WHERE e.expenseDate >= :startOfMonth AND e.expenseDate < :startOfNextMonth")
    List<Expense> findByMonthAndYear(@Param("startOfMonth") long startOfMonth,
                                    @Param("startOfNextMonth") long startOfNextMonth);

    /**
     * Find expenses by category with pagination
     */
    Page<Expense> findByCategory(String category, Pageable pageable);

    /**
     * Count expenses by category
     */
    long countByCategory(String category);

    /**
     * Find expenses by date range with pagination
     */
    @Query("SELECT e FROM Expense e WHERE " + "(:startDate IS NULL OR e.expenseDate >= :startDate) AND "
            + "(:endDate IS NULL OR e.expenseDate <= :endDate)")
    Page<Expense> findByDateRangeWithPagination(@Param("startDate") Long startDate,
            @Param("endDate") Long endDate, Pageable pageable);

    /**
     * Get expense summary by category
     */
    @Query("SELECT e.category, COUNT(e), SUM(e.amount) FROM Expense e "
            + "WHERE e.category IS NOT NULL GROUP BY e.category ORDER BY SUM(e.amount) DESC")
    List<Object[]> getExpenseSummaryByCategory();
}
