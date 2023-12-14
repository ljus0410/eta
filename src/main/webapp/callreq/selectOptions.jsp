<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<meta charset="UTF-8">
<title>selectOptions</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="../_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="../app/icons/icon-192x192.png">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=70ef6f6883ad97593a97af6324198ac0&libraries=services"></script>
  <style>
    /* 버튼에 적용할 스타일 */
    .hidden {
      display: none;
    }
    .divFlex {
    display: flex;
    align-items: center; /* 세로 가운데 정렬 */
}
  .center-container {
    text-align: center;
    font-weight: bold;
  }
  </style>
</head>
<body class="theme-light">
<div id="page">
    <div class="page-content header-clear-medium">
      <div class="card card-style">
<form>
<br>
<div class="divFlex">
<input type="text" value="" id="startAddrKeyword" name="startKeyword" class="form-control rounded-xs" readonly>
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8"/>
</svg>
<input type="text" value="" id="endAddrKeyword" name="endKeyword" class="form-control rounded-xs" readonly>
 </div>
 <input type="hidden" name="startAddr" id="startAddrInput">
 <input type="hidden" name="endAddr" id="endAddrInput">
  <input type="hidden" name="userNo" id="userNo" value="${user.userNo }">
 <input type="hidden" name="startX" id="startX" value="">
 <input type="hidden" name="startY" id="startY" value="">
 <input type="hidden" name="endX" id="endX" value="">
 <input type="hidden" name="endY" id="endY" value="">
 <input type="hidden" name="callCode" id="callCode" value="${callCode }">
 <div class="center-container">
<input type="radio"  value="RECOMMEND" class="form-check-input" name="routeOpt" onclick="getRoute('recommend')" checked> 추천경로
<input type="radio" value="TIME" class="form-check-input" name="routeOpt" onclick="getRoute('time')"> 최단시간
<input type="radio" value="DISTANCE" class="form-check-input" name="routeOpt" onclick="getRoute('distance')"> 최단경로 <br>
<span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill" id="distance"></span> 
<span class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill" id="duration"></span>
<span class="badge bg-danger-subtle border border-danger-subtle text-danger-emphasis rounded-pill" id="fare"></span>
<div id="map" style="width:100%;height:400px;"></div>
</div>
<br>
<select class="form-select" name="carOpt" onchange="updatePrepay()">
    <option value="4"> 소형(5인)(기본요금)</option>
    <option value="5"> 중형(6인)(기본요금 X 1.2)</option>
    <option value="7"> 대형(8인)(기본요금 X 1.4)</option>
    <option value="0"> 장애인(기본요금 X 1.4)</option>
</select>
 
<br>
 <div class="center-container">
<input type="checkbox" class="btn-check" id="btn-check-outlined" autocomplete="off" onchange="updatePrepay()">
<label class="btn btn-outline-primary" for="btn-check-outlined">반려동물(+5,000원)</label>
</div>     
<br>
 <!-- 
 RECOMMEND: 추천 경로
TIME: 최단 시간
DISTANCE: 최단 경로 -->
 <div class="center-container">
<span class="badge bg-warning-subtle border border-warning-subtle text-warning-emphasis rounded-pill">
  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-currency-dollar" viewBox="0 0 16 16">
  <path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718H4zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73l.348.086z"/>
</svg> 잔여 Tpay ${myMoney} 원 </span>
<br>
<span class="badge bg-success-subtle border border-success-subtle text-success-emphasis rounded-pill" id="showPrepay"></span><br>
 <input type="hidden"  name="realPay" id="prepay" value="" readonly><br>
<button type="button" class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" onclick="addCall()" >호출하기</button>
    </div>
</form>
</div>
</div>
</div>
</body>
<script>
document.addEventListener('DOMContentLoaded', function() {
		var startAddress = sessionStorage.getItem('startAddress');
		var endAddress = sessionStorage.getItem('endAddress');
		var startPlaceName = sessionStorage.getItem('startPlaceName');
	  var endPlaceName = sessionStorage.getItem('endPlaceName');
	  var startLat = sessionStorage.getItem('startLat');
	  var startLng = sessionStorage.getItem('startLng');
	  var endLat = sessionStorage.getItem('endLat');
	  var endLng = sessionStorage.getItem('endLng');
		
		var startKeywordInput = document.getElementById('startAddrKeyword'); // Add quotes around the ID
		var endKeywordInput = document.getElementById('endAddrKeyword'); // Add quotes around the ID
	  var startxInput = document.getElementById('startX'); // Add quotes around the ID
	  var startyInput = document.getElementById('startY'); // Add quotes around the ID
	  var endxInput = document.getElementById('endX'); // Add quotes around the ID
	  var endyInput = document.getElementById('endY'); // Add quotes around the ID
	    
		// sessionStorage에 데이터가 있을 때만 처리
		
	  if (startxInput) {
		  startxInput.value = startLng;
    }
	  if (startyInput) {
		  startyInput.value = startLat;
		    }
		if (endxInput) {
			endxInput.value = endLng;
		    }
		if (endyInput) {
			endyInput.value = endLat;
		    }
		if (startKeywordInput) {
		    startKeywordInput.value = startPlaceName;
		}
		
		if (endKeywordInput) {
		    endKeywordInput.value = endPlaceName;
		}
		
        window.selectOptionsData = {
        		startAddress: startAddress,
        		startPlaceName: startPlaceName,
            endAddress: endAddress,
            endPlaceName: endPlaceName,
            startLat: startLat,
            startLng: startLng,
            endLat: endLat,
            endLng: endLng
            };
        
      //지도
        var container = document.getElementById('map');
        var options = {
          center: new kakao.maps.LatLng(startLat, startLng),
          level: 3
        };

        var map = new kakao.maps.Map(container, options);
        
        getRoute('recommend', map);
});
const drawPolylineAndMoveMarker = (data, map) => {

    const linePath = [];
    var bounds = new kakao.maps.LatLngBounds();
    data.routes[0].sections[0].roads.forEach(router => {
    router.vertexes.forEach((vertex, index) => {
    if (index % 2 === 0) {
      const lat = router.vertexes[index + 1]; 
      const lng = router.vertexes[index]; 
      linePath.push(new kakao.maps.LatLng(lat, lng)); 
      bounds.extend(new kakao.maps.LatLng(lat, lng));
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
      map.setBounds(bounds);
} 
	function updatePrepay() {
	    // 차량 옵션 선택값 가져오기
	    var carOption = document.getElementsByName('carOpt')[0].value;

	    // 반려동물 옵션 가져오기
	    var petCheckbox = document.getElementById('btn-check-outlined');
	    var isPetChecked = petCheckbox.checked;
	    var petOption;
	    // 체크 여부에 따라 원하는 작업 수행
	    if (isPetChecked) {
	    	petOption = '1'
	    } else {
	    	petOption = '0'
	    }
	    // Fare 값 가져오기
	    var fareInput = document.getElementById('fare');
	    var recommendFare = parseFloat(fareInput.innerHTML.replace('원', '')); // 금액 숫자로 변환
	    
	   //alert(carOption); alert(petOption); alert(recommendFare);
	   
	   if(carOption == '5'){
		   recommendFare = recommendFare * 1.2;
	   } else if(carOption == '7' || carOption == '0' ){
		   recommendFare = recommendFare * 1.4;
	   } 
	   
	   if(petOption == '1'){
		   recommendFare = recommendFare + 5000;
	   }
	    // 차량 옵션에 따라 prepay 갱신
	    var prepayInput = document.getElementById('prepay');
	    prepayInput.value = recommendFare.toFixed(0);
	    
	     var showPrepayInput = document.getElementById('showPrepay');
	     showPrepayInput.innerHTML = '선결제 예상금액 '+recommendFare.toFixed(0)+' 원';
	}


async function getRoute(type, map) {
    
	if(!map){
        var container = document.getElementById('map');
        var options = {
          center: new kakao.maps.LatLng('37.4923615', '127.0292881'),
          level: 3
        };

        var map = new kakao.maps.Map(container, options);
		
	}
    const startLat = parseFloat(sessionStorage.getItem('startLat'));
    const startLng = parseFloat(sessionStorage.getItem('startLng'));
    const endLat = parseFloat(sessionStorage.getItem('endLat'));
    const endLng = parseFloat(sessionStorage.getItem('endLng'));

    // 호출방식의 URL을 입력합니다.
    const url = 'https://apis-navi.kakaomobility.com/v1/directions';
    
    const origin = startLng + ','+startLat;
    const destination = endLng + ','+endLat;

    // 요청 헤더를 추가합니다.
    const headers = {
        Authorization: 'KakaoAK 16e815ac6b904a963cd94cdb83b0b87d',
        'Content-Type': 'application/json'
    };

    let requestUrl;
    // 요청 URL을 구성합니다.
    if(type == 'recommend'){   	
    	requestUrl = url+'?origin='+origin+'&destination='+destination+'&priority=RECOMMEND&car_fuel=GASOLINE&car_hipass=false&alternatives=false&road_details=false';
    } else if(type == 'time'){
    	requestUrl = url+'?origin='+origin+'&destination='+destination+'&priority=TIME&car_fuel=GASOLINE&car_hipass=false&alternatives=false&road_details=false';
    } else if(type == 'distance'){
    	requestUrl = url+'?origin='+origin+'&destination='+destination+'&priority=DISTANCE&car_fuel=GASOLINE&car_hipass=false&alternatives=false&road_details=false';
    }
    
   // alert(requestUrl);
    try {
        // API에 GET 요청을 보냅니다.
        const response = await fetch(requestUrl, {
            method: 'GET',
            headers: headers
        });

        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const data = await response.json(); 
        console.log(data);        
       drawPolylineAndMoveMarker(data, map);
        
     // Fare 값 출력
        console.log("Fare (taxi):", data.routes[0].summary.fare.taxi);
        var recommendFare = data.routes[0].summary.fare.taxi;
        var fareInput = document.getElementById('fare');
        fareInput.innerHTML  = recommendFare + "원";
        
     // 차량 옵션 선택값 가져오기
        var carOption = document.getElementsByName('carOpt')[0].value;
     // 반려동물 옵션 선택값 가져오기
            var petOptionElements = document.getElementsByName('petOpt');
            var petOption;
        
            for (var i = 0; i < petOptionElements.length; i++) {
                if (petOptionElements[i].checked) {
                    petOption = petOptionElements[i].value;
                    break; // 선택된 경우 반복문 종료
                }
            }
            
            if(carOption == '5'){
            	recommendFare = recommendFare * 1.2;
              } else if(carOption == '7' || carOption == '0' ){
            	  recommendFare = recommendFare * 1.4;
              } 
              
              if(petOption == '1'){ 
            	  recommendFare = recommendFare + 5000;
              }
              var prepayInput = document.getElementById('prepay');    
              prepayInput.value = recommendFare.toFixed(0);
              
              var showPrepayInput = document.getElementById('showPrepay');    
              showPrepayInput.innerHTML = '선결제 예상금액 '+recommendFare.toFixed(0)+' 원';

        // Distance 값 출력
        console.log("Distance:", data.routes[0].summary.distance);
        var recommendDistance = data.routes[0].summary.distance;
        const distanceInKilometers = (recommendDistance / 1000).toFixed(2);
        var distanceInput = document.getElementById('distance');
        distanceInput.innerHTML = distanceInKilometers + 'km';

        // Duration 값 출력
				console.log("Duration:", data.routes[0].summary.duration);
				var recommendDuration = data.routes[0].summary.duration;
				
				// 전체 시간을 분으로 변환
				const totalMinutes = Math.floor(recommendDuration / 60);
				
				// 남은 초 계산
				const remainingSeconds = recommendDuration % 60;
				
				// 소수점 둘째 자리까지 표시
				const formattedSeconds = remainingSeconds;
				
				var durationInput = document.getElementById('duration');
				durationInput.innerHTML = totalMinutes + '분 ' + formattedSeconds + '초';

					    } catch (error) {
					        console.error('Error:', error);
					    }
	}
	

function addCall(){
	  
	   document.getElementById('startAddrInput').value = window.selectOptionsData.startAddress;
	   document.getElementById('endAddrInput').value = window.selectOptionsData.endAddress;
	   document.getElementById('startX').value = window.selectOptionsData.startLng;
	   document.getElementById('startY').value = window.selectOptionsData.startLat;
	   document.getElementById('endX').value = window.selectOptionsData.endLng;
	   document.getElementById('endY').value = window.selectOptionsData.endLat;
	   
	   var callCode = document.getElementById('callCode').value;
	   
	   if(callCode == 'R'){
		   $("form").attr("method" , "POST").attr("action" , "/community/addReservation").submit();
	   } else if(callCode == 'D'){
		   $("form").attr("method" , "POST").attr("action" , "/community/addDeal").submit();
	   } else if(callCode == 'S'){
		   $("form").attr("method" , "POST").attr("action" , "/community/addShare").submit();
	   } else if(callCode == 'N'){
		   $("form").attr("method" , "POST").attr("action" , "/callreq/addCall").submit();
	   }
	  
	  
	}

</script>
</html>