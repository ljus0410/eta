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
  
  <select id="month">
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
    <option value="wait">승인 대기</option>
    <option value="complete">승인 완료</option>
</select>
    
<button onclick="CashRequest()">정산하기</button>
<br>

    
    <c:choose>
        <c:when test="${empty cashDriverList}">
            정산 대상이 없습니다.
        </c:when>
      <c:otherwise>
        <!-- Tpay 리스트--> 
		    <c:set var="i" value="0" />   
		    <c:forEach var="cashDriverList" items="${cashDriverList}">
		      <c:set var="i" value="${ i+1 }" />        
		    <form id="cashForm" class="cashItem" data-star="${cashDriverList.star}">
		    <c:choose>
		      <c:when test="${cashDriverList.star ne 1}">
		        <input type="checkbox" class="optionCheckbox" name="option" >      
		      </c:when>
		    </c:choose>               
		        <a class="getRecordList">${cashDriverList.userNo} </a>
		        ${cashDriverList.callDate} ${cashDriverList.realPay}
            <c:choose>
                <c:when test="${cashDriverList.star eq 1}">
                    <span class="approvalStatus">승인 완료</span>
                </c:when>
                <c:otherwise>
                    <span class="approvalStatus">승인 대기</span>
                </c:otherwise>
            </c:choose>      
		        <br>
		        <input type="hidden" name="cashDriverNo" value="${cashDriverList.userNo}">
		        <input type="hidden" name="cashMonth" value="${cashDriverList.callDate}">
		        <input type="hidden" name="cashTotal" value="${cashDriverList.realPay}">
		    </form>
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
    
 <!--<div id="totalRealPay"></div> --><!--  선택한 총 금액 -->
       
</body>
<script>

document.getElementById('cashState').addEventListener('change', function () {
    var selectedValue = this.value;
    var cashItems = document.querySelectorAll('.cashItem');

    cashItems.forEach(function (item) {
        var starValue = item.getAttribute('data-star');

        if ((selectedValue === 'wait' && starValue !== '1') || (selectedValue === 'complete' && starValue === '1') || selectedValue === 'all') {
            item.style.display = 'block'; // 보이게 설정
        } else {
            item.style.display = 'none'; // 숨기게 설정
        }
    });
});

$(function() {
    
    $( "#searchButton" ).on("click" , function() {
      var month = $("#month").val();
      self.location = "/pay/cashDriverList?month="+month;
   });
    
    $( ".getRecordList" ).on("click" , function() {
        alert("해당 driver의 운행 기록 리스트로 이동");
     });
    
    $(".optionCheckbox").on("change", function() {
        calculateTotalRealPay();
    });
});



function checkAll(source) {
    var checkboxes = document.querySelectorAll('.optionCheckbox');
    for (var checkbox of checkboxes) {
        checkbox.checked = source.checked;
    }
    calculateTotalRealPay();
}

function calculateTotalRealPay() {
    var checkboxes = document.querySelectorAll('.optionCheckbox:checked');
    var totalAmount = 0;

    checkboxes.forEach(function (checkbox) {
        var form = checkbox.closest('form'); // 현재 체크박스에 가장 가까운 form 찾기
        totalAmount += parseFloat(form.querySelector('input[name="cashTotal"]').value);
    });

    document.getElementById('totalRealPay').innerText = "선택한 월의 총 정산 금액: " + totalAmount.toFixed(2);
}

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