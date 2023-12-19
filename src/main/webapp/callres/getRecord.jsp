<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ page import="kr.pe.eta.domain.User"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet">
<link rel="manifest" href="_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180"
	href="app/icons/icon-192x192.png">
	<link rel="stylesheet" type="text/css"
	href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css"
	href="/templates/styles/style.css">
</head>
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



<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62&libraries=services"></script>
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62"></script>

<script>
	var routeId = "${call.callNo}";
	console.log("Fetching route data from MongoDB for ID:", routeId);
	var url = '/route/' + routeId;

	$.ajax({
		url : url,
		method : 'GET',
		success : function(response) {
			console.log("Successfully fetched route data:", response);
			const linePath = [];
			var bounds = new kakao.maps.LatLngBounds();

			for (let i = 0; i < response.route.length; i += 2) {
				const lat = response.route[i];
				const lng = response.route[i + 1];
				linePath.push(new kakao.maps.LatLng(lat, lng));
				bounds.extend(new kakao.maps.LatLng(lat, lng));
			}

			var polyline = new kakao.maps.Polyline({
				path : linePath,
				strokeWeight : 5,
				strokeColor : '#000000',
				strokeOpacity : 0.7,
				strokeStyle : 'solid'
			});

			polyline.setMap(map);
			map.setBounds(bounds);
		},
		error : function(error) {
			console.error("Error fetching route data from MongoDB: ", error);
		}
	});

	$(document).ready(function() {
	    $("#accordion5-3-button").click(function() {
	    	 var accordionId = "#accordion5-3";


	            // AJAX 요청 및 아코디언 처리
	            var badCallNo = routeId;
	            $.ajax({
	                url : '/feedback/updateBlacklist/' + badCallNo,
	            
	                type : 'GET',
	                success : function(response) {
						// 성공 시, 아코디언 본문에 내용 삽입
						;
						if ($(accordionId).hasClass('show')) {
		                    $(accordionId).collapse('hide');
		                } else {
		                    $(accordionId).collapse('show');
		                    $("#accordion5-3").html(response)
		                }
					},
	                error : function(error) {
	                    console.log("오류 응답:", error);
	                }
	            });
	        
	    });
	});
	
	$(document).ready(function() {
	    $("#accordion5-2-button").click(function() {
	    	var accordionId = "#accordion5-2";

	        // 아코디언이 이미 열려있는지 확인

	            // AJAX 요청 및 아코디언 처리
	            var badCallNo = routeId;
	            $.ajax({
	                url : '/feedback/updateStar/' + badCallNo,
	                type : 'GET',
	                success : function(response) {
						// 성공 시, 아코디언 본문에 내용 삽입
						
						if ($(accordionId).hasClass('show')) {
		                    $(accordionId).collapse('hide');
		                } else {
		                    $(accordionId).collapse('show');
		                    $("#accordion5-2").html(response);
		                }
					},
	                error : function(error) {
	                    console.log("오류 응답:", error);
	                }
	            });
	        
	    });
	});
</script>
</head>
<body class="theme-light">
	<%
	User user = (User) session.getAttribute("user");
	%>

	<div id='page'>
	<jsp:include page="/home/top.jsp" />
		<div class="page-content header-clear-medium">
			<div class="card card-style">
				<div class="content">
				
					<h6 class="font-700 mb-n1 color-highlight">Gorgeous Styles</h6>
					<h1 class="pb-2">
						<c:choose>
							<c:when test="${sessionScope.user.role == 'passenger'}">
                            이용기록
                        </c:when>
							<c:otherwise>
                            운행기록
                        </c:otherwise>
						</c:choose>
					</h1>

					<div class="section-title">운행 정보</div>
					<ul class="mb-0 ps-3">
						<li class="info-item"><span class="info-label">배차 번호:</span>
							<span class="info-value">${call.callNo}</span></li>
						<li class="info-item"><span class="info-label">출발:</span> <span
							class="info-value">${call.startKeyword}</span></li>
						<li class="info-item"><span class="info-label">도착:</span> <span
							class="info-value">${call.endKeyword}</span></li>
						<li class="info-item"><span class="info-label">호출 옵션:</span>
							<span class="info-value">${call.callCode}</span></li>
						<li class="info-item"><span class="info-label">운행 종료
								시간:</span> <span class="info-value">${call.callDate}</span></li>
					</ul>

					<c:if test="${sessionScope.user.role == 'passenger'}">
						<div class="section-title">택시 정보</div>
						<ul class="mb-0 ps-3">
							<li class="info-item"><span class="info-label">기사 번호:</span>
								<span class="info-value">${users.phone}</span></li>
							<li class="info-item"><span class="info-label">차량 번호:</span>
								<span class="info-value">${users.carNum}</span></li>
						</ul>
						
						<div class="accordion accordion-m border-0" id="accordion-group-5">
						<div class="accordion-item">
							<button class="accordion-button px-0 ps-1 collapsed"
								type="button" data-bs-toggle="collapse"
								data-bs-target="#accordion5-2" id="accordion5-2-button" data-target="#accordion5-2">
								<i class="bi bi-star-fill color-yellow-dark pe-3 font-14"></i> <span
									class="font-600 font-13">별점</span> <i
									class="bi bi-plus font-20"></i>
							</button>
							<div id="accordion5-2" class="accordion-collapse collapse"
								data-bs-parent="#accordion-group-5">
							<h5 class="pt-1 font-700">This is an Image</h5>
							<p class="mb-0 pb-3 opacity-70">
								This is the accordion body. It can support most content you want without restrictions. You can use
								images, videos lists or whatever you want.
							</p>
							</div>
						</div>
						</div>
						
						
					</c:if>
					<c:if test="${sessionScope.user.role == 'driver'}">
						<div class="section-title">Passenger 정보</div>
						<ul class="mb-0 ps-3">
							<li class="info-item"><span class="info-label">Passenger
									정보:</span> <span class="info-value">${users.userNo}</span></li>
						</ul>
						
					<div class="accordion accordion-m border-0" id="accordion-group-5">
						<div class="accordion-item">
							<button class="accordion-button px-0 ps-1 collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#accordion5-3" id="accordion5-3-button" data-target="#accordion5-3">
								<i class="bi bi-check-circle-fill color-green-dark pe-3 font-14"></i>
								<span class="font-600 font-13">블랙리스트</span>
								<i class="bi bi-arrow-down-short font-20"></i>
							</button>
							<div id="accordion5-3" class="accordion-collapse collapse" data-bs-parent="#accordion-group-5">
							<p class="mb-0 pb-3 opacity-70">
	
								</p>
							</div>
						</div>
					</div>

					</c:if>
					<c:if test="${sessionScope.user.role == 'admin'}">
						<div class="section-title">관리자 정보</div>
						<ul class="mb-0 ps-3">
							<li class="info-item"><span class="info-label">Passenger
									정보:</span> <span class="info-value">${users.userNo},
									${call.callNo}</span></li>
							<li class="info-item"><span class="info-label">택시 정보:</span>
								<span class="info-value">${users.phone}, ${call.callNo},
									${users.carNum}, ${call.star}</span></li>
						</ul>
					</c:if>
				</div>
			</div>
			</div>

			<div
				style="margin-top: 10px; display: flex; justify-content: center; align-items: center; height: 100%;">
				<div id="map"
					style="width: 90%; height: 300px; border-radius: 15px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);"></div>
			</div>
		</div>


	<script>
		var mapContainer = document.getElementById('map'), mapOption = {
			center : new kakao.maps.LatLng(37.4939072071976, 127.0143838311636),
			level : 3
		};
		var map = new kakao.maps.Map(mapContainer, mapOption);
	</script>


	<script src="/templates/scripts/bootstrap.min.js"></script>
	<script src="/templates/scripts/custom.js"></script>
</body>
</html>
