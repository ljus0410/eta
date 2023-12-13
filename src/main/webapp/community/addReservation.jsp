<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>예약 시간 설정</title>
  
  <!-- templates 설정 -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
  <link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
  <link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
  <link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
  <!-- templates 설정 끝 -->
  
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  
  <script type="text/javascript">
  
    $(function() {
      
      //폼 제출
      $( "#submitbt" ).on("click" , function() {
        let callDate =$("#resdate").val()+' '+$("#restime").val()+":00"
        $("#callDate").val(callDate);
  
        let confirmDate = new Date(callDate);
        let now = new Date();
  
        if (confirmDate < now) {
          $('#toast-top-2').removeClass('toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s')
          .addClass('toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s fade show');
        } else {
            $("form").attr("method" , "POST").attr("action" , "/community/addReservationReq").submit();
        }
      });
  
      //리셋
      $("a[href='#']").on("click" , function() {
        $("form")[0].reset();
      });
      
    });
  
    //날짜선택 당일 이후만 가능하게하는 로직
    $(function() {
      var today = new Date();
  
      var yyyy = today.getFullYear();
      var mm = String(today.getMonth() + 1).padStart(2, '0');
      var dd = String(today.getDate()).padStart(2, '0');
      var formattedDate = yyyy + '-' + mm + '-' + dd;
  
      $("#resdate").attr("min", formattedDate);
    })
    
  </script>
  
</head>

<body class="theme-light">

  <div id="page">

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
              <input type="date" class="form-control rounded-xs" id="resdate"  name="resdate"/>
              <label for="resdate" class="form-label-always-active color-theme">예약 날짜</label>
            </div>
            
            <div class="form-custom form-label form-icon mb-3">
              <i class="bi bi-clock font-12"></i>
              <input type="time" class="form-control rounded-xs" id="restime"  name="restime"/>
              <label for="restime" class="form-label-always-active color-theme">예약 시간</label>
            </div>
            
            <button class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" type="submit" id="submitbt">예약 하기</button>
          
          </form>
          
        </div><!-- content -->
      
      </div> <!-- card card-style -->
      
    </div> <!-- page-content header-clear-medium -->
    
    <!--Warning Toast Bar-->
      <div id="toast-top-2" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">
      
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

  <!-- templates 설정 -->
  <script src="/templates/scripts/bootstrap.min.js"></script>
  <script src="/templates/scripts/custom.js"></script>
  <!-- templates 설정 끝 -->

</body>
</html>