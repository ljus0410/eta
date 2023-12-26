<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eTa</title>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

function navigateToHome() {
    // home.jsp로 이동
    window.location.href = "/home.jsp";  // 적절한 경로로 수정해야 합니다.
}
  


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
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;회원정보
            </h1>
  
          </div>
        </div>
      
<div class="card card-style">
      <div class="content">
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          
   <c:if test="${not empty email.pwd}">
        <input type="text" class="form-control rounded-xs" id="pwd" name="pwd" value="${email.pwd}" readonly/>
</c:if>
    
    <!-- If user.pwd is null -->
<c:if test="${not empty phone.pwd}">
        <input type="text" class="form-control rounded-xs" id="email" name="email" value="${phone.email}" readonly/>

</c:if>
          <label for="password" class="color-theme">Password</label>
          <span id="passwordMessage" style="margin-left: 10px;"></span>
        </div>
        <a href="#" onclick="navigateToHome()"class='btn rounded-sm btn-m gradient-blue text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s'>확인</a>
        <div class="d-flex">
        </div>
      </div>
    </div>
      </div>

</form>
</div>
</body>
</html>