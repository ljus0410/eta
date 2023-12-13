<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>택시비 딜 배차</title>
  
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
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
  
  <script type="text/javascript">
  
    $(function() {

        $("a[href='#']").on("click" , function() {
          $("form")[0].reset();
        });
        
    });

    $(function (){

        $( "#submitbt" ).on("click" , function() {

          let preMoney = parseFloat($("#money").val()); // 문자열을 숫자로 변환
          let TPay = parseFloat($("#myMoney").val()); // 문자열을 숫자로 변환
          let offer = parseFloat($("#passengerOffer").val()); // 문자열을 숫자로 변환

          if (offer > TPay && offer > preMoney) {
            $('#notification-bar-5').removeClass('notification-bar glass-effect detached rounded-s shadow-l')
              .addClass('notification-bar glass-effect detached rounded-s shadow-l fade show');
              return;
          } else if (offer < preMoney && offer < TPay) {
            $('#toast-top-2').removeClass('toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s')
              .addClass('toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s fade show');
              return;
          } else if (offer > preMoney && offer < TPay) {
              $("form").attr("method" , "POST").attr("action" , "/community/addDealReq").submit();
          }
        })
      })
      
      $(function () {
    	  $.ajax({
              url: "/community/json/getMyMoney",
              type: "GET",
              dataType: "json",
              success: function (response){
            	  console.log(response)
            	  var receivedInt = parseInt(response);
                $("#myMoney").val(receivedInt)
              }
        })
      })
      
      function payRequest(){
  
    var userInput = prompt("충전할 금액을 입력하세요 :");
    
    if(userInput !== null && userInput < 10000){
      alert("10000원 이상 충전이 가능합니다.");
      payRequest();
      
    } else if (userInput !== null && userInput >= 10000) {
      
      TpayCharge(userInput);
      
    } else {
      alert("충전이 취소되었습니다.");
    }

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
             pg : 'html5_inicis',
                pay_method : 'card',
                merchant_uid: "merchant_" + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
                name : 'Tpay 충전',
                amount : Tpay,
                buyer_name : userName,
                buyer_email : userEmail,
                buyer_tel : userPhone,  //필수입력
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
                    $.ajax({
                        url: "/community/json/getMyMoney",
                        type: "GET",
                        dataType: "json",
                        success: function (response){
                          console.log(response)
                          var receivedInt = parseInt(response);
                          $("#myMoney").val(receivedInt)
                        }
                  })
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
  
</head>

<body class="theme-light">

  <div id="page">
  
    <div class="page-content header-clear-medium">

      <div class="card card-style">
      
        <div class="content">
        
          <form class="demo-animation needs-validation m-0" novalidate>
          
            <input type="hidden" class="form-control" id="callNo" name="callNo" value="${callNo}">
            <input type="hidden" id="userNo" value="${user.userNo }">
            <input type="hidden" id="email" value="${user.email }">
            <input type="hidden" id="name" value="${user.name }">
            <input type="hidden" id="phone" value="${user.phone }">
  
            <div class="form-custom form-label form-icon mb-3">
              <i class="bi bi-credit-card font-12"></i>
              <input type="text" class="form-control rounded-xs" id="money"  name="money" value="${money}" readonly/>
              <label for="money" class="form-label-always-active color-theme">선결제 금액</label>
            </div>
            
            <div class="form-custom form-label form-icon mb-3">
              <i class="bi bi-currency-dollar font-12"></i>
              <input type="text" class="form-control rounded-xs" id="myMoney"  name="myMoney" readonly/>
              <label for="myMoney" class="form-label-always-active color-theme">잔여 Tpay</label>
            </div>
            
            <div class="form-custom form-label form-icon mb-3">
              <i class="bi bi-cash font-12"></i>
              <input type="text" class="form-control rounded-xs" id="passengerOffer"  name="passengerOffer"/>
              <label for="passengerOffer" class="form-label-always-active color-theme">제시금액</label>
            </div>
            
            <button class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" type="submit" id="submitbt">Submit form</button>
          
          </form>
          
        </div><!-- content -->
        
      </div><!-- card card-style -->
    
    </div><!-- page-content header-clear-medium -->
    
    <!--Warning Toast Bar-->
      <div id="toast-top-2" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">
    
        <div class="align-self-center">
          <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>
        
        <div class="align-self-center">
          <strong class="font-12 mb-n2">금액이 잘못 입력되었습니다.</strong>
          <span class="font-10 mt-n1 opacity-70">선결제 금액을 확인해주세요</span>
        </div>
        
        <div class="align-self-center ms-auto">
          <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>
        
      </div>
    <!--Warning Toast Bar 끝 -->
  
    <!-- iOS Toast Bar-->
      <div id="notification-bar-5" class="notification-bar glass-effect detached rounded-s shadow-l" data-bs-delay="15000">
        <div class="toast-body px-3 py-3">
          <div class="d-flex">
            <div class="align-self-center">
              <span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>
            </div>
            <div class="align-self-center">
              <h5 class="font-16 ps-2 ms-1 mb-0">잔여 TPay가 부족합니다.</h5>
            </div>
          </div>
          <p class="font-12 pt-2 mb-3">
            TPay 충전을 하시겠습니까?
          </p>
          <div class="row">
            <div class="col-6">
              <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">취소</a>
            </div>
            <div class="col-6">
              <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-red-dark color-red-dark" aria-label="Close"  onclick="payRequest()">충전</a>
            </div>
          </div>
        </div>
      </div>
    <!-- iOS Toast Bar 끝-->
    
  </div><!-- page -->

  <!-- templates 설정 -->
  <script src="/templates/scripts/bootstrap.min.js"></script>
  <script src="/templates/scripts/custom.js"></script>
  <!-- templates 설정 끝 -->
  
</body>
</html>