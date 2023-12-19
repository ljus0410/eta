<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>예약 시간 설정</title>

  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="/javascript/community/addReservation.js"></script>

</head>

<body class="theme-light">

<div id="page">

  <jsp:include page="../home/top.jsp" />

  <div class="page-content header-clear-medium">

    <div class="card card-style">
      <div class="content">
        <form class="demo-animation needs-validation m-0" novalidate>
          <input type="hidden" class="form-control" id="callCode" name="callCode" value="${call.callCode}">
          <input type="hidden" class="form-control" id="routeOpt" name="routeOpt" value="${call.routeOpt}">
          <input type="hidden" class="form-control" id="realPay" name="realPay" value="${call.realPay}">
          <input type="hidden" class="form-control" id="startAddr" name="startAddr" value="${call.startAddr}">
          <input type="hidden" class="form-control" id="startKeyword" name="startKeyword" value="${call.startKeyword}">
          <input type="hidden" class="form-control" id="startX" name="startX" value="${call.startX}">
          <input type="hidden" class="form-control" id="startY" name="startY" value="${call.startY}">
          <input type="hidden" class="form-control" id="endAddr" name="endAddr" value="${call.endAddr}">
          <input type="hidden" class="form-control" id="endKeyword" name="endKeyword" value="${call.endKeyword}">
          <input type="hidden" class="form-control" id="endX" name="endX" value="${call.endX}">
          <input type="hidden" class="form-control" id="endY" name="endY" value="${call.endY}">
          <input type="hidden" class="form-control" id="callDate" name="callDate">
          <input type="hidden" class="form-control" id="carOpt" name="carOpt" value="${call.carOpt}">
          <input type="hidden" class="form-control" id="petOpt" name="petOpt" value="${call.petOpt}">

          <div class="form-custom form-label form-icon mb-3">
            <i class="bi bi-calendar font-12"></i>
            <input type="date" class="form-control rounded-xs" id="resDate"  name="resDate"/>
            <label for="resDate" class="form-label-always-active color-theme">예약 날짜</label>
          </div>

          <div class="form-custom form-label form-icon mb-3">
            <i class="bi bi-clock font-12"></i>
            <input type="time" class="form-control rounded-xs" id="resTime"  name="resTime"/>
            <label for="resTime" class="form-label-always-active color-theme">예약 시간</label>
          </div>

          <button class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" type="submit" id="reservationSubmit">예약 하기</button>
        </form>
      </div><!-- content -->
    </div> <!-- card card-style -->

  </div> <!-- page-content header-clear-medium -->

  <!--Warning Toast Bar-->
  <div id="reservationAlert" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

    <div class="align-self-center">
      <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
    </div>

    <div class="align-self-center">
      <span class="font-10 mt-n1 opacity-70">출발 날짜와 시간을 확인해주세요</span>
    </div>

    <div class="align-self-center ms-auto">
      <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
    </div>

  </div>
  <!-- Warning Toast Bar 끝 -->

</div> <!-- page -->

</body>
</html>