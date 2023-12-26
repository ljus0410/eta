<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eTa</title>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">


  


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
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;비밀번호 찾기
            </h1>
  
          </div>
        </div>
      
<div class="card card-style">
      <div class="content">
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="password" class="form-control rounded-xs" id="email" name="email" value="" placeholder="Email"/>
          <label for="password" class="color-theme">Email</label>
          <span id="passwordMessage" style="margin-left: 10px;"></span>
        </div>
        <a href="#" onclick="()"class='btn rounded-sm btn-m gradient-blue text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s'>확인</a>
        <div class="d-flex">
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