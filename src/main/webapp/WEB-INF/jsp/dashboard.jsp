<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="meta/head.jsp"/>

<body>
    <!-- Begin page -->
    <div id="wrapper">
        <jsp:include page="meta/topnavbar.jsp"/>
        <jsp:include page="meta/leftsidemenu.jsp"/>
        <!-- ============================================================== -->
        <!-- Start Page Content here -->
        <!-- ============================================================== -->

        <div class="content-page">
            <div class="content">

                <!-- Start Content-->
                <div class="container-fluid">
                    
                    <!-- start page title -->
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box">
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item active">Dashboard</li>
                                    </ol>
                                </div>
                                <h4 class="page-title">Dashboard</h4>
                            </div>
                        </div>
                    </div>     
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-md-6 col-xl-3">
                            <div class="widget-rounded-circle card-box">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="avatar-lg rounded-circle bg-soft-primary">
                                            <i class="fe-car font-22 avatar-title text-primary"></i>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="text-right">
                                            <h3 class="mt-1"><span data-plugin="counterup">${totalCars}</span></h3>
                                            <p class="text-muted mb-1 text-truncate">Total Cars</p>
                                        </div>
                                    </div>
                                </div> <!-- end row-->
                            </div> <!-- end widget-rounded-circle-->
                        </div> <!-- end col-->

                        <div class="col-md-6 col-xl-3">
                            <div class="widget-rounded-circle card-box">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="avatar-lg rounded-circle bg-soft-success">
                                            <i class="fe-check-circle font-22 avatar-title text-success"></i>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="text-right">
                                            <h3 class="text-dark mt-1"><span data-plugin="counterup">${availableCars}</span></h3>
                                            <p class="text-muted mb-1 text-truncate">Available Cars</p>
                                        </div>
                                    </div>
                                </div> <!-- end row-->
                            </div> <!-- end widget-rounded-circle-->
                        </div> <!-- end col-->

                        <div class="col-md-6 col-xl-3">
                            <div class="widget-rounded-circle card-box">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="avatar-lg rounded-circle bg-soft-info">
                                            <i class="fe-users font-22 avatar-title text-info"></i>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="text-right">
                                            <h3 class="text-dark mt-1"><span data-plugin="counterup">${totalUsers}</span></h3>
                                            <p class="text-muted mb-1 text-truncate">Total Users</p>
                                        </div>
                                    </div>
                                </div> <!-- end row-->
                            </div> <!-- end widget-rounded-circle-->
                        </div> <!-- end col-->

                        <div class="col-md-6 col-xl-3">
                            <div class="widget-rounded-circle card-box">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="avatar-lg rounded-circle bg-soft-warning">
                                            <i class="fe-calendar font-22 avatar-title text-warning"></i>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="text-right">
                                            <h3 class="text-dark mt-1"><span data-plugin="counterup">${totalBookings}</span></h3>
                                            <p class="text-muted mb-1 text-truncate">Total Bookings</p>
                                        </div>
                                    </div>
                                </div> <!-- end row-->
                            </div> <!-- end widget-rounded-circle-->
                        </div> <!-- end col-->
                    </div>
                    <!-- end row-->

                    <div class="row">
                        <div class="col-xl-8">
                            <div class="card-box">
                                <div class="dropdown float-right">
                                    <a href="#" class="dropdown-toggle arrow-none card-drop" data-toggle="dropdown" aria-expanded="false">
                                        <i class="mdi mdi-dots-vertical"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <a href="/admin/cars" class="dropdown-item">View All Cars</a>
                                        <a href="/admin/users" class="dropdown-item">View All Users</a>
                                    </div>
                                </div>
                                <h4 class="header-title mb-3">Recent Bookings</h4>

                                <div class="table-responsive">
                                    <table class="table table-borderless table-hover table-nowrap table-centered m-0">
                                        <thead class="thead-light">
                                            <tr>
                                                <th>Booking #</th>
                                                <th>Customer</th>
                                                <th>Car</th>
                                                <th>Status</th>
                                                <th>Amount</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="recent-bookings-table">
                                            <!-- Data will be loaded via AJAX -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div> <!-- end col -->

                        <div class="col-xl-4">
                            <div class="card-box">
                                <div class="dropdown float-right">
                                    <a href="#" class="dropdown-toggle arrow-none card-drop" data-toggle="dropdown" aria-expanded="false">
                                        <i class="mdi mdi-dots-vertical"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <a href="/admin/cars" class="dropdown-item">View All Cars</a>
                                    </div>
                                </div>
                                <h4 class="header-title mb-3">Car Status</h4>

                                <div class="widget-chart text-center" dir="ltr">
                                    <div id="car-status-chart" style="height: 250px;" class="morris-chart"></div>
                                </div>
                            </div> <!-- end card-box -->
                        </div> <!-- end col -->
                    </div>
                    <!-- end row -->
                    
                </div> <!-- container -->

            </div> <!-- content -->

            <jsp:include page="meta/footer.jsp"/>

        </div>

        <!-- ============================================================== -->
        <!-- End Page content -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- Right bar overlay-->
    <div class="rightbar-overlay"></div>

    <!-- Vendor js -->
    <jsp:include page="meta/scripts.jsp"/>
    
    <!-- Plugins js-->
    <script src="/static/assets/libs/morris-js/morris.min.js"></script>
    <script src="/static/assets/libs/raphael/raphael.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Get token from localStorage
            var token = localStorage.getItem('token');
            
            if (!token) {
                window.location.href = '/login';
                return;
            }
            
            // Load recent bookings
            $.ajax({
                url: '/api/dashboard/recent-bookings',
                type: 'GET',
                headers: {
                    'Authorization': 'Bearer ' + token
                },
                success: function(data) {
                    var tableBody = $('#recent-bookings-table');
                    tableBody.empty();
                    
                    if (data.length === 0) {
                        tableBody.append('<tr><td colspan="6" class="text-center">No recent bookings found</td></tr>');
                        return;
                    }
                    
                    $.each(data, function(index, booking) {
                        var statusClass = '';
                        switch(booking.status) {
                            case 'PENDING':
                                statusClass = 'badge-warning';
                                break;
                            case 'CONFIRMED':
                                statusClass = 'badge-info';
                                break;
                            case 'ACTIVE':
                                statusClass = 'badge-primary';
                                break;
                            case 'COMPLETED':
                                statusClass = 'badge-success';
                                break;
                            case 'CANCELLED':
                                statusClass = 'badge-danger';
                                break;
                        }
                        
                        var row = '<tr>' +
                            '<td><a href="/booking/' + booking.id + '">' + booking.bookingNumber + '</a></td>' +
                            '<td>' + booking.customerName + '</td>' +
                            '<td>' + booking.carName + '</td>' +
                            '<td><span class="badge ' + statusClass + '">' + booking.status + '</span></td>' +
                            '<td>$' + booking.totalAmount + '</td>' +
                            '<td><a href="/booking/' + booking.id + '" class="btn btn-xs btn-light"><i class="mdi mdi-eye"></i></a></td>' +
                            '</tr>';
                        
                        tableBody.append(row);
                    });
                },
                error: function() {
                    $('#recent-bookings-table').html('<tr><td colspan="6" class="text-center">Error loading bookings</td></tr>');
                }
            });
            
            // Load car status chart
            $.ajax({
                url: '/api/dashboard/stats',
                type: 'GET',
                headers: {
                    'Authorization': 'Bearer ' + token
                },
                success: function(data) {
                    Morris.Donut({
                        element: 'car-status-chart',
                        data: [
                            {label: "Available", value: data.availableCars},
                            {label: "Booked", value: data.totalCars - data.availableCars}
                        ],
                        colors: ['#10c469', '#ff5b5b'],
                        resize: true
                    });
                }
            });
        });
    </script>
</body>
</html>
