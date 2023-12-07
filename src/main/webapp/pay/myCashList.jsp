<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myCashList</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
</head>
<body>
정산 내역 리스트<br>

    <!-- 정산 내역 리스트--> 
    <c:set var="i" value="0" />
    
    <c:forEach var="myCashList" items="${myCashList}">
      <c:set var="i" value="${ i+1 }" />
                
        ${myCashList.callNo} ${myCashList.callDate} ${myCashList.realPay}원
       <c:choose>
          <c:when test="${myCashList.star eq 1}">
            정산 완료
          </c:when>
          <c:otherwise>
            정산 대기
          </c:otherwise>
       </c:choose>       
        <br>
      </c:forEach>
       
</body>

</html>