<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Customers" />

<jsp:include page="../common/header.jsp" />

<!-- Search Form -->
<div class="search-form">
    <form method="get" action="/customers" id="searchForm">
        <div class="row g-3">
            <div class="col-md-4">
                <label for="search" class="form-label">Search</label>
                <input type="text" class="form-control" id="search" name="search" 
                       value="${search}" placeholder="Search by name, email, or contact">
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
            Showing ${customers.numberOfElements} of ${totalElements} customers
        </span>
    </div>
</div>

<!-- Customers Table -->
<div class="card">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>
                        <a href="?sort=name&direction=${sort == 'name' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Name
                            <c:if test="${sort == 'name'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>
                        <a href="?sort=email&direction=${sort == 'email' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Email
                            <c:if test="${sort == 'email'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>Contact</th>
                    <th>
                        <a href="?sort=createdDate&direction=${sort == 'createdDate' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Joined Date
                            <c:if test="${sort == 'createdDate'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>Status</th>
                    <th width="150">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty customers.content}">
                        <c:forEach items="${customers.content}" var="customer">
                            <tr>
                                <td>
                                    <a href="/customers/${customer.id}" class="text-decoration-none">
                                        <strong>${customer.name}</strong>
                                    </a>
                                </td>
                                <td>${customer.email}</td>
                                <td>${customer.contact}</td>
                                <td>
                                    <fmt:formatDate value="${dateUtils.timestampToDate(customer.createdDate)}" pattern="MMM dd, yyyy" />
                                </td>
                                <td>
                                    <span class="badge bg-${customer.isActive ? 'success' : 'danger'}">
                                        ${customer.isActive ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href="/customers/${customer.id}" class="btn btn-outline-info" 
                                           data-bs-toggle="tooltip" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <c:choose>
                                            <c:when test="${customer.isActive}">
                                                <form method="post" action="/customers/${customer.id}/deactivate" class="d-inline">
                                                    <button type="submit" class="btn btn-outline-warning" 
                                                            data-bs-toggle="tooltip" title="Deactivate"
                                                            onclick="return confirm('Are you sure you want to deactivate ${customer.name}?')">
                                                        <i class="fas fa-user-slash"></i>
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <form method="post" action="/customers/${customer.id}/activate" class="d-inline">
                                                    <button type="submit" class="btn btn-outline-success" 
                                                            data-bs-toggle="tooltip" title="Activate">
                                                        <i class="fas fa-user-check"></i>
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center py-4">
                                <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No customers found</p>
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
    <nav aria-label="Customers pagination" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- Previous page -->
            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage - 1}&size=${size}&sort=${sort}&direction=${direction}&search=${search}">
                    <i class="fas fa-chevron-left"></i>
                </a>
            </li>
            
            <!-- Page numbers -->
            <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                <c:if test="${pageNum >= currentPage - 2 && pageNum <= currentPage + 2}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${pageNum}&size=${size}&sort=${sort}&direction=${direction}&search=${search}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:if>
            </c:forEach>
            
            <!-- Next page -->
            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage + 1}&size=${size}&sort=${sort}&direction=${direction}&search=${search}">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </li>
        </ul>
    </nav>
</c:if>

<jsp:include page="../common/footer.jsp" />
