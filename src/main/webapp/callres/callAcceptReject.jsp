<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Websocket Call Handler</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
    var passengerNo = ${passengerNo};
    console.log(passengerNo);
    window.onload = function() {
        var acceptButton = document.querySelector('.btn.border-green-dark');
        var rejectButton = document.querySelector('.btn.border-blue-dark');

        // 수락 버튼 이벤트 리스너
        acceptButton.addEventListener('click', function() {
            var callNo = ${call.callNo}; // JSTL 변수를 JavaScript 변수로 변환
            var callCode = '${call.callCode}';
			console.log(callCode);
            // 첫 번째 AJAX 요청 (삭제)
            var xhrDelete = new XMLHttpRequest();
            xhrDelete.open('POST', '/callres/json/deleteRequest/' + callNo, true);
            xhrDelete.onload = function() {
                if (this.status === 200) {
                    var socket = new SockJS('/websoket');
                    var stompClient = Stomp.over(socket);

                    stompClient.connect({}, function(frame) {
                        // 연결 성공 시 콜백
                        if(callCode === 'R'){
                        	stompClient.send("/sendStartNotification/" + passengerNo, {}, '예약 완료');
                        }
                        else{
                        	stompClient.send("/sendStartNotification/" + passengerNo, {}, '운행시작');
                        }
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

<style>
/* 기존 스타일 유지 */
.record-container {
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
	margin-bottom: 10px;
	cursor: pointer;
}

.record-container p {
	margin-right: 20px;
}

.content p {
	margin-top: 3px; /* 상단 간격을 줄임 */
	margin-bottom: 3px; /* 하단 간격을 줄임 */
}

.w-100 {
	margin-bottom: 15px; /* 각 결과 항목 사이의 거리를 조정 */
}
</style>
</head>
<body class="theme-light">
	<div id='page'>
		<jsp:include page="/home/top.jsp" />
		<div class="page-content header-clear-medium">
			<div class="card card-style">
				<div class="content">

					<h6 class="font-700 mb-n1 color-highlight">Request List</h6>
					<h1 class="pb-2">
						<i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;배차
						요청
					</h1>
				</div>
			</div>
			<c:choose>
				<c:when test="${not empty call}">
					<div class="w-100" data-callno="${record.callNo}">
						<div class="card card-style mb-0">
							<div class="content">
								<div
									style="display: flex; align-items: center; margin-bottom: 10px;">
									<img src="/images/taxi.png"
										style="height: 1.5em; margin-right: 10px;">
									<h4 class="font-20 font-800" style="margin-bottom: 0;">요청
										수락</h4>
								</div>
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
									<a href="#"
										class="btn-full btn border-blue-dark color-blue-dark">거절</a>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="text-center" style="color: grey; margin-top: 50px;">배차
						요청이 존재하지 않습니다.</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>
