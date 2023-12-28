<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>eta</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="manifest" href="_manifest.json">
    <meta id="theme-check" name="theme-color" content="#FFFFFF">
    <link rel="apple-touch-icon" sizes="180x180" href="app/icons/icon-192x192.png">
    
    <style>
.section-title {
	font-size: 1.2em; /* 제목 크기 */
	font-weight: bold; /* 굵게 */
	color: black; /* 진한 검정색으로 변경 */
	margin-bottom: 10px; /* 제목 아래 여백 */
}

.info-item {
	display: flex; /* Flexbox 레이아웃 사용 */
	justify-content: space-between; /* 양 끝에 요소 배치 */
	margin-bottom: 5px; /* 항목 사이 여백 */
}

.info-value {
	font-weight: normal; /* 얇은 글씨체로 변경 */
	color: black; /* 검정색 */
	text-align: right; /* 값은 오른쪽 정렬 */
}

.info-label, .info-value {
	min-width: 50%; /* 라벨과 값의 최소 너비 */
}

.info-label {
	text-align: left; /* 라벨을 왼쪽 정렬 */
}
.accordion-item {
    height: auto;
    overflow: hidden; /* 내용이 넘치는 경우 숨김 */
}
</style>
</head>
<body class="theme-light">
<div id="page">
    <jsp:include page="/home/top.jsp" />
    <div class="page-content header-clear-medium">
        <div class="card card-style">
            <div class="content">
                <h6 class="font-700 mb-n1 color-highlight">Driver and Passenger Info</h6>
                <h1 class="pb-2">예약</h1>
                <ul class="mb-0 ps-3">
                    <li class="info-item"><span class="info-label">예약 시간:</span> <span class="info-value">${call.callDate}</span></li>
                    <li class="info-item"><span class="info-label">출발:</span> <span class="info-value">${call.startKeyword}</span></li>
                    <li class="info-item"><span class="info-label">도착:</span> <span class="info-value">${call.endKeyword}</span></li>
                    <li class="info-item"><span class="info-label">배차 번호:</span> <span class="info-value">${call.callNo}</span></li>

                    <c:if test="${users.role == 'driver'}">
                        <li class="info-item"><span class="info-label">Driver Info:</span>
                            <ul>
                                <li class="info-value">기사 전화번호 : ${users.phone}</li>
                                <li class="info-value">차량 번호 : ${users.carNum}</li>
                            </ul>
                        </li>
                    </c:if>

                    <c:if test="${users.role == 'passenger'}">
                        <li class="info-item"><span class="info-label">Passenger Info:</span>
                            <ul>
                                <li class="info-value">승객 번호 : ${users.userNo}</li>
                                <li class="info-value">승객 전화번호 : ${users.phone}</li>
                            </ul>
                            
                        </li>
                    </c:if>
                </ul>
            </div>
            <c:if test="${user.role == 'driver'}">
			    <div class="row">
			        <div class="col-6 mb-4 pb-1 mx-auto my-3">
			            <a href="#" class="btn-full btn border-blue-dark color-blue-dark" onclick="startDriving()" style="padding: 8px 12px; font-size: 0.9em;">
			                <i class="bi bi-gear-fill pe-3 ms-n1"></i>운행 시작
			            </a>
			        </div>
			    </div>
			</c:if>
			<c:if test="${user.role == 'passenger'}">
			    <div class="row">
			        <div class="col-6 mb-4 pb-1 mx-auto my-3">
			            <a href="#" class="btn-full btn border-blue-dark color-blue-dark" onclick="checkDriver()" style="padding: 8px 12px; font-size: 0.9em;">
			                <i class="bi bi-gear-fill pe-3 ms-n1"></i>택시 기사 위치
			            </a>
			        </div>
			    </div>
			</c:if>

        </div>
        
    </div>
</div>
<script>
    function startDriving() {
        var callNo = ${call.callNo};
        window.location.href = '/callres/startReservationDriving?callNo=' + callNo;
    }
    
    function checkDriver() {
        var callNo = ${call.callNo};
        window.location.href = '/callres/drivingP.jsp?callNo=' + callNo;
    }
</script>

        <script src="/templates/scripts/bootstrap.min.js"></script>
    <script src="/templates/scripts/custom.js"></script>
</body>
</html>
