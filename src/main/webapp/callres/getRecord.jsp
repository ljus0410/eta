<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  

  

<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62&libraries=services"></script>

<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62"></script>

<script>

var routeId = "${call.callNo}";

  

console.log("Fetching route data from MongoDB for ID:", routeId);

  

// Build the URL with the route ID

var url = '/route/' + routeId;

  

$.ajax({

url: url,

method: 'GET',

success: function(response) {

console.log("Successfully fetched route data:", response);

// Process the response here

// For example, if you want to draw a polyline on a map with this data

// drawPolyline(response);

const linePath = [];

var bounds = new kakao.maps.LatLngBounds();

  

// Assuming each pair of values in the array represents a latitude and longitude

for (let i = 0; i < response.route.length; i += 2) {

const lat = response.route[i];

const lng = response.route[i + 1];

linePath.push(new kakao.maps.LatLng(lat, lng));

bounds.extend(new kakao.maps.LatLng(lat, lng));

}

  

var polyline = new kakao.maps.Polyline({

path: linePath,

strokeWeight: 5,

strokeColor: '#000000',

strokeOpacity: 0.7,

strokeStyle: 'solid'

});

  

polyline.setMap(map);

map.setBounds(bounds);

},

error: function(error) {

console.error("Error fetching route data from MongoDB: ", error);

}

});

  

  

</script>

</head>

<body>

  

${call.callDate}

${call.startKeyword }

${call.endKeyword }

${call.realPay }

<c:if test="${user.role == 'driver'}">

택시 정보

${user.phone }

${call.callNo }

${user.carNum }

  

${call.star }

</c:if>

  

<c:if test="${user.role == 'passenger'}">

passenger 정보

${user.userNo }

${call.callNo }

  

  

</c:if>

  

<div id="map" style="width:100%;height:400px;"></div>

  

<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div

mapOption = {

center: new kakao.maps.LatLng(37.4939072071976, 127.0143838311636), // 지도의 중심좌표

level: 3 // 지도의 확대 레벨

};

  

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

</script>

</body>

</html>