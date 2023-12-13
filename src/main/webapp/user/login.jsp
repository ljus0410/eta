<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/templates/scripts/bootstrap.min.js"></script>
<script src="/templates/scripts/custom.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    $("#loginBtn").on("click", function() {
    	 var id = $("#c3").val();
    	    var pw = $("#c4").val();
    	   

    	    if (id == null || id.length < 1) {
    	        // 얼럿(alert) 대신 모달(offcanvas) 표시
    	        alert('ID를 입력하지 않으셨습니다.');
    	       
    	        $("#c3").focus();
    	        return;
    	    }

    	    if (pw == null || pw.length < 1) {
    	        // 얼럿(alert) 대신 모달(offcanvas) 표시
    	         alert('패스워드를 입력하지 않으셨습니다.');
    	       
    	        $("#42").focus();
    	        return;
    	    }
      var loginSuccess = false;

      if (loginSuccess) {
        // 로그인 성공 시 원하는 동작 수행
        $("form").attr("method", "POST").attr("action", "/user/login").submit();
      } else {
        // 로그인 실패 시 알림창 표시
    	  showLoginFailedToast();
      }
    });
  });

  function showLoginFailedToast() {
    var toast = $('#snack-3');
    var bsToast = new bootstrap.Toast(toast);
    bsToast.show();
  }
</script>
<title>Insert title here</title>
</head>
<body class="theme-light">
<jsp:include page="../home/top.jsp" />
<form>

<div id="page">


  
  <div class="page-content header-clear-medium">
    <div class="card card-style">
      <div class="content">
        <h1 class="text-center font-800 font-30 mb-2">Sign In</h1>
        <p class="text-center font-13 mt-n2 mb-3">Enter your Credentials</p>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c3" name="email" placeholder="email"/>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-lock-fill font-14"></i>
          <input type="password" class="form-control rounded-xs" id="c4" name="pwd" placeholder="Password"/>
        </div>
        <a id="loginBtn" href="#" class='btn rounded-sm btn-m gradient-green text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s'>Sign In</a>
        <div class="d-flex">
          <div>
            <a href="page-forgot-1.html" class="color-theme opacity-30 font-12">Recover Account</a>
          </div>
          <div class="ms-auto">
            <a href="page-register-1.html" class="color-theme opacity-30 font-12">Create Account</a>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div id="snack-3" class="snackbar bg-red-dark shadow-bg shadow-bg-m rounded-s shadow-l" data-bs-delay="4000">
    <div class="d-flex">
      <div class="align-self-center">
        <p class="mb-0 color-white font-600 line-height-s pe-2">Login Failed.</p>
      </div>
      <div class="align-self-center ms-auto">
        <a href="#" data-bs-dismiss="toast" class="bg-white px-2 py-1 my-1 d-block text-uppercase color-black font-700 font-10 rounded-xs text-center">Reset Pasword</a>
      </div>
    </div>
    </div>
   
</div>
</form>
</body>
</html>
