<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62&libraries=services"></script>

<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62"></script>

<script>

var passengerNo = '1003';

var socket2 = new SockJS('/websoket');

var stompClient2 = Stomp.over(socket2);

  

stompClient2.connect({}, function(frame) {

stompClient2.subscribe('/topic/notifications'+passengerNo, function(notification) {

// 알림을 받으면 확인 버튼을 표시

if(confirm(notification.body)) {

// 사용자가 '확인'을 클릭하면 drivingP.jsp로 이동

window.location.href = '/callres/home.jsp';

}

});

});

</script>

</head>

<body>

<div class="col-md-6">

<div id="map" style="width:100%;height:710px;"></div>

</div>

  

<script>

var mapContainer = document.getElementById('map'),

mapOption = {

center: new kakao.maps.LatLng(37.4939072071976, 127.0143838311636),

level: 3

};

  

var map = new kakao.maps.Map(mapContainer, mapOption);

var marker = new kakao.maps.Marker({map: map}); // 전역 스코프에서 마커 정의

var passengerNo = '1003';

//세션에서 처리되어야될 값

var stompClient = null;

  

function connect() {

var socket = new SockJS('/ws');

stompClient = Stomp.over(socket);

  

stompClient.connect({}, function (frame) {

console.log('Connected: ' + frame);

  

stompClient.subscribe('/topic/location/'+passengerNo, function (message) {

var locationData = JSON.parse(message.body);

console.log("Received location for " + passengerNo + ": ", locationData.lat, locationData.lng);

console.log(locationData);

moveMarker(locationData);

});

});

}

  

connect();

  

  

function moveMarker(locationData) {

var newPosition = new kakao.maps.LatLng(locationData.lat, locationData.lng);

marker.setPosition(newPosition);

map.setCenter(newPosition);

}

</script>

</body>

</html>