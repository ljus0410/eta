<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<meta charset="UTF-8">
<title>input Address Map</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="../_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="../app/icons/icon-192x192.png">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=70ef6f6883ad97593a97af6324198ac0&libraries=services"></script>
<script>

var map;
var marker;

function initMarker(lat, lng) {
    var initialPosition = new kakao.maps.LatLng(lat, lng);

    marker = new kakao.maps.Marker({
        position: initialPosition
    });

    // 마커를 지도에 표시합니다
    marker.setMap(map);

    // 초기 마커 위치의 주소를 가져와서 출력합니다
    getAddressFromCoords(lat, lng);
    
    // 마커를 클릭했을 때 이벤트 처리
    kakao.maps.event.addListener(marker, 'click', function() {
        var position = marker.getPosition();
        getAddressFromCoords(position.getLat(), position.getLng());
    });
}

async function getAddressFromCoords(lat, lng) {
    var geocoder = new kakao.maps.services.Geocoder();
    geocoder.coord2Address(lng, lat, async function (result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
            var placeName = await getPlaceName(detailAddr);

            var resultPlaceName = placeName; // 키워드 or 도로명주소
            var resultPlaceDiv = document.getElementById('clickLatlng');
            resultPlaceDiv.innerHTML = resultPlaceName;
            
            var resultAddr = detailAddr; // 도로명 주소
            var resultAddrDiv = document.getElementById('address');
            resultAddrDiv.innerHTML = resultAddr;
            
            var resultLat = lat;
            var resultLatDiv = document.getElementById('lat');
            resultLatDiv.innerHTML = resultLat;
            
            var resultLng = lng;
            var resultLatDiv = document.getElementById('lng');
            resultLatDiv.innerHTML = resultLng;

            
        }
    });
}

function getPlaceName(detailAddr) {
    return new Promise((resolve) => {
        // 장소검색 객체를 생성합니다
        var ps = new kakao.maps.services.Places();

        // 키워드로 장소검색을 요청합니다
        ps.keywordSearch(detailAddr, function (data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                // 검색 결과가 있을 때 처리
                if (data.length > 0) {
                    console.log("place_name : " + data[0].place_name);
                    resolve(data[0].place_name);
                } else {
                    resolve(detailAddr);
                }
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                //alert('검색 결과가 존재하지 않습니다.');
                resolve(detailAddr);
            } else if (status === kakao.maps.services.Status.ERROR) {
                alert('검색 결과 중 오류가 발생했습니다.');
                resolve(detailAddr);
            }
        });
    });
}


function initMap(lat, lng) {
    var mapContainer = document.getElementById('map');

    var mapOption = { 
        center: new kakao.maps.LatLng(lat, lng),
        level: 3
    };
    
    map = new kakao.maps.Map(mapContainer, mapOption);
    initMarker(lat, lng);

    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
        var latlng = mouseEvent.latLng; 
        marker.setPosition(latlng);

        var lat = latlng.getLat();
        var lng = latlng.getLng();
        console.log('클릭위치 위도 : ' + lat);
        console.log('클릭위치 경도 : ' + lng);

        getAddressFromCoords(lat, lng);
    });
}

document.addEventListener('DOMContentLoaded', function() {
    // 세션 스토리지에서 데이터 가져오기
    var lat = sessionStorage.getItem('lat');
    var lng = sessionStorage.getItem('lng');
    var type = sessionStorage.getItem('type');
    var callCode = sessionStorage.getItem('callCode');    
    
    initMap(lat, lng);

    // 버튼 생성
    var buttonContainer = document.querySelector('.card.card-style');

    if (type === 'start') {
        var startButton = document.createElement('button');
        startButton.className = 'btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4';
        startButton.id = 'getStartAddress';
        startButton.textContent = '출발지로 설정';

        // 버튼 클릭 이벤트 처리
        startButton.addEventListener('click', function() {
            // 여기에 '출발지로 설정' 버튼을 클릭했을 때의 동작을 추가
        	  var startPlaceName = document.getElementById('clickLatlng').innerHTML;
            var startAddress = document.getElementById('address').innerHTML;
            var startLat = document.getElementById('lat').innerHTML;
            var startLng = document.getElementById('lng').innerHTML;
            
            console.log('startAddress :', startAddress);
            console.log('startPlaceName :', startPlaceName);
            console.log('startLat :', startLat);
            console.log('startLng :', startLng);
            
            sessionStorage.setItem('startAddress', startAddress);
            sessionStorage.setItem('startPlaceName', startPlaceName);
            sessionStorage.setItem('startLat', startLat);
            sessionStorage.setItem('startLng', startLng);
            
            self.location = "/callreq/inputAddress?userNo="+${user.userNo }+"&callCode="+callCode;
        });

        // 버튼을 문서에 추가
        buttonContainer.appendChild(startButton);
    } else if (type === 'end') {
        var endButton = document.createElement('button');
        endButton.className = 'btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4';
        endButton.id = 'getEndAddress';
        endButton.textContent = '도착지로 설정';

        // 버튼 클릭 이벤트 처리
        endButton.addEventListener('click', function() {
            // 여기에 '도착지로 설정' 버튼을 클릭했을 때의 동작을 추가
            var endPlaceName = document.getElementById('clickLatlng').innerHTML;
            var endAddress = document.getElementById('address').innerHTML;
            var endLat = document.getElementById('lat').innerHTML;
            var endLng = document.getElementById('lng').innerHTML;
            
            console.log('endAddress :', endAddress);
            console.log('endPlaceName :', endPlaceName);
            console.log('endtLat :', endLat);
            console.log('endLng :', endLng);
            
            sessionStorage.setItem('endAddress', endAddress);
            sessionStorage.setItem('endPlaceName', endPlaceName);
            sessionStorage.setItem('endLat', endLat);
            sessionStorage.setItem('endLng', endLng);
            
            self.location = "/callreq/inputAddress?userNo="+${user.userNo }+"&callCode="+callCode;
            
        });

        // 버튼을 문서에 추가
        buttonContainer.appendChild(endButton);
    }
});

</script>
<style>
#clickLatlng{
    font-weight: bold;
}
</style>
</head>
<body class="theme-light">
<div id="page">
    <div class="page-content header-clear-medium">
	    <div class="card card-style">
		    <div id="map" style="width:100%;height:350px;"></div> 
		    <div id="clickLatlng"></div>
		    <div id="address"></div>
		    <div id="lat" style="display: none;"></div>
		    <div id="lng" style="display: none;"></div>
		  </div>
		</div>
	</div>
</body>
</html>
