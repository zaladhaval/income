<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="${isEdit ? 'Edit Car' : 'Add New Car'}" />
<c:set var="pageActions">
    <a href="/cars" class="btn btn-secondary">
        <i class="fas fa-arrow-left me-1"></i>Back to Cars
    </a>
</c:set>

<jsp:include page="../common/header.jsp" />

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-${isEdit ? 'edit' : 'plus'} me-2"></i>
                    ${isEdit ? 'Edit Car' : 'Add New Car'}
                </h5>
            </div>
            <div class="card-body">
                <form:form modelAttribute="car" method="post" 
                          action="${isEdit ? '/cars/' += car.id : '/cars'}" 
                          id="carForm" class="needs-validation" novalidate="true">
                    
                    <div class="row">
                        <!-- Car Name -->
                        <div class="col-md-6 mb-3">
                            <label for="name" class="form-label">Car Name <span class="text-danger">*</span></label>
                            <form:input path="name" class="form-control" id="name" 
                                       placeholder="Enter car name" required="true" maxlength="100" />
                            <form:errors path="name" class="invalid-feedback d-block" />
                        </div>
                        
                        <!-- Company -->
                        <div class="col-md-6 mb-3">
                            <label for="company" class="form-label">Company <span class="text-danger">*</span></label>
                            <form:input path="company" class="form-control" id="company" 
                                       placeholder="Enter company name" required="true" maxlength="50" />
                            <form:errors path="company" class="invalid-feedback d-block" />
                        </div>
                    </div>
                    
                    <div class="row">
                        <!-- Color -->
                        <div class="col-md-6 mb-3">
                            <label for="color" class="form-label">Color <span class="text-danger">*</span></label>
                            <form:input path="color" class="form-control" id="color" 
                                       placeholder="Enter car color" required="true" maxlength="30" />
                            <form:errors path="color" class="invalid-feedback d-block" />
                        </div>
                        
                        <!-- Listing ID -->
                        <div class="col-md-6 mb-3">
                            <label for="listingId" class="form-label">Listing ID <span class="text-danger">*</span></label>
                            <form:input path="listingId" class="form-control" id="listingId" 
                                       placeholder="Enter unique listing ID" required="true" maxlength="50" />
                            <form:errors path="listingId" class="invalid-feedback d-block" />
                            <div class="form-text">Must be unique across all cars</div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <!-- Date of Purchase -->
                        <div class="col-md-6 mb-3">
                            <label for="dateOfPurchaseStr" class="form-label">Date of Purchase <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="dateOfPurchaseStr" name="dateOfPurchaseStr"
                                   value="${isEdit ? dateUtils.formatShortDate(car.dateOfPurchase) : ''}"
                                   required max="${dateUtils.formatShortDate(System.currentTimeMillis())}">
                            <form:hidden path="dateOfPurchase"/>
                            <div class="invalid-feedback">
                                Please provide a valid purchase date.
                            </div>
                        </div>
                        
                        <!-- Fuel Type -->
                        <div class="col-md-6 mb-3">
                            <label for="fuelType" class="form-label">Fuel Type <span class="text-danger">*</span></label>
                            <form:select path="fuelType" class="form-select" id="fuelType" required="true">
                                <option value="">Select fuel type</option>
                                <c:forEach items="${fuelTypes}" var="type">
                                    <form:option value="${type}">${type.displayName}</form:option>
                                </c:forEach>
                            </form:select>
                            <form:errors path="fuelType" class="invalid-feedback d-block" />
                        </div>
                    </div>
                    
                    <div class="row">
                        <!-- Gear Type -->
                        <div class="col-md-6 mb-3">
                            <label for="gearType" class="form-label">Gear Type <span class="text-danger">*</span></label>
                            <form:select path="gearType" class="form-select" id="gearType" required="true">
                                <option value="">Select gear type</option>
                                <c:forEach items="${gearTypes}" var="type">
                                    <form:option value="${type}">${type.displayName}</form:option>
                                </c:forEach>
                            </form:select>
                            <form:errors path="gearType" class="invalid-feedback d-block" />
                        </div>
                        
                        <!-- Availability -->
                        <c:if test="${isEdit}">
                            <div class="col-md-6 mb-3">
                                <label for="isAvailable" class="form-label">Availability</label>
                                <div class="form-check form-switch mt-2">
                                    <form:checkbox path="isAvailable" class="form-check-input" id="isAvailable" />
                                    <label class="form-check-label" for="isAvailable">
                                        Car is available for booking
                                    </label>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    
                    <!-- Description -->
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <form:textarea path="description" class="form-control" id="description" rows="3" 
                                      placeholder="Enter car description (optional)" maxlength="500" />
                        <form:errors path="description" class="invalid-feedback d-block" />
                        <div class="form-text">Maximum 500 characters</div>
                    </div>
                    
                    <!-- Form Actions -->
                    <div class="d-flex justify-content-between">
                        <a href="/cars" class="btn btn-secondary">
                            <i class="fas fa-times me-1"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>
                            ${isEdit ? 'Update Car' : 'Create Car'}
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<!-- Custom JavaScript for this page -->
<script>
    $(document).ready(function() {
        // Form validation
        $('#carForm').on('submit', function(e) {
            if (!this.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            }
            $(this).addClass('was-validated');
        });
        
        // Character counter for description
        $('#description').on('input', function() {
            const maxLength = 500;
            const currentLength = $(this).val().length;
            const remaining = maxLength - currentLength;
            
            let counterText = remaining + ' characters remaining';
            if (remaining < 0) {
                counterText = Math.abs(remaining) + ' characters over limit';
            }
            
            $(this).siblings('.form-text').text(counterText);
            
            if (remaining < 0) {
                $(this).addClass('is-invalid');
            } else {
                $(this).removeClass('is-invalid');
            }
        });
        
        // Auto-generate listing ID based on company and name
        $('#company, #name').on('input', function() {
            if (!${isEdit} && $('#company').val() && $('#name').val()) {
                const company = $('#company').val().substring(0, 3).toUpperCase();
                const name = $('#name').val().substring(0, 3).toUpperCase();
                const random = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
                const listingId = company + '-' + name + '-' + random;
                $('#listingId').val(listingId);
            }
        });
        
        // Date validation and conversion
        $('#dateOfPurchaseStr').on('change', function() {
            const selectedDate = new Date($(this).val());
            const today = new Date();

            if (selectedDate > today) {
                $(this).addClass('is-invalid');
                $(this).siblings('.invalid-feedback').text('Purchase date cannot be in the future');
            } else {
                $(this).removeClass('is-invalid');
                // Convert date string to timestamp for the hidden field
                const timestamp = selectedDate.getTime();
                $('#dateOfPurchase').val(timestamp);
            }
        });

        // Initialize the hidden field on page load if editing
        <c:if test="${isEdit}">
            const initialDate = new Date('${dateUtils.formatShortDate(car.dateOfPurchase)}');
            if (!isNaN(initialDate.getTime())) {
                $('#dateOfPurchase').val(initialDate.getTime());
            }
        </c:if>
        
        // Real-time validation feedback
        $('.form-control, .form-select').on('blur', function() {
            if ($(this).is(':invalid')) {
                $(this).addClass('is-invalid');
            } else {
                $(this).removeClass('is-invalid');
                $(this).addClass('is-valid');
            }
        });
        
        // Focus on first input
        $('#name').focus();
    });
</script>

<jsp:include page="../common/footer.jsp" />
