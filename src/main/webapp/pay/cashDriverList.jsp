<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>cashList</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="/templates/_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="/templates/app/icons/icon-192x192.png">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
<style type="text/css">
  td{
    height: 100px;
  }
</style>
</head>
<body class="theme-light">
  <form name="detailform">
    <div id="page">
      <div class="page-content header-clear-medium">
        <div class="card card-style">
          <div class="content">
            <!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

            <h1 class="pb-2">
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;정산 승인 대상 리스트
            </h1>

          </div>
        </div>
        
        <div class="card overflow-visible card-style">
          <div class="content mb-0">
            <div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
              <a class="btn btn-xxs bg-fade2-blue color-blue-dark"
                onclick="CashRequest()"
                style="display: inline-block; padding-top: 3px; padding-bottom: 3px; float: left;">정산하기</a>
                <select id="cashState" class="form-select" style="float: left; display: inline-block; width: 10%">
							    <option value="all">전체</option>
							    <option value="wait">승인 대기</option>
							    <option value="complete">승인 완료</option>
							</select>
                <select id="month" class="form-select" style="width: 20%; display: inline-block">
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
              <a class="btn btn-xxs border-blue-dark color-blue-dark"
                style="display: inline-block; padding-top: 3px; padding-bottom: 3px" id="searchButton">검색</a>
            </div>

            <div class="table-responsive">
              <table class="table color-theme mb-2" id="muhanlist">
                <thead>
                  <tr>
                    <th scope="col">  <label>
									    <input type="checkbox" id="selectAll" onchange="checkAll(this)">
									    선택
									  </label></th>
                    <th scope="col">driver 회원번호</th>
                    <th scope="col">날짜</th>
                    <th scope="col">금액</th>
                    <th scope="col">정산 승인 상태</th>
                  </tr>
                </thead>
                <tbody>
                <c:choose>
                        <c:when test="${empty cashDriverList}">
								            정산 대상이 없습니다.
								        </c:when>
								         <c:otherwise>
								         <c:set var="i" value="0" />   
									        <c:forEach var="cashDriverList" items="${cashDriverList}">
									        <c:set var="i" value="${ i+1 }" />        
									        <form id="cashForm" class="cashItem" data-star="${cashDriverList.star}">
									          <input type="hidden" name="cashDriverNo" value="${cashDriverList.userNo}">
								            <input type="hidden" name="cashMonth" value="${cashDriverList.callDate}">
								            <input type="hidden" name="cashTotal" value="${cashDriverList.realPay}">
									             <tr class="list">
						                      <td>        
						                      <c:choose>
						                        <c:when test="${cashDriverList.star ne 1}">
						                          <input type="checkbox" class="optionCheckbox" name="option" >      
						                        </c:when>
						                      </c:choose></td>
						                      <td>${cashDriverList.userNo}</td>
						                      <td>${cashDriverList.callDate}</td>
						                      <td>${cashDriverList.realPay} 원</td>
						                      <td>            
						                      <c:choose>
										                <c:when test="${cashDriverList.star eq 1}">
										                    <span class="approvalStatus">승인 완료</span>
										                </c:when>
										                <c:otherwise>
										                    <span class="approvalStatus">승인 대기</span>
										                </c:otherwise>
										            </c:choose> </td>
										            </tr>
										       </form>
                           </c:forEach>  
								         </c:otherwise>
								  </c:choose>
                </tbody>
              </table>
                    <c:choose>
                      <c:when test="${monthTotal eq 0}">       
                      </c:when>
                      <c:otherwise>
                       <span style="display: inline-block"> ${month} 월 총 금액 ${monthTotal} 원</span>
                      </c:otherwise>
                    </c:choose>
            </div>
          </div>
        </div>
      </div>
    </div>
  </form>
</body>
<script>

document.getElementById('cashState').addEventListener('change', function () {
    var selectedValue = this.value;
    var cashItems = document.querySelectorAll('.cashItem');
    cashItems.forEach(function (item) {
        var starValue = item.getAttribute('data-star');
        alert("starValue : "+starValue);
        if ((selectedValue === 'wait' && starValue !== '1') || (selectedValue === 'complete' && starValue === '1') || selectedValue === 'all') {
            item.style.display = 'block'; // 보이게 설정
        } else 
            item.style.display = 'none'; // 숨기게 설정
        }
    });
});

$(function() {
    
    $( "#searchButton" ).on("click" , function() {
      var month = $("#month").val();
      self.location = "/pay/cashDriverList?month="+month;
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
	
	var checkboxes = document.querySelectorAll('.optionCheckbox');
	var checkedCount = 0;
    checkboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            checkedCount++;
        }
    });
    
    if (checkedCount === 0) {
        alert("선택된 항목이 없습니다.");
    } else {
        // 체크된 체크박스가 하나 이상인 경우에는 정산 진행
        var result = confirm("정산하시겠습니까?");
        if (result) {
            addCash();
            alert("정산이 완료되었습니다.");
        } else {
            alert("정산 취소");
        }
    }
}
</script>
</html>