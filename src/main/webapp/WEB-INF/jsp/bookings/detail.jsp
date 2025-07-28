<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="pageTitle" value="Booking Details" />
<c:set var="pageActions">
    <sec:authorize access="hasAnyRole('ADMIN', 'TECHNICAL')">
        <div class="btn-group" role="group">
            <a href="/bookings/${booking.bookingId}/edit" class="btn btn-primary btn-sm">
                <i class="fas fa-edit me-1"></i>Edit Booking
            </a>
            <a href="/bookings" class="btn btn-secondary btn-sm">
                <i class="fas fa-arrow-left me-1"></i>Back to Bookings
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
                        <i class="fas fa-calendar-alt me-2"></i>Booking Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <table class="table table-borderless">
                                <tr>
                                    <td class="fw-bold">Booking ID:</td>
                                    <td><code>#${booking.bookingId}</code></td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Customer:</td>
                                    <td>
                                        <a href="/customers/${booking.customer.id}" class="text-decoration-none">
                                            <i class="fas fa-user me-1"></i>${booking.customer.name}
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Car:</td>
                                    <td>
                                        <a href="/cars/${booking.car.id}" class="text-decoration-none">
                                            <i class="fas fa-car me-1"></i>${booking.car.name}
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Start Date:</td>
                                    <td>
                                        <fmt:formatDate value="${dateUtils.timestampToDate(booking.startDate)}" pattern="MMM dd, yyyy" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">End Date:</td>
                                    <td>
                                        <fmt:formatDate value="${dateUtils.timestampToDate(booking.endDate)}" pattern="MMM dd, yyyy" />
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
                                            <c:when test="${booking.bookingStatus == 'PENDING'}">
                                                <span class="badge bg-warning">
                                                    <i class="fas fa-clock me-1"></i>Pending
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.bookingStatus == 'CONFIRMED'}">
                                                <span class="badge bg-info">
                                                    <i class="fas fa-check me-1"></i>Confirmed
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.bookingStatus == 'COMPLETED'}">
                                                <span class="badge bg-success">
                                                    <i class="fas fa-check-circle me-1"></i>Completed
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.bookingStatus == 'CANCELLED'}">
                                                <span class="badge bg-danger">
                                                    <i class="fas fa-times me-1"></i>Cancelled
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Earning Amount:</td>
                                    <td>
                                        <span class="text-success fw-bold">
                                            <i class="fas fa-dollar-sign me-1"></i>
                                            <fmt:formatNumber value="${booking.earningAmount}" type="currency" />
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Total Earning:</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty booking.totalEarning}">
                                                <span class="text-success fw-bold">
                                                    <i class="fas fa-rupee-sign me-1"></i>
                                                    ₹<fmt:formatNumber value="${booking.totalEarning}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Not calculated</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Created Date:</td>
                                    <td>
                                        <fmt:formatDate value="${dateUtils.timestampToDate(booking.createdDate)}" pattern="MMM dd, yyyy HH:mm" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Amount Credited:</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty booking.amountCreditedDate and booking.amountCreditedDate > 0}">
                                                <span class="text-success">
                                                    <i class="fas fa-check-circle me-1"></i>
                                                    <fmt:formatDate value="${dateUtils.timestampToDate(booking.amountCreditedDate)}" pattern="MMM dd, yyyy" />
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-warning">
                                                    <i class="fas fa-clock me-1"></i>Pending
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-info-circle me-2"></i>Booking Summary
                    </h6>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <div class="mb-3">
                            <h4 class="text-primary mb-0" id="bookingDuration">
                                <i class="fas fa-calendar-day me-2"></i>
                                <span>-</span> days
                            </h4>
                            <small class="text-muted">Booking Duration</small>
                        </div>
                        <div class="mb-3">
                            <h4 class="text-success mb-0">
                                <i class="fas fa-dollar-sign me-2"></i>
                                <fmt:formatNumber value="${booking.earningAmount}" type="currency" />
                            </h4>
                            <small class="text-muted">Daily Rate</small>
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
                            <a href="/bookings/${booking.bookingId}/edit" class="btn btn-primary btn-sm">
                                <i class="fas fa-edit me-2"></i>Edit Booking
                            </a>
                            
                            <c:if test="${booking.bookingStatus == 'PENDING'}">
                                <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'CONFIRMED')">
                                    <i class="fas fa-check me-2"></i>Confirm Booking
                                </button>
                                <button class="btn btn-danger btn-sm" onclick="updateStatus(${booking.bookingId}, 'CANCELLED')">
                                    <i class="fas fa-times me-2"></i>Cancel Booking
                                </button>
                            </c:if>
                            
                            <c:if test="${booking.bookingStatus == 'CONFIRMED'}">
                                <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'COMPLETED')">
                                    <i class="fas fa-check-circle me-2"></i>Mark Completed
                                </button>
                            </c:if>
                            
                            <c:if test="${booking.bookingStatus == 'COMPLETED' and (empty booking.amountCreditedDate or booking.amountCreditedDate == 0)}">
                                <button class="btn btn-warning btn-sm" onclick="markAmountCredited(${booking.bookingId})">
                                    <i class="fas fa-credit-card me-2"></i>Mark Amount Credited
                                </button>
                            </c:if>
                        </div>
                    </sec:authorize>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function updateStatus(bookingId, status) {
    if (confirm('Are you sure you want to update the booking status to ' + status + '?')) {
        // Implementation for updating booking status
        window.location.href = '/bookings/' + bookingId + '/update-status?status=' + status;
    }
}

function markAmountCredited(bookingId) {
    if (confirm('Are you sure you want to mark the amount as credited?')) {
        // Implementation for marking amount as credited
        window.location.href = '/bookings/' + bookingId + '/mark-credited';
    }
}

// Calculate booking duration
$(document).ready(function() {
    var startDate = new Date(${booking.startDate});
    var endDate = new Date(${booking.endDate});
    var timeDiff = endDate.getTime() - startDate.getTime();
    var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
    $('#bookingDuration span').text(daysDiff);
});
</script>

<jsp:include page="../common/footer.jsp" />
