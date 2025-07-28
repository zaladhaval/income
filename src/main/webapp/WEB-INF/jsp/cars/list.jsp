<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Cars" />
<c:set var="pageActions">
    <a href="/cars/new" class="btn btn-primary">
        <i class="fas fa-plus me-1"></i>Add New Car
    </a>
</c:set>

<jsp:include page="../common/header.jsp" />

<!-- Search and Filter Form -->
<div class="search-form">
    <form method="get" action="/cars" id="searchForm">
        <div class="row g-3">
            <div class="col-md-3">
                <label for="search" class="form-label">Search</label>
                <input type="text" class="form-control" id="search" name="search" 
                       value="${search}" placeholder="Search by name, company, or listing ID">
            </div>
            <div class="col-md-2">
                <label for="fuelType" class="form-label">Fuel Type</label>
                <select class="form-select" id="fuelType" name="fuelType">
                    <option value="">All Fuel Types</option>
                    <c:forEach items="${fuelTypes}" var="type">
                        <option value="${type}" ${fuelType == type ? 'selected' : ''}>
                            ${type.displayName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <label for="gearType" class="form-label">Gear Type</label>
                <select class="form-select" id="gearType" name="gearType">
                    <option value="">All Gear Types</option>
                    <c:forEach items="${gearTypes}" var="type">
                        <option value="${type}" ${gearType == type ? 'selected' : ''}>
                            ${type.displayName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <label for="available" class="form-label">Availability</label>
                <select class="form-select" id="available" name="available">
                    <option value="">All Cars</option>
                    <option value="true" ${available == true ? 'selected' : ''}>Available</option>
                    <option value="false" ${available == false ? 'selected' : ''}>Not Available</option>
                </select>
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
            Showing ${cars.numberOfElements} of ${totalElements} cars
        </span>
    </div>
    <div class="btn-group btn-group-sm" role="group">
        <input type="radio" class="btn-check" name="view" id="tableView" checked>
        <label class="btn btn-outline-secondary" for="tableView">
            <i class="fas fa-table"></i> Table
        </label>
        <input type="radio" class="btn-check" name="view" id="cardView">
        <label class="btn btn-outline-secondary" for="cardView">
            <i class="fas fa-th-large"></i> Cards
        </label>
    </div>
</div>

<!-- Cars Table -->
<div class="card" id="tableViewContent">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>
                        <a href="?sort=listingId&direction=${sort == 'listingId' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&fuelType=${fuelType}&gearType=${gearType}&available=${available}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Listing ID
                            <c:if test="${sort == 'listingId'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>
                        <a href="?sort=name&direction=${sort == 'name' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&fuelType=${fuelType}&gearType=${gearType}&available=${available}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Car Name
                            <c:if test="${sort == 'name'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>
                        <a href="?sort=company&direction=${sort == 'company' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&fuelType=${fuelType}&gearType=${gearType}&available=${available}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Company
                            <c:if test="${sort == 'company'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>Color</th>
                    <th>Fuel Type</th>
                    <th>Gear Type</th>
                    <th>
                        <a href="?sort=dateOfPurchase&direction=${sort == 'dateOfPurchase' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&fuelType=${fuelType}&gearType=${gearType}&available=${available}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Purchase Date
                            <c:if test="${sort == 'dateOfPurchase'}">
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
                    <c:when test="${not empty cars.content}">
                        <c:forEach items="${cars.content}" var="car">
                            <tr>
                                <td>
                                    <strong>${car.listingId}</strong>
                                </td>
                                <td>
                                    <a href="/cars/${car.id}" class="text-decoration-none">
                                        ${car.name}
                                    </a>
                                </td>
                                <td>${car.company}</td>
                                <td>
                                    <span class="badge" style="background-color: ${car.color.toLowerCase()}; color: white;">
                                        ${car.color}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-info">${car.fuelType.displayName}</span>
                                </td>
                                <td>
                                    <span class="badge bg-secondary">${car.gearType.displayName}</span>
                                </td>
                                <td>
                                    <fmt:formatDate value="${dateUtils.timestampToDate(car.dateOfPurchase)}" pattern="MMM dd, yyyy" />
                                </td>
                                <td>
                                    <span class="badge bg-${car.isAvailable ? 'success' : 'danger'}">
                                        ${car.isAvailable ? 'Available' : 'Not Available'}
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href="/cars/${car.id}" class="btn btn-outline-info" 
                                           data-bs-toggle="tooltip" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="/cars/${car.id}/edit" class="btn btn-outline-primary" 
                                           data-bs-toggle="tooltip" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <form method="post" action="/cars/${car.id}/toggle-availability" class="d-inline">
                                            <button type="submit" class="btn btn-outline-${car.isAvailable ? 'warning' : 'success'}" 
                                                    data-bs-toggle="tooltip" title="${car.isAvailable ? 'Mark Unavailable' : 'Mark Available'}">
                                                <i class="fas fa-${car.isAvailable ? 'pause' : 'play'}"></i>
                                            </button>
                                        </form>
                                        <form method="post" action="/cars/${car.id}/delete" class="d-inline" 
                                              onsubmit="return confirmDelete('Are you sure you want to delete ${car.name}?')">
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
                            <td colspan="9" class="text-center py-4">
                                <i class="fas fa-car fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No cars found</p>
                                <a href="/cars/new" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i>Add First Car
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
    <nav aria-label="Cars pagination" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- Previous page -->
            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage - 1}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&fuelType=${fuelType}&gearType=${gearType}&available=${available}">
                    <i class="fas fa-chevron-left"></i>
                </a>
            </li>
            
            <!-- Page numbers -->
            <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                <c:if test="${pageNum >= currentPage - 2 && pageNum <= currentPage + 2}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${pageNum}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&fuelType=${fuelType}&gearType=${gearType}&available=${available}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:if>
            </c:forEach>
            
            <!-- Next page -->
            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage + 1}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&fuelType=${fuelType}&gearType=${gearType}&available=${available}">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </li>
        </ul>
    </nav>
</c:if>

<jsp:include page="../common/footer.jsp" />
