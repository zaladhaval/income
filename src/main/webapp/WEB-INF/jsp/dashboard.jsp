<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rental.util.DateUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="pageTitle" value="Dashboard" />
<c:set var="pageActions">
    <sec:authorize access="hasAnyRole('ADMIN', 'TECHNICAL')">
        <div class="btn-group" role="group">
            <a href="/cars/new" class="btn btn-primary btn-sm">
                <i class="fas fa-plus me-1"></i>Add Car
            </a>
            <a href="/bookings/new" class="btn btn-success btn-sm">
                <i class="fas fa-calendar-plus me-1"></i>New Booking
            </a>
            <a href="/expenses/new" class="btn btn-warning btn-sm">
                <i class="fas fa-receipt me-1"></i>Add Expense
            </a>
        </div>
    </sec:authorize>
</c:set>

<jsp:include page="common/header.jsp" />

<sec:authorize access="hasAnyRole('ADMIN', 'TECHNICAL')">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card card-stats success">
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <h5 class="card-title text-uppercase text-muted mb-0">Total Earnings</h5>
                            <span class="h2 font-weight-bold mb-0">
                                ₹<fmt:formatNumber value="${dashboardStats.totalEarnings}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                            </span>
                        </div>
                        <div class="col-auto">
                            <div class="icon icon-shape bg-success text-white rounded-circle shadow">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card card-stats">
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <h5 class="card-title text-uppercase text-muted mb-0">Monthly Earnings</h5>
                            <span class="h2 font-weight-bold mb-0">
                                ₹<fmt:formatNumber value="${dashboardStats.monthlyEarnings}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                            </span>
                        </div>
                        <div class="col-auto">
                            <div class="icon icon-shape bg-primary text-white rounded-circle shadow">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card card-stats warning">
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <h5 class="card-title text-uppercase text-muted mb-0">Monthly Expenses</h5>
                            <span class="h2 font-weight-bold mb-0">
                                ₹<fmt:formatNumber value="${dashboardStats.monthlyExpenses}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                            </span>
                        </div>
                        <div class="col-auto">
                            <div class="icon icon-shape bg-warning text-white rounded-circle shadow">
                                <i class="fas fa-receipt"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card card-stats ${dashboardStats.netMonthlyProfit >= 0 ? 'success' : 'danger'}">
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <h5 class="card-title text-uppercase text-muted mb-0">Net Monthly Profit</h5>
                            <span class="h2 font-weight-bold mb-0">
                                ₹<fmt:formatNumber value="${dashboardStats.netMonthlyProfit}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                            </span>
                        </div>
                        <div class="col-auto">
                            <div class="icon icon-shape ${dashboardStats.netMonthlyProfit >= 0 ? 'bg-success' : 'bg-danger'} text-white rounded-circle shadow">
                                <i class="fas fa-chart-line"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- System Overview Cards -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card">
                <div class="card-body text-center">
                    <i class="fas fa-car fa-2x text-primary mb-2"></i>
                    <h5 class="card-title">Total Cars</h5>
                    <h3 class="text-primary">${dashboardStats.totalCars}</h3>
                    <small class="text-muted">${dashboardStats.availableCars} available</small>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card">
                <div class="card-body text-center">
                    <i class="fas fa-users fa-2x text-success mb-2"></i>
                    <h5 class="card-title">Total Customers</h5>
                    <h3 class="text-success">${dashboardStats.totalCustomers}</h3>
                    <small class="text-muted">Active users</small>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card">
                <div class="card-body text-center">
                    <i class="fas fa-calendar-check fa-2x text-info mb-2"></i>
                    <h5 class="card-title">Total Bookings</h5>
                    <h3 class="text-info">${dashboardStats.totalBookings}</h3>
                    <small class="text-muted">All time</small>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card">
                <div class="card-body text-center">
                    <i class="fas fa-percentage fa-2x text-warning mb-2"></i>
                    <h5 class="card-title">Utilization Rate</h5>
                    <h3 class="text-warning">
                        <fmt:formatNumber value="${(dashboardStats.totalCars - dashboardStats.availableCars) / dashboardStats.totalCars * 100}" 
                                          maxFractionDigits="1" />%
                    </h3>
                    <small class="text-muted">Cars in use</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts and Tables Row -->
    <div class="row">
        <!-- Earnings by Car This Month -->
        <div class="col-xl-6 col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-car me-2"></i>Earnings by Car (This Month)
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty dashboardStats.monthlyCarPerformance}">
                            <div class="table-responsive">
                                <table class="table table-sm">
                                    <thead>
                                        <tr>
                                            <th>Car Name</th>
                                            <th class="text-end">Monthly Earnings</th>
                                            <th width="40%">Performance</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${dashboardStats.monthlyCarPerformance}" var="carEarning" varStatus="status">
                                            <c:if test="${status.index < 10}">
                                                <tr>
                                                    <td>${carEarning.carName}</td>
                                                    <td class="text-end">
                                                        ₹<fmt:formatNumber value="${carEarning.totalEarnings}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                                                    </td>
                                                    <td>
                                                        <div class="progress" style="height: 20px;">
                                                            <div class="progress-bar bg-success"
                                                                 role="progressbar"
                                                                 style="width: ${carEarning.totalEarnings / dashboardStats.monthlyCarPerformance[0].totalEarnings * 100}%">
                                                                <fmt:formatNumber value="${carEarning.totalEarnings / dashboardStats.monthlyCarPerformance[0].totalEarnings * 100}"
                                                                                  maxFractionDigits="1" />%
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-car fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No monthly earnings data available</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Earnings by Car Chart (All Time) -->
        <div class="col-xl-6 col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-chart-bar me-2"></i>Earnings by Car (All Time)
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty dashboardStats.earningsByCar}">
                            <div class="table-responsive">
                                <table class="table table-sm">
                                    <thead>
                                        <tr>
                                            <th>Car Name</th>
                                            <th class="text-end">Total Earnings</th>
                                            <th width="40%">Performance</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${dashboardStats.earningsByCar}" var="carEarning" varStatus="status">
                                            <c:if test="${status.index < 10}">
                                                <tr>
                                                    <td>${carEarning.carName}</td>
                                                    <td class="text-end">
                                                        ₹<fmt:formatNumber value="${carEarning.totalEarnings}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                                                    </td>
                                                    <td>
                                                        <div class="progress" style="height: 20px;">
                                                            <div class="progress-bar bg-primary"
                                                                 role="progressbar"
                                                                 style="width: ${carEarning.totalEarnings / dashboardStats.earningsByCar[0].totalEarnings * 100}%">
                                                                <fmt:formatNumber value="${carEarning.totalEarnings / dashboardStats.earningsByCar[0].totalEarnings * 100}"
                                                                                  maxFractionDigits="1" />%
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-chart-bar fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No earnings data available</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Bookings Row -->
    <div class="row mt-4">
        <!-- Recent Bookings -->
        <div class="col-xl-4 col-lg-5">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-clock me-2"></i>Recent Bookings
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty recentBookings}">
                            <c:forEach items="${recentBookings}" var="booking">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="flex-shrink-0">
                                        <span class="badge bg-${booking.bookingStatus == 'COMPLETED' ? 'success' : 
                                                                booking.bookingStatus == 'CONFIRMED' ? 'primary' : 
                                                                booking.bookingStatus == 'PENDING' ? 'warning' : 'danger'} 
                                                     status-badge">
                                            ${booking.bookingStatus}
                                        </span>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-0">${booking.car.name}</h6>
                                        <small class="text-muted">
                                            ${booking.customer.name} •
                                            <fmt:formatDate value="${dateUtils.timestampToDate(booking.startDate)}" pattern="MMM dd" />
                                        </small>
                                    </div>
                                    <div class="flex-shrink-0">
                                        <strong>₹<fmt:formatNumber value="${booking.earningAmount}" type="number" maxFractionDigits="2" minFractionDigits="2" /></strong>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="text-center mt-3">
                                <a href="/bookings" class="btn btn-outline-primary btn-sm">
                                    View All Bookings
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                <p class="text-muted">No recent bookings</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Monthly Car Performance -->
    <c:if test="${not empty dashboardStats.monthlyCarPerformance}">
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-trophy me-2"></i>Current Month Car Performance
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Rank</th>
                                        <th>Car Name</th>
                                        <th class="text-end">Monthly Earnings</th>
                                        <th width="30%">Performance</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${dashboardStats.monthlyCarPerformance}" var="carPerformance" varStatus="status">
                                        <tr>
                                            <td>
                                                <span class="badge bg-${status.index == 0 ? 'warning' : status.index == 1 ? 'secondary' : status.index == 2 ? 'dark' : 'light text-dark'}">
                                                    #${status.index + 1}
                                                </span>
                                            </td>
                                            <td>${carPerformance.carName}</td>
                                            <td class="text-end">
                                                ₹<fmt:formatNumber value="${carPerformance.totalEarnings}" type="number" maxFractionDigits="2" minFractionDigits="2" />
                                            </td>
                                            <td>
                                                <div class="progress" style="height: 20px;">
                                                    <div class="progress-bar bg-success" 
                                                         role="progressbar" 
                                                         style="width: ${carPerformance.totalEarnings / dashboardStats.monthlyCarPerformance[0].totalEarnings * 100}%">
                                                        <fmt:formatNumber value="${carPerformance.totalEarnings / dashboardStats.monthlyCarPerformance[0].totalEarnings * 100}" 
                                                                          maxFractionDigits="1" />%
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</sec:authorize>

<!-- Customer Dashboard -->
<sec:authorize access="hasRole('CUSTOMER')">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body text-center py-5">
                    <i class="fas fa-user-circle fa-4x text-primary mb-4"></i>
                    <h3>Welcome, <sec:authentication property="name" />!</h3>
                    <p class="lead text-muted mb-4">
                        Manage your car rental bookings and view your rental history.
                    </p>
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <a href="/my-bookings" class="btn btn-primary btn-lg w-100">
                                        <i class="fas fa-calendar-check me-2"></i>
                                        My Bookings
                                    </a>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <a href="/profile" class="btn btn-outline-primary btn-lg w-100">
                                        <i class="fas fa-user-edit me-2"></i>
                                        Update Profile
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</sec:authorize>

<jsp:include page="common/footer.jsp" />
