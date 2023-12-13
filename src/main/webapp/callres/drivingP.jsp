<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="manifest" href="_manifest.json">
    <meta id="theme-check" name="theme-color" content="#FFFFFF">
    <link rel="apple-touch-icon" sizes="180x180" href="app/icons/icon-192x192.png">
    <%@ page import="kr.pe.eta.domain.User"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62&libraries=services"></script>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=843ae0fd7d31559bce57a18dcd82bf62"></script>
    
</head>
<body class="theme-light">
    <div id="page">
        <div id="notification-bar-6" class="notification-bar bg-dark-dark detached rounded-s shadow-l" data-bs-delay="15000">
            <div class="toast-body px-3 py-3">
                <div class="d-flex">
                    <div class="align-self-center">
                        <span class="icon icon-xxs rounded-xl bg-fade2-green scale-box">
                            <i class="bi bi-check-circle color-green-dark font-17"></i>
                        </span>
                    </div>
                    <div class="align-self-center">
                        <h5 class="font-16 ps-2 ms-1 mb-0 color-white">Call to Action</h5>
                    </div>
                </div>
                <p id="notificationMessage" class="font-12 pt-2 mb-3 color-white opacity-70">
                    Please click a button to dismiss the notification. These are user action based.
                </p>
                <div class="row">
                    <div class="col-6">
                        <a href="#" data-bs-dismiss="toast" id="confirmButton" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">Okay</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div id="map" style="width: 100%; height: 710px;"></div>
        </div>
    </div>

    <script>
        var mapContainer = document.getElementById('map'),
        mapOption = {
            center: new kakao.maps.LatLng(37.4939072071976, 127.0143838311636),
            level: 3
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var marker = new kakao.maps.Marker({ map: map }); // 전역 스코프에서 마커 정의
    </script>
    
    <script>
        var passengerNo = "<%=((User) session.getAttribute("user")).getUserNo()%>";
        console.log(passengerNo);

        var socket2 = new SockJS('/websoket');
        var stompClient2 = Stomp.over(socket2);
        var modal = document.getElementById('notification-bar-6');
        var confirmBtn = document.getElementById('confirmButton');
        

        stompClient2.connect({}, function(frame) {
        	console.log('Connected: ' + frame);
            confirmBtn.onclick = function() {
                window.location.href = '/callres/home.jsp';
            }
            stompClient2.subscribe('/topic/notifications/' + passengerNo, function(notification) {
            	var messageElement = document.getElementById('notificationMessage');
                if (messageElement) {
                    messageElement.innerText = notification.body;
                    console.log(notification.body);
                    showModal(); // 모달 표시
                } else {
                    console.error('notificationMessage element not found');
                }
            });
        });
        
        function showModal() {
            // Bootstrap의 Toast 컴포넌트를 활용하여 모달 표시
            var toastEl = new bootstrap.Toast(modal, {
                autohide: false // 자동 숨김 비활성화
            });
            toastEl.show();
        }
        
        var socket = new SockJS('/ws');
        var stompClient = Stomp.over(socket);
        
        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/location/' + passengerNo, function(message) {
                var locationData = JSON.parse(message.body);
                console.log("Received location for " + passengerNo + ": ", locationData.lat, locationData.lng);
                moveMarker(locationData);
            });
        }, function(error) {
            console.error('Connection failed: ' + error);
        });


        function moveMarker(locationData) {
            var newPosition = new kakao.maps.LatLng(locationData.lat, locationData.lng);
            marker.setPosition(newPosition);
            map.setCenter(newPosition);
        }
    </script>
    
    <script src="/javascript/callres/bootstrap.min.js"></script>
    <script src="/javascript/callres/custom.js"></script>
</body>
</html>
                