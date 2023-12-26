<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eTa</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/templates/scripts/bootstrap.min.js"></script>
<script src="/templates/scripts/custom.js"></script>

<script type="text/javascript">
//URL에서 Query String 파라미터 읽기
    $(document).ready(function() {
    $("#search").on("click", function() {
        // URL에서 코드 매개변수 가져오기
        var code = "${param.code}";
        var email = "${param.email}";
        var phone = "${param.phone}";
        var message = "${param.message}";
        var codeCer = $("#codeCer").val();

        // 콘솔에 값 출력
        console.log("code: " + code);
        console.log("email: " + email);
        console.log("phone: " + phone);
        console.log("message: " + message);
        
        console.log("codeCer: " + codeCer);
        if (code === null || code === '') {
            // 코드 일치 여부 확인
            if (message === codeCer) {
                // 코드가 일치하면 다음 페이지로 이동
                window.location.href = "/user/searchAnswer?phone=" + phone;
            } else {
                // 코드가 일치하지 않으면 알림 표시
                userEnteredValue = "인증번호가 맞지 않습니다";
                updateToastText();
                showToast();
               
            }
        } else if (code != null ) {
        	  if(code == codeCer){
            window.location.href = "/user/searchAnswer?email=" + email;
        
        } else {
            // 적절한 처리: code와 phone이 모두 null이면 또는 message가 codeCer 값과 일치하지 않으면
        	 userEnteredValue = "인증번호가 맞지 않습니다";
             updateToastText();
             showToast();
        }
        }
        
        });
});
    function showToast() {
        var toastElement = document.getElementById('addUserTa');
        var toast = new bootstrap.Toast(toastElement);
        toast.show();

      }

      var userEnteredValue
      function updateToastText() {
        // 사용자가 입력한 값을 각 요소에 적용
        document.getElementById('messgeInfo').textContent = userEnteredValue;

      }



</script>
</head>
<body class="theme-light">
<div id="page">
<jsp:include page="../home/top.jsp" />

<div class="page-content header-clear-medium" >
        
       <div class="card card-style" style="margin-bottom: 15px;">
    <div class="content" style="margin-bottom: 9px; display: flex; justify-content: space-between; align-items: center;">
        <h1 class="pb-2" style="width: 180px;">
            <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns"></i>&nbsp;&nbsp;인증
        </h1>
       <div style="text-align: right;">  
</div>

    </div>
</div>


          
        <div class="card card-style">      
      <div class="content">
      
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-unlock font-14"></i>
          <input type="text" class="form-control rounded-xs " name="codeCer" id="codeCer" value=""/>
          <span>new</span>
        </div>
        
      <a href="#" class='btn rounded-sm btn-m gradient-blue text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s' id="search">확인</a>
</div>
</div>
</div>
</div>

      
<div id="addUserTa" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">
    <div class="align-self-center">
      <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
    </div>
    <div class="align-self-center">
      <strong id ="messgeInfo" class="font-13 mb-n2"></strong>
      <span class="font-10 mt-n1 opacity-70">Failed. Try again.</span>
    </div>
    <div class="align-self-center ms-auto">
      <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
    </div>
  </div>



</body>
</html>
