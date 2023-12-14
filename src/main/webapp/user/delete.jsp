<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
function checkPasswordAndDeleteUser() {
    var password = document.getElementById('c1').value;
    var confirmPassword = document.getElementById('c2').value;

    var passwordMessage = document.getElementById('passwordMessage');
    var confirmPasswordMessage = document.getElementById('confirmPasswordMessage');

    // 비밀번호 확인 입력란이 비어있는지 체크
    if (confirmPassword === "") {
        confirmPasswordMessage.innerHTML = '비밀번호를 입력하세요.';
        confirmPasswordMessage.style.color = 'red';  // 일치하지 않을 때의 메시지 색상
        return;
    }

    // 비밀번호 일치 여부 확인
    if (password === confirmPassword) {
        confirmPasswordMessage.innerHTML = '비밀번호가 일치합니다.';
        confirmPasswordMessage.style.color = 'blue';  // 일치할 때의 메시지 색상
        // 여기에서 회원탈퇴 로직을 추가하면 됩니다.
        deleteUser();
    } else {
        confirmPasswordMessage.innerHTML = '비밀번호가 일치하지 않습니다.';
        confirmPasswordMessage.style.color = 'red';  // 일치하지 않을 때의 메시지 색상
        // 비밀번호가 일치하지 않을 때 얼럿을 띄우는 부분 추가
        alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
    }
}

function deleteUser() {
    
     $("form").attr("method", "POST").attr("action", "/user/deleteUser").submit();
}
     



</script>

</head>
<body>
<jsp:include page="../home/top.jsp" />
<form>
<div class="page-content header-clear-medium" >
        <div class="card card-style" style="margin-bottom: 15px;">
          <div class="content"style="margin-bottom: 9px; ">
            <!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

            <h1 class="pb-2" style="width: 140px; display: inline-block;">
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;회원탈퇴
            </h1>
  
          </div>
        </div>
        
        <div class="card card-style">
      <div class="content">
       <div class="form-custom form-label form-icon mb-3">
    <i class="bi bi-at font-16"></i>
    <input type="password" class="form-control rounded-xs" id="c1" value="${user.pwd}" />
    <label for="c1" class="color-theme">비밀번호</label>
    <span id="passwordMessage">비밀번호</span>
</div>

<div class="form-custom form-label form-icon mb-3">
    <i class="bi bi-at font-16"></i>
    <input type="password" class="form-control rounded-xs" id="c2" name="detailPwd" value="" placeholder="password"/>
    <label for="c2" class="color-theme">비밀번호 확인</label>
    <span id="confirmPasswordMessage">비밀번호 확인</span>
</div>
        <a href="#" onclick="checkPasswordAndDeleteUser()"class='btn rounded-sm btn-m gradient-red text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s'>회원탈퇴</a>
        
      </div>
    </div>
        
        <input type="hidden" name="email" value="${user.email}">
        </div>
        
        
        
        <div id="toast-top-2" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">
    <div class="align-self-center">
      <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
    </div>
    <div class="align-self-center">
      <strong class="font-13 mb-n2">Password Incorrect</strong>
      <span class="font-10 mt-n1 opacity-70">Account Login Failed. Try again.</span>
    </div>
    <div class="align-self-center ms-auto">
      <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
    </div>
  </div>
</form>
</body>
</html>