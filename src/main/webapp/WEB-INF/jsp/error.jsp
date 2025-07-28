<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Car Rental Management System</title>
    
    <!-- Bootstrap CSS -->
    <link href="/webjars/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .error-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 600px;
            width: 90%;
        }
        
        .error-icon {
            color: #dc3545;
            font-size: 5rem;
            margin-bottom: 1.5rem;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .error-code {
            font-size: 4rem;
            font-weight: bold;
            color: #495057;
            margin-bottom: 1rem;
        }
        
        .error-message {
            font-size: 1.2rem;
            color: #6c757d;
            margin-bottom: 2rem;
        }
        
        .btn-home {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            color: white;
        }
        
        .error-details {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 2rem;
            text-align: left;
        }
        
        .error-details h6 {
            color: #495057;
            margin-bottom: 1rem;
        }
        
        .error-details code {
            background: #e9ecef;
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        
        <div class="error-code">
            <c:choose>
                <c:when test="${not empty status}">
                    ${status}
                </c:when>
                <c:otherwise>
                    Error
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="error-message">
            <c:choose>
                <c:when test="${not empty error}">
                    ${error}
                </c:when>
                <c:when test="${not empty message}">
                    ${message}
                </c:when>
                <c:when test="${status == 404}">
                    <h4>Page Not Found</h4>
                    <p>The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
                </c:when>
                <c:when test="${status == 403}">
                    <h4>Access Forbidden</h4>
                    <p>You don't have permission to access this resource. Please contact your administrator if you believe this is an error.</p>
                </c:when>
                <c:when test="${status == 500}">
                    <h4>Internal Server Error</h4>
                    <p>Something went wrong on our end. We're working to fix this issue. Please try again later.</p>
                </c:when>
                <c:otherwise>
                    <h4>Oops! Something went wrong</h4>
                    <p>We encountered an unexpected error while processing your request. Please try again or contact support if the problem persists.</p>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="mb-3">
            <a href="/dashboard" class="btn-home">
                <i class="fas fa-home me-2"></i>Go to Dashboard
            </a>
        </div>
        
        <div class="mb-2">
            <a href="javascript:history.back()" class="text-muted text-decoration-none">
                <i class="fas fa-arrow-left me-1"></i>Go Back
            </a>
        </div>
        
        <!-- Error Details (for development/debugging) -->
        <c:if test="${not empty trace or not empty path or not empty timestamp}">
            <div class="error-details">
                <h6><i class="fas fa-info-circle me-2"></i>Error Details</h6>
                
                <c:if test="${not empty timestamp}">
                    <p><strong>Timestamp:</strong> <code><fmt:formatDate value="${timestamp}" pattern="yyyy-MM-dd HH:mm:ss" /></code></p>
                </c:if>
                
                <c:if test="${not empty path}">
                    <p><strong>Path:</strong> <code>${path}</code></p>
                </c:if>
                
                <c:if test="${not empty exception}">
                    <p><strong>Exception:</strong> <code>${exception}</code></p>
                </c:if>
                
                <!-- Only show trace in development mode -->
                <c:if test="${not empty trace and param.debug == 'true'}">
                    <details>
                        <summary><strong>Stack Trace</strong> (Click to expand)</summary>
                        <pre class="mt-2" style="font-size: 0.8rem; max-height: 200px; overflow-y: auto;">${trace}</pre>
                    </details>
                </c:if>
            </div>
        </c:if>
        
        <div class="mt-3">
            <small class="text-muted">
                <i class="fas fa-car me-1"></i>Car Rental Management System
            </small>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="/webjars/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Auto-refresh after 30 seconds for 5xx errors
        <c:if test="${status >= 500}">
            setTimeout(function() {
                if (confirm('Would you like to refresh the page and try again?')) {
                    window.location.reload();
                }
            }, 30000);
        </c:if>
        
        // Log error details to console for debugging
        console.error('Error Details:', {
            status: '${status}',
            error: '${error}',
            message: '${message}',
            path: '${path}',
            timestamp: '${timestamp}'
        });
    </script>
</body>
</html>
