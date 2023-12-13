<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>택시비 딜 상세조회</title>
  
  <!-- templates 설정 -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
  <link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
  <link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
  <link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
  <!-- templates 설정 끝 -->
  
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  
  <script>
  
    $(function() {
      
        $( "#delete" ).on("click" , function() {
          self.location="/community/deleteDealReq?callNo="+${dealReq.callNo};
        });

        $( "#select" ).on("click" , function() {
          alert("driver 선택")
        });
        
    });
    
  </script>
  
</head>

<body class="theme-light">

  <div id="page">
  
    <div class="page-content header-clear-medium">
    
      <div class="card card-style">
        <div class="content">
          <h1 class="pb-2">택시비 딜 상세조회</h1>
            <ul class="mb-0 ps-3">
              <li><strong>출발</strong> : ${call.startAddr}</li>
              <li><strong>도착</strong> : ${call.endAddr}</li>
              <li><strong>경로 옵션</strong> : ${call.routeOpt}</li>
              <li><strong>제시 금액</strong> : ${dealReq.passengerOffer}</li>
            </ul>
        </div>
      </div><!-- card card-style 끝 -->
      
      <div class="card card-style">
        <div class="content">
            <c:choose>
              <c:when test="${empty list}">
                <h5 class="pb-2">참여한 driver가 없습니다.</h5>
              </c:when>
              <c:otherwise>
                <div class="list-group list-custom list-group-m rounded-xs">
                  <ul class="driver-list">
                    <c:forEach var="driver" items="${list}">
                      <li class="list-group-item">
                        <input type="radio" name="driverNo" id="driverNo"> ${driver.userNo} : ${driver.driverOffer} /
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div><!-- card card-style 끝 -->
    
    </div><!-- page-content header-clear-medium 끝 -->
  
  </div><!-- page 끝 -->

  <!-- templates 설정 -->
  <script src="/templates/scripts/bootstrap.min.js"></script>
  <script src="/templates/scripts/custom.js"></script>
  <!-- templates 설정 끝 -->

</body>
</html>