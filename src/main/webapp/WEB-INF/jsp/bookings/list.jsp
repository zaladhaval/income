<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Bookings" />
<c:set var="pageActions">
    <a href="/bookings/new" class="btn btn-primary">
        <i class="fas fa-plus me-1"></i>New Booking
    </a>
</c:set>

<jsp:include page="../common/header.jsp" />

<!-- Search and Filter Form -->
<div class="search-form">
    <form method="get" action="/bookings" id="searchForm">
        <div class="row g-3">
            <div class="col-md-3">
                <label for="search" class="form-label">Search</label>
                <input type="text" class="form-control" id="search" name="search" 
                       value="${search}" placeholder="Search by car, customer, or booking ID">
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
            Showing ${bookings.numberOfElements} of ${totalElements} bookings
        </span>
    </div>
</div>

<!-- Bookings Table -->
<div class="card">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>
                        <a href="?sort=bookingId&direction=${sort == 'bookingId' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&startDate=${startDate}&endDate=${endDate}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Booking ID
                            <c:if test="${sort == 'bookingId'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>Car</th>
                    <th>Customer</th>
                    <th>
                        <a href="?sort=startDate&direction=${sort == 'startDate' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&startDate=${startDate}&endDate=${endDate}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Start Date
                            <c:if test="${sort == 'startDate'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th>
                        <a href="?sort=endDate&direction=${sort == 'endDate' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&startDate=${startDate}&endDate=${endDate}&size=${size}" 
                           class="text-decoration-none text-dark">
                            End Date
                            <c:if test="${sort == 'endDate'}">
                                <i class="fas fa-sort-${direction == 'asc' ? 'up' : 'down'}"></i>
                            </c:if>
                        </a>
                    </th>
                    <th class="text-end">
                        <a href="?sort=earningAmount&direction=${sort == 'earningAmount' && direction == 'asc' ? 'desc' : 'asc'}&search=${search}&startDate=${startDate}&endDate=${endDate}&size=${size}" 
                           class="text-decoration-none text-dark">
                            Amount
                            <c:if test="${sort == 'earningAmount'}">
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
                    <c:when test="${not empty bookings.content}">
                        <c:forEach items="${bookings.content}" var="booking">
                            <tr>
                                <td>
                                    <strong>#${booking.bookingId}</strong>
                                </td>
                                <td>
                                    <div>
                                        <strong>${booking.car.name}</strong>
                                        <br>
                                        <small class="text-muted">${booking.car.company} • ${booking.car.listingId}</small>
                                    </div>
                                </td>
                                <td>
                                    <div>
                                        <strong>${booking.customer.name}</strong>
                                        <br>
                                        <small class="text-muted">${booking.customer.email}</small>
                                    </div>
                                </td>
                                <td>
                                    <fmt:formatDate value="${dateUtils.timestampToDate(booking.startDate)}" pattern="MMM dd, yyyy" />
                                </td>
                                <td>
                                    <fmt:formatDate value="${dateUtils.timestampToDate(booking.endDate)}" pattern="MMM dd, yyyy" />
                                </td>
                                <td class="text-end">
                                    <strong>₹<fmt:formatNumber value="${booking.earningAmount}" type="number" maxFractionDigits="2" minFractionDigits="2" /></strong>
                                </td>
                                <td>
                                    <span class="badge bg-${booking.bookingStatus == 'COMPLETED' ? 'success' : 
                                                            booking.bookingStatus == 'CONFIRMED' ? 'primary' : 
                                                            booking.bookingStatus == 'PENDING' ? 'warning' : 'danger'}">
                                        ${booking.bookingStatus.displayName}
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href="/bookings/${booking.bookingId}" class="btn btn-outline-info" 
                                           data-bs-toggle="tooltip" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="/bookings/${booking.bookingId}/edit" class="btn btn-outline-primary" 
                                           data-bs-toggle="tooltip" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <div class="btn-group btn-group-sm" role="group">
                                            <button type="button" class="btn btn-outline-secondary dropdown-toggle" 
                                                    data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="fas fa-cog"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <c:if test="${booking.bookingStatus == 'PENDING'}">
                                                    <li>
                                                        <form method="post" action="/bookings/${booking.bookingId}/status" class="d-inline">
                                                            <input type="hidden" name="status" value="CONFIRMED">
                                                            <button type="submit" class="dropdown-item">
                                                                <i class="fas fa-check text-primary me-2"></i>Confirm
                                                            </button>
                                                        </form>
                                                    </li>
                                                </c:if>
                                                <c:if test="${booking.bookingStatus == 'CONFIRMED'}">
                                                    <li>
                                                        <form method="post" action="/bookings/${booking.bookingId}/status" class="d-inline">
                                                            <input type="hidden" name="status" value="COMPLETED">
                                                            <button type="submit" class="dropdown-item">
                                                                <i class="fas fa-flag-checkered text-success me-2"></i>Complete
                                                            </button>
                                                        </form>
                                                    </li>
                                                </c:if>
                                                <c:if test="${booking.bookingStatus != 'CANCELLED' && booking.bookingStatus != 'COMPLETED'}">
                                                    <li>
                                                        <form method="post" action="/bookings/${booking.bookingId}/status" class="d-inline">
                                                            <input type="hidden" name="status" value="CANCELLED">
                                                            <button type="submit" class="dropdown-item" 
                                                                    onclick="return confirm('Are you sure you want to cancel this booking?')">
                                                                <i class="fas fa-times text-danger me-2"></i>Cancel
                                                            </button>
                                                        </form>
                                                    </li>
                                                </c:if>
                                                <li><hr class="dropdown-divider"></li>
                                                <li>
                                                    <form method="post" action="/bookings/${booking.bookingId}/delete" class="d-inline" 
                                                          onsubmit="return confirmDelete('Are you sure you want to delete booking #${booking.bookingId}?')">
                                                        <button type="submit" class="dropdown-item text-danger">
                                                            <i class="fas fa-trash me-2"></i>Delete
                                                        </button>
                                                    </form>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="text-center py-4">
                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No bookings found</p>
                                <a href="/bookings/new" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i>Create First Booking
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
    <nav aria-label="Bookings pagination" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- Previous page -->
            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage - 1}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&startDate=${startDate}&endDate=${endDate}">
                    <i class="fas fa-chevron-left"></i>
                </a>
            </li>
            
            <!-- Page numbers -->
            <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                <c:if test="${pageNum >= currentPage - 2 && pageNum <= currentPage + 2}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${pageNum}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&startDate=${startDate}&endDate=${endDate}">
                            ${pageNum + 1}
                        </a>
                    </li>
                </c:if>
            </c:forEach>
            
            <!-- Next page -->
            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage + 1}&size=${size}&sort=${sort}&direction=${direction}&search=${search}&startDate=${startDate}&endDate=${endDate}">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </li>
        </ul>
    </nav>
</c:if>

<jsp:include page="../common/footer.jsp" />
