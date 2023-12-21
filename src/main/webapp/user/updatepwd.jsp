<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script type="text/javascript">

function updatePwd(){
	 $("form").attr("method", "POST").attr("action", "/user/updatePwd").submit();

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

            <h1 class="pb-2" style="width: 220px; display: inline-block;">
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;비밀번호 수정
            </h1>
  
          </div>
        </div>
      
<div class="card card-style">
      <div class="content">
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c1" name="pwd" placeholder="새로운 비밀번호"/>
          <label for="c1" class="color-theme">새로운 비밀번호</label>
          <span>새 비밀반호</span>
        </div>
        <a href="#" onclick="updatePwd()"class='btn rounded-sm btn-m gradient-blue text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s'>수정</a>
        <div class="d-flex">
        </div>
      </div>
    </div>
      </div>
<input type="hidden" name="email" value="${user.email}">

</form>
</body>
</html>