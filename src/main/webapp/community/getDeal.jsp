<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>택시비 딜 상세 조회</title>
  
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

</head>

<body class="theme-light">

  <div id="page">

    <jsp:include page="../home/top.jsp" />
  
    <div class="page-content header-clear-medium">

      <div class="card card-style">
        <div class="content">
          <div class="row">
            <div class="col-9">
              <h2 class="pb-2" style=" margin-top: 10px;">택시비 딜 상세조회</h2>
            </div>
            <div class="col-3">
              <a class="btn btn-xxs border-red-dark color-red-dark" id="dealDelete" style=" margin-top: 5px;">삭제</a>
            </div>
          </div>
        </div>
      </div><!-- card card-style 끝 -->
    
      <div class="card card-style">
        <div class="content">
          <ul class="mb-0 ps-3">
            <input type="hidden" id="callNo" value="${call.callNo}">
            <input type="hidden" id="userNo" value="${user.userNo}">
            <input type="hidden" id="limitTime" value="${dealReq.limitTime}">
            <li><strong>출발</strong> : ${call.startAddr}</li>
            <li><strong>도착</strong> : ${call.endAddr}</li>
            <li><strong>경로 옵션</strong> : ${call.routeOpt}</li>
            <li><strong>제시 금액</strong> : ${dealReq.passengerOffer}</li>
            <li><strong>종료 시간</strong> : ${dealReq.limitTime}</li>
          </ul>
        </div>
      </div><!-- card card-style 끝 -->
      
      <div class="card card-style" style="margin-bottom: 20px;">
        <div class="content">
            <c:choose>
              <c:when test="${empty driverList}">
                <h5 class="pb-2" style=" margin-top: 10px;">참여한 driver가 없습니다.</h5>
              </c:when>
              <c:otherwise>
                <form>
                <c:forEach var="driver" items="${driverList}">
                  <input type="radio" name="driverNo" id="driverNo" value="${driver.userNo}"> &nbsp; &nbsp; ${driver.userNo} : ${driver.driverOffer} 원 / ${driver.starAvg} 점 <br/>
                </c:forEach>
                </form>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

      <button class="btn-full btn bg-fade2-blue color-blue-dark" type="submit" style="float: right; margin-right: 15px;" id="match">선택하기</button>
    
    </div><!-- page-content header-clear-medium 끝 -->

  <!-- iOS Toast Bar-->
  <div id="dealDeleteAlert" class="notification-bar glass-effect detached rounded-s shadow-l" data-bs-delay="15000">
    <div class="toast-body px-3 py-3">
      <div class="d-flex">
        <div class="align-self-center">
          <span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>
        </div>
        <div class="align-self-center">
          <h5 class="font-16 ps-2 ms-1 mb-0">택시비 딜을 취소하시겠습니까?</h5>
        </div>
      </div>
      <p class="font-12 pt-2 mb-3">
      </p>
      <div class="row">
        <div class="col-6">
          <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">취소</a>
        </div>
        <div class="col-6">
          <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-red-dark color-red-dark" aria-label="Close"  onclick="deleteReq()">삭제</a>
        </div>
      </div>
    </div>
  </div>
  <!-- iOS Toast Bar 끝-->

    <div id="timeOver" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

      <div class="align-self-center">
        <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
      </div>

      <div class="align-self-center">
        <span class="font-11 mt-n1 opacity-70">시간이 지났습니다.</span>
      </div>

      <div class="align-self-center ms-auto">
        <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
      </div>

    </div>

    <div id="noSelectDriver" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

      <div class="align-self-center">
        <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
      </div>

      <div class="align-self-center">
        <span class="font-11 mt-n1 opacity-70">선택한 driver가 없습니다.</span>
      </div>

      <div class="align-self-center ms-auto">
        <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
      </div>

    </div>
  
  </div><!-- page 끝 -->

  <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

  <script>
    const socket = new SockJS('/ws');
    const stompClient = Stomp.over(socket);

    function sendDeal(driverNo) {
      const callNo = document.getElementById('callNo').value;

      const message = {
        callNo: callNo,
        content: "택시비 딜 배차를 시작하시겠습니까?"
      };

      stompClient.send("/deal/"+driverNo, {}, JSON.stringify(message));
      self.location='/callres/drivingP.jsp?callNo='+callNo;
    }

    function deleteReq() {
      self.location="/community/deleteDealReq?callNo="+${dealReq.callNo};
    }

    $(function() {

      $( "#dealDelete" ).on("click" , function() {
        $('#dealDeleteAlert').addClass('fade show');
      });

      $( "#match" ).on("click" , function() {

        if($("input[name='driverNo']:checked").length > 0) {
          let currentDate = new Date();
          let limitDate =  new Date($("#limitTime").val());

          if (currentDate > limitDate) {
            $('#timeOver').addClass('fade show');
            setTimeout(() => {
              deleteReq();
            }, 3 * 1000);
          } else {
            let driverNo = $("input[name='driverNo']:checked").val();
            sendDeal(driverNo);
          }
        } else {
          $("#noSelectDriver").addClass("fade show")
        }


      });

    });

  </script>
</body>
</html>