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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
<script>
function payRequest(){ 
    
    var message = '충전할 금액을 입력하세요';
    confirmAlert(message); 
}
function TpayCharge(Tpay) {
    
    var IMP = window.IMP;
    IMP.init("imp16061541");
    
    var No = document.getElementById('userNo');
    var userNo = No.value;
    var name = document.getElementById('name');
    var userName = name.value;
    var phone = document.getElementById('phone');
    var userPhone = phone.value;
    var email = document.getElementById('email');
    var userEmail = email.value;
    
    //alert(userNo, userName, userPhone, userEmail);

      // IMP.request_pay(param, callback) 결제창 호출
      IMP.request_pay({ // param
    	     // pg : 'html5_inicis',
    	      pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid: "merchant_" + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
            name : 'Tpay 충전',
            amount : Tpay,
            buyer_name : userName,
            buyer_email : userEmail,
            buyer_tel : userPhone  //필수입력
            //buyer_postcode : '123-456',
            //m_redirect_url : 'https://eta.pe.kr/pay/json/addChargeMobile'
      }, function (rsp) { // callback
          if (rsp.success) {
        	    
        	  var message = Tpay+'원 충전이 완료되었습니다';
              messageAlert(message);
              addCharge(Tpay, userNo);
                 
          } else {        
             var message ='충전이 실패하였습니다';
                messageAlert(message);
                
          }
      });
    }

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
          '<input type="text" class="form-control rounded-xs" id="moneyInput"><br>' +
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
        
        var money = document.getElementById('moneyInput').value;
          if(money !== null && money < 10000){
            document.getElementById('notification-bar-5').remove();
               var message = '10,000원 이상 충전 가능합니다'; 
               messageAlert(message);
            } else if (money !== null && money >= 10000) {
              
              TpayCharge(money);
              
            }
        
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

</script>

<style type="text/css">
  td{
    height: 100px;
  }
  #mymoney{
  font-size:15px;}
</style>
</head>
<body class="theme-light">
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
   <c:when test="${!empty user.role && user.role eq 'driver'}">
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
            <h1 class="pb-2">
              <i class="has-bg rounded-s bi bg-mint-dark bi-currency-dollar" style="vertical-align:bottom !important; line-height: 0px!important;height: 30px !important;font-size: 30px !important; all:initial; display: inline-block;"></i>&nbsp;&nbsp;Tpay 이용 내역&nbsp;
              
                        <c:choose>
                          <c:when test="${month eq 'all' }">
                           (전체)
                          </c:when>
                          <c:otherwise>
                          (${month }월)
                          </c:otherwise>
                        </c:choose>
              
            </h1>
            <span id="mymoney"style="display: inline-block; padding-top: 3px; padding-bottom: 3px; float: left;" class="badge bg-warning-subtle border border-warning-subtle text-warning-emphasis rounded-pill"></span>
          </div>
        </div>
        
        <div class="card overflow-visible card-style">
          <div class="content mb-0">
            <div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
               
              <a class="btn-full btn bg-blue-dark"
                onclick="payRequest()"
                style="display: inline-block; padding-top: 5px; padding-bottom: 5px; float: left; margin-top: 2px" ><i class="bi bi-cash-coin"></i>&nbsp;충전</a>

              <select id="month" class="form-select" style="width: 50%; display: inline-block">
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
                      <c:when test="${empty TpayList}">
                          <div class="alert border-red-dark alert-dismissible color-red-dark rounded-s fade show" >
									          <i class="has-bg rounded-s bi bg-red-dark bi-exclamation-circle"></i>&nbsp;<strong>이용 내역이 없습니다.</strong>
									        </div>
                      </c:when>
                 <c:otherwise>
              <table class="table color-theme mb-2" id="muhanlist">
                <thead>
                  <tr>
                    <th scope="col">배차번호</th>
                    <th scope="col">결제 유형</th>
                    <th scope="col">날짜</th>
                    <th scope="col">금액</th>
                  </tr>
                </thead>
                <tbody>
                       <c:set var="i" value="0" />
							            <c:forEach var="TpayList" items="${TpayList}">        
							              <c:set var="i" value="${ i+1 }" />
							              <tr class="list">
							                  <td>
							                  <c:choose>
										                <c:when test="${TpayList.callNo eq 0}">
										                  <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-currency-dollar" viewBox="0 0 16 16">
																			  <path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718H4zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73l.348.086z"></path>
																			</svg>
			                              </c:when>
			                              <c:otherwise>
			                               <a class="getRecord" data-callno="${TpayList.callNo} "> ${TpayList.callNo} </a>
			                              </c:otherwise>
			                          </c:choose>     
                               </td>
					                      <td>${TpayList.payType}</td>
					                      <td>${TpayList.payDate}</td>  
					                      <td><span class="TpayListMoney">${TpayList.money}</span></td>        
							              </tr>
	                      </c:forEach>             
                </tbody>
              </table>
              </c:otherwise>
             </c:choose>
            </div>
                <input type="hidden" id="userNo" value="${user.userNo }">
						    <input type="hidden" id="email" value="${user.email }">
						    <input type="hidden" id="name" value="${user.name }">
						    <input type="hidden" id="phone" value="${user.phone }">
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
	
	document.querySelectorAll('.TpayListMoney').forEach(function(spanElement) {
		  var TpayListMoneyFormat = spanElement.textContent; // TpayList의 각 요소의 money 속성 가져오기
		    var formattedTpayList = parseFloat(TpayListMoneyFormat).toLocaleString(); // 숫자로 변환 후 형식화
		    spanElement.textContent = formattedTpayList + ' 원'; 
	}); 
});
var myMoneyFormatSpan = document.getElementById('mymoney');
var myMoneyFormat= ${myMoney};
var formattedMoney = parseFloat(myMoneyFormat).toLocaleString(); // myMoneyFormat를 숫자로 변환 후 형식화
myMoneyFormatSpan.textContent = '잔여 Tpay '+formattedMoney + ' 원';

function addCharge(Tpay, userNo){
    $.ajax({
        type: 'POST',
        url: '/pay/json/addCharge',
        data: {
          Tpay: Tpay,
          userNo: userNo
        },
        success: function (response) {
          console.log("addCharge() 성공");          
          if (response.success) {
                messageAlert(response.message);
                
                location.reload();
            } else {
              messageAlert(response.message);
            }
        },
        error: function (error) {
          console.error('addCharge() 실패', error);
        }
      });

    }


$(function() {
	   
	   $( "#searchButton" ).on("click" , function() {
		   var month = $("#month").val();
		   self.location = '/pay/TpayList?userNo=${user.userNo}&month='+month;
	  });
	   
	    $( ".getRecord" ).on("click" , function() { 
	        
	        var callNo = $(this).data("callno");
	          self.location = "/callres/getRecordPassenger?callNo="+callNo;
	       }); 
});



</script>
</html>