var passengerNo = "${passengerNo}";
    	var driverNo = "${driverNo}";
    	var waypointCoordinates; //경유지 좌표
    	
        async function loadMapData() {
        	
        	
            const apiUrl = "https://apis-navi.kakaomobility.com/v1/directions?origin=${currentY},${currentX}&destination=${call.endY},${call.endX}&waypoints=${call.startY},${call.startX}&priority=${call.routeOpt}";
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
                
                var waypoint = data.routes[0].sections.find(section => 
                section.guides.some(guide => guide.name === "경유지")
            	).guides.find(guide => guide.name === "경유지");

            	waypointCoordinates = { lat: waypoint.y, lng: waypoint.x };
            	console.log(waypointCoordinates);//경유지

            } catch (error) {
                console.error("Error fetching data:", error);
            }
        }

        

        const drawPolylineAndMoveMarker = (data, map) => {
            const linePath = [];
            data.routes[0].sections.forEach(section => {
                section.roads.forEach(road => {
                    road.vertexes.forEach((vertex, index) => {
                        if (index % 2 === 0) {
                            const lat = road.vertexes[index + 1];
                            const lng = road.vertexes[index];
                            linePath.push(new kakao.maps.LatLng(lat, lng));
                        }
                    });
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

            const intervalId = setInterval(moveMarker, 100);
        };

        var locationBuffer = [];
        var firstLocation = null;
        var lastLocation = null;
        
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
        var passedWaypoint = false;//경유지 지났는지 확인

        function addLocation(locationData) {
            // 경유지 좌표와 현재 위치가 일치하는지 확인
            if (locationData.lat === waypointCoordinates.lat && locationData.lng === waypointCoordinates.lng) {
                passedWaypoint = true; // 경유지를 지났음을 표시
            }

            // 경유지를 지난 후의 위치 데이터만 추가
            if (passedWaypoint) {
                locationBuffer.push(locationData);
            }
        }

        function connectWebSocket() {
            var socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);

            stompClient.connect({}, function (frame) {
                console.log('Connected: ' + frame);
                loadMapData();
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
                        startX: firstLocation.lat,
                        startY: firstLocation.lng,
                        endX: lastLocation.lat,
                        endY: lastLocation.lng,
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
            stompClient2.send("/sendNotification/" + passengerNo, {}, '운행종료');
        }