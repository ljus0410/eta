<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>

function checkPasswordAndDeleteUser() {
    var password = document.getElementById('czxc1').value;
    var confirmPassword = document.getElementById('czxc2').value;

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
 
        // 여기에서 회원탈퇴 로직을 추가하면 됩니다.
        deleteUser();
    } else {
        confirmPasswordMessage.innerHTML = '비밀번호가 일치하지 않습니다.';
        confirmPasswordMessage.style.color = 'red';  // 일치하지 않을 때의 메시지 색상
        // 비밀번호가 일치하지 않을 때 얼럿을 띄우는 부분 추가
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
    <input type="password" class="form-control rounded-xs" id="czxc1" value="${user.pwd}" />
    <span id="passwordMessage">비밀번호</span>
</div>

<div class="form-custom form-label form-icon mb-3">
    <i class="bi bi-at font-16"></i>
    <input type="password" class="form-control rounded-xs" id="czxc2" name="pwd" value="" placeholder="password"/>
    <span id="passwordMessage">비밀번호 확인</span>
    <div style = "margin-left:5px; font-size: 11px;" id="confirmPasswordMessage"></div> 
</div>
        <a href="#" onclick="checkPasswordAndDeleteUser()"class='btn rounded-sm btn-m gradient-red text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s'>회원탈퇴</a>
        
      </div>
    </div>       
        </div>
        <input type="hidden" name="userNo" value="${user.userNo}">
    </form>    
        
        

</body>
</html>