<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Websocket Call Handler</title>

<script>
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
	</div>



</body>
</html>