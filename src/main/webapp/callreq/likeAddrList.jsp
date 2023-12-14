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
<title>like Address</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="/templates/_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="/templates/app/icons/icon-192x192.png">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=70ef6f6883ad97593a97af6324198ac0&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
#homeSubmit {
  display: none;
}
#companySubmit {
  display: none;
}
#customSubmit {
  display: none;
}
#likeHomeList {
  display: none;
}
#likeCompanyList {
  display: none;
}
#likeCustomList {
  display: none;
}
</style>
</head>
<body class="theme-light">
<jsp:include page="/home/top.jsp" /><br>
       <div class="card card-style">
          <div class="content">
            <h1 class="pb-2">
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;즐겨찾기
            </h1>

          </div>
        </div>
        <div class="card card-style">
          <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
             <div id="menu_wrap" class="bg_white">
            <div class="content"> 
              <div class="d-flex pb-1">
                <div>
                  <h3>집
                    <c:choose>
                      <c:when test="${likeList[0].likeName eq '집' && empty likeList[0].likeAddr}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-slash" viewBox="0 0 16 16">
                          <path d="M13.879 10.414a2.5 2.5 0 0 0-3.465 3.465zm.707.707-3.465 3.465a2.501 2.501 0 0 0 3.465-3.465m-4.56-1.096a3.5 3.5 0 1 1 4.949 4.95 3.5 3.5 0 0 1-4.95-4.95Z"/>
                          <path d="M7.293 1.5a1 1 0 0 1 1.414 0L11 3.793V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v3.293l2.354 2.353a.5.5 0 0 1-.708.708L8 2.207l-5 5V13.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 1 0 1h-4A1.5 1.5 0 0 1 2 13.5V8.207l-.646.647a.5.5 0 1 1-.708-.708z"/>
                        </svg> 
                      </c:when>
                      <c:when test="${likeList[0].likeName eq '집' && !empty likeList[0].likeAddr}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-check-fill" viewBox="0 0 16 16">
                          <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
                          <path d="m8 3.293 4.712 4.712A4.5 4.5 0 0 0 8.758 15H3.5A1.5 1.5 0 0 1 2 13.5V9.293l6-6Z"/>
                          <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m1.679-4.493-1.335 2.226a.75.75 0 0 1-1.174.144l-.774-.773a.5.5 0 0 1 .708-.707l.547.547 1.17-1.951a.5.5 0 1 1 .858.514Z"/>
                        </svg> 
                      </c:when>
                    </c:choose> </h3>
                </div>
                <div class="align-self-center ms-auto">
                    <a onclick="deleteHomeAddrRequest()" class="btn btn-xxs border-red-dark color-red-dark" style="display: inline-block; padding-top: 3px; padding-bottom: 3px">삭제</a>
                </div>
              </div>
              <div class="homeAddrSearch">
                <div>
                    <form class="form">
                        <input type="hidden" name="likeNo" value="1000">
                        <input type="hidden" name="likeName" value="집">  
                        <input type="text" value="" name="likeAddr" id="homeAddrKeyword" class="form-control rounded-xs"> 
                        <input type="hidden" value="" name="likeX" id="homeAddrKeywordLng"> 
                        <input type="hidden" value="" name="likeY" id="homeAddrKeywordLat"> 
                        <button id="homeSubmit" type="submit">주소검색</button>                                            
                    </form>
                    </div>
                </div>
            </div>
          </div>
          </div>
          </div>
          <div class="card card-style">
            <div class="content"> 
              <div class="d-flex pb-1">
                <div>
                  <h3>회사
                    <c:choose>
                      <c:when test="${likeList[1].likeName eq '회사' && empty likeList[1].likeAddr}">         
                          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-slash" viewBox="0 0 16 16">
                          <path d="M13.879 10.414a2.501 2.501 0 0 0-3.465 3.465zm.707.707-3.465 3.465a2.501 2.501 0 0 0 3.465-3.465m-4.56-1.096a3.5 3.5 0 1 1 4.949 4.95 3.5 3.5 0 0 1-4.95-4.95Z"/>
                          <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                          <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                        </svg>
                      </c:when>
                      <c:when test="${likeList[1].likeName eq '회사' && !empty likeList[1].likeAddr}"> 
                          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-fill-check" viewBox="0 0 16 16">
                          <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m1.679-4.493-1.335 2.226a.75.75 0 0 1-1.174.144l-.774-.773a.5.5 0 0 1 .708-.708l.547.548 1.17-1.951a.5.5 0 1 1 .858.514Z"/>
                          <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v7.256A4.493 4.493 0 0 0 12.5 8a4.493 4.493 0 0 0-3.59 1.787A.498.498 0 0 0 9 9.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .39-.187A4.476 4.476 0 0 0 8.027 12H6.5a.5.5 0 0 0-.5.5V16H3a1 1 0 0 1-1-1zm2 1.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m3 0v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM4 5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M7.5 5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M4.5 8a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                        </svg>                                          
                      </c:when>
                    </c:choose> </h3>
                </div>
                <div class="align-self-center ms-auto">
                    <a onclick="deleteCompanyAddrRequest()" class="btn btn-xxs border-red-dark color-red-dark" style="display: inline-block; padding-top: 3px; padding-bottom: 3px">삭제 </a>
                </div>
              </div>
              <div class="companyAddrSearch">
                <div>
                    <form class="form">
                        <input type="hidden" name="likeNo" value="1001">
                        <input type="hidden" name="likeName" value="회사">
                        <input type="hidden" value="" name="likeX" id="companyAddrKeywordLng"> 
                        <input type="hidden" value="" name="likeY" id="companyAddrKeywordLat"> 
                        <button id="companySubmit" type="submit">주소검색</button> 
                        <input type="text" class="form-control rounded-xs" name="likeAddr" id="companyAddrKeyword">
                   </form>
                    </div>
                </div>
            </div>
          </div>
          <div class="card card-style">
            <div class="content"> 
              <div class="d-flex pb-1">
                <div>
                  <h3>즐겨찾는장소
                      <c:choose>
                          <c:when test="${ empty likeList[2].likeName && empty likeList[2].likeAddr}">            
                              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-x" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M6.146 5.146a.5.5 0 0 1 .708 0L8 6.293l1.146-1.147a.5.5 0 1 1 .708.708L8.707 7l1.147 1.146a.5.5 0 0 1-.708.708L8 7.707 6.854 8.854a.5.5 0 1 1-.708-.708L7.293 7 6.146 5.854a.5.5 0 0 1 0-.708"/>
                                <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1z"/>
                            </svg>                  
                          </c:when>
                           <c:when test="${ !empty likeList[2].likeName && !empty likeList[2].likeAddr}">  
                              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-star-fill" viewBox="0 0 16 16">
                              <path fill-rule="evenodd" d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5M8.16 4.1a.178.178 0 0 0-.32 0l-.634 1.285a.178.178 0 0 1-.134.098l-1.42.206a.178.178 0 0 0-.098.303L6.58 6.993c.042.041.061.1.051.158L6.39 8.565a.178.178 0 0 0 .258.187l1.27-.668a.178.178 0 0 1 .165 0l1.27.668a.178.178 0 0 0 .257-.187L9.368 7.15a.178.178 0 0 1 .05-.158l1.028-1.001a.178.178 0 0 0-.098-.303l-1.42-.206a.178.178 0 0 1-.134-.098z"/>
                            </svg>
                          </c:when>            
                        </c:choose>  </h3>
                </div>
                <div class="align-self-center ms-auto">
                <a onclick="updateCustomAddr()" class="btn btn-xxs border-blue-dark color-blue-dark" style="display: inline-block; padding-top: 3px; padding-bottom: 3px">수정</a>
                <a onclick="deleteCustomAddrRequest()" class="btn btn-xxs border-red-dark color-red-dark" style="display: inline-block; padding-top: 3px; padding-bottom: 3px">삭제</a>                  
                </div>
              </div>
              <div class="customAddrSearch">
                <div>
                    <form class="form">
                        <input type="hidden" name="likeNo" value="1002">
                         <input type="text" class="form-control rounded-xs" value="" name="likeName" id="customNameKeyword">
                         <input type="text" class="form-control rounded-xs" value="" name="likeAddr" id="customAddrKeyword">
                         <input type="hidden" value="" name="likeX" id="customAddrKeywordLng" > 
                         <input type="hidden" value="" name="likeY" id="customAddrKeywordLat" > 
                         <button id="customSubmit" type="submit">주소검색</button>
                   </form>
                    </div>
                </div>
            </div>
          </div>    
            <ul id="placesList"></ul>
            <div id="pagination"></div>
    <!-- 즐겨찾기 리스트--> 
      <div id="likeHomeList">
      ${likeList[0].likeNo} ${likeList[0].likeName} <span id="likeHomeAddr">${likeList[0].likeAddr}</span>    
      </div>
      <div id="likeCompanyList">
      ${likeList[1].likeNo} ${likeList[1].likeName} <span id="likeCompanyAddr">${likeList[1].likeAddr}</span>     
      </div>
      <div id="likeCustomList">
      ${likeList[2].likeNo} <span id="likeCustomName">${likeList[2].likeName}</span> <span id="likeCustomAddr">${likeList[2].likeAddr}</span>     
      </div>
    
       
</body>
<script>

function deleteHomeAddrRequest(){
	  
	  if (document.getElementById('homeAddrKeyword').value == '' || document.getElementById('homeAddrKeyword').value == null){
		  
		  alert("삭제할 값이 없습니다.");
		  
	  }else {
		  var result = confirm("삭제하시겠습니까?");
		    if (result == true) {
		        alert("삭제가 완료되었습니다.");
		        deleteHomeAddr();
		    } else {
		        alert("삭제 취소");
		    }  
		  
	  }
	}
	
function deleteCompanyAddrRequest(){
	
	   if (document.getElementById('companyAddrKeyword').value == '' || document.getElementById('companyAddrKeyword').value == null){
		      
		      alert("삭제할 값이 없습니다.");
	   } else {
    
    var result = confirm("삭제하시겠습니까?");

    if (result == true) {
        alert("삭제가 완료되었습니다.");
        deleteCompanyAddr();
    } else {
        alert("삭제 취소");
    }  
  }
}
  
function deleteCustomAddrRequest(){
	
    if (document.getElementById('customAddrKeyword').value == '' || document.getElementById('customAddrKeyword').value == null){
        
        alert("삭제할 값이 없습니다.");
   } else {
    
    var result = confirm("삭제하시겠습니까?");

    if (result == true) {
        alert("삭제가 완료되었습니다.");
        deleteCustomAddr();
    } else {
        alert("삭제 취소");
    }  
  }
}
	
function updateHomeAddr() {
    // homeAddrSearch div 안에 있는 form을 선택하여 submit
    $(".homeAddrSearch form").attr("method", "POST").attr("action", '/callreq/updateLikeAddr?userNo=${user.userNo }').submit();
}

function updateCompanyAddr() {
    $(".companyAddrSearch form").attr("method", "POST").attr("action", '/callreq/updateLikeAddr?userNo=${user.userNo }').submit();
}

function updateCustomAddr() {
	   var customNameInput = document.getElementById('customNameKeyword');
     var customName = customNameInput.value;
     
     var customAddrInput = document.getElementById('customAddrKeyword');
     var customAddr = customAddrInput.value;
     
     if(customName == '집'|| customName == '회사'){
    	 alert("집 혹은 회사 외의 다른 별칭을 입력해주세요.");
     } else if(customName == ''){
         alert("별칭을 입력해주세요.");
       } else if(customAddr == '' ){
    	   alert("주소를 입력해주세요.");
       } else if(customName != '' && customAddr != ''){
    	   $(".customAddrSearch form").attr("method", "POST").attr("action", "/callreq/updateLikeAddr?userNo=${user.userNo }").submit();
       }
	
	  
   
}

function deleteHomeAddr() {
   self.location = "/callreq/deleteLikeAddr?userNo=${user.userNo }&likeNo=1000"
}

function deleteCompanyAddr() {
	self.location = "/callreq/deleteLikeAddr?userNo=${user.userNo }&likeNo=1001"
}

function deleteCustomAddr() {
	self.location = "/callreq/deleteLikeAddr?userNo=${user.userNo }&likeNo=1002"
}

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
const homeAddrForm = document.querySelector('.homeAddrSearch .form');
homeAddrForm.addEventListener('submit', function (e) {
    e.preventDefault();

    // 키워드로 장소를 검색합니다
    searchPlaces('homeAddrKeyword', 'home');
});

// 종료 주소 검색 form에 이벤트 리스너 추가
const companyAddrForm = document.querySelector('.companyAddrSearch .form');
companyAddrForm.addEventListener('submit', function (e) {
    e.preventDefault();
    // 키워드로 장소를 검색합니다
    searchPlaces('companyAddrKeyword', 'company');
});

//주소 검색 form에 이벤트 리스너 추가
const customAddrForm = document.querySelector('.customAddrSearch .form');
customAddrForm.addEventListener('submit', function (e) {
    e.preventDefault();
    // 키워드로 장소를 검색합니다
    searchPlaces('customAddrKeyword', 'add');
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
  
  var latitude = parseFloat(position.getLat());
  var longitude = parseFloat(position.getLng());
  
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
        var keywordId = null;
        var latId = null;
        var lngId = null;
        
        if(type === 'home'){
        	keywordId = 'homeAddrKeyword';
        	latId = 'homeAddrKeywordLat';
        	lngId = 'homeAddrKeywordLng';
        	
        } else if(type === 'company'){
        	keywordId = 'companyAddrKeyword';
        	latId = 'companyAddrKeywordLat';
          lngId = 'companyAddrKeywordLng';
        } else {
        	keywordId = 'customAddrKeyword';
        	latId = 'customAddrKeywordLat';
          lngId = 'customAddrKeywordLng';
        }
        var keywordInput = document.getElementById(keywordId);
        var latIdInput = document.getElementById(latId);
        var lngIdInput = document.getElementById(lngId);

        if (keywordInput) {
        	/*  
           if(title == null){            
             keywordInput.value = detailAddr;
           } else{
             keywordInput.value = title;
           }*/
           
           keywordInput.value = detailAddr;
           latIdInput.value = latitude;
           lngIdInput.value = longitude;
           
           if(type === 'home'){
        	   updateHomeAddr();
           } else if(type === 'company'){
        	   updateCompanyAddr();
           } else {
        	   updateCustomAddr();
           }
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
	       
    var homeKeywordInput = document.getElementById('homeAddrKeyword'); // Add quotes around the ID
    var companyKeywordInput = document.getElementById('companyAddrKeyword'); // Add quotes around the ID
    var customKeywordInput = document.getElementById('customAddrKeyword');
    var customNameInput = document.getElementById('customNameKeyword');
    
    var likeHomeAddrSpan= document.getElementById('likeHomeAddr');
    var likeCompanyAddrSpan = document.getElementById('likeCompanyAddr');
    var likeCustomAddrSpan = document.getElementById('likeCustomAddr');
    var likeCustomNameSpan = document.getElementById('likeCustomName');
    
    var homeAddrKeywordLngSpan= document.getElementById('homeAddrKeywordLng');
    var homeAddrKeywordLatSpan = document.getElementById('homeAddrKeywordLat');
    var companyAddrKeywordLngSpan = document.getElementById('companyAddrKeywordLng');
    var companyAddrKeywordLatSpan = document.getElementById('companyAddrKeywordLat');
    var customAddrKeywordLngSpan = document.getElementById('customAddrKeywordLng');
    var customAddrKeywordLatSpan = document.getElementById('customAddrKeywordLat');

    // db에 저장된 즐겨찾기 가져오기
    var likeHomeAddr = likeHomeAddrSpan.textContent.trim();
    console.log('likeHomeAddr:', likeHomeAddr);

    var likeCompanyAddr = likeCompanyAddrSpan.textContent.trim();
    console.log('likeCompanyAddr:', likeCompanyAddr);

    var likeCustomAddr = likeCustomAddrSpan.textContent.trim();
    console.log('likeCustomAddr:', likeCustomAddr);
    
    var likeCustomName = likeCustomNameSpan.textContent.trim();
    console.log('likeCustomName:', likeCustomName);
    
    var homeAddrLng = homeAddrKeywordLngSpan.textContent.trim();
    console.log('homeAddrLng:', homeAddrLng);
    
    var homeAddrLat = homeAddrKeywordLatSpan.textContent.trim();
    console.log('homeAddrLat:', homeAddrLat);
    
    var companyAddrLng = companyAddrKeywordLngSpan.textContent.trim();
    console.log('companyAddrLng:', companyAddrLng);
    
    var companyAddrLat = companyAddrKeywordLatSpan.textContent.trim();
    console.log('companyAddrLat:', companyAddrLat);
    
    var customAddrLng = customAddrKeywordLngSpan.textContent.trim();
    console.log('customAddrLng:', customAddrLng);
    
    var customAddrLat = customAddrKeywordLatSpan.textContent.trim();
    console.log('customAddrLat:', customAddrLat);


    //데이터가 있을 때만 처리
    if (homeKeywordInput && likeHomeAddr != null) {
    	 homeKeywordInput.value = likeHomeAddr;
    	 registerInputEvents(homeAddrKeyword, likeHomeAddr);
    }
    
    if (companyKeywordInput && likeCompanyAddr != null) {
        companyKeywordInput.value = likeCompanyAddr;
        registerInputEvents(companyAddrKeyword, likeCompanyAddr);
    } 
    
    if (customKeywordInput && likeCustomAddr != null) {
        customKeywordInput.value = likeCustomAddr;
        registerInputEvents(customAddrKeyword, likeCustomAddr);
    } 
    
    if (customNameInput && likeCustomName != null) {
    	customNameInput.value = likeCustomName;
    	registerInputEvents(customNameKeyword, likeCustomName);
    }
    
    if (homeAddrKeywordLngSpan && homeAddrLng != null) {
    	  homeAddrKeywordLngSpan.value = homeAddrLng;
      }
    if (homeAddrKeywordLatSpan && homeAddrLat != null) {
    	homeAddrKeywordLatSpan.value = homeAddrLat;
      }
    if (companyAddrKeywordLngSpan && companyAddrLng != null) {
    	companyAddrKeywordLngSpan.value = companyAddrLng;
        }
    if (companyAddrKeywordLatSpan && companyAddrLat != null) {
    	companyAddrKeywordLatSpan.value = companyAddrLat;
          }
    if (customAddrKeywordLngSpan && customAddrLng != null) {
    	customAddrKeywordLngSpan.value = customAddrLng;
            }
    if (customAddrKeywordLatSpan && customAddrLat != null) {
    	customAddrKeywordLatSpan.value = customAddrLat;
              }

});

</script>

</body>

</html>