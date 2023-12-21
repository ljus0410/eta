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
<title>eTa</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
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
  .routeOptStyle{
    color: #E6E6E6;
    font-size : 20px;
    padding-right:20px;
    padding-left:15px;
  }
  .routeOptStyle.checked{
    color: #6E6E6E;
    font-size : 20px;
    padding-right:20px;
    padding-left:15px;
  }
  .carOptStyle{
    color: #E6E6E6;
    padding-right:20px;
  }
  .carOptStyle.checked {
    color: #6E6E6E;
    font-weight: bold;
  }
  #carOptContent{
    padding-top:10px;
    color: #585858;
    font-size : 15px;
  }
    #petOptContent{
    color: #585858;
    font-size : 15px;
  }
  #myMoneyFont{
    font-size : 20px;
  }
  #reservationContent{
    color: #585858;
    font-size : 15px;
  }
  #showPrepay{
   font-size : 20px;
  }
  #moneyAlert{
  color: #DF3A01;
  font-size : 13px;
  }
  </style>
</head>
<body class="theme-light">
<jsp:include page="/home/top.jsp" />
<c:choose>
    <c:when test="${empty user.role}">
        <form name="detailform">
        <div id="page">
        <div class="page-content header-clear-medium">
        <div class="card card-style" style="margin-bottom: 15px ;">
          <div class="content" style="margin-bottom: 9px ;">
         <div class="alert border-red-dark alert-dismissible color-red-dark rounded-s fade show" >
           <i class="has-bg rounded-s bi bg-red-dark bi-exclamation-circle"></i>&nbsp;<strong>로그인해주세요.</strong>
         </div>
         </div>
         </div>
         </div>
         </div>
        </form>
    </c:when>
   <c:when test="${!empty user.role && user.role eq 'driver'}">
                 <form name="detailform">
        <div id="page">
        <div class="page-content header-clear-medium">
        <div class="card card-style" style="margin-bottom: 15px ;">
          <div class="content" style="margin-bottom: 9px ;">
         <div class="alert border-red-dark alert-dismissible color-red-dark rounded-s fade show" >
           <i class="has-bg rounded-s bi bg-red-dark bi-exclamation-circle"></i>&nbsp;<strong>권한이 없습니다.</strong>
         </div>
         </div>
         </div>
         </div>
         </div>
        </form>
    </c:when>
    <c:otherwise>
<div id="page">
<div class="page-content header-clear-medium">
<div class="card card-style">
<form>
<div class="divFlex">
<input type="text" value="" id="startAddrKeyword" name="startKeyword" class="form-control rounded-xs" readonly>
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8"/>
</svg>
<input type="text" value="" id="endAddrKeyword" name="endKeyword" class="form-control rounded-xs" readonly>
 </div>
 <div id="map" style="width:100%;height:400px;"></div>
 <input type="hidden" name="startAddr" id="startAddrInput">
 <input type="hidden" name="endAddr" id="endAddrInput">
  <input type="hidden" name="userNo" id="userNo" value="${user.userNo }">
 <input type="hidden" name="startX" id="startX" value="">
 <input type="hidden" name="startY" id="startY" value="">
 <input type="hidden" name="endX" id="endX" value="">
 <input type="hidden" name="endY" id="endY" value="">
 <input type="hidden" name="callCode" id="callCode" value="${callCode }">
 <div class="center-container">
<span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill" id="distance"></span> 
<span class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill" id="duration"></span>
<span class="badge bg-danger-subtle border border-danger-subtle text-danger-emphasis rounded-pill" id="fare"></span>
<br><br>
<span id="recommendRoute" class="routeOptStyle"><input type="radio"  style="display: none;" value="RECOMMEND" class="form-check-input" name="routeOpt" onclick="getRoute('recommend')" checked> <span class="routeFont">추천경로</span></span>
<span id="timeRoute" class="routeOptStyle"><input type="radio" style="display: none;" value="TIME" class="form-check-input" name="routeOpt" onclick="getRoute('time')"> <span class="routeFont">최단시간</span></span>
<span id="distanceRoute" class="routeOptStyle"><input type="radio" style="display: none;" value="DISTANCE" class="form-check-input" name="routeOpt" onclick="getRoute('distance')"> <span class="routeFont">최단경로</span></span> <br><br>
<span id="smallCar" class="carOptStyle"><input type="radio" style="display: none;" value="4" class="form-check-input" name="carOpt" onclick="updatePrepay()" checked> <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-car-front-fill" viewBox="0 0 16 16">
  <path d="M2.52 3.515A2.5 2.5 0 0 1 4.82 2h6.362c1 0 1.904.596 2.298 1.515l.792 1.848c.075.175.21.319.38.404.5.25.855.715.965 1.262l.335 1.679c.033.161.049.325.049.49v.413c0 .814-.39 1.543-1 1.997V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.338c-1.292.048-2.745.088-4 .088s-2.708-.04-4-.088V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.892c-.61-.454-1-1.183-1-1.997v-.413a2.5 2.5 0 0 1 .049-.49l.335-1.68c.11-.546.465-1.012.964-1.261a.807.807 0 0 0 .381-.404l.792-1.848ZM3 10a1 1 0 1 0 0-2 1 1 0 0 0 0 2m10 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2M6 8a1 1 0 0 0 0 2h4a1 1 0 1 0 0-2zM2.906 5.189a.51.51 0 0 0 .497.731c.91-.073 3.35-.17 4.597-.17 1.247 0 3.688.097 4.597.17a.51.51 0 0 0 .497-.731l-.956-1.913A.5.5 0 0 0 11.691 3H4.309a.5.5 0 0 0-.447.276L2.906 5.19Z"/>
</svg></span>
<span id="middleCar" class="carOptStyle"><input type="radio" style="display: none;" value="5" class="form-check-input" name="carOpt" onclick="updatePrepay()" > 
<svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-truck-front-fill" viewBox="0 0 16 16">
  <path d="M3.5 0A2.5 2.5 0 0 0 1 2.5v9c0 .818.393 1.544 1 2v2a.5.5 0 0 0 .5.5h2a.5.5 0 0 0 .5-.5V14h6v1.5a.5.5 0 0 0 .5.5h2a.5.5 0 0 0 .5-.5v-2c.607-.456 1-1.182 1-2v-9A2.5 2.5 0 0 0 12.5 0zM3 3a1 1 0 0 1 1-1h8a1 1 0 0 1 1 1v3.9c0 .625-.562 1.092-1.17.994C10.925 7.747 9.208 7.5 8 7.5c-1.208 0-2.925.247-3.83.394A1.008 1.008 0 0 1 3 6.9zm1 9a1 1 0 1 1 0-2 1 1 0 0 1 0 2m8 0a1 1 0 1 1 0-2 1 1 0 0 1 0 2m-5-2h2a1 1 0 1 1 0 2H7a1 1 0 1 1 0-2"/>
</svg></span>
<span id="largeCar" class="carOptStyle"><input type="radio"  style="display: none;" value="7" class="form-check-input" name="carOpt" onclick="updatePrepay()" ><svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-bus-front-fill" viewBox="0 0 16 16">
  <path d="M16 7a1 1 0 0 1-1 1v3.5c0 .818-.393 1.544-1 2v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5V14H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2a2.496 2.496 0 0 1-1-2V8a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1V2.64C1 1.452 1.845.408 3.064.268A43.608 43.608 0 0 1 8 0c2.1 0 3.792.136 4.936.268C14.155.408 15 1.452 15 2.64V4a1 1 0 0 1 1 1zM3.552 3.22A43.306 43.306 0 0 1 8 3c1.837 0 3.353.107 4.448.22a.5.5 0 0 0 .104-.994A44.304 44.304 0 0 0 8 2c-1.876 0-3.426.109-4.552.226a.5.5 0 1 0 .104.994ZM8 4c-1.876 0-3.426.109-4.552.226A.5.5 0 0 0 3 4.723v3.554a.5.5 0 0 0 .448.497C4.574 8.891 6.124 9 8 9c1.876 0 3.426-.109 4.552-.226A.5.5 0 0 0 13 8.277V4.723a.5.5 0 0 0-.448-.497A44.304 44.304 0 0 0 8 4m-3 7a1 1 0 1 0-2 0 1 1 0 0 0 2 0m8 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m-7 0a1 1 0 0 0 1 1h2a1 1 0 1 0 0-2H7a1 1 0 0 0-1 1"/>
</svg></span>
<span id="disabledCar" class="carOptStyle"><input type="radio" style="display: none;" value="0" class="form-check-input" name="carOpt" onclick="updatePrepay()" ><svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-person-wheelchair" viewBox="0 0 16 16">
  <path d="M12 3a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3m-.663 2.146a1.5 1.5 0 0 0-.47-2.115l-2.5-1.508a1.5 1.5 0 0 0-1.676.086l-2.329 1.75a.866.866 0 0 0 1.051 1.375L7.361 3.37l.922.71-2.038 2.445A4.732 4.732 0 0 0 2.628 7.67l1.064 1.065a3.25 3.25 0 0 1 4.574 4.574l1.064 1.063a4.732 4.732 0 0 0 1.09-3.998l1.043-.292-.187 2.991a.872.872 0 1 0 1.741.098l.206-4.121A1 1 0 0 0 12.224 8h-2.79l1.903-2.854ZM3.023 9.48a3.25 3.25 0 0 0 4.496 4.496l1.077 1.077a4.75 4.75 0 0 1-6.65-6.65l1.077 1.078Z"/>
</svg> </span>
<span id="petButton"><input class="form-check-input" style="display: none;" type="checkbox" value="" id="pet_btn" onchange="updatePrepay()">
<img src="../images/pet_before.png" width="35" height="35" id="petImage"></span>
<div id="carOptContent"></div>
<div id="petOptContent"></div>
<c:choose>
  <c:when test="${callCode eq 'R'}">
   <div id="reservationContent">예약비 2,000원 추가</div>
  </c:when>
</c:choose><br>
<div id="moneyAlert"></div>
<span class="badge bg-warning-subtle border border-warning-subtle text-warning-emphasis rounded-pill" id="myMoneyFont">
  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-currency-dollar" viewBox="0 0 16 16">
  <path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718H4zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73l.348.086z"/>
</svg><span id="TmoneyFormat"></span></span>
 <input type="hidden"  id="mymoney" value="${myMoney}">
 <span class="badge bg-success-subtle border border-success-subtle text-success-emphasis rounded-pill" id="showPrepay"></span><br>
 <input type="hidden"  name="realPay" id="prepay" value="" readonly>
<button type="button" id="callButton" class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" onclick="addCall()" >호출하기</button>
<input type="hidden" id="hasNoDataException" value="${hasNoDataException}">
</div>
</form>
</div>
</div>
</div>
</c:otherwise>
</c:choose>
</body>
<script>
var recommendRouteSpan = document.getElementById('recommendRoute');
var timeRouteSpan = document.getElementById('timeRoute');
var distanceRouteSpan = document.getElementById('distanceRoute');

var smallCarSpan = document.getElementById('smallCar');
var middleCarSpan = document.getElementById('middleCar');
var largeCarSpan = document.getElementById('largeCar');
var disabledCarSpan = document.getElementById('disabledCar');

var petButtonSpan = document.getElementById('petButton');
var petImage = document.getElementById('petImage');

function handleRouteClick(type) {
	
    var clickedSpan;
    var otherSpans = [recommendRouteSpan, timeRouteSpan, distanceRouteSpan];

    if (type == 'recommend') {
        clickedSpan = recommendRouteSpan;
      } else if (type == 'time') {
        clickedSpan = timeRouteSpan;
      } else if (type == 'distance') {
        clickedSpan = distanceRouteSpan;
      }
    
    // 다른 모든 span에서 checked 클래스 제거
    otherSpans.forEach(function (span) {
      span.classList.remove('checked');
    });
    
 // 클릭한 span에 checked 클래스 추가
    clickedSpan.classList.add('checked');
 
    var radioBtn = clickedSpan.querySelector('input[type="radio"]');
    radioBtn.checked = true;
    var radioValue = radioBtn.value;
    console.log('선택된 route:', radioValue);
    
    if(radioValue == 'RECOMMEND'){
    	getRoute('recommend');
    } else if(radioValue == 'TIME'){
    	getRoute('time');
    }else if(radioValue == 'DISTANCE'){
    	getRoute('distance');
    }

}
function handleCarClick(type) {
    var clickedSpan;
    var otherSpans = [smallCarSpan, middleCarSpan, largeCarSpan, disabledCarSpan];

    if (type == 'small') {
        clickedSpan = smallCarSpan;
      } else if (type == 'middle') {
        clickedSpan = middleCarSpan;
      } else if (type == 'large') {
        clickedSpan = largeCarSpan;
      } else if (type == 'disabled') {
        clickedSpan = disabledCarSpan;
      }
    
    // 다른 모든 span에서 checked 클래스 제거
    otherSpans.forEach(function (span) {
      span.classList.remove('checked');
    });
    
 // 클릭한 span에 checked 클래스 추가
    clickedSpan.classList.add('checked');
 
    var radioBtn = clickedSpan.querySelector('input[type="radio"]');
    radioBtn.checked = true;
    var radioValue = radioBtn.value;
    console.log('선택된 car:', radioValue);
    updatePrepay();

	}
function handlePetClick() {

	 var checkBtn = petButtonSpan.querySelector('input[type="checkbox"]');

	  if (checkBtn.checked) {
	    checkBtn.checked = false;
	    petImage.src = "../images/pet_before.png";
	    console.log('체크 해제됨');
	  } else {
	    checkBtn.checked = true;
	    petImage.src = "../images/pet_after.png";
	    console.log('체크됨');
	  }
	  updatePrepay();
      
  }
recommendRouteSpan.addEventListener('click', function () {
  handleRouteClick('recommend');
});
timeRouteSpan.addEventListener('click', function () {
  handleRouteClick('time');
});
distanceRouteSpan.addEventListener('click', function () {
  handleRouteClick('distance');
});
smallCarSpan.addEventListener('click', function () {
	  handleCarClick('small');
	});
middleCarSpan.addEventListener('click', function () {
    handleCarClick('middle');
  });
largeCarSpan.addEventListener('click', function () {
    handleCarClick('large');
  });
disabledCarSpan.addEventListener('click', function () {
    handleCarClick('disabled');
  });
petButtonSpan.addEventListener('click', function () {
    handlePetClick();
  });


document.addEventListener('DOMContentLoaded', function() {
	  var hasNoDataException = document.getElementById('hasNoDataException').value;
	//alert(hasNoDataException);
	if (hasNoDataException == 'true'){
		var message1 = '현재 배차 가능한 driver가 없습니다.';
	  var message2 = '잠시 후 다시 시도해주세요.';
		messageAlert(message1, message2);
	}
            


	var myMoneyFormatSpan = document.getElementById('TmoneyFormat');
	var myMoneyFormat= ${myMoney};
	var formattedMoney = parseFloat(myMoneyFormat).toLocaleString(); // myMoneyFormat를 숫자로 변환 후 형식화
	myMoneyFormatSpan.textContent = '잔여 Tpay'+formattedMoney + ' 원';
	
		var startAddress = sessionStorage.getItem('startAddress');
		var endAddress = sessionStorage.getItem('endAddress');
		var startPlaceName = sessionStorage.getItem('startPlaceName');
	  var endPlaceName = sessionStorage.getItem('endPlaceName');
	  var startLat = sessionStorage.getItem('startLat');
	  var startLng = sessionStorage.getItem('startLng');
	  var endLat = sessionStorage.getItem('endLat');
	  var endLng = sessionStorage.getItem('endLng');
		console.log(endPlaceName);console.log(endLat);console.log(endLng);console.log(endAddress);
		console.log(startPlaceName);console.log(startLat);console.log(startLng);console.log(startAddress);
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
        
        handleRouteClick('recommend');
        handleCarClick('small');
        getRoute('recommend', map);
});
function messageAlert(message1, message2) {
	   var toastContainer = document.createElement('div');
	     toastContainer.innerHTML = '<div id="notification-bar-5" class="notification-bar glass-effect detached rounded-s shadow-l fade show" data-bs-delay="15000">' +
	         '<div class="toast-body px-3 py-3">' +
	         '<div class="d-flex">' +
	         '<div class="align-self-center">' +
	         '<span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>' +
	         '</div>' +
	         '<div class="align-self-center">' +
	         '<h5 class="font-16 ps-2 ms-1 mb-0">'+message1+'</h5>' +
	         '<h5 class="font-16 ps-2 ms-1 mb-0">'+message2+'</h5>' +
	         '</div>' +
	         '</div><br>' +
	         '<a href="#" data-bs-dismiss="toast" id="confirmBtn" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">확인</a>' +
	         '</div>' +
	         '</div>';

	     document.body.appendChild(toastContainer.firstChild); // body에 토스트 알림창 추가
	     
	     document.getElementById('confirmBtn').addEventListener('click', function () {
	         // Remove the toast element from the DOM
	         document.getElementById('notification-bar-5').remove();
	     });
	     $('.toast').toast('show'); // Bootstrap 토스트 표시 함수 호출
	}
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
          strokeColor: '#13860F', 
          strokeOpacity: 0.7, 
          strokeStyle: 'solid'  
        });
      polyline.setMap(map);
      map.setBounds(bounds);
} 
	function updatePrepay() {
	    // 차량 옵션 선택값 가져오기
	    var carOption = $('input[name=carOpt]:checked').val();

	    // 반려동물 옵션 가져오기
	    var petCheckbox = document.getElementById('pet_btn');
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
	   if(carOption == '4'){
		   carOptContent.innerHTML = '소형 | 5인승 | 추가요금 없음';
	   } else if(carOption == '5'){
		   recommendFare = recommendFare * 1.2;
		   carOptContent.innerHTML = '중형 | 6인승 | 기본요금 X 1.2';
	   } else if(carOption == '7' ){
		   recommendFare = recommendFare * 1.4;
		   carOptContent.innerHTML = '대형 | 8인승 | 기본요금 X 1.4';
	   } else if(carOption == '0'){
		   recommendFare = recommendFare * 1.4;
		   carOptContent.innerHTML = '장애인 | 기본요금 X 1.4';
	   }
	   
	   if(petOption == '1'){
		   recommendFare = recommendFare + 5000;
		   petOptContent.innerHTML = '반려동물 옵션 선택 시 5,000원 추가';
	   } else {
		   petOptContent.innerHTML = '';
	   }
	   
	   var callCode = document.getElementById('callCode').value;
	   if(callCode == 'R'){
		   recommendFare = recommendFare + 2000;
	   }
	   
	    // 차량 옵션에 따라 prepay 갱신
	    var prepayInput = document.getElementById('prepay');
	    prepayInput.value = recommendFare.toFixed(0);
	    
	    var prePayFormat = parseFloat(recommendFare).toLocaleString();

	     var showPrepayInput = document.getElementById('showPrepay');
	     showPrepayInput.innerHTML = '선결제 예상금액 '+prePayFormat+' 원';
	     var callButton = document.getElementById('callButton');
         var moneyAlert = document.getElementById('moneyAlert');    
         var myMoney = document.getElementById('mymoney').value;   
         if(callCode == 'R' || callCode == 'N' || callCode == 'S'){
        	 if(myMoney < parseInt(recommendFare.toFixed(0)) + 10000){
               moneyAlert.innerHTML = 'Tpay를 충전해주세요(선결제 예상금액+1만원 이상)';
               callButton.disabled = true;
             } else{
            	 moneyAlert.innerHTML = '';
               callButton.disabled = false;
             }
           }
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
//alert(startLat);alert(startLng);alert(endLat);alert(endLng);
    // 호출방식의 URL을 입력합니다.
    const url = 'https://apis-navi.kakaomobility.com/v1/directions';
    
    const origin = startLng + ','+startLat;
    const destination = endLng + ','+endLat;

    // 요청 헤더를 추가합니다.
    const headers = {
        'Authorization' : 'KakaoAK 8f0ca1a839a76df15892c48aa41d71dd', 
        'Content-Type': 'application/json' 
    };
    console.log('headers : '+headers);
    let requestUrl;
    // 요청 URL을 구성합니다.
    if(type == 'recommend'){   	
    	requestUrl = url+'?origin='+origin+'&destination='+destination+'&priority=RECOMMEND';
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
        	var moneyAlert = document.getElementById('moneyAlert');    
        	moneyAlert.innerHTML = '경로를 불러올 수 없습니다.';
        	var callButton = document.getElementById('callButton');
        	callButton.disabled = true;
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
 

        updatePrepay();

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