<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>eTa</title>

  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

</head>

<body class="theme-light">

<div id="page">

  <jsp:include page="../home/top.jsp" />

  <div class="page-content header-clear-medium">
    <input type="hidden" id="dealCode" value="${user.dealCode}">
    <input type="hidden" id="userNo" value="${user.userNo}">
    <div class="card card-style">
      <div class="content">
        <h2 class="pb-2" style=" margin-top: 10px;">택시비 딜 리스트 조회</h2>
      </div>
    </div><!-- card card-style 끝 -->

    <c:forEach var="call" items="${callList}" varStatus="status">
      <div class="card card-style" style="margin-bottom: 10px;">
        <div class="content">
          <div class="row">
            <div class="col-12">
              배차 번호 : <span class="callNo">${call.callNo}</span><br/>
              출발 : ${call.startAddr}<br/>
              도착 : ${call.endAddr}<br/>
            </div>
            <div class="col-9">
              <c:set var="deal" value="${dealList[status.index]}"/>
              제시 금액 : <span class="passengerOffer">${deal.passengerOffer}</span><br/>
              종료 시간 : <span id="limitDate">${deal.limitTime}</span>
            </div>
            <div class="col-3" style="margin-top: 10px; float: right;">
              <c:if test="${deal.callNo==callNo}">
                <button type="button" onclick="deleteDealDriver()" class="btn btn-xxs border-red-dark color-red-dark">
                  삭제
                </button>
              </c:if>
              <c:if test="${deal.callNo!=callNo || callNo==null}">
                <button type="button" class="btn-xxs btn border-blue-dark color-blue-dark offerButton">
                  제시
                </button>
              </c:if>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>

  </div> <!-- page-content header-clear-medium -->

  <!-- iOS Toast Bar-->
  <div id="offerAlert" class="notification-bar glass-effect detached rounded-s shadow-l" data-bs-delay="15000">
    <div class="toast-body px-3 py-3">
      <div class="d-flex">
        <div class="align-self-center">
          <span class="icon icon-xxs rounded-xs bg-fade-green scale-box"><i class="bi bi-exclamation-triangle color-green-dark font-16"></i></span>
        </div>
        <div class="align-self-center">
          <h5 class="font-16 ps-2 ms-1 mb-0">제시금액</h5>
        </div>
      </div>
      <p class="font-12 pt-2 mb-3">
      </p>
      <div class="align-self-center">
        <form class="demo-animation needs-validation m-0" novalidate>
          <input type="text" class="form-control rounded-xs" id="driverOffer" name="driverOffer" placeholder="제시금액을 입력하세요."/>
        </form>
      </div>
      <p class="font-12 pt-2 mb-3">
      </p>
      <div class="row">
        <div class="col-6">
          <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">취소</a>
        </div>
        <div class="col-6">
          <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-green-dark color-green-dark " aria-label="Close" id="reqButton">제시</a>
        </div>
      </div>
    </div>
  </div>
  <!-- iOS Toast Bar 끝-->

  <!-- iOS Toast Bar-->
  <div id="deleteDealAlert" class="notification-bar glass-effect detached rounded-s shadow-l" data-bs-delay="15000">
    <div class="toast-body px-3 py-3">
      <div class="d-flex">
        <div class="align-self-center">
          <span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>
        </div>
        <div class="align-self-center">
          <h5 class="font-16 ps-2 ms-1 mb-0">택시비 딜 참여를 취소하시겠습니까?</h5>
        </div>
      </div>
      <p class="font-12 pt-2 mb-3">
      </p>
      <div class="row">
        <div class="col-6">
          <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">취소</a>
        </div>
        <div class="col-6">
          <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-red-dark color-red-dark" aria-label="Close" id="deleteDeal">확인</a>
        </div>
      </div>
    </div>
  </div>
  <!-- iOS Toast Bar 끝-->

  <!--Warning Toast Bar-->
  <div id="dealOfferError" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

    <div class="align-self-center">
      <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
    </div>

    <div class="align-self-center">
      <span class="font-11 mt-n1 opacity-70">입력된 금액이 제시 금액을 <br/> 초과합니다.</span>
    </div>

    <div class="align-self-center ms-auto">
      <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
    </div>

  </div>
  <!--Warning Toast Bar 끝 -->

  <!--Warning Toast Bar-->
  <div id="alreadyDealAlert" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

    <div class="align-self-center">
      <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
    </div>

    <div class="align-self-center">
      <span class="font-11 mt-n1 opacity-70">이미 참여한 택시비 딜이 있습니다.</span>
    </div>

    <div class="align-self-center ms-auto">
      <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
    </div>

  </div>

  <div id="timeOver" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

    <div class="align-self-center">
      <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
    </div>

    <div class="align-self-center">
      <span class="font-11 mt-n1 opacity-70">시간이 지난 배차입니다.</span>
    </div>

    <div class="align-self-center ms-auto">
      <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
    </div>

  </div>
  <!--Warning Toast Bar 끝 -->
  <div id="here">

  </div>

</div> <!-- page -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/javascript/community/listDeal.js"></script>
</body>
</html>