<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
    $("#blockButton").on("click", function() {
        // 여기서 user.userNo 가져오기
        var userNo = ${user.userNo}; // 예시로 사용, 실제로는 적절한 방식으로 가져와야 함
        console.log("No : "+userNo);
        // AJAX 요청 보내기
        $.ajax({
            type: "GET",
            url: "../feedback/json/addBlock/" + userNo,
            success: function(response) {
                console.log("response"+response);
               
            },
            error: function(error) {
                console.error("에러 발생: ", error);
            }
        });
    });
});
 
 

function updateUser() {
    $("form").attr("method", "POST").attr("action", "/user/updateUser").submit();
});  
 
 
 //readonly
 document.getElementById("c4").disabled = true;
 document.getElementById("c5").disabled = true;
 document.getElementById("c6").disabled = true;
 document.getElementById("c13").disabled = true;
 
 
 
 </script>
    
</head>
<body>
<jsp:include page="../home/top.jsp" />

<div class="page-content header-clear-medium" >
        
        
       <div class="card card-style" style="margin-bottom: 15px;">
    <div class="content" style="margin-bottom: 9px; display: flex; justify-content: space-between; align-items: center;">
        <h1 class="pb-2" style="width: 140px;">
            <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns"></i>&nbsp;&nbsp;내정보
        </h1>
        <div style="text-align: right;">
           <p class="font-12 color-highlight" style="margin-bottom: 0;text-align: left;">잔액: ${user.myMoney}</p>
            <p class="font-12 color-highlight" style="margin-bottom: 0;">가입일자: ${user.regDate}</p>
            
        </div>
    </div>
</div>


        <div class="card card-style">
      <div class="content">
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs " id="c1" value="${user.name}"/>
          <span>이름</span>
        </div>
         <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-envelope font-14"></i>
          <input type="text" class="form-control rounded-xs " id="c2" value="${user.phone}"/>
          <span>전화번호</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c3" value="${user.nickName}"/>
          <span>닉네임</span>
        </div>
         <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-envelope font-14"></i>
          <input type="text" class="form-control rounded-xs readonly" id="c4" value="${user.email}" readonly/>
          <span>이메일</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c5" value="${user.birth}" readonly/>
          <span>생년월일</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
        <i class="bi bi-envelope font-14"></i>
        <input type="text" class="form-control rounded-xs" id="c6" value="${user.gender eq 0 ? '남' : '여'}" readonly />
        <span>성별</span>
        </div>

        
         <c:if test="${user.role eq 'driver'}">
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c9" value="${user.carNum}"/>
          <span>차량번호</span>
        </div>
     
          <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c7" value="${user.carOpt}"/>
          <span>닉네임</span>
        </div>
     
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c9" value="${user.petOpt}"/>
          <span>옵션</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c10" value="${user.bank}"/>
          <input type="text" class="form-control rounded-xs" id="c11" value="${user.account}"/>
          <span>정산수단</span>
        </div>
        
        </c:if>    
<div class="form-custom form-label form-icon mb-3" style="display: flex;">
    <i class="bi bi-person-circle font-14"></i>
    <input type="password" class="form-control rounded-s" id="c9" value="${user.pwd}" readonly/>
</div>
        <a href="#" onclick="updateUser()"class="btn btn-full gradient-blue shadow-bg shadow-bg-s mt-4">수정</a> 
        </div>    
        </div>
     
        </div>

</body>
</html>