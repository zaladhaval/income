<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="pageTitle" value="${isEdit ? 'Edit Booking' : 'New Booking'}" />
<c:set var="pageActions">
    <a href="/bookings" class="btn btn-secondary btn-sm">
        <i class="fas fa-arrow-left me-1"></i>Back to Bookings
    </a>
</c:set>

<jsp:include page="../common/header.jsp" />

<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-calendar-plus me-2"></i>
                        ${isEdit ? 'Edit Booking' : 'Create New Booking'}
                    </h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form:form method="post" modelAttribute="booking" class="needs-validation" novalidate="true">
                        <c:if test="${isEdit}">
                            <form:hidden path="bookingId"/>
                            <form:hidden path="createdDate"/>
                        </c:if>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="carId" class="form-label">
                                        <i class="fas fa-car me-1"></i>Car <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" id="carId" name="carId" required>
                                        <option value="">Select a car...</option>
                                        <c:forEach var="car" items="${cars}">
                                            <option value="${car.id}"
                                                ${(isEdit and booking.car.id == car.id) or param.carId == car.id ? 'selected' : ''}>
                                                ${car.name} - ${car.company} (${car.listingId})
                                                ${car.isAvailable ? '' : ' - Not Available'}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a car.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="customerId" class="form-label">
                                        <i class="fas fa-user me-1"></i>Customer <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" id="customerId" name="customerId" required>
                                        <option value="">Select a customer...</option>
                                        <c:forEach var="customer" items="${customers}">
                                            <option value="${customer.id}" 
                                                ${(isEdit and booking.customer.id == customer.id) or param.customerId == customer.id ? 'selected' : ''}>
                                                ${customer.name} (${customer.email})
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a customer.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="startDate" class="form-label">
                                        <i class="fas fa-calendar-alt me-1"></i>Start Date <span class="text-danger">*</span>
                                    </label>
                                    <input type="date" class="form-control" id="startDate"
                                           value="${isEdit ? dateUtils.formatShortDate(booking.startDate) : ''}"
                                           required>
                                    <form:hidden path="startDate" id="startDateHidden" />
                                    <div class="invalid-feedback">
                                        Please provide a valid start date.
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="endDate" class="form-label">
                                        <i class="fas fa-calendar-alt me-1"></i>End Date <span class="text-danger">*</span>
                                    </label>
                                    <input type="date" class="form-control" id="endDate"
                                           value="${isEdit ? dateUtils.formatShortDate(booking.endDate) : ''}"
                                           required>
                                    <form:hidden path="endDate" id="endDateHidden" />
                                    <div class="invalid-feedback">
                                        Please provide a valid end date.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="earningAmount" class="form-label">
                                        <i class="fas fa-dollar-sign me-1"></i>Daily Rate <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <form:input path="earningAmount" class="form-control" type="number" 
                                                   step="0.01" min="0" required="true" placeholder="0.00"/>
                                        <div class="invalid-feedback">
                                            Please provide a valid daily rate.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <c:if test="${isEdit}">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="bookingStatus" class="form-label">
                                            <i class="fas fa-info-circle me-1"></i>Status
                                        </label>
                                        <form:select path="bookingStatus" class="form-select">
                                            <c:forEach var="status" items="${bookingStatuses}">
                                                <form:option value="${status}" label="${status}"/>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <c:if test="${isEdit}">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="totalEarning" class="form-label">
                                            <i class="fas fa-calculator me-1"></i>Total Earning
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <form:input path="totalEarning" class="form-control" type="number" 
                                                       step="0.01" min="0" placeholder="Auto-calculated"/>
                                        </div>
                                        <small class="form-text text-muted">
                                            Leave empty for auto-calculation based on duration and daily rate.
                                        </small>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="amountCreditedDate" class="form-label">
                                            <i class="fas fa-credit-card me-1"></i>Amount Credited Date
                                        </label>
                                        <input type="date" class="form-control" id="amountCreditedDate" name="amountCreditedDate" 
                                               value="${(isEdit and booking.amountCreditedDate > 0) ? dateUtils.formatShortDate(booking.amountCreditedDate) : ''}">
                                        <small class="form-text text-muted">
                                            Leave empty if amount is not yet credited.
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <div class="row">
                            <div class="col-12">
                                <div class="d-flex justify-content-between">
                                    <a href="/bookings" class="btn btn-secondary">
                                        <i class="fas fa-times me-1"></i>Cancel
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-1"></i>
                                        ${isEdit ? 'Update Booking' : 'Create Booking'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Form validation
(function() {
    'use strict';
    window.addEventListener('load', function() {
        var forms = document.getElementsByClassName('needs-validation');
        var validation = Array.prototype.filter.call(forms, function(form) {
            form.addEventListener('submit', function(event) {
                if (form.checkValidity() === false) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }, false);
})();

// Date handling (validation removed as per requirements)
document.getElementById('startDate').addEventListener('change', function() {
    const selectedDate = new Date(this.value);
    const timestamp = selectedDate.getTime();
    document.getElementById('startDateHidden').value = timestamp;
});

document.getElementById('endDate').addEventListener('change', function() {
    const selectedDate = new Date(this.value);
    const timestamp = selectedDate.getTime();
    document.getElementById('endDateHidden').value = timestamp;
});

// Initialize hidden fields on page load
<c:if test="${isEdit}">
    const startDate = new Date('${dateUtils.formatShortDate(booking.startDate)}');
    if (!isNaN(startDate.getTime())) {
        document.getElementById('startDateHidden').value = startDate.getTime();
    }

    const endDate = new Date('${dateUtils.formatShortDate(booking.endDate)}');
    if (!isNaN(endDate.getTime())) {
        document.getElementById('endDateHidden').value = endDate.getTime();
    }
</c:if>

// Initialize hidden fields when user selects dates for new bookings
document.addEventListener('DOMContentLoaded', function() {
    // Initialize with current values if they exist
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');

    if (startDateInput.value) {
        const startDate = new Date(startDateInput.value);
        document.getElementById('startDateHidden').value = startDate.getTime();
    }

    if (endDateInput.value) {
        const endDate = new Date(endDateInput.value);
        document.getElementById('endDateHidden').value = endDate.getTime();
    }
});

// Auto-calculate total earning
function calculateTotal() {
    var startDate = document.getElementById('startDate').value;
    var endDate = document.getElementById('endDate').value;
    var dailyRate = parseFloat(document.getElementById('earningAmount').value) || 0;
    
    if (startDate && endDate && dailyRate > 0) {
        var start = new Date(startDate);
        var end = new Date(endDate);
        var timeDiff = end.getTime() - start.getTime();
        var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
        
        if (daysDiff > 0) {
            var total = daysDiff * dailyRate;
            var totalEarningInput = document.getElementById('totalEarning');
            if (totalEarningInput) {
                totalEarningInput.value = total.toFixed(2);
            }
        }
    }
}

document.getElementById('startDate').addEventListener('change', calculateTotal);
document.getElementById('endDate').addEventListener('change', calculateTotal);
document.getElementById('earningAmount').addEventListener('input', calculateTotal);
</script>

<jsp:include page="../common/footer.jsp" />
