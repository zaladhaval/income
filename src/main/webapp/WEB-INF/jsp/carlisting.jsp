<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="shortcut icon" href="/api/static/assets/images/favicon.svg" type="image/x-icon" />
  <title>Cars</title>
  <jsp:include page="meta/css.jsp"/>

</head>

  <body>
    <!-- ======== Preloader =========== -->
    <div id="preloader">
      <div class="spinner"></div>
    </div>
    <!-- ======== Preloader =========== -->
    <jsp:include page="meta/sidebar.jsp"/>
    <!-- ======== main-wrapper start =========== -->
    <main class="main-wrapper">
      <jsp:include page="meta/header.jsp"/>
      <!-- ========== section start ========== -->
      <section class="section">
        <div class="container-fluid">
          <!-- ========== title-wrapper start ========== -->
          <div class="title-wrapper pt-30">
            <div class="row align-items-center">
              <div class="col-md-6">
                <div class="title">
                  <h2>Car List</h2>
                </div>
              </div>

            </div>
            <!-- end row -->
          </div>
          <!-- ========== title-wrapper end ========== -->
        </div>
        <!-- end container -->
      </section>
      <!-- ========== section end ========== -->
      <!-- ========== tables-wrapper start ========== -->
      <div class="tables-wrapper">
        <div class="row">
          <div class="col-lg-12">
            <div class="card-style mb-30">
              <div class="table-wrapper table-responsive">
                <table class="table">
                  <thead>
                  <tr>

                    <th class="lead-email">
                      <h6>Name</h6>
                    </th>
                    <th class="lead-phone">
                      <h6>Number</h6>
                    </th>
                    <th class="lead-company">
                      <h6>Color</h6>
                    </th>
                    <th>
                      <h6>Model</h6>
                    </th>
                  </tr>
                  <!-- end table row-->
                  </thead>
                  <tbody>
                  <c:forEach items="${cars}" var="car">
                    <tr>
                      <td>${car.name}</td>
                      <td>${car.carNumber}</td>
                      <td>${car.color}</td>
                      <td>${car.model}</td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
                <!-- end table -->
              </div>
            </div>
            <!-- end card -->
          </div>
          <!-- end col -->
        </div>

      </div>
      <!-- ========== tables-wrapper end ========== -->
      <!-- ========== footer start =========== -->
      <footer class="footer">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-6 order-last order-md-first">
              <div class="copyright text-center text-md-start">
                <p class="text-sm">
                  Designed and Developed by
                  <a href="https://plainadmin.com" rel="nofollow" target="_blank">
                    Dhaval Zala
                  </a>
                </p>
              </div>
            </div>
            <!-- end col-->

          </div>
          <!-- end row -->
        </div>
        <!-- end container -->
      </footer>
      <!-- ========== footer end =========== -->
    </main>
    <!-- ======== main-wrapper end =========== -->

    <!-- ========= All Javascript files linkup ======== -->
    <jsp:include page="meta/javascripts.jsp"/>
  </body>
</html>
