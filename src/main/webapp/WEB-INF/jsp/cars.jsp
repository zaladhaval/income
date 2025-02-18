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
                                            <li class="breadcrumb-item active">Cars</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Cars</h4>
                                </div>
                            </div>
                        </div>     
                        <!-- end page title -->

                        <div class="row" id="cars">

                        </div>
                        <!-- end row -->

                        <!-- end row -->
                        
                    </div> <!-- container -->

                </div> <!-- content -->

                <!-- Footer Start -->
                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6">

                            </div>
                            <div class="col-md-6">
                                <div class="text-md-right footer-links d-none d-sm-block">
                                    <a href="javascript:void(0);">About Us</a>
                                    <a href="javascript:void(0);">Help</a>
                                    <a href="javascript:void(0);">Contact Us</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->


        </div>
        <!-- END wrapper -->


        <!-- Modal -->
        <div id="custom-modal" class="modal-demo">
            <button type="button" class="close" onclick="Custombox.modal.close();">
                <span>&times;</span><span class="sr-only">Close</span>
            </button>
            <h4 class="custom-modal-title">Add Members</h4>
            <div class="custom-modal-text text-left">
                <form>
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter name">
                    </div>
                    <div class="form-group">
                        <label for="position">Position</label>
                        <input type="text" class="form-control" id="position" placeholder="Enter position">
                    </div>
                    <div class="form-group">
                        <label for="company">Company</label>
                        <input type="text" class="form-control" id="company" placeholder="Enter company">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">Email address</label>
                        <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
                    </div>

                    <div class="text-right">
                        <button type="submit" class="btn btn-success waves-effect waves-light">Save</button>
                        <button type="button" class="btn btn-danger waves-effect waves-light m-l-10" onclick="Custombox.close();">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>

        <!-- Vendor js -->
        <jsp:include page="meta/scripts.jsp"/>
        <script>
            $(document).ready(function(){
                $.ajax({
                    type: 'GET',
                    url: "/api/car",
                    dataType: "json",
                    success: function(resultData) {

                        var cardsContainer = $("#cars"); // Select the element with ID 'cards'
                        cardsContainer.empty();
                        if (resultData && resultData.length > 0) {
                            resultData.forEach(function(item) {
                                console.log(item);
                               var cardetaisl='<div class="col-lg-4">'
                   +'         <div class="text-center card-box">'
                   +'         <div class="pt-2 pb-2">'
                   +'         <img src="/static/assets/images/users/user-3.jpg" class="rounded-circle img-thumbnail avatar-xl" alt="profile-image">'
                   +'         <h4 class="mt-3"><a href="extras-profile.html" class="text-dark">'+item.name+' </a></h4>'
                   +'     <p class="text-muted">'+item.carNumber+' <span> | </span> <span> <a href="#" class="text-pink">'+item.model+'</a> </span></p>'
                   +'     <button type="button" class="btn btn-primary btn-sm waves-effect waves-light">'+item.color+'</button>'
                   +'     <button type="button" class="btn btn-light btn-sm waves-effect">'+item.gearType+'</button>'
                   +'     <div class="row mt-4">'
                   +'         <div class="col-4">'
                   +'             <div class="mt-3">'
                   +'                 <h4>₹2563</h4>'
                   +'                 <p class="mb-0 text-muted text-truncate">Total Income</p>'
                   +'             </div>'
                   +'         </div>'
                   +'         <div class="col-4">'
                   +'             <div class="mt-3">'
                   +'                 <h4>29.8k</h4>'
                   +'                 <p class="mb-0 text-muted text-truncate">Total Trips</p>'
                   +'             </div>'
                   +'         </div>'
                   +'         <div class="col-4">'
                   +'             <div class="mt-3">'
                   +'                 <h4>1125</h4>'
                   +'                 <p class="mb-0 text-muted text-truncate">Total Hours</p>'
                   +'             </div>'
                   +'         </div>'
                   +'     </div> <!-- end row-->'
                   +' </div> <!-- end .padding -->'
                   +' </div> <!-- end card-box-->'
                   +' </div>';
                            cardsContainer.append(cardetaisl);
                            });
                        }

                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching data:", error);
                    }

                });
            });
        </script>
    </body>
</html>