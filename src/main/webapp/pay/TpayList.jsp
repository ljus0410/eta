<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TpayList</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
</head>
<body>
Tpay 이용 내역<br>
잔여 Tpay : ${myMoney} 원  <button onclick="payRequeset()">Tpay 충전</button><br>
            
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
<hr>
    

    
		<c:choose>
		    <c:when test="${empty TpayList}">
		        이용 내역이 없습니다.
		    </c:when>
		    <c:otherwise>
		        <!-- Tpay 리스트--> 
				    <c:set var="i" value="0" />
				    <c:forEach var="TpayList" items="${TpayList}">				
				      <c:set var="i" value="${ i+1 }" />				      
				      <div id="TpayList">
				      <c:choose>
				        <c:when test="${TpayList.callNo eq 0}">
				        </c:when>
				        <c:otherwise>
				         <p><button class="getRecord">${TpayList.callNo} </button>
				        </c:otherwise>
				      </c:choose>				     
				      ${TpayList.payType} ${TpayList.payDate} ${TpayList.money}</p>
				      </div> 
				    </c:forEach>		       
		    </c:otherwise>
		</c:choose>

    
    <form>
    <input type="hidden" name="userNo" value="1004">
     <input type="hidden" name="callNo" value="1044">
    <input type="hidden" name="payType" value="실결제">
    <input type="hidden" name="money" value="3000">
    <button onclick="addPay()">addPay Test</button>
    </form>
       
</body>
<script>

$(function() {
	   
	   $( "#searchButton" ).on("click" , function() {
		   var month = $("#month").val();
		   self.location = "/pay/TpayList?userNo=1004&month="+month;
	  });
	   
	     $( ".getRecord" ).on("click" , function() {
	         alert("이용기록상세조회로 이동");
	      });
});

function addPay(){
	$("form").attr("method" , "POST").attr("action" , "/pay/addPay").submit();
}
function payRequeset(){
	
	  var userInput = prompt("충전할 금액을 입력하세요 :");
	  
	  if(userInput !== null && userInput < 10000){
		  alert("10000원 이상 충전이 가능합니다.");
		  payRequeset();
		  
	  } else if (userInput !== null && userInput >= 10000) {
	    
		  TpayCharge(userInput);
		  
	  } else {
	    alert("충전이 취소되었습니다.");
	  }

}
function TpayCharge(Tpay) {
	  
	  var IMP = window.IMP;
	  IMP.init("imp16061541");
	  
	  var userNo = 1004;
	  
	    // IMP.request_pay(param, callback) 결제창 호출
	    IMP.request_pay({ // param
	       pg : 'html5_inicis',
	          pay_method : 'card',
	          merchant_uid: "merchant_" + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
	          name : 'Tpay 충전',
	          amount : Tpay,
	          buyer_name : userNo.toString(),  // 사용자 닉네임?이름?회원번호?
	          buyer_email : 'mirim666@naver.com',
	          buyer_tel : '010-0000-0000'  //필수입력
	          //buyer_postcode : '123-456',
	          //m_redirect_url : '{/purchase/addPurchase.jsp}' // 예: https://www.my-service.com/payments/complete/mobile
	    }, function (rsp) { // callback
	        if (rsp.success) {
	            alert(Tpay+"원 충전이 완료되었습니다.");
	            addCharge(Tpay, userNo);
	          
	        } else {
	           alert("충전이 실패하였습니다.");
	        }
	    });
	  }
	  
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
		            alert(response.message);
		            location.reload();
		        } else {
		            alert(response.message);
		        }
		    },
		    error: function (error) {
		      console.error('addCharge() 실패', error);
		    }
		  });

	  }
</script>
</html>