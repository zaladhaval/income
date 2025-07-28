<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Dashboard Statistics Fragment -->
<c:if test="${not empty stats}">
    <div class="row">
        <div class="col-md-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">
                                ₹<fmt:formatNumber value="${stats.totalEarnings}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                            </h4>
                            <p class="mb-0">Total Earnings</p>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-rupee-sign fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">
                                ₹<fmt:formatNumber value="${stats.monthlyEarnings}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                            </h4>
                            <p class="mb-0">Monthly Earnings</p>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-chart-line fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-warning text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">
                                ₹<fmt:formatNumber value="${stats.monthlyExpenses}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                            </h4>
                            <p class="mb-0">Monthly Expenses</p>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-receipt fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">
                                <fmt:formatNumber value="${stats.netMonthlyProfit}" type="currency" />
                            </h4>
                            <p class="mb-0">Net Profit</p>
                        </div>
                        <div class="align-self-center">
                            <i class="fas fa-chart-pie fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-3">
        <div class="col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h3 class="text-primary">${stats.totalCars}</h3>
                    <p class="mb-0">Total Cars</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h3 class="text-success">${stats.availableCars}</h3>
                    <p class="mb-0">Available Cars</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h3 class="text-info">${stats.totalCustomers}</h3>
                    <p class="mb-0">Total Customers</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h3 class="text-warning">${stats.totalBookings}</h3>
                    <p class="mb-0">Total Bookings</p>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i>
        ${errorMessage}
    </div>
</c:if>
