<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="pageTitle" value="Customer Details" />
<c:set var="pageActions">
    <sec:authorize access="hasRole('ADMIN')">
        <div class="btn-group" role="group">
            <a href="/customers/${customer.id}/edit" class="btn btn-primary btn-sm">
                <i class="fas fa-edit me-1"></i>Edit Customer
            </a>
            <a href="/customers" class="btn btn-secondary btn-sm">
                <i class="fas fa-arrow-left me-1"></i>Back to Customers
            </a>
        </div>
    </sec:authorize>
</c:set>

<jsp:include page="../common/header.jsp" />

<div class="container-fluid">
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-user me-2"></i>Customer Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <table class="table table-borderless">
                                <tr>
                                    <td class="fw-bold">Name:</td>
                                    <td>${customer.name}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Email:</td>
                                    <td>
                                        <a href="mailto:${customer.email}" class="text-decoration-none">
                                            <i class="fas fa-envelope me-1"></i>${customer.email}
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Contact:</td>
                                    <td>
                                        <a href="tel:${customer.contact}" class="text-decoration-none">
                                            <i class="fas fa-phone me-1"></i>${customer.contact}
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">User Type:</td>
                                    <td>
                                        <span class="badge bg-info">${customer.userType}</span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-6">
                            <table class="table table-borderless">
                                <tr>
                                    <td class="fw-bold">Status:</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${customer.active}">
                                                <span class="badge bg-success">
                                                    <i class="fas fa-check me-1"></i>Active
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">
                                                    <i class="fas fa-times me-1"></i>Inactive
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Member Since:</td>
                                    <td>
                                        <fmt:formatDate value="${dateUtils.timestampToDate(customer.createdDate)}" pattern="MMM dd, yyyy" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Customer ID:</td>
                                    <td><code>#${customer.id}</code></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Customer Bookings -->
            <div class="card mt-3">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-calendar-alt me-2"></i>Recent Bookings
                    </h6>
                    <a href="/bookings?search=${customer.email}" class="btn btn-sm btn-outline-primary">
                        View All Bookings
                    </a>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty customerBookings}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Booking ID</th>
                                            <th>Car</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Status</th>
                                            <th>Amount</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="booking" items="${customerBookings}">
                                            <tr>
                                                <td><code>#${booking.bookingId}</code></td>
                                                <td>
                                                    <a href="/cars/${booking.car.id}" class="text-decoration-none">
                                                        ${booking.car.name}
                                                    </a>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${dateUtils.timestampToDate(booking.startDate)}" pattern="MMM dd, yyyy" />
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${dateUtils.timestampToDate(booking.endDate)}" pattern="MMM dd, yyyy" />
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${booking.bookingStatus == 'PENDING'}">
                                                            <span class="badge bg-warning">Pending</span>
                                                        </c:when>
                                                        <c:when test="${booking.bookingStatus == 'CONFIRMED'}">
                                                            <span class="badge bg-info">Confirmed</span>
                                                        </c:when>
                                                        <c:when test="${booking.bookingStatus == 'COMPLETED'}">
                                                            <span class="badge bg-success">Completed</span>
                                                        </c:when>
                                                        <c:when test="${booking.bookingStatus == 'CANCELLED'}">
                                                            <span class="badge bg-danger">Cancelled</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    ₹<fmt:formatNumber value="${booking.earningAmount}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                                                </td>
                                                <td>
                                                    <a href="/bookings/${booking.bookingId}" class="btn btn-sm btn-outline-primary">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No bookings found for this customer.</p>
                                <sec:authorize access="hasAnyRole('ADMIN', 'TECHNICAL')">
                                    <a href="/bookings/new?customerId=${customer.id}" class="btn btn-primary">
                                        <i class="fas fa-plus me-1"></i>Create First Booking
                                    </a>
                                </sec:authorize>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-chart-bar me-2"></i>Customer Statistics
                    </h6>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <div class="mb-3">
                            <h4 class="text-primary mb-0">
                                <i class="fas fa-calendar-check me-2"></i>
                                <span id="totalBookings">${not empty customerBookings ? customerBookings.size() : 0}</span>
                            </h4>
                            <small class="text-muted">Total Bookings</small>
                        </div>
                        <div class="mb-3">
                            <h4 class="text-success mb-0">
                                <i class="fas fa-dollar-sign me-2"></i>
                                <span id="totalSpent">$0.00</span>
                            </h4>
                            <small class="text-muted">Total Spent</small>
                        </div>
                        <div class="mb-3">
                            <h4 class="text-info mb-0">
                                <i class="fas fa-star me-2"></i>
                                <span id="loyaltyStatus">Regular</span>
                            </h4>
                            <small class="text-muted">Customer Status</small>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card mt-3">
                <div class="card-header">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-tools me-2"></i>Quick Actions
                    </h6>
                </div>
                <div class="card-body">
                    <sec:authorize access="hasRole('ADMIN')">
                        <div class="d-grid gap-2">
                            <a href="/customers/${customer.id}/edit" class="btn btn-primary btn-sm">
                                <i class="fas fa-edit me-2"></i>Edit Customer
                            </a>
                            <a href="/bookings/new?customerId=${customer.id}" class="btn btn-success btn-sm">
                                <i class="fas fa-calendar-plus me-2"></i>New Booking
                            </a>
                            <a href="mailto:${customer.email}" class="btn btn-info btn-sm">
                                <i class="fas fa-envelope me-2"></i>Send Email
                            </a>
                            <c:choose>
                                <c:when test="${customer.active}">
                                    <button class="btn btn-warning btn-sm" onclick="toggleStatus(${customer.id}, false)">
                                        <i class="fas fa-pause me-2"></i>Deactivate
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-success btn-sm" onclick="toggleStatus(${customer.id}, true)">
                                        <i class="fas fa-play me-2"></i>Activate
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </sec:authorize>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function toggleStatus(customerId, active) {
    var action = active ? 'activate' : 'deactivate';
    if (confirm('Are you sure you want to ' + action + ' this customer?')) {
        // Implementation for toggling customer status
        window.location.href = '/customers/' + customerId + '/toggle-status?active=' + active;
    }
}

// Calculate customer statistics
$(document).ready(function() {
    var totalSpent = 0;
    <c:if test="${not empty customerBookings}">
        <c:forEach var="booking" items="${customerBookings}">
            <c:if test="${booking.bookingStatus == 'COMPLETED'}">
                totalSpent += ${booking.earningAmount};
            </c:if>
        </c:forEach>
    </c:if>
    
    $('#totalSpent').text('₹' + totalSpent.toFixed(2));
    
    // Determine loyalty status based on total bookings
    var totalBookings = ${not empty customerBookings ? customerBookings.size() : 0};
    var loyaltyStatus = 'New';
    if (totalBookings >= 10) {
        loyaltyStatus = 'VIP';
    } else if (totalBookings >= 5) {
        loyaltyStatus = 'Premium';
    } else if (totalBookings >= 2) {
        loyaltyStatus = 'Regular';
    }
    
    $('#loyaltyStatus').text(loyaltyStatus);
});
</script>

<jsp:include page="../common/footer.jsp" />
