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

  <select id="month">
  <option value="all">전체</option>
  <option value="01">1월</option>
  <option value="02">2월</option>
  <option value="03">3월</option>
  <option value="04">4월</option>
  <option value="05">5월</option>
  <option value="06">6월</option>
  <option value="07">7월</option>
  <option value="08">8월</option>
  <option value="09">9월</option>
  <option value="10">10월</option>
  <option value="11">11월</option>
  <option value="12">12월</option>
</select>
 <button type="button" id="searchButton">검색</button>
<select id="cashState">
    <option value="all">전체</option>
    <option value="wait">정산 대기</option>
    <option value="complete">정산 완료</option>
</select>
<br>
<c:choose>
  <c:when test="${empty myCashList}">
      정산 내역이 없습니다.
  </c:when>
  <c:otherwise>
          <!-- 정산 내역 리스트--> 
    <c:set var="i" value="0" />    
    <c:forEach var="myCashList" items="${myCashList}">
      <c:set var="i" value="${ i+1 }" />
       <div class="cashItem" data-star="${myCashList.star}">         
        <a class="getRecord" data-callno="${myCashList.callNo}">${myCashList.callNo}</a> ${myCashList.callDate} ${myCashList.realPay}원
       <c:choose>
          <c:when test="${myCashList.star eq 1}">
            정산 완료
          </c:when>
          <c:otherwise>
            정산 대기
          </c:otherwise>
       </c:choose>
       </div>       
        <br>
      </c:forEach>
  </c:otherwise>
</c:choose>
 <hr>
     <c:choose>
      <c:when test="${monthTotal eq 0}">       
      </c:when>
      <c:otherwise>
        ${month} 월 총 금액 : ${monthTotal} 원
      </c:otherwise>
    </c:choose>
</body>
<script>
$(function () {
	
    $( ".getRecord" ).on("click" , function() {
    	
    	var callNo = $(this).data("callno");
    	  self.location = "/callres/getRecordDriver?callNo="+callNo;
     }); 
    
    $("#searchButton").on("click", function () {
        var month = $("#month").val();
        self.location = "/pay/myCashList?userNo="+${user.userNo}+"&month=" + month;
    });

    $("#cashState").on("change", function () {
        var selectedValue = this.value;
        var cashItems = $(".cashItem");

        cashItems.each(function () {
            var starValue = $(this).data("star");

            if ((selectedValue === 'complete' && starValue === 1) || (selectedValue === 'wait' && starValue !== 1) || selectedValue === 'all') {
                $(this).show(); // 보이게 설정
            } else {
                $(this).hide(); // 숨기게 설정
            }
        });
    });
});
</script>

</html>