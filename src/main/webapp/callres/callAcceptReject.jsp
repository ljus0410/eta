<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Websocket Call Handler</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
	var passengerNo = ${passengerNo};
	console.log(passengerNo);
    window.onload = function() {
        var acceptButton = document.querySelector('.btn.border-green-dark');
        var rejectButton = document.querySelector('.btn.border-blue-dark');

        // 수락 버튼 이벤트 리스너
        acceptButton.addEventListener('click', function() {
            var callNo = ${call.callNo}; // JSTL 변수를 JavaScript 변수로 변환

            // 첫 번째 AJAX 요청 (삭제)
            var xhrDelete = new XMLHttpRequest();
            xhrDelete.open('POST', '/callres/json/deleteRequest/' + callNo, true);
            xhrDelete.onload = function() {
                if (this.status === 200) {
                	var socket = new SockJS('/websoket');
                    var stompClient = Stomp.over(socket);

                    stompClient.connect({}, function(frame) {
                        // 연결 성공 시 콜백
                        stompClient.send("/sendStartNotification/" + passengerNo, {}, '운행시작');
                    }, function(error) {
                        // 연결 실패 시 콜백
                        console.error('Stomp connection error: ' + error);
                    });

                    // 두 번째 요청 (수락 처리)
                    window.location.href = '/callres/callAccept?callNo=' + callNo;
                } else {
                    // 오류 처리
                    console.error('Delete request failed: ' + this.status);
                }
            };
            xhrDelete.send();
        });

        // 거절 버튼 이벤트 리스너
        rejectButton.addEventListener('click', function() {
            window.location.href = '/callres/json/getRequest';
        });
    };
</script>


</head>
<body>
	<div id='page'>
		<jsp:include page="/home/top.jsp" />
		 <c:choose>
            <c:when test="${not empty call}">
		<div class="page-content header-clear-medium">
			<div class="card card-style">
				<div class="content">
					<p>
						<strong>출발지 키워드:</strong> ${call.startKeyword}
					</p>
					<p>
						<strong>도착지 키워드:</strong> ${call.endKeyword}
					</p>

					<div class="col-4">
						<a href="#"
							class="btn-full btn border-green-dark color-green-dark">수락</a>
					</div>
					<div class="col-4 mb-4 pb-1">
						<a href="#" class="btn-full btn border-blue-dark color-blue-dark">거절</a>
					</div>
				</div>
			</div>
		</div>
	</c:when>
            <c:otherwise>
                <div style="text-align: center; color: gray; margin-top: 20%;">
                    <h2 style="opacity: 0.5;">요청 배차가 없습니다</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>