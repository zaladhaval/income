<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Expenses" />
<c:set var="pageActions">
    <a href="/expenses/new" class="btn btn-primary">
        <i class="fas fa-plus me-1"></i>Add New Expense
    </a>
</c:set>

<jsp:include page="../common/header.jsp" />

<!-- Search and Filter Form -->
<div class="search-form">
    <form method="get" action="/expenses" id="searchForm">
        <div class="row g-3">
            <div class="col-md-3">
                <label for="search" class="form-label">Search</label>
                <input type="text" class="form-control" id="search" name="search" 
                       value="${search}" placeholder="Search by name or description">
            </div>
            <div class="col-md-2">
                <label for="category" class="form-label">Category</label>
                <select class="form-select" id="category" name="category">
                    <option value="">All Categories</option>
                    <c:forEach items="${categories}" var="cat">
                        <option value="${cat}" ${category == cat ? 'selected' : ''}>
                            ${cat}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <label for="startDate" class="form-label">Start Date</label>
                <input type="date" class="form-control" id="startDate" name="startDate" 
                       value="${startDate}">
            </div>
            <div class="col-md-2">
                <label for="endDate" class="form-label">End Date</label>
                <input type="date" class="form-control" id="endDate" name="endDate" 
                       value="${endDate}">
            </div>
            <div class="col-md-2">
                <label for="size" class="form-label">Per Page</label>
                <select class="form-select" id="size" name="size">
                    <option value="10" ${size == 10 ? 'selected' : ''}>10</option>
                    <option value="25" ${size == 25 ? 'selected' : ''}>25</option>
                    <option value="50" ${size == 50 ? 'selected' : ''}>50</option>
                </select>
            </div>
            <div class="col-md-1">
                <label class="form-label">&nbsp;</label>
                <div class="d-grid">
                    <button type="submit" class="btn btn-outline-primary">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Hidden fields for sorting -->
        <input type="hidden" name="sort" value="${sort}">
        <input type="hidden" name="direction" value="${direction}">
        <input type="hidden" name="page" value="0">
    </form>
</div>

<!-- Results Summary -->
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <span class="text-muted">
            Showing ${expenses.numberOfElements} of ${totalElements} expenses
        </span>
    </div>
</div>

<!-- Expenses Table -->
<div class="card">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>
                        <a href="?sort=name&direction=${sort == 'name' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&category=${category}&startDate=${startDate}&endDate=${endDate}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Name
                            <c:if test="${sort == 'name'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>Description</th>
                    <th>
                        <a href="?sort=category&direction=${sort == 'category' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&category=${category}&startDate=${startDate}&endDate=${endDate}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Category
                            <c:if test="${sort == 'category'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>
                        <a href="?sort=expenseDate&direction=${sort == 'expenseDate' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&category=${category}&startDate=${startDate}&endDate=${endDate}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Date
                            <c:if test="${sort == 'expenseDate'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th class="text-end">
                        <a href="?sort=amount&direction=${sort == 'amount' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&category=${category}&startDate=${startDate}&endDate=${endDate}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Amount
                            <c:if test="${sort == 'amount'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th width="120">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty expenses.content}">
                        <c:forEach items="${expenses.content}" var="expense">
                            <tr>
                                <td>
                                    <strong>${expense.name}</strong>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty expense.description}">
                                            ${expense.description}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">No description</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty expense.category}">
                                            <span class="badge bg-secondary">${expense.category}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Uncategorized</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <fmt:formatDate value="${dateUtils.timestampToDate(expense.expenseDate)}" pattern="MMM dd, yyyy" />
                                </td>
                                <td class="text-end">
                                    <strong>₹<fmt:formatNumber value="${expense.amount}" type="number" maxFractionDigits="2" minFractionDigits="2" /></strong>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href="/expenses/${expense.id}/edit" class="btn btn-outline-primary" 
                                           data-bs-toggle="tooltip" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <form method="post" action="/expenses/${expense.id}/delete" class="d-inline" 
                                              onsubmit="return confirmDelete('Are you sure you want to delete ${expense.name}?')">
                                            <button type="submit" class="btn btn-outline-danger" 
                                                    data-bs-toggle="tooltip" title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center py-4">
                                <i class="fas fa-receipt fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No expenses found</p>
                                <a href="/expenses/new" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i>Add First Expense
                                </a>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<!-- Pagination -->
<c:if test="${totalPages > 1}">
    <nav aria-label="Expenses pagination" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- Previous page -->
            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage - 1}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&category=${category}&startDate=${startDate}&endDate=${endDate}">
                    <i class="fas fa-chevron-left"></i>
                </a>
            </li>
            
            <!-- Page numbers -->
            <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                <c:if test="${pageNum >= currentPage - 2 && pageNum <= currentPage + 2}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${pageNum}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&category=${category}&startDate=${startDate}&endDate=${endDate}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:if>
            </c:forEach>
            
            <!-- Next page -->
            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage + 1}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&category=${category}&startDate=${startDate}&endDate=${endDate}">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </li>
        </ul>
    </nav>
</c:if>

<jsp:include page="../common/footer.jsp" />
