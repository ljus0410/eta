<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>input Address</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="../app/icons/icon-192x192.png">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=70ef6f6883ad97593a97af6324198ac0&libraries=services"></script>
<script>
// 각 input 요소에 대한 이벤트 핸들러 등록
function registerInputEvents(inputElement, defaultValue) {

    inputElement.addEventListener('click', function(event) {
        // 클릭 시 입력 값 초기화
        inputElement.value = '';
        inputElement.placeholder = '주소를 입력해주세요';

        // 이벤트 전파 방지
        event.stopPropagation();
    });

    document.addEventListener('click', function() {
        // 다른 곳을 클릭하면서 이전 값 복원
      if (inputElement.value === '') {
            inputElement.value = defaultValue;
            inputElement.placeholder = '';
        }

        // 이벤트 전파 방지
        event.stopPropagation();
    });
}
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(async function (position) {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;

        var startAddress = sessionStorage.getItem('startAddress');
        var startLat = sessionStorage.getItem('startLat');
        var startLng = sessionStorage.getItem('startLng');
        var startPlaceName = sessionStorage.getItem('startPlaceName');

        console.log("지도에서 받은 startAddr!! : " + startAddress);
        console.log("지도에서 받은 startLat!! : " + startLat);
        console.log("지도에서 받은 startLng!! : " + startLng);
        console.log("지도에서 받은 startPlaceName!! : " + startPlaceName);

        // async 키워드 추가
        var result = await getAddressFromCoords(latitude, longitude);
        var firstPlaceName = result.placeName;
        var firstAddr = result.address;
        var firstLat = result.latitude;
        var firstLng = result.longitude;

        if (startAddress == null) {
            document.getElementById('startAddrKeyword').value = "현 위치 : " + firstPlaceName;
            registerInputEvents(startAddrKeyword, "현 위치 : " +firstPlaceName);
            document.getElementById('startx').value =firstLat;
            document.getElementById('starty').value =firstLng;
            window.selectOptionsStartData = {
                    startAddress: firstAddr,
                    startPlaceName: firstPlaceName,
                    startLat : firstLat,
                    startLng : firstLng
                };
        } else {
            document.getElementById('startAddrKeyword').value = startPlaceName;
            registerInputEvents(startAddrKeyword, startPlaceName);
        }

        if (startLat == null || startLng == null) {
            startLat = latitude;
            startLng = longitude;
        }

        function getAddressFromCoords(lat, lng) {
            return new Promise(async (resolve) => {
                var geocoder = new kakao.maps.services.Geocoder();
                geocoder.coord2Address(lng, lat, async function (result, status) {
                    var data = {};
                    if (status === kakao.maps.services.Status.OK) {
                        var detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
                        var placeName = await getPlaceName(detailAddr);

                        data.placeName = placeName;
                        data.address = detailAddr;
                        data.latitude = lat;
                        data.longitude = lng;

                        console.log('현재 위치 장소 이름:', placeName);
                        console.log('현재 위치 주소:', detailAddr);
                        console.log('현재 위치 lat:', lat);
                        console.log('현재 위치 lng:', lng);
                    }

                    resolve(data);
                });
            });
        }

        function getPlaceName(detailAddr) {
            return new Promise((resolve) => {
                var ps = new kakao.maps.services.Places();
                ps.keywordSearch(detailAddr, function (data, status, pagination) {
                    if (status === kakao.maps.services.Status.OK) {
                        if (data.length > 0) {
                            console.log("first_place_name : " + data[0].place_name);
                            resolve(data[0].place_name);
                        } else {
                            resolve(detailAddr);
                        }
                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                        resolve(detailAddr);
                    } else if (status === kakao.maps.services.Status.ERROR) {
                        alert('검색 결과 중 오류가 발생했습니다.');
                        resolve(detailAddr);
                    }
                });
            });
        }

    });
}


</script>
<style>
.hiddenButton{
  display: none; 
}
</style>
</head>
<body class="theme-light">
<jsp:include page="/home/top.jsp" />
<br>
<div id="page">
    <div class="card card-style">
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            <div id="menu_wrap" class="bg_white">
               <div class="form-custom form-label form-icon mb-3">
                <div class="startAddrSearch">
                    <div>
                        <form class="form">
                        <br>
                            <input type="text" value="" id="startAddrKeyword" class="form-control rounded-xs"> 
                            <button class="hiddenButton" id="startSubmit" type="submit">주소검색</button>
                            <input type="hidden" value="" id="startx" size="20px"> 
                            <input type="hidden" value="" id="starty" size="20px"> 
                        </form>
                    </div>
                </div>
                </div>
                <div class="form-custom form-label form-icon mb-3">
                <div class="endAddrSearch">
                    <div>
                        <form class="form">
                            <input type="text" value="" id="endAddrKeyword" class="form-control rounded-xs"> 
                            <button class="hiddenButton" id="endSubmit" type="submit">주소검색</button> 
                            <input type="hidden" value="" id="endx" size="20px"> 
                            <input type="hidden" value="" id="endy" size="20px"> 
                        </form>
                    </div>
                </div>
               </div>
                <ul id="placesList"></ul>
                <div id="pagination"></div>
            </div>
        </div>
                 <!-- 출발지, 목적지 둘다 입력되어야 넘어가게 하기 -->
          <button type="button" class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" onclick="selectOptions('${callCode}')">옵션 선택</button><br>
          <input type="hidden" value="${callCode}" id="getCallCode">
          
              <!-- 즐겨찾기 리스트-->
    <c:set var="i" value="0" />
    <c:forEach var="likeList" items="${likeList}">
      <c:set var="i" value="${ i+1 }" /> 
      <c:choose>
        <c:when test="${empty likeList.likeAddr && !empty likeList.likeName && likeList.likeName eq '집'}">
             <button type="button" class="btn btn-secondary" onclick="handleButtonClick('${likeList.likeAddr}')" disabled>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-slash" viewBox="0 0 16 16">
								  <path d="M13.879 10.414a2.5 2.5 0 0 0-3.465 3.465zm.707.707-3.465 3.465a2.501 2.501 0 0 0 3.465-3.465m-4.56-1.096a3.5 3.5 0 1 1 4.949 4.95 3.5 3.5 0 0 1-4.95-4.95Z"/>
								  <path d="M7.293 1.5a1 1 0 0 1 1.414 0L11 3.793V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v3.293l2.354 2.353a.5.5 0 0 1-.708.708L8 2.207l-5 5V13.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 1 0 1h-4A1.5 1.5 0 0 1 2 13.5V8.207l-.646.647a.5.5 0 1 1-.708-.708z"/>
								</svg>
              </button>     
        </c:when>
        <c:when test="${empty likeList.likeAddr && !empty likeList.likeName && likeList.likeName eq '회사'}">
             <button type="button" class="btn btn-secondary" onclick="handleButtonClick('${likeList.likeAddr}')" disabled>
				       <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-slash" viewBox="0 0 16 16">
								  <path d="M13.879 10.414a2.501 2.501 0 0 0-3.465 3.465zm.707.707-3.465 3.465a2.501 2.501 0 0 0 3.465-3.465m-4.56-1.096a3.5 3.5 0 1 1 4.949 4.95 3.5 3.5 0 0 1-4.95-4.95Z"/>
								  <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
								  <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
								</svg>
              </button>    
        </c:when>
        <c:when test="${empty likeList.likeAddr && empty likeList.likeName}">
             <button type="button" class="btn btn-secondary" onclick="handleButtonClick('${likeList.likeAddr}')" disabled>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-x" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M6.146 5.146a.5.5 0 0 1 .708 0L8 6.293l1.146-1.147a.5.5 0 1 1 .708.708L8.707 7l1.147 1.146a.5.5 0 0 1-.708.708L8 7.707 6.854 8.854a.5.5 0 1 1-.708-.708L7.293 7 6.146 5.854a.5.5 0 0 1 0-.708"/>
								  <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1z"/>
								</svg>
              </button>     
        </c:when>
        <c:when test="${!empty likeList.likeAddr && !empty likeList.likeName && likeList.likeName eq '집'}">
                <button type="button" class="btn-full btn border-blue-dark color-blue-dark" onclick="handleButtonClick('${likeList.likeAddr}','${likeList.likeName}','${likeList.likeX}','${likeList.likeY}')">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-check-fill" viewBox="0 0 16 16">
									  <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
									  <path d="m8 3.293 4.712 4.712A4.5 4.5 0 0 0 8.758 15H3.5A1.5 1.5 0 0 1 2 13.5V9.293l6-6Z"/>
									  <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m1.679-4.493-1.335 2.226a.75.75 0 0 1-1.174.144l-.774-.773a.5.5 0 0 1 .708-.707l.547.547 1.17-1.951a.5.5 0 1 1 .858.514Z"/>
									</svg>
              </button>
        </c:when>
        <c:when test="${!empty likeList.likeAddr && !empty likeList.likeName && likeList.likeName eq '회사'}">
              <button type="button" class="btn-full btn border-blue-dark color-blue-dark" onclick="handleButtonClick('${likeList.likeAddr}','${likeList.likeName}','${likeList.likeX}','${likeList.likeY}')">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-fill-check" viewBox="0 0 16 16">
								  <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m1.679-4.493-1.335 2.226a.75.75 0 0 1-1.174.144l-.774-.773a.5.5 0 0 1 .708-.708l.547.548 1.17-1.951a.5.5 0 1 1 .858.514Z"/>
								  <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v7.256A4.493 4.493 0 0 0 12.5 8a4.493 4.493 0 0 0-3.59 1.787A.498.498 0 0 0 9 9.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .39-.187A4.476 4.476 0 0 0 8.027 12H6.5a.5.5 0 0 0-.5.5V16H3a1 1 0 0 1-1-1zm2 1.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m3 0v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM4 5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M7.5 5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M4.5 8a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
								</svg>
              </button> 
        </c:when>
        <c:otherwise>
         <button type="button" class="btn-full btn border-blue-dark color-blue-dark" onclick="handleButtonClick('${likeList.likeAddr}','${likeList.likeName}','${likeList.likeX}','${likeList.likeY}')">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-star-fill" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5M8.16 4.1a.178.178 0 0 0-.32 0l-.634 1.285a.178.178 0 0 1-.134.098l-1.42.206a.178.178 0 0 0-.098.303L6.58 6.993c.042.041.061.1.051.158L6.39 8.565a.178.178 0 0 0 .258.187l1.27-.668a.178.178 0 0 1 .165 0l1.27.668a.178.178 0 0 0 .257-.187L9.368 7.15a.178.178 0 0 1 .05-.158l1.028-1.001a.178.178 0 0 0-.098-.303l-1.42-.206a.178.178 0 0 1-.134-.098z"/>
								</svg>
								${likeList.likeName}
         </button>
        </c:otherwise>
      </c:choose>     
     
    </c:forEach>
    <br>
        <div class="list-group list-custom list-group-m rounded-xs"> 
        <h5>&nbsp;&nbsp;최근 내역</h5><br>     
            <!-- 이용내역 도착지 키워드, 주소 리스트 -->
			    <c:set var="i" value="0" />
			    <c:forEach var="endAddrList" items="${endAddrList}">
			      <c:set var="i" value="${ i+1 }" />
			      <div id="endAddrList">
			        <a onclick="handleButtonClick('${endAddrList.endAddr}','${endAddrList.endKeyword}',${endAddrList.endX},${endAddrList.endY})" class="list-group-item">
		            <div><h5 class="mb-0">${endAddrList.endKeyword}</h5><p class="pb-0">${endAddrList.endAddr}</p></div>
		          </a> 
			      </div>
			    </c:forEach> 
        </div>
</div>
</div>
<script>

//마커를 담을 배열입니다
var markers = [];
let presentPosition;
 
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨 
    }; 
 
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

 
////////////////////장소 검색/////////////////////////////
// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  
 
// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});
 
//시작 주소 검색 form에 이벤트 리스너 추가
const startAddrForm = document.querySelector('.startAddrSearch .form');
startAddrForm.addEventListener('submit', function (e) {
    e.preventDefault();

    // 키워드로 장소를 검색합니다
    searchPlaces('startAddrKeyword', 'start');
});

// 종료 주소 검색 form에 이벤트 리스너 추가
const endAddrForm = document.querySelector('.endAddrSearch .form');
endAddrForm.addEventListener('submit', function (e) {
    e.preventDefault();
    // 키워드로 장소를 검색합니다
    searchPlaces('endAddrKeyword', 'end');
});
 
//키워드 검색을 요청하는 함수입니다
function searchPlaces(keywordId, type) {
    console.log("searchPlaces type : "+type);
  
    var keyword = document.getElementById(keywordId).value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }
    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch(keyword, function(data, status, pagination) {
        placesSearchCB(data, status, pagination, type);
    });
}
 
// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination, type) {
   console.log("placesSearchCB type : "+type);
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data, type);
 
        // 페이지 번호를 표출합니다
        displayPagination(pagination);
 
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
 
        alert('검색 결과가 존재하지 않습니다.');
        return;
 
    } else if (status === kakao.maps.services.Status.ERROR) {
 
        alert('검색 결과 중 오류가 발생했습니다.');
        return;
 
    }
}
 
// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places, type) {
  console.log("displayPlaces type: "+type);
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);
 
    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {
 
        const lon = places[i].x;
        const lat = places[i].y;
 
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i], type); // 검색 결과 항목 Element를 생성합니다
 
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

 
        // 마커와 검색 결과를 클릭했을때 좌표를 가져온다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'click', function() {
                searchDetailAddrFromCoords(presentPosition, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
                        location.href = "https://map.kakao.com/?sName="+detailAddr+"&eName="+title                                            
                    }   
                });
            })
        })(marker, places[i].place_name);
 
        fragment.appendChild(itemEl);
    }
 
    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
 
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}
 
// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places, type) {
   console.log("getListItem : "+type);
    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';
 
    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div><hr>';           
 
    el.innerHTML = itemStr;
    el.className = 'item';
    
    // 클릭 이벤트 핸들러에 클로저를 사용하여 좌표 정보 전달
    el.onclick = (function (place, type) {
        return function () {
          var position = new kakao.maps.LatLng(place.y, place.x);
            displayInfowindow(place.place_name, position, type);
        };
    })(places, type);
 
    return el;
}
 
// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });
 
    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
 
    return marker;
}
 
// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}
 
// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 
 
    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }
    
    var ul = document.createElement('ul');
    ul.className = 'pagination px-3';
 
    for (i = 1; i <= pagination.last; i++) {
        var li = document.createElement('li');
        li.className = 'page-item';

        var el = document.createElement('a');
        el.className = 'page-link rounded-xs bg-dark-dark shadow-l border-0';
        el.href = "#";
        el.innerHTML = i;

        if (i === pagination.current) {
            li.className += ' active';
        } else {
            el.onclick = (function (i) {
                return function () {
                    pagination.gotoPage(i);
                };
            })(i);
        }

        li.appendChild(el);
        ul.appendChild(li);
    }

    fragment.appendChild(ul);
    paginationEl.appendChild(fragment);
}
 
// 검색결과 목록 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
async function displayInfowindow(title, position, type) {
  console.log("displayInfowindow type : "+type);
  console.log("title : "+title);
  
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
 
    infowindow.setContent(content);
    
    // 클릭한 검색 결과 항목의 좌표 정보를 활용하여 주소 정보를 가져옵니다
    var result = await new Promise((resolve) => {
        searchDetailAddrFromCoords(position, function(result, status) {
            resolve({ result, status });
        });
    });
    
    if (result.status === kakao.maps.services.Status.OK) {
        var detailAddr = !!result.result[0].road_address ? result.result[0].road_address.address_name : result.result[0].address.address_name;
        console.log('Clicked Position:', position);
        console.log('Detail Address:', detailAddr);
        
        // 결과를 input text에 넣어줍니다
        var keywordId = type === 'start' ? 'startAddrKeyword' : 'endAddrKeyword';
        var keywordInput = document.getElementById(keywordId);
        if (keywordInput) {
          
           if(title == null){            
             keywordInput.value = detailAddr;
           } else{
             keywordInput.value = title;
           }
 
         // 세션 스토리지에 정보 저장
            sessionStorage.setItem('lat', position.getLat());
            sessionStorage.setItem('lng', position.getLng());
            sessionStorage.setItem('address', detailAddr);
            sessionStorage.setItem('type', type);
            sessionStorage.setItem('callCode', window.callCodeData.callCode);
            
            location.href = '/callreq/inputAddressMap?userNo='+${user.userNo }+'&callCode='+window.callCodeData.callCode; 
        }
    }
}
 
 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 
//좌표 -> 주소
var geocoder = new kakao.maps.services.Geocoder();

// 좌표를 이용하여 주소를 검색하고 콜백 함수를 호출하는 함수
function searchDetailAddrFromCoords(coords, callback) {
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

document.addEventListener('DOMContentLoaded', function() {
  
  window.onload = function() {
      // 특정 input 엘리먼트를 찾아 포커스 설정
      var endAddrKeyword = document.getElementById('endAddrKeyword');
      if (endAddrKeyword) {
        endAddrKeyword.focus();
      }
      
      var callCodeInput = document.getElementById('getCallCode');
      var callCode = callCodeInput.value;
      
      window.callCodeData = {
          callCode: callCode
          };
      
  };
  
  /*  var startAddrKeyword = document.getElementById('startAddrKeyword');
    startAddrKeyword.addEventListener('click', function() {
      startAddrKeyword.value = '';
      startAddrKeyword.placeholder = '출발지를 입력해주세요';
     });
  
     var endAddrKeyword = document.getElementById('endAddrKeyword');
     endAddrKeyword.addEventListener('click', function() {
       endAddrKeyword.value = '';
       endAddrKeyword.placeholder = '도착지를 입력해주세요';
      });*/
      
    // 세션 스토리지에서 데이터 가져오기
    var startAddress = sessionStorage.getItem('startAddress');
    var endAddress = sessionStorage.getItem('endAddress');
    var startPlaceName = sessionStorage.getItem('startPlaceName');
    var endPlaceName = sessionStorage.getItem('endPlaceName');
    var startLat = sessionStorage.getItem('startLat');
    var endLat = sessionStorage.getItem('endLat');
    var startLng = sessionStorage.getItem('startLng');
    var endLng = sessionStorage.getItem('endLng');

    console.log("start : "+startAddress); // 옵션선택화면으로 넘길 최종 값
    console.log("end : "+endAddress); // 옵션선택화면으로 넘길 최종 값
    console.log("start place: "+startPlaceName); // 옵션선택화면으로 넘길 최종 값
    console.log("end place: "+endPlaceName); // 옵션선택화면으로 넘길 최종 값
    console.log("start lat : "+startLat); // 옵션선택화면으로 넘길 최종 값
    console.log("end lat : "+endLat); // 옵션선택화면으로 넘길 최종 값
    console.log("start lng: "+startLng); // 옵션선택화면으로 넘길 최종 값
    console.log("end lng: "+endLng); // 옵션선택화면으로 넘길 최종 값
    
    var startKeywordInput = document.getElementById('startAddrKeyword'); // Add quotes around the ID
    var endKeywordInput = document.getElementById('endAddrKeyword'); // Add quotes around the ID
    var startxInput = document.getElementById('startx');
    var startyInput = document.getElementById('starty');
    var endxInput = document.getElementById('endx');
    var endyInput = document.getElementById('endy');
    
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
    // sessionStorage에 데이터가 있을 때만 처리
    if (startKeywordInput) {
        startKeywordInput.value = startPlaceName;
        registerInputEvents(startAddrKeyword, startPlaceName);
    }
    
    if (endKeywordInput) {
        endKeywordInput.value = endPlaceName;
        registerInputEvents(endAddrKeyword, endPlaceName);
    }
    
    // selectOptions 함수에 전달할 데이터 설정
    window.selectOptionsEndData = {
        endAddress: endAddress,
        endPlaceName: endPlaceName,
        endLat: endLat,
        endLng: endLng
    };
    
    window.selectOptionsStartDataMap = {
            startAddress: startAddress,
            startPlaceName: startPlaceName,
            startLat: startLat,
            startLng: startLng
        };
});
 
function handleButtonClick(Addr, Name, X, Y) {
    
    /*alert(likeAddr);
    alert(likeName);
    alert(likeX);
    alert(likeY);*/ 
    
    var endAddrKeywordInput = document.getElementById('endAddrKeyword');
        endAddrKeywordInput.value=Addr;
        registerInputEvents(endAddrKeyword, Addr);
    var endxInput = document.getElementById('endx');
        endxInput.value=X;
    var endyInput = document.getElementById('endy');
        endyInput.value=Y;
        
        window.selectOptionsEndData = {
                endAddress: Addr,
                endPlaceName: Addr,
                endLng: X,
                endLat: Y
            };
  }

function selectOptions(callCode){
  
  // 출발/도착지 값 둘다 있는지 체크

    var startAddrInput = document.getElementById('startAddrKeyword');
    var endAddrInput = document.getElementById('endAddrKeyword');
    
    if(startAddrInput.value == '' || endAddrInput.value == ''){
       alert("출발지와 목적지를 모두 입력해주세요.");
    } else if (startAddrInput.value.trim() !== '' && endAddrInput.value.trim() !== '') {
    
    // 세션 스토리지에 정보 저장  
    if(window.selectOptionsStartDataMap.startAddress != null){
      sessionStorage.setItem('startAddress', window.selectOptionsStartDataMap.startAddress);
      sessionStorage.setItem('startPlaceName', window.selectOptionsStartDataMap.startPlaceName);
      sessionStorage.setItem('startLat', window.selectOptionsStartDataMap.startLat);
      sessionStorage.setItem('startLng', window.selectOptionsStartDataMap.startLng);
    } else{
        sessionStorage.setItem('startAddress', window.selectOptionsStartData.startAddress);
        sessionStorage.setItem('startPlaceName', window.selectOptionsStartData.startPlaceName);
        sessionStorage.setItem('startLat', window.selectOptionsStartData.startLat);
        sessionStorage.setItem('startLng', window.selectOptionsStartData.startLng);
    }
    
    sessionStorage.setItem('endAddress', window.selectOptionsEndData.endAddress);    
    sessionStorage.setItem('endPlaceName', window.selectOptionsEndData.endPlaceName);
    sessionStorage.setItem('endLat', window.selectOptionsEndData.endLat);
    sessionStorage.setItem('endLng', window.selectOptionsEndData.endLng);

    self.location = "/callreq/selectOptions?userNo="+${user.userNo }+"&callCode="+callCode;
  }
}
</script>
</body>
</html>