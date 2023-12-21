<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

var Numer;
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
  
function updatePwd(){
	
	 if (Numer==2) {
         userEnteredValue = "형식을 지켜주세여";
         updateToastText();
         showToast();
         return;
       }

	$("#updatePwdP").attr("method", "POST").attr("action", "/user/updatePwd").submit();

	 
}
	
$(document).ready(function() {
    $("#password").on("keyup", function() {
      console.log("비밀번호 입력 ");
      var password = $(this).val();
      var message = $("#passwordMessage");

      // 비밀번호 길이가 8자 이상이고, 특수문자를 포함하는지 확인
      if (password.length >= 8 && /[!@#$%^&*(),.?":{}|<>]/.test(password)) {
        Numer = 0;
        message.text("조건 만족").css('color', 'white');
      } else {
        Numer = 2;
        message.text("조건 불만족").css('color', 'red');
      }
    });
  });
	


</script>



</head>
<body>



<div id="page">
<jsp:include page="../home/top.jsp" />
<form id="updatePwdP">
<div class="page-content header-clear-medium" >
        <div class="card card-style" style="margin-bottom: 15px;">
          <div class="content"style="margin-bottom: 9px; ">
            <!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

            <h1 class="pb-2" style="width: 220px; display: inline-block;">
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;비밀번호 수정
            </h1>
  
          </div>
        </div>
      
<div class="card card-style">
      <div class="content">
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
           <input type="hidden" name="userNo" value="${user.userNo}">
          <input type="password" class="form-control rounded-xs" id="password" name="pwd" value="" placeholder="새로운 비밀번호"/>
          <label for="password" class="color-theme">새로운 비밀번호</label>
          <span id="passwordMessage" style="margin-left: 10px;"></span>
        </div>
        <a href="#" onclick="updatePwd()"class='btn rounded-sm btn-m gradient-blue text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s'>수정</a>
        <div class="d-flex">
        </div>
      </div>
    </div>
      </div>
<input type="hidden" id="email" name="email" value="${user.email}">


<div id="addUserTa" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">
    <div class="align-self-center">
      <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
    </div>
    <div class="align-self-center">
      <strong id ="messgeInfo" class="font-13 mb-n2"></strong>
      <span class="font-10 mt-n1 opacity-70">Sign-up Failed. Try again.</span>
    </div>
    <div class="align-self-center ms-auto">
      <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
    </div>
  </div>

</form>
</div>
</body>
</html>