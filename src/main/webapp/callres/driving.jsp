<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62&libraries=services"></script>

<script type="text/javascript"
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>

async function loadMapData() {

const apiUrl = 'https://apis-navi.kakaomobility.com/v1/directions?origin=${call.startX},${call.startY}&destination=${call.endX},${call.endY}';

  

  

console.log("Generated URL:", apiUrl);

  

try {

const response = await fetch(apiUrl, {

method: 'get',

headers: {

"Content-Type": "application/json",

"Authorization": "KakaoAK bb9f3068bf970e08b9d0147524d0258f"

}

});

  

if (!response.ok) {

throw new Error("Failed to fetch data");

}

  

const data = await response.json();

console.log(data);

drawPolylineAndMoveMarker(data, map);

} catch (error) {

console.error("Error fetching data:", error);

}

}

  

loadMapData();

  

const drawPolylineAndMoveMarker = (data,map) => {

const linePath = [];

data.routes[0].sections[0].roads.forEach(router => {

router.vertexes.forEach((vertex, index) => {

if (index % 2 === 0) {

const lat = router.vertexes[index + 1];

const lng = router.vertexes[index];

linePath.push(new kakao.maps.LatLng(lat, lng));

}

});

});

  

var polyline = new kakao.maps.Polyline({

path: linePath,

strokeWeight: 5,

strokeColor: '#000000',

strokeOpacity: 0.7,

strokeStyle: 'solid'

});

polyline.setMap(map);

// 마커를 생성하고 지도에 표시합니다.

let marker = new kakao.maps.Marker({

map: map,

position: linePath[0], // 폴리라인의 시작점에 마커를 배치합니다.

});

// 마커를 이동시킬 인덱스 변수를 초기화합니다.

let index = 0;

// 일정 시간 간격으로 마커를 이동시키는 함수입니다.

const moveMarker = () => {

if (index < linePath.length) {

// 현재 인덱스의 좌표로 마커를 이동시킵니다.

marker.setPosition(linePath[index]);

map.setCenter(linePath[index]);

sendLocationToServer(linePath[index]);

//////////////////////////////////////////////////////////위치보내기

index++;

} else {

// 폴리라인의 끝에 도달했다면, 인터벌을 중단합니다.

clearInterval(intervalId);

}

};

// 1초마다 마커를 이동시키기 위한 인터벌 설정

const intervalId = setInterval(moveMarker, 500);

};

var locationBuffer = []; // 위치 데이터를 저장할 배열

var firstLocation = null;

var lastLocation = null;

var passengerNo = "${passengerNo}";

var stompClient = null; // 전역 스코프에서 stompClient 초기화

function sendLocationToServer(index) {

if (stompClient && stompClient.connected) {

const location = index;

const locationData = { lat: location.getLat(), lng: location.getLng() };

stompClient.send("/sendLocation/" + passengerNo, {}, JSON.stringify(locationData));

addLocation(locationData);

if (!firstLocation) {

firstLocation = locationData;

}

  

// 마지막 위치 데이터 갱신

lastLocation = locationData;

} else {

console.error("Websocket is not connected.");

}

}

function addLocation(locationData) {

locationBuffer.push(locationData);

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

}, function (error) {

console.error('Websocket connection error: ', error);

});

}

connectWebSocket();

var callNo = ${call.callNo};

console.log("callNO: "+callNo);

  

  

function updateLocationData() {

if (firstLocation && lastLocation) {

addRouteMongo();

sendEndDriving();

// 서버에 AJAX 요청 보내기

$.ajax({

url: '/callres/callEnd', // 컨트롤러 URL

method: 'POST',

contentType: 'application/json',

data: JSON.stringify({

startX: firstLocation.lng,

startY: firstLocation.lat,

endX: lastLocation.lng,

endY: lastLocation.lat,

callNo: callNo

}),

success: function(response) {

console.log('서버에 데이터 전송 성공:', response);

window.location.href = '/callres/getRealPay?callNo=' + callNo;

},

error: function(error) {

console.error('서버에 데이터 전송 실패:', error);

}

});

} else {

console.error('위치 데이터가 충분하지 않습니다.');

}

}

function addRouteMongo() {

console.log("Saving location data to MongoDB.");

console.log(locationBuffer);

// 예시: 모든 위치 데이터를 하나의 RouteDTO로 변환

var routeDto = {

callNo: callNo, // 적절한 callNo 값 설정 필요

route: locationBuffer.flatMap(loc => [loc.lat, loc.lng])

};

console.log(routeDto);

  

// 서버에 DTO 전송하여 MongoDB에 저장 요청

// Ajax 또는 다른 HTTP 클라이언트 라이브러리 사용

$.ajax({

url: '/route/saveRoute', // 서버의 해당 엔드포인트 URL

method: 'POST',

contentType: 'application/json',

data: JSON.stringify(routeDto),

success: function (response) {

console.log("Location data saved to MongoDB successfully.");

},

error: function (error) {

console.error("Error saving location data to MongoDB: ", error);

}

});

  

// 버퍼 비우기

locationBuffer = [];

}

var socket2 = new SockJS('/websoket');

var stompClient2 = Stomp.over(socket2);

function sendEndDriving() {

stompClient2.send("/sendNotification" + passengerNo, {}, '운행종료');

}

</script>

</head>

<body>

	<div class="col-md-6">

		<div id="map" style="width: 100%; height: 710px;"></div>

	</div>

	<button onclick="updateLocationData()">운행종료</button>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62&libraries=services"></script>

	<script type="text/javascript"
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62"></script>

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