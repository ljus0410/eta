<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchCall</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>

<div class="msgArea"></div>   <!--websocket 전송받기 test -->

배차 탐색 중<br>
배차번호 : ${callNo} <br>

    <c:set var="i" value="0" />
    <c:forEach var="callDriverList" items="${callDriverList}">
      <c:set var="i" value="${ i+1 }" />
      
      <div id="callDriverList">
      <p> petOpt, carOpt에 해당하는 driver : ${callDriverList.userNo}</p>        
      </div>
    </c:forEach>
    
<form>
<input type="hidden" name="callNo" id="callNo" value="${callNo}">
<button type="button" onclick="deleteCall()">취소</button>
</form>

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
	   $("form").attr("method" , "POST").attr("action" , "/callreq/deleteCall").submit();

}

function deleteCall(){
	
	 var result = confirm("배차 탐색을 취소하시겠습니까?");

	  if (result == true) {
		  $("form").attr("method" , "POST").attr("action" , "/callreq/deleteCall").submit();
	  } else {

	  }  
}

function connectWebSocket() {
    var socket = new SockJS('/ws'); // '/ws'는 서버의 웹소켓 연결 URL
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);
        // 추가 구독 설정
        
        socket.onclose = function () {
            console.log('WebSocket connection closed');
          };

          var driverNo = 1012;
          sendLocationToServer(driverNo);
    }, function (error) {
        console.error('Websocket connection error: ', error);
    
    });

}

function sendLocationToServer(driverNo) {
  if (stompClient && stompClient.connected) {
	    const sendDriverNo = driverNo;
      const callNo = window.callNo.callNo;
      stompClient.send("/sendCall/" + sendDriverNo, {}, callNo);
      
      setTimeout(() => {
    	  removeMessage();
        }, 2 * 60 * 1000); // 2분(밀리초 단위)
    
  } else {
      console.error("Websocket is not connected.");
  }
}
connectWebSocket();

</script>
</html>