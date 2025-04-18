<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Car Rental - Login</title>
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
                                <p class="text-muted mb-4 mt-3">Enter your username and password to access the admin panel.</p>
                            </div>

                            <div id="error-message" class="alert alert-danger" style="display: none;"></div>

                            <form id="login-form">
                                <div class="form-group mb-3">
                                    <label for="username">Username</label>
                                    <input class="form-control" type="text" id="username" required placeholder="Enter your username">
                                </div>

                                <div class="form-group mb-3">
                                    <label for="password">Password</label>
                                    <input class="form-control" type="password" required id="password" placeholder="Enter your password">
                                </div>

                                <div class="form-group mb-0 text-center">
                                    <button class="btn btn-primary btn-block" type="submit"> Log In </button>
                                </div>
                            </form>
                        </div> <!-- end card-body -->
                    </div>
                    <!-- end card -->

                    <div class="row mt-3">
                        <div class="col-12 text-center">
                            <p class="text-white-50">Don't have an account? <a href="/register" class="text-white ml-1"><b>Sign Up</b></a></p>
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
            $('#login-form').submit(function(e) {
                e.preventDefault();
                
                var username = $('#username').val();
                var password = $('#password').val();
                
                $.ajax({
                    type: 'POST',
                    url: '/api/auth/login',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        username: username,
                        password: password
                    }),
                    success: function(response) {
                        // Store token in localStorage
                        localStorage.setItem('token', response.token);
                        
                        // Redirect to dashboard
                        window.location.href = '/dashboard';
                    },
                    error: function(xhr) {
                        // Display error message
                        var errorMessage = 'Invalid username or password';
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMessage = xhr.responseJSON.message;
                        }
                        
                        $('#error-message').text(errorMessage).show();
                    }
                });
            });
        });
    </script>
</body>
</html>
