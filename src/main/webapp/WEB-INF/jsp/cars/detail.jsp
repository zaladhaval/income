<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="pageTitle" value="Car Details" />
<c:set var="pageActions">
    <sec:authorize access="hasAnyRole('ADMIN', 'TECHNICAL')">
        <div class="btn-group" role="group">
            <a href="/cars/${car.id}/edit" class="btn btn-primary btn-sm">
                <i class="fas fa-edit me-1"></i>Edit Car
            </a>
            <a href="/cars" class="btn btn-secondary btn-sm">
                <i class="fas fa-arrow-left me-1"></i>Back to Cars
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
                        <i class="fas fa-car me-2"></i>Car Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <table class="table table-borderless">
                                <tr>
                                    <td class="fw-bold">Car Name:</td>
                                    <td>${car.name}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Company:</td>
                                    <td>${car.company}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Color:</td>
                                    <td>
                                        <span class="badge bg-secondary">${car.color}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Fuel Type:</td>
                                    <td>
                                        <span class="badge bg-info">${car.fuelType}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Gear Type:</td>
                                    <td>
                                        <span class="badge bg-warning">${car.gearType}</span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-6">
                            <table class="table table-borderless">
                                <tr>
                                    <td class="fw-bold">Listing ID:</td>
                                    <td><code>${car.listingId}</code></td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Purchase Date:</td>
                                    <td>
                                        <fmt:formatDate value="${dateUtils.timestampToDate(car.dateOfPurchase)}" pattern="MMM dd, yyyy" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Added Date:</td>
                                    <td>
                                        <fmt:formatDate value="${dateUtils.timestampToDate(car.createdDate)}" pattern="MMM dd, yyyy HH:mm" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Availability:</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${car.isAvailable}">
                                                <span class="badge bg-success">
                                                    <i class="fas fa-check me-1"></i>Available
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">
                                                    <i class="fas fa-times me-1"></i>Not Available
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    
                    <c:if test="${not empty car.description}">
                        <div class="mt-3">
                            <h6 class="fw-bold">Description:</h6>
                            <p class="text-muted">${car.description}</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-chart-line me-2"></i>Car Statistics
                    </h6>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <div class="mb-3">
                            <h4 class="text-primary mb-0">
                                <i class="fas fa-calendar-check me-2"></i>
                                <span id="totalBookings">-</span>
                            </h4>
                            <small class="text-muted">Total Bookings</small>
                        </div>
                        <div class="mb-3">
                            <h4 class="text-success mb-0">
                                <i class="fas fa-dollar-sign me-2"></i>
                                <span id="totalEarnings">-</span>
                            </h4>
                            <small class="text-muted">Total Earnings</small>
                        </div>
                        <div class="mb-3">
                            <h4 class="text-info mb-0">
                                <i class="fas fa-star me-2"></i>
                                <span id="averageRating">-</span>
                            </h4>
                            <small class="text-muted">Average Rating</small>
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
                    <sec:authorize access="hasAnyRole('ADMIN', 'TECHNICAL')">
                        <div class="d-grid gap-2">
                            <a href="/bookings/new?carId=${car.id}" class="btn btn-success btn-sm">
                                <i class="fas fa-calendar-plus me-2"></i>New Booking
                            </a>
                            <a href="/cars/${car.id}/edit" class="btn btn-primary btn-sm">
                                <i class="fas fa-edit me-2"></i>Edit Car
                            </a>
                            <c:choose>
                                <c:when test="${car.isAvailable}">
                                    <button class="btn btn-warning btn-sm" onclick="toggleAvailability(${car.id}, false)">
                                        <i class="fas fa-pause me-2"></i>Mark Unavailable
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-success btn-sm" onclick="toggleAvailability(${car.id}, true)">
                                        <i class="fas fa-play me-2"></i>Mark Available
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
function toggleAvailability(carId, available) {
    if (confirm('Are you sure you want to change the availability status?')) {
        // Implementation for toggling availability
        window.location.href = '/cars/' + carId + '/toggle-availability?available=' + available;
    }
}

// Load car statistics (placeholder for future implementation)
$(document).ready(function() {
    // You can implement AJAX calls here to load car statistics
    $('#totalBookings').text('0');
    $('#totalEarnings').text('₹0.00');
    $('#averageRating').text('N/A');
});
</script>

<jsp:include page="../common/footer.jsp" />
