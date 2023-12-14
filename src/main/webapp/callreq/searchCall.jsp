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
<title>searchCall</title>
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
<style>
  .center-container {
    text-align: center;
    font-weight: bold;
  }
</style>
</head>
<body class="theme-light">
<jsp:include page="/home/top.jsp" />
<div id="page">
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
</div>
</div>
</div>
</body>
<script>

document.addEventListener('DOMContentLoaded', function() {
	
	var callNo = document.getElementById('callNo').value;
	
    window.callNo = {
    		callNo: callNo
            };
    
});


function removeMessage() {

	   alert("배차에 실패하였습니다.");
	   $("form").attr("method" , "GET").attr("action" , "/callreq/deleteCall").submit();
}

function deleteCall(){
	
	 var result = confirm("배차 탐색을 취소하시겠습니까?");

	  if (result == true) {
		  $("form").attr("method" , "GET").attr("action" , "/callreq/deleteCall").submit();
	  } else {

	  }  
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