<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Car Rental - Register</title>
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
</head>

<body class="authentication-bg authentication-bg-pattern">
    <div class="account-pages mt-5 mb-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 col-xl-5">
                    <div class="card bg-pattern">
                        <div class="card-body p-4">
                            <div class="text-center w-75 m-auto">
                                <div class="auth-logo">
                                    <a href="/" class="logo logo-dark text-center">
                                        <span class="logo-lg">
                                            <h3>Car Rental</h3>
                                        </span>
                                    </a>
                                </div>
                                <p class="text-muted mb-4 mt-3">Create a new account to rent cars.</p>
                            </div>

                            <div id="error-message" class="alert alert-danger" style="display: none;"></div>
                            <div id="success-message" class="alert alert-success" style="display: none;"></div>

                            <form id="register-form">
                                <div class="form-group mb-3">
                                    <label for="name">Full Name</label>
                                    <input class="form-control" type="text" id="name" required placeholder="Enter your full name">
                                </div>

                                <div class="form-group mb-3">
                                    <label for="username">Username</label>
                                    <input class="form-control" type="text" id="username" required placeholder="Enter your username">
                                </div>

                                <div class="form-group mb-3">
                                    <label for="email">Email address</label>
                                    <input class="form-control" type="email" id="email" required placeholder="Enter your email">
                                </div>

                                <div class="form-group mb-3">
                                    <label for="password">Password</label>
                                    <input class="form-control" type="password" required id="password" placeholder="Enter your password">
                                </div>

                                <div class="form-group mb-3">
                                    <label for="contactNumber">Contact Number</label>
                                    <input class="form-control" type="text" id="contactNumber" placeholder="Enter your contact number">
                                </div>

                                <div class="form-group mb-0 text-center">
                                    <button class="btn btn-primary btn-block" type="submit"> Sign Up </button>
                                </div>
                            </form>
                        </div> <!-- end card-body -->
                    </div>
                    <!-- end card -->

                    <div class="row mt-3">
                        <div class="col-12 text-center">
                            <p class="text-white-50">Already have an account? <a href="/login" class="text-white ml-1"><b>Log In</b></a></p>
                        </div> <!-- end col -->
                    </div>
                    <!-- end row -->
                </div> <!-- end col -->
            </div>
            <!-- end row -->
        </div>
        <!-- end container -->
    </div>
    <!-- end page -->

    <footer class="footer footer-alt">
        <script>document.write(new Date().getFullYear())</script> &copy; Car Rental by <a href="#" class="text-white-50">Car Rental</a> 
    </footer>

    <!-- Vendor js -->
    <script src="/static/assets/js/vendor.min.js"></script>

    <!-- App js -->
    <script src="/static/assets/js/app.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#register-form').submit(function(e) {
                e.preventDefault();
                
                var name = $('#name').val();
                var username = $('#username').val();
                var email = $('#email').val();
                var password = $('#password').val();
                var contactNumber = $('#contactNumber').val();
                
                $.ajax({
                    type: 'POST',
                    url: '/api/auth/register',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        name: name,
                        username: username,
                        email: email,
                        password: password,
                        contactNumber: contactNumber
                    }),
                    success: function(response) {
                        // Display success message
                        $('#success-message').text('Registration successful! You can now login.').show();
                        $('#error-message').hide();
                        
                        // Clear form
                        $('#register-form')[0].reset();
                        
                        // Redirect to login page after 2 seconds
                        setTimeout(function() {
                            window.location.href = '/login';
                        }, 2000);
                    },
                    error: function(xhr) {
                        // Display error message
                        var errorMessage = 'Registration failed. Please try again.';
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMessage = xhr.responseJSON.message;
                        }
                        
                        $('#error-message').text(errorMessage).show();
                        $('#success-message').hide();
                    }
                });
            });
        });
    </script>
</body>
</html>
