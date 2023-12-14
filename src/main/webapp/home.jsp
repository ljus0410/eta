<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

.card-style2 {
  width: 600px; /* 넓이를 원하는 값으로 조절 */
  overflow: hidden;
  border-radius: 30px;
  margin: 0px 15px 30px 15px;
  border: none;
  box-shadow: rgba(0, 0, 0, 0.03) 0px 20px 25px -5px, rgba(0, 0, 0, 0.02) 0px 10px 10px -5px;
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center center;
}

</style>
<script>
function inputAddress(callCode) {
	  var callCode = callCode;

	  if(callCode === 'N'){
	    self.location = "/callreq/inputAddress?userNo="+${user.userNo }+"&callCode=N"
	  } else if(callCode === 'D'){
	    self.location = "/callreq/inputAddress?userNo="+${user.userNo }+"&callCode=D"
	  } else if(callCode === 'S'){
	     self.location = "/callreq/inputAddress?userNo="+${user.userNo }+"&callCode=S"
	  } else if(callCode === 'R'){
	    self.location = "/callreq/inputAddress?userNo="+${user.userNo }+"&callCode=R"
	  } 
	} 

//내일 물어보자
function ReservationList() {

	window.location.href = '/callres/getReservationList';

	}
function GetdealList() {

	  window.location.href = '/community/getDealList';

	  }



</script>



</head>
<body class="theme-light">
<jsp:include page="/home/top.jsp" />
<div id="page">
<div class="page-content header-clear-medium">

<c:choose>
    <c:when test="${empty user.role}">
        <!-- 로그인이 안 된 경우 -->
        <!-- 이 경우 아무것도 보이지 않게 할 수도 있습니다. -->
    </c:when>
    <c:when test="${user.role eq 'passenger'}">

        <div class="d-flex justify-content-center">
      <div class="form-custom card-style2 form-label form-icon mb-1">
         <input type="text" class="form-control rounded-xs" onclick="inputAddress('N')" placeholder="가자!!"/>
        </div>
        </div>
        
        <div class="content px-2 text-center mb-0">
            <div class="row me-0 ms-0 mb-0">
                <div class="col-4 ps-0 pe-0" onclick="inputAddress('R')">
                    <div class="card card-style">
                        <img src="/templates/images/pictures/23.jpg" class="img-fluid">
                        <div class="content pb-0">
                            <p class="mb-0">예약</p>
                        </div>
                    </div>
                </div>
                <div class="col-4 pe-0 ps-0" onclick="inputAddress('D')">
                    <div class="card card-style">
                        <img src="/templates/images/pictures/2.jpg" class="img-fluid">
                        <div class="content pb-0">
                            <p class="mb-0">딜</p>
                        </div>
                    </div>
                </div>
                <div class="col-4 pe-0 ps-0" onclick="inputAddress('S')">
                    <div class="card card-style">
                        <img src="/templates/images/pictures/5.jpg" class="img-fluid">
                        <div class="content pb-0">
                            <p class="mb-0">합승</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${user.role eq 'driver'}">
        <!-- 로그인이 되어 있고, 역할이 'driver'인 경우 -->
        <div class="row mb-0">
            <div class="col-6 pe-0" onclick="ReservationList()">
                <div class="card card-style me-2">
                    <img src="/templates/images/pictures/21.jpg" class="img-fluid">
                    <div class="content pb-0">
                        <p>예약배차</p>
                    </div>
                </div>
            </div>
            <div class="col-6 ps-0" onclick="GetdealList()">
                <div class="card card-style ms-2">
                    <img src="/templates/images/pictures/22.jpg" class="img-fluid">
                    <div class="content pb-0">
                        <p>딜 하러 가기</p>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <!-- 그 외의 경우 -->
    </c:otherwise>
</c:choose>
      

  
</div>
</div>



</body>
</html>