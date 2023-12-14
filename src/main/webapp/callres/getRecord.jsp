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
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="app/icons/icon-192x192.png">
</head>
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
                <ul class="mb-0 ps-3">
                    <li>${call.callDate} </li>
                    <li>${call.startKeyword} </li>
                    <li>${call.endKeyword}</li>
                    <li>${call.realPay}</li>
                    <c:if test="${sessionScope.user.role == 'passenger'}">
                        <li>택시 정보: ${users.phone}, ${call.callNo}, ${users.carNum}, ${call.star}</li>
                    </c:if>
                    <c:if test="${sessionScope.user.role == 'driver'}">
                        <li>passenger 정보: ${users.userNo}, ${call.callNo}</li>
                    </c:if>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li>passenger 정보: ${users.userNo}, ${call.callNo}</li>
                        <li>택시 정보: ${users.phone}, ${call.callNo}, ${users.carNum}, ${call.star}</li>
                    </c:if>
                </ul>
            </div>
        </div>
        
        <div style="margin-top: 10px; display: flex; justify-content: center; align-items: center; height: 100%;">
            <div id="map" style="width: 90%; height: 300px; border-radius: 15px; box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);"></div>
        </div>
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
