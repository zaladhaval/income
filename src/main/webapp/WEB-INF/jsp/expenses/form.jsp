<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="${isEdit ? 'Edit Expense' : 'Add New Expense'}" />
<c:set var="pageActions">
    <a href="/expenses" class="btn btn-secondary">
        <i class="fas fa-arrow-left me-1"></i>Back to Expenses
    </a>
</c:set>

<jsp:include page="../common/header.jsp" />

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-${isEdit ? 'edit' : 'plus'} me-2"></i>
                    ${isEdit ? 'Edit Expense' : 'Add New Expense'}
                </h5>
            </div>
            <div class="card-body">
                <form:form modelAttribute="expense" method="post"
                          action="${isEdit ? '/expenses/'.concat(expense.id) : '/expenses'}"
                          id="expenseForm" class="needs-validation" novalidate="true">
                    
                    <div class="row">
                        <!-- Expense Name -->
                        <div class="col-md-6 mb-3">
                            <label for="name" class="form-label">Expense Name <span class="text-danger">*</span></label>
                            <form:input path="name" class="form-control" id="name" 
                                       placeholder="Enter expense name" required="true" maxlength="100" />
                            <form:errors path="name" class="invalid-feedback d-block" />
                        </div>
                        
                        <!-- Category -->
                        <div class="col-md-6 mb-3">
                            <label for="category" class="form-label">Category</label>
                            <div class="input-group">
                                <form:input path="category" class="form-control" id="category" 
                                           placeholder="Enter or select category" maxlength="50" list="categoryList" />
                                <datalist id="categoryList">
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat}">
                                    </c:forEach>
                                    <option value="Fuel">
                                    <option value="Maintenance">
                                    <option value="Insurance">
                                    <option value="Office">
                                    <option value="Marketing">
                                    <option value="Utilities">
                                    <option value="Other">
                                </datalist>
                            </div>
                            <form:errors path="category" class="invalid-feedback d-block" />
                        </div>
                    </div>
                    
                    <div class="row">
                        <!-- Expense Date -->
                        <div class="col-md-6 mb-3">
                            <label for="expenseDateStr" class="form-label">Expense Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="expenseDateStr" name="expenseDateStr"
                                   value="${isEdit ? dateUtils.formatShortDate(expense.expenseDate) : ''}"
                                   required />
                            <form:hidden path="expenseDate" id="expenseDate" />
                            <form:errors path="expenseDate" class="invalid-feedback d-block" />
                        </div>
                        
                        <!-- Amount -->
                        <div class="col-md-6 mb-3">
                            <label for="amount" class="form-label">Amount <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">₹</span>
                                <form:input path="amount" type="number" step="0.01" min="0.01"
                                           class="form-control" id="amount"
                                           placeholder="0.00" required="true" />
                            </div>
                            <form:errors path="amount" class="invalid-feedback d-block" />
                        </div>
                    </div>
                    
                    <!-- Description -->
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <form:textarea path="description" class="form-control" id="description" rows="3" 
                                      placeholder="Enter expense description (optional)" maxlength="255" />
                        <form:errors path="description" class="invalid-feedback d-block" />
                        <div class="form-text">Maximum 255 characters</div>
                    </div>
                    
                    <!-- Form Actions -->
                    <div class="d-flex justify-content-between">
                        <a href="/expenses" class="btn btn-secondary">
                            <i class="fas fa-times me-1"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>
                            ${isEdit ? 'Update Expense' : 'Create Expense'}
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
        $('#expenseForm').on('submit', function(e) {
            if (!this.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            }
            $(this).addClass('was-validated');
        });
        
        // Character counter for description
        $('#description').on('input', function() {
            const maxLength = 255;
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
        
        // Date conversion (validation removed as per requirements)
        $('#expenseDateStr').on('change', function() {
            const selectedDate = new Date($(this).val());
            // Convert date string to timestamp for the hidden field
            const timestamp = selectedDate.getTime();
            $('#expenseDate').val(timestamp);
        });
        
        // Amount validation
        $('#amount').on('input', function() {
            const amount = parseFloat($(this).val());
            
            if (amount <= 0) {
                $(this).addClass('is-invalid');
                $(this).siblings('.invalid-feedback').text('Amount must be greater than 0');
            } else {
                $(this).removeClass('is-invalid');
            }
        });
        
        // Real-time validation feedback
        $('.form-control, .form-select').on('blur', function() {
            if ($(this).is(':invalid')) {
                $(this).addClass('is-invalid');
            } else {
                $(this).removeClass('is-invalid');
                $(this).addClass('is-valid');
            }
        });
        
        // Set default date to today if creating new expense
        if (!${isEdit}) {
            const today = new Date().toISOString().split('T')[0];
            $('#expenseDateStr').val(today);
            $('#expenseDate').val(new Date().getTime());
        }

        // Initialize the hidden field on page load if editing
        <c:if test="${isEdit}">
            const initialDate = new Date('${dateUtils.formatShortDate(expense.expenseDate)}');
            if (!isNaN(initialDate.getTime())) {
                $('#expenseDate').val(initialDate.getTime());
            }
        </c:if>
        
        // Focus on first input
        $('#name').focus();
    });
</script>

<jsp:include page="../common/footer.jsp" />
