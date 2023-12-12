<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62&libraries=services"></script>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

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

        const drawPolylineAndMoveMarker = (data, map) => {
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

            let marker = new kakao.maps.Marker({
                map: map,
                position: linePath[0],
            });

            let index = 0;

            const moveMarker = () => {
                if (index < linePath.length) {
                    marker.setPosition(linePath[index]);
                    map.setCenter(linePath[index]);
                    sendLocationToServer(linePath[index]);
                    index++;
                } else {
                    clearInterval(intervalId);
                }
            };

            const intervalId = setInterval(moveMarker, 500);
        };

        var locationBuffer = [];
        var firstLocation = null;
        var lastLocation = null;
        var passengerNo = "${passengerNo}";
        var stompClient = null;

        function sendLocationToServer(index) {
            if (stompClient && stompClient.connected) {
                const location = index;
                const locationData = { lat: location.getLat(), lng: location.getLng() };
                stompClient.send("/sendLocation/" + passengerNo, {}, JSON.stringify(locationData));
                addLocation(locationData);

                if (!firstLocation) {
                    firstLocation = locationData;
                }

                lastLocation = locationData;
            } else {
                console.error("Websocket is not connected.");
            }
        }

        function addLocation(locationData) {
            locationBuffer.push(locationData);
        }

        function connectWebSocket() {
            var socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);

            stompClient.connect({}, function (frame) {
                console.log('Connected: ' + frame);
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

                $.ajax({
                    url: '/callres/callEnd',
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

            var routeDto = {
                callNo: callNo,
                route: locationBuffer.flatMap(loc => [loc.lat, loc.lng])
            };

            console.log(routeDto);

            $.ajax({
                url: '/route/saveRoute',
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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62&libraries=services"></script>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62"></script>
    <script>
        var mapContainer = document.getElementById('map'),
            mapOption = {
                center: new kakao.maps.LatLng(37.4939072071976, 127.0143838311636),
                level: 3
            };

        var map = new kakao.maps.Map(mapContainer, mapOption);
    </script>
</body>
</html>
