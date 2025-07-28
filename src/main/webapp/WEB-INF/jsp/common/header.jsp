<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Car Rental Management System</title>
    
    <!-- Bootstrap CSS -->
    <link href="/webjars/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <style>
        .navbar-brand {
            font-weight: bold;
        }
        .sidebar {
            min-height: calc(100vh - 56px);
            background-color: #f8f9fa;
        }
        .main-content {
            min-height: calc(100vh - 56px);
        }
        .card-stats {
            border-left: 4px solid #007bff;
        }
        .card-stats.success {
            border-left-color: #28a745;
        }
        .card-stats.warning {
            border-left-color: #ffc107;
        }
        .card-stats.danger {
            border-left-color: #dc3545;
        }
        .table-responsive {
            border-radius: 0.375rem;
        }
        .btn-group-sm > .btn, .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        .search-form {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 0.375rem;
            margin-bottom: 1rem;
        }
        .status-badge {
            font-size: 0.75rem;
        }
        .footer {
            background-color: #f8f9fa;
            padding: 1rem 0;
            margin-top: 2rem;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="/dashboard">
                <i class="fas fa-car me-2"></i>Car Rental System
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <sec:authorize access="hasAnyRole('ADMIN', 'TECHNICAL')">
                        <li class="nav-item">
                            <a class="nav-link" href="/dashboard">
                                <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/cars">
                                <i class="fas fa-car me-1"></i>Cars
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/bookings">
                                <i class="fas fa-calendar-check me-1"></i>Bookings
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/expenses">
                                <i class="fas fa-receipt me-1"></i>Expenses
                            </a>
                        </li>
                    </sec:authorize>
                    
                    <sec:authorize access="hasRole('ADMIN')">
                        <li class="nav-item">
                            <a class="nav-link" href="/customers">
                                <i class="fas fa-users me-1"></i>Customers
                            </a>
                        </li>
                    </sec:authorize>
                    
                    <sec:authorize access="hasRole('CUSTOMER')">
                        <li class="nav-item">
                            <a class="nav-link" href="/my-bookings">
                                <i class="fas fa-calendar-check me-1"></i>My Bookings
                            </a>
                        </li>
                    </sec:authorize>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user me-1"></i>
                            <sec:authentication property="name" />
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/profile">
                                <i class="fas fa-user-edit me-2"></i>Profile
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="/logout" method="post" class="d-inline">
                                    <button type="submit" class="dropdown-item">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar (only for admin and technical users) -->
            <sec:authorize access="hasAnyRole('ADMIN', 'TECHNICAL')">
                <nav class="col-md-2 d-none d-md-block sidebar">
                    <div class="position-sticky pt-3">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link ${pageTitle == 'Dashboard' ? 'active' : ''}" href="/dashboard">
                                    <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link ${pageTitle == 'Cars' ? 'active' : ''}" href="/cars">
                                    <i class="fas fa-car me-2"></i>Cars
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link ${pageTitle == 'Bookings' ? 'active' : ''}" href="/bookings">
                                    <i class="fas fa-calendar-check me-2"></i>Bookings
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link ${pageTitle == 'Expenses' ? 'active' : ''}" href="/expenses">
                                    <i class="fas fa-receipt me-2"></i>Expenses
                                </a>
                            </li>
                            <sec:authorize access="hasRole('ADMIN')">
                                <li class="nav-item">
                                    <a class="nav-link ${pageTitle == 'Customers' ? 'active' : ''}" href="/customers">
                                        <i class="fas fa-users me-2"></i>Customers
                                    </a>
                                </li>
                            </sec:authorize>
                        </ul>
                    </div>
                </nav>
            </sec:authorize>

            <!-- Main Content -->
            <main class="col-md-10 ms-sm-auto col-lg-10 px-md-4 main-content">
                <div class="pt-3">
                    <!-- Page Header -->
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
                        <h1 class="h2">${pageTitle}</h1>
                        <c:if test="${not empty pageActions}">
                            <div class="btn-toolbar mb-2 mb-md-0">
                                ${pageActions}
                            </div>
                        </c:if>
                    </div>

                    <!-- Alert Messages -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty warningMessage}">
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${warningMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty infoMessage}">
                        <div class="alert alert-info alert-dismissible fade show" role="alert">
                            <i class="fas fa-info-circle me-2"></i>${infoMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Page Content -->
