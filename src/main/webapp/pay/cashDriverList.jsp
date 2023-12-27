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
<title>eTa</title>
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
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

<script>
function checkedMoney(){
    
    var checkboxes = document.querySelectorAll('#driverCheck');
    
    var totalRealPay = 0;
      checkboxes.forEach((checkbox) => {
          if (checkbox.checked) {
            var realPay = parseInt(checkbox.getAttribute('data-realPay')) || 0;
       //     alert("realPay: "+realPay);
              totalRealPay += realPay;
          }
      });

      var formattedCheckedMoney = parseFloat(totalRealPay).toLocaleString(); // 숫자로 변환 후 형식화
      $('#totalRealPay').text(formattedCheckedMoney);

  }

</script>

<style type="text/css">
  td{
    height: 100px;
  }
    #totalMoney{
  font-size: 18px;
  font-weight: bold;
  }
</style>
</head>
<body class="theme-light">
<script>
document.addEventListener("DOMContentLoaded", function () {
	
	const ctx = document.getElementById('myChart');
	const adminCash = ${adminCashTotal};
	 const monthTotal = ${monthTotal};
	 const completeTotal = ${completeTotal};
	 const waitTotal = ${waitTotal};
	 let month = '${month}';
	 console.log("month : "+month);
	 
if(month === 'all'){
		 month = '전체';
	 } else {
		 month = month+'월';
	 }
	 
	 console.log("monthTotal :"+monthTotal);
	 
	 const myChart = new Chart(ctx, {
		    plugins: [ChartDataLabels],
		    type: 'bar',
		    data: {
		        labels: ['전체금액', '정산금액', '정산대기', 'admin 수익'],
		        datasets: [{
		            label: '전체',
		            data: [monthTotal, completeTotal, waitTotal, adminCash],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255, 99, 132, 1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)'
		            ],
		            borderWidth: 1,
		            datalabels: {
		                anchor: 'end',
		                align: 'top',
		                formatter: (value, context) => {
		                    // value를 정수로 반올림하고, 천 단위로 콤마를 추가하고, "원"을 붙임
		                    return Math.round(value).toLocaleString() + '원';
		                },
		                font: {
		                    size: 14,
		                },
		                color: 'rgba(0, 0, 0, 1)', // 데이터 레이블의 색상 설정
		            }
		        }]
		    },
		    options: {
		    	plugins:{
		    		title:{
		    			display:true,
		    			text:month
		    		},
		    		legend:{
		    			display:false
		    		}
		    	},
		        scales: {
		            y: {
		                beginAtZero: true,
		                fontColor: 'rgba(102, 102, 102, 1)',
		                fontSize: 14
		            }
		        }
		    }
		});

	});
document.addEventListener("DOMContentLoaded", function () {
    
    const ctx = document.getElementById('myPieChart');
    let first = ${firstSeasonCash};
    let second = ${secondSeasonCash};
    let third = ${thirdSeasonCash};
    let fourth = ${fourthSeasonCash};
     
    if(first == null || first == ''){
      first = 0;
    } else{
    	first = first * 5/95;
    }
    if(second == null || second == ''){
      second = 0;
      } else{
    	  second = second * 5/95;
      }
    if(third == null || third == ''){
      third = 0;
      } else{
    	  third=third * 5/95;
      }
    if(fourth == null || fourth == ''){
      fourth = 0;
      } else{
    	  fourth=fourth * 5/95;
      }
    
    
     const myChart = new Chart(ctx, {
          plugins: [ChartDataLabels],
          type: 'pie',
          data: {
              labels: ['1분기', '2분기', '3분기', '4분기'],
              datasets: [{
                //  data: [jan, fab, mar, apr, may, jun, jul, aug, sep, oct, nov, dec],
                data: [first, second, third, fourth],
                  backgroundColor: [
                      'rgba(255, 102, 204, 0.2)',
                      'rgba(255, 204, 0, 0.2)',
                      'rgba(204, 153, 255, 0.2)',
                      'rgba(102, 153, 0, 0.2)'
                  ],
                  borderColor: [
                    'rgba(255, 102, 204, 1)',
                    'rgba(255, 204, 0, 1)',
                    'rgba(204, 153, 255, 1)',
                    'rgba(102, 153, 0, 1)'
                  ],
                  borderWidth: 1,
                  datalabels: {
                      anchor: 'end',
                      align: 'top',
                      formatter: (value, context) => {
                          // value를 정수로 반올림하고, 천 단위로 콤마를 추가하고, "원"을 붙임
                          return Math.round(value).toLocaleString() + '원';
                      },
                      font: {
                          size: 14,
                      },
                      color: 'rgba(0, 0, 0, 1)', // 데이터 레이블의 색상 설정
                  }
              }]
          },
          options: {
            plugins:{
              title:{
                display:true,
                text:'admin 분기별 수익 통계'
              }, 
              legend:{
                display:true,
                labels: {
                        boxWidth: 20 // 범례 아이템의 너비
                    }
              }
            },
              scales: {
                  y: {
                      beginAtZero: true,
                      fontColor: 'rgba(102, 102, 102, 1)',
                      fontSize: 14
                  }
              }
          }
      });

    });
document.addEventListener("DOMContentLoaded", function () {
	 var chartContainer = document.getElementById('chartContainer');
	   chartContainer.style.display = 'none';
	    var toggleChartBtn = document.getElementById('toggleChartBtn');

	    toggleChartBtn.addEventListener('click', function() {
	        // 토글
	        if (chartContainer.style.display === 'none') {
	            chartContainer.style.display = 'block';
	        } else {
	            chartContainer.style.display = 'none';
	        }
	    });

});


</script>
<jsp:include page="/home/top.jsp" />
<c:choose>
    <c:when test="${empty user.role}">
        <form name="detailform">
        <div id="page">
        <div class="page-content header-clear-medium">
        <div class="card card-style" style="margin-bottom: 15px ;">
          <div class="content" style="margin-bottom: 9px ;">
         <div class="alert border-red-dark alert-dismissible color-red-dark rounded-s fade show" >
           <i class="has-bg rounded-s bi bg-red-dark bi-exclamation-circle"></i>&nbsp;<strong>로그인해주세요.</strong>
         </div>
         </div>
         </div>
         </div>
         </div>
        </form>
    </c:when>
   <c:when test="${!empty user.role && user.role ne 'admin'}">
                 <form name="detailform">
        <div id="page">
        <div class="page-content header-clear-medium">
        <div class="card card-style" style="margin-bottom: 15px ;">
          <div class="content" style="margin-bottom: 9px ;">
         <div class="alert border-red-dark alert-dismissible color-red-dark rounded-s fade show" >
           <i class="has-bg rounded-s bi bg-red-dark bi-exclamation-circle"></i>&nbsp;<strong>권한이 없습니다.</strong>
         </div>
         </div>
         </div>
         </div>
         </div>
        </form>
    </c:when>
    <c:otherwise>
  <form name="detailform">
    <div id="page">
      <div class="page-content header-clear-medium">
        <div class="card card-style" style="margin-bottom: 15px ;">
          <div class="content" style="margin-bottom: 9px ;">
            <!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

            <h1 class="pb-2">
              <i class="has-bg rounded-s bi bg-mint-dark bi-currency-dollar" style="vertical-align:bottom !important; line-height: 0px!important;height: 30px !important;font-size: 30px !important; all:initial; display: inline-block;"></i>&nbsp;&nbsp;정산 승인 대상 리스트
            </h1>

          </div>
        </div>
        
        <div class="card card-style" style="margin-bottom: 15px ; align-items: center;">
          <a id="toggleChartBtn" class="btn btn-xxs border-blue-dark color-blue-dark"
                style="width:98%">
           차트보기</a>
          <div class="content" style="margin-bottom: 9px ;" id="chartContainer">
            <canvas id="myChart" width="350" height="400"></canvas>
            <canvas id="myPieChart" width="350" height="400"></canvas>
          </div>
        </div>
        
        <div class="card overflow-visible card-style">
          <div class="content mb-0">
            <div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
              <a class="btn btn-xxs bg-fade2-blue color-blue-dark"
                onclick="CashRequest()"
                style="display: inline-block; padding-top: 5px; padding-bottom: 5px; float: left; margin-top: 2px">정산</a>
                <select id="cashState" class="form-select" style="float: left; display: inline-block; width: 35%">
							    <option value="all">전체</option>
							    <option value="wait">승인 대기</option>
							    <option value="complete">승인 완료</option>
							</select>
                <select id="month" class="form-select" style="width: 25%; display: inline-block; " >
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
                style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px;margin-left: 5px; " id="searchButton">검색</a>
            </div>

            <div class="table-responsive">
                 <c:choose>
                        <c:when test="${empty cashDriverList}">
                             <div class="alert border-red-dark alert-dismissible color-red-dark rounded-s fade show" >
                              <i class="has-bg rounded-s bi bg-red-dark bi-exclamation-circle"></i>&nbsp;<strong>정산 대상이 없습니다.</strong>
                          </div>
                        </c:when>
                        <c:otherwise>
                     <c:choose>
                      <c:when test="${monthTotal ne 0}">      
                        <div align="right" id="totalMoney">
                        <c:choose>
                          <c:when test="${month eq 'all'}">
                          전체
                          </c:when>
                          <c:otherwise>
                          ${month }월
                          </c:otherwise>
                        </c:choose> 
                        
                        <span id="monthTotal"></span><br>
                        선택한 금액 총 <span id="totalRealPay"></span> 원
                        </div>
                      </c:when>
                    </c:choose>
              <table class="table color-theme mb-2" id="muhanlist">
                <thead>
                  <tr>
                    <th scope="col"><input type="checkbox" id="selectAll" onchange="checkAll(this)">회원번호</th>
                    <th scope="col">날짜</th>
                    <th scope="col">금액</th>
                    <th scope="col">정산 상태</th>
                  </tr>
                </thead>
                <tbody>
                     <c:set var="i" value="0" />   
									        <c:forEach var="cashDriverList" items="${cashDriverList}">
									         <c:set var="i" value="${ i+1 }" /> 
									             <tr class="cashItem" data-star="${cashDriverList.star}">
						                      <td><c:choose>
                                    <c:when test="${cashDriverList.star ne 1}">
                                      <input onchange="checkedMoney()" type="checkbox" id="driverCheck" class="optionCheckbox" name="option" data-userNo="${cashDriverList.userNo}" data-callDate="${cashDriverList.callDate}" data-realPay="${cashDriverList.realPay}">       
                                    </c:when>
                                  </c:choose>${cashDriverList.userNo}</td>
						                      <td>${cashDriverList.callDate}</td>
						                      <td><span class="driverCashListMoney">${cashDriverList.realPay}</span></td>
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
                           </c:forEach>  
                </tbody>
              </table>
               </c:otherwise>
                  </c:choose>

            </div>
          </div>
        </div>
      </div>
    </div>
  </form>
  </c:otherwise>
  </c:choose>
</body>
<script>
  
document.addEventListener('DOMContentLoaded', function() {

	  var monthTotalFormatSpan = document.getElementById('monthTotal');
	  var monthTotalFormat= ${monthTotal};
	  var discountedTotalFormat= ${discountedTotal};
	  var formattedMoney = parseFloat(monthTotalFormat).toLocaleString(); // myMoneyFormat를 숫자로 변환 후 형식화
	  var discountedformattedMoney = parseFloat(discountedTotalFormat).toLocaleString();
	  monthTotalFormatSpan.textContent = '총 '+formattedMoney + ' 원 / 정산 총 '+discountedformattedMoney+' 원';
	  
	  $('#totalRealPay').text(0);
	    
	    document.querySelectorAll('.driverCashListMoney').forEach(function(spanElement) {
	        var myCashListMoneyFormat = spanElement.textContent; // TpayList의 각 요소의 money 속성 가져오기
	          var formattedMyCashList = parseFloat(myCashListMoneyFormat).toLocaleString(); // 숫자로 변환 후 형식화
	          spanElement.textContent = formattedMyCashList + ' 원'; 
	    });
	    
	    

	  });

function confirmAlert(message) {
    var toastContainer = document.createElement('div');
      toastContainer.innerHTML = '<div id="notification-bar-5" class="notification-bar glass-effect detached rounded-s shadow-l fade show" data-bs-delay="15000">' +
          '<div class="toast-body px-3 py-3">' +
          '<div class="d-flex">' +
          '<div class="align-self-center">' + 
          '<span class="icon icon-xxs rounded-xs bg-fade-green scale-box"><i class="bi bi-exclamation-triangle color-green-dark font-16"></i></span>' +
          '</div>' +
          '<div class="align-self-center">' +
          '<h5 class="font-16 ps-2 ms-1 mb-0">'+message+'</h5>' +
          '</div>' +
          '</div><br>' +
          '<div class="row">' +
          '<div class="col-6">' +
          '<a href="#" id="cancel" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">취소</a>' +
          '</div>' +
          '<div class="col-6">' +
          '<a href="#" id="ok" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">확인</a>' +
          '</div>' +
          '</div>' +
          '</div>' +
          '</div>';

      document.body.appendChild(toastContainer.firstChild); // body에 토스트 알림창 추가
      
      document.getElementById('cancel').addEventListener('click', function () {
          // Remove the toast element from the DOM
          document.getElementById('notification-bar-5').remove();
      });
      document.getElementById('ok').addEventListener('click', function () {
        
    	  addCash();
      });
      $('.toast').toast('show'); // Bootstrap 토스트 표시 함수 호출
 }
function messageAlert(message) {
    var toastContainer = document.createElement('div');
      toastContainer.innerHTML = '<div id="notification-bar-5" class="notification-bar glass-effect detached rounded-s shadow-l fade show" data-bs-delay="15000">' +
          '<div class="toast-body px-3 py-3">' +
          '<div class="d-flex">' +
          '<div class="align-self-center">' +
          '<span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>' +
          '</div>' +
          '<div class="align-self-center">' +
          '<h5 class="font-16 ps-2 ms-1 mb-0">'+message+'</h5>' +
          '</div>' +
          '</div><br>' +
          '<a href="#" data-bs-dismiss="toast" id="confirmBtn" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">확인</a>' +
          '</div>' +
          '</div>';

      document.body.appendChild(toastContainer.firstChild); // body에 토스트 알림창 추가
      
      document.getElementById('confirmBtn').addEventListener('click', function () {
          // Remove the toast element from the DOM
          document.getElementById('notification-bar-5').remove();
      });
      $('.toast').toast('show'); // Bootstrap 토스트 표시 함수 호출
 }
$(document).ready(function() {

	$(function() {
	    
	    $( "#searchButton" ).on("click" , function() {
	      var month = $("#month").val();
	      self.location = "/pay/cashDriverList?month="+month;
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

	});

function CashRequest(){ 
    
    var checkboxes = document.querySelectorAll('#driverCheck');
    var checkedCount = 0;
      checkboxes.forEach(function (checkbox) {
          if (checkbox.checked) {
              checkedCount++;
          }
      });
      
      if (checkedCount === 0) {
    	  messageAlert('선택된 항목이 없습니다');
      } else {
          // 체크된 체크박스가 하나 이상인 경우에는 정산 진행
          confirmAlert('정산하시겠습니까?');
          
      }
  }
  
function checkAll(source) {
    var checkboxes = document.querySelectorAll('#driverCheck');
    
    var totalRealPay = 0;
    
    for (var checkbox of checkboxes) {
        checkbox.checked = source.checked;
    }
    checkboxes.forEach((checkbox) => {
        if (checkbox.checked) {
            var realPay = parseInt(checkbox.getAttribute('data-realPay')) || 0;
            totalRealPay += realPay;
        }
    });

            var formattedCheckedMoney = parseFloat(totalRealPay).toLocaleString(); // 숫자로 변환 후 형식화
            $('#totalRealPay').text(formattedCheckedMoney);
    }

function addCash() {
    var selectedData = [];
    document.querySelectorAll('#driverCheck').forEach(function (checkbox) {
        if (checkbox.checked) {
            var userNo = checkbox.getAttribute('data-userNo');
            var callDate = checkbox.getAttribute('data-callDate');
            var realPay = checkbox.getAttribute('data-realPay');
            
            selectedData.push({
                cashDriverNo: userNo,
                cashMonth: callDate,
                cashTotal: realPay
            });
        }
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



</script>
</html>