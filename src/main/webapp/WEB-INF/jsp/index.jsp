<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Car Rental - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Car Rental Application" name="description" />
    <meta content="Car Rental" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
    <!-- App favicon -->
    <link rel="shortcut icon" href="/static/assets/images/favicon.ico">

    <!-- App css -->
    <link href="/static/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/static/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="/static/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('/static/assets/images/hero-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        
        .feature-box {
            padding: 30px;
            text-align: center;
            border-radius: 5px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            height: 100%;
        }
        
        .feature-box:hover {
            transform: translateY(-10px);
        }
        
        .feature-icon {
            font-size: 40px;
            margin-bottom: 20px;
            color: #3bafda;
        }
    </style>
</head>

<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/">Car Rental</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/carview">Cars</a>
                    </li>
                    <li class="nav-item" id="bookings-nav" style="display: none;">
                        <a class="nav-link" href="/bookings">My Bookings</a>
                    </li>
                    <li class="nav-item" id="dashboard-nav" style="display: none;">
                        <a class="nav-link" href="/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item" id="login-nav">
                        <a class="nav-link" href="/login">Login</a>
                    </li>
                    <li class="nav-item" id="register-nav">
                        <a class="nav-link" href="/register">Register</a>
                    </li>
                    <li class="nav-item" id="profile-nav" style="display: none;">
                        <a class="nav-link" href="/profile">Profile</a>
                    </li>
                    <li class="nav-item" id="logout-nav" style="display: none;">
                        <a class="nav-link" href="#" id="logout-link">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 offset-lg-2">
                    <h1 class="display-4">Rent Your Dream Car Today</h1>
                    <p class="lead">Explore our wide range of vehicles for any occasion. From economy to luxury, we have the perfect car for you.</p>
                    <a href="/carview" class="btn btn-primary btn-lg mt-3">Browse Cars</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-lg-8 offset-lg-2">
                    <h2>Why Choose Us?</h2>
                    <p class="lead">We offer the best car rental experience with competitive prices and excellent service.</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="mdi mdi-car"></i>
                        </div>
                        <h4>Wide Selection</h4>
                        <p>Choose from our extensive fleet of vehicles to find the perfect car for your needs.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="mdi mdi-currency-usd"></i>
                        </div>
                        <h4>Best Prices</h4>
                        <p>We offer competitive rates and special discounts for long-term rentals.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="mdi mdi-shield-check"></i>
                        </div>
                        <h4>Safety First</h4>
                        <p>All our vehicles are regularly maintained and thoroughly cleaned for your safety.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-lg-8 offset-lg-2">
                    <h2>How It Works</h2>
                    <p class="lead">Renting a car with us is quick and easy.</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="text-center">
                        <div class="bg-primary rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                            <h3 class="text-white m-0">1</h3>
                        </div>
                        <h4 class="mt-3">Choose a Car</h4>
                        <p>Browse our selection and find the perfect vehicle for your needs.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center">
                        <div class="bg-primary rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                            <h3 class="text-white m-0">2</h3>
                        </div>
                        <h4 class="mt-3">Book Online</h4>
                        <p>Make a reservation online and select your pickup and return dates.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center">
                        <div class="bg-primary rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                            <h3 class="text-white m-0">3</h3>
                        </div>
                        <h4 class="mt-3">Enjoy Your Ride</h4>
                        <p>Pick up your car and enjoy your journey with peace of mind.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>Car Rental</h5>
                    <p>Your trusted partner for car rentals. We provide quality vehicles at affordable prices.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="/" class="text-white">Home</a></li>
                        <li><a href="/carview" class="text-white">Cars</a></li>
                        <li><a href="/login" class="text-white">Login</a></li>
                        <li><a href="/register" class="text-white">Register</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Contact Us</h5>
                    <address>
                        <p><i class="mdi mdi-map-marker mr-1"></i> 123 Car Street, Auto City</p>
                        <p><i class="mdi mdi-phone mr-1"></i> +1 234 567 8900</p>
                        <p><i class="mdi mdi-email mr-1"></i> info@carrental.com</p>
                    </address>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12 text-center">
                    <p class="mb-0">&copy; <script>document.write(new Date().getFullYear())</script> Car Rental. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Vendor js -->
    <script src="/static/assets/js/vendor.min.js"></script>

    <!-- App js -->
    <script src="/static/assets/js/app.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Check if user is logged in
            var token = localStorage.getItem('token');
            if (token) {
                // User is logged in
                $('#login-nav, #register-nav').hide();
                $('#profile-nav, #logout-nav, #bookings-nav').show();
                
                // Check user role for dashboard access
                $.ajax({
                    type: 'GET',
                    url: '/api/auth/check-role',
                    headers: {
                        'Authorization': 'Bearer ' + token
                    },
                    success: function(response) {
                        if (response.roles && (response.roles.includes('ROLE_ADMIN') || response.roles.includes('ROLE_STAFF'))) {
                            $('#dashboard-nav').show();
                        }
                    }
                });
            }
            
            // Logout functionality
            $('#logout-link').click(function(e) {
                e.preventDefault();
                
                // Clear token
                localStorage.removeItem('token');
                
                // Redirect to home page
                window.location.href = '/';
            });
        });
    </script>
</body>
</html>
