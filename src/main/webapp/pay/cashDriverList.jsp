<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
</head>
<body>
정산 승인 대상 리스트<br>
  <label>
    <input type="checkbox" id="selectAll" onchange="checkAll(this)">
    전체 선택
  </label>

<button onclick="CashRequest()">정산하기</button>
<br>
    
    <!-- Tpay 리스트--> 
    <c:set var="i" value="0" />
    
    <c:forEach var="cashDriverList" items="${cashDriverList}">
      <c:set var="i" value="${ i+1 }" />
      		
		<form id="cashForm">
		<c:choose>
		  <c:when test="${cashDriverList.star ne 1}">
		    <input type="checkbox" class="optionCheckbox" name="option" >      
		  </c:when>
		</c:choose>		    
		    ${cashDriverList.userNo} ${cashDriverList.callDate} ${cashDriverList.realPay}
		   <c:choose>
		      <c:when test="${cashDriverList.star eq 1}">
		        승인 완료
		      </c:when>
		      <c:otherwise>
		        승인 대기
		      </c:otherwise>
       </c:choose>
        <br>
		    <input type="hidden" name="cashDriverNo" value="${cashDriverList.userNo}">
		    <input type="hidden" name="cashMonth" value="${cashDriverList.callDate}">
		    <input type="hidden" name="cashTotal" value="${cashDriverList.realPay}">
		</form>
    

      </c:forEach>
       
</body>
<script>
function checkAll(source) {
    var checkboxes = document.querySelectorAll('.optionCheckbox');
    for (var checkbox of checkboxes) {
      checkbox.checked = source.checked;
    }
  }
  
/*function addCash() {

	$("form").attr("method" , "POST").attr("action" , "/pay/addCash").submit();
}*/
function addCash() {
    // Iterate over checked checkboxes and collect data
    var checkboxes = document.querySelectorAll('.optionCheckbox:checked');
    var selectedData = [];

    checkboxes.forEach(function (checkbox) {
        var form = checkbox.closest('form'); // 현재 체크박스에 가장 가까운 form 찾기
        selectedData.push({
            cashDriverNo: form.querySelector('input[name="cashDriverNo"]').value,
            cashMonth: form.querySelector('input[name="cashMonth"]').value,
            cashTotal: form.querySelector('input[name="cashTotal"]').value
        });
    });

    $.ajax({
        type: 'POST',
        url: '/pay/json/addCash',
        contentType: 'application/json',
        data: JSON.stringify(selectedData),
        success: function (response) {
            console.log("Data sent successfully:", response);
            location.reload();
        },
        error: function (error) {
            console.error('Error sending data:', error);
            location.reload();
        }
    });
}


function CashRequest(){
  
	var result = confirm("정산하시겠습니까?");

	if (result == true) {
		  addCash();
	    alert("정산이 완료되었습니다.");
	} else {
	    alert("정산 취소");
	}  
}
</script>
</html>