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
<meta charset="UTF-8">
<title>eTa</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="../_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="../app/icons/icon-192x192.png">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<style>
  .center-container {
    text-align: center;
    font-weight: bold;
  }
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
<div id="page">
<div id="notification-bar-6" class="notification-bar bg-dark-dark detached rounded-s shadow-l" data-bs-delay="15000">
            <div class="toast-body px-3 py-3">
                <div class="d-flex">
                    <div class="align-self-center">
                        <span class="icon icon-xxs rounded-xl bg-fade2-green scale-box">
                            <i class="bi bi-check-circle color-green-dark font-17"></i>
                        </span>
                    </div>
                    <div class="align-self-center">
                        <h5 class="font-16 ps-2 ms-1 mb-0 color-white">배차 완료</h5>
                    </div>
                </div>
                <p id="notificationMessage" class="font-12 pt-2 mb-3 color-white opacity-70">
                    배차 요청이 수락되셨습니다. 택시 기사의 위치를 보시겠습니까?
                </p>
                <div class="row">
                    <div class="col-6">
                        <a href="#" data-bs-dismiss="toast" id="confirmButton" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">Okay</a>
                    </div>
                </div>
            </div>
        </div>
<div class="page-content header-clear-medium">
      <div class="card card-style">
		    <div class="center-container">
		      배차 탐색 중<br>
		      <img src="../images/Taxi.gif" width="300" height="200">
		    </div>
    <c:set var="i" value="0" />
    <c:forEach var="callDriverNo" items="${driverNoResult}">
      <c:set var="i" value="${ i+1 }" />
      <div id="callDriverNo">
      <input type="hidden" value="${callDriverNo}" id="driverNo">
      </div>
    </c:forEach>
<form>
<input type="hidden" name="callNo" id="callNo" value="${callNo}">
<input type="hidden" value="${driverNoResult}" name=driverNoResult>
<button type="button" class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" onclick="deleteCall()">취소</button>
</form>
<input type="hidden" value="${user.userNo}" id="userNo">
</div>
</div>
</div>
</c:otherwise>
</c:choose>
</body>
<script>



var passengerNo = document.getElementById('userNo').value;
console.log(passengerNo);

var socket = new SockJS('/websoket');
var stompClient = Stomp.over(socket);
var modal = document.getElementById('notification-bar-6');
var confirmBtn = document.getElementById('confirmButton');


stompClient.connect({}, function(frame) {
   console.log('Connected: ' + frame);
    confirmBtn.onclick = function() {
    	var callNo = document.getElementById('callNo').value;
        window.location.href = '/callres/drivingP.jsp?callNo=' + callNo;
    }
    stompClient.subscribe('/topic/startnotifications/' + passengerNo, function(notification) {
       var messageElement = document.getElementById('notificationMessage');
        if (messageElement) {
            messageElement.innerText = notification.body;
            console.log(notification.body);
            showModal(); // 모달 표시
        } else {
            console.error('notificationMessage element not found');
        }
    });
});

function showModal() {
    // Bootstrap의 Toast 컴포넌트를 활용하여 모달 표시
    var toastEl = new bootstrap.Toast(modal, {
        autohide: false // 자동 숨김 비활성화
    });
    toastEl.show();
}
document.addEventListener('DOMContentLoaded', function() {
	
	var callNo = document.getElementById('callNo').value;
	
    window.callNo = {
    		callNo: callNo
            };
    
    setTimeout(function() {
    	  removeMessage();
    	}, 120000);
    
});


function removeMessage() {
	   var message = '배차에 실패하였습니다';
	   messageAlert(message);
}

function deleteCall(){
	
	 var message = '배차 탐색을 취소하시겠습니까?';
	 confirmAlert(message);

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
	    	 $("form").attr("method" , "GET").attr("action" , "/callreq/deleteCall").submit();
	     });
	     $('.toast').toast('show'); // Bootstrap 토스트 표시 함수 호출
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
          '<div class="row">' +
          '<div class="col-6">' +
          '<a href="#" id="cancel" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">아니오</a>' +
          '</div>' +
          '<div class="col-6">' +
          '<a href="#" id="ok" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">예</a>' +
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
    	  $("form").attr("method" , "GET").attr("action" , "/callreq/deleteCall").submit();
    	  
      });
      $('.toast').toast('show'); // Bootstrap 토스트 표시 함수 호출
 }
/*function connectWebSocket() {
    var socket = new SockJS('/ws'); // '/ws'는 서버의 웹소켓 연결 URL
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);
        // 추가 구독 설정
        
        socket.onclose = function () {
            console.log('WebSocket connection closed');
          };
          
          var driverNo = document.getElementById('driverNo').value;

          //alert(driverNo);        
          
          sendLocationToServer(driverNo);     
          
    }, function (error) {
        console.error('Websocket connection error: ', error);
    
    });

}

function sendLocationToServer(driverNo) {
  if (stompClient && stompClient.connected) {
      const callNo = window.callNo.callNo;
      stompClient.send("/sendCall/" + driverNo, {}, callNo);
      
      setTimeout(() => {
    	  removeMessage();
        }, 2 * 60 * 1000); // 2분(밀리초 단위)
    
  } else {
      console.error("Websocket is not connected.");
  }
}
connectWebSocket();*/

</script>
</html>