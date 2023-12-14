<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>택시비 딜 배차</title>
  
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
  <script src="/javascript/community/addDeal.js"></script>
  
</head>

<body class="theme-light">

  <div id="page">

    <jsp:include page="../home/top.jsp" />
  
    <div class="page-content header-clear-medium">

      <div class="card card-style">
        <div class="content">
          <form class="demo-animation needs-validation m-0" style="margin-top: 5px;" novalidate>
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
            
            <button class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" type="submit" id="submitbt">제시 하기</button>
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
  
</body>
</html>