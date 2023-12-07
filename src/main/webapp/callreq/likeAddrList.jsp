<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>like Address</title>
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
<body>
    <div class="map_wrap">
        <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
        <div id="menu_wrap" class="bg_white">
            <div class="homeAddrSearch">
                <div>
                    <form class="form">
                    <input type="hidden" name="likeNo" value="1000">
                    <input type="hidden" name="likeName" value="집">
                       ${likeList[0].likeName} <input type="text" value="" name="likeAddr" id="homeAddrKeyword" size="50px"> 
                        <button id="homeSubmit" type="submit">주소검색</button>                        
                    </form>
                    <button id="deleteHomeAddr" type="submit" onclick="deleteHomeAddrRequest()">삭제</button>
                </div>
            </div>
            <div class="companyAddrSearch">
                <div>
                    <form class="form">
                    <input type="hidden" name="likeNo" value="1001">
                    <input type="hidden" name="likeName" value="회사">
                      ${likeList[1].likeName}  <input type="text" value="" name="likeAddr" id="companyAddrKeyword" size="50px"> 
                        <button id="companySubmit" type="submit">주소검색</button> 
                    </form>
                     <button id="deleteCompanyAddr" type="submit" onclick="deleteCompanyAddrRequest()">삭제</button>
                </div>
            </div>
             <div class="customAddrSearch">
                <div>
                    <form class="form">
                        <input type="hidden" name="likeNo" value="1002">
                        <input type="text" value="" name="likeName" id="customNameKeyword" size="20px"> 
                        <input type="text" value="" name="likeAddr" id="customAddrKeyword" size="50px"> 
                        <button id="customSubmit" type="submit">주소검색</button> 
                    </form>
                    <button id="updateCustomAddr" type="submit" onclick="updateCustomAddr()">수정</button>
                    <button id="deleteCustomAddr" type="submit" onclick="deleteCustomAddrRequest()">삭제</button>
                </div>
            </div>
            <hr>
            <ul id="placesList"></ul>
            <div id="pagination"></div>
        </div>
    </div>
    
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
	  
	  var result = confirm("삭제하시겠습니까?");

	  if (result == true) {
	      alert("삭제가 완료되었습니다.");
	      deleteHomeAddr();
	  } else {
	      alert("삭제 취소");
	  }  
	}
	
function deleteCompanyAddrRequest(){
    
    var result = confirm("삭제하시겠습니까?");

    if (result == true) {
        alert("삭제가 완료되었습니다.");
        deleteCompanyAddr();
    } else {
        alert("삭제 취소");
    }  
  }
  
function deleteCustomAddrRequest(){
    
    var result = confirm("삭제하시겠습니까?");

    if (result == true) {
        alert("삭제가 완료되었습니다.");
        deleteCustomAddr();
    } else {
        alert("삭제 취소");
    }  
  }
	
function updateHomeAddr() {
    // homeAddrSearch div 안에 있는 form을 선택하여 submit
    $(".homeAddrSearch form").attr("method", "POST").attr("action", "/callreq/updateLikeAddr?userNo=1004").submit();
}

function updateCompanyAddr() {
    $(".companyAddrSearch form").attr("method", "POST").attr("action", "/callreq/updateLikeAddr?userNo=1004").submit();
}

function updateCustomAddr() {
	   var customNameInput = document.getElementById('customNameKeyword');
     var customName = customNameInput.value;
     
     var customAddrInput = document.getElementById('customAddrKeyword');
     var customAddr = customAddrInput.value;
     
       if(customName == ''){
         alert("별칭을 입력해주세요.");
       } else if(customAddr == '' ){
    	   alert("주소를 입력해주세요.");
       } else if(customName != '' && customAddr != ''){
    	   $(".customAddrSearch form").attr("method", "POST").attr("action", "/callreq/updateLikeAddr?userNo=1004").submit();
       }
	
	  
   
}

function deleteHomeAddr() {
   $(".homeAddrSearch form").attr("method", "POST").attr("action", "/callreq/deleteLikeAddr?userNo=1004").submit();
}

function deleteCompanyAddr() {
    $(".companyAddrSearch form").attr("method", "POST").attr("action", "/callreq/deleteLikeAddr?userNo=1004").submit();
}

function deleteCustomAddr() {
    $(".customAddrSearch form").attr("method", "POST").attr("action", "/callreq/deleteLikeAddr?userNo=1004").submit();
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
                '</div>';           
 
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
 
    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;
 
        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }
 
        fragment.appendChild(el);
    }
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
        var keywordId = null;
        
        if(type === 'home'){
        	keywordId = 'homeAddrKeyword';
        } else if(type === 'company'){
        	keywordId = 'companyAddrKeyword';
        } else {
        	keywordId = 'customAddrKeyword';
        }
        var keywordInput = document.getElementById(keywordId);
        if (keywordInput) {
        	/*  
           if(title == null){            
             keywordInput.value = detailAddr;
           } else{
             keywordInput.value = title;
           }*/
           
           keywordInput.value = detailAddr;
           
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
	  var homeAddrKeyword = document.getElementById('homeAddrKeyword');
	  homeAddrKeyword.addEventListener('click', function() {
		  homeAddrKeyword.value = '';
		  homeAddrKeyword.placeholder = '주소를 입력해주세요';
    });
	  
	   var companyAddrKeyword = document.getElementById('companyAddrKeyword');
	   companyAddrKeyword.addEventListener('click', function() {
		   companyAddrKeyword.value = '';
		   companyAddrKeyword.placeholder = '주소를 입력해주세요';
	    });
	   
	     var customAddrKeyword = document.getElementById('customAddrKeyword');
	     customAddrKeyword.addEventListener('click', function() {
	    	 customAddrKeyword.value = '';
	    	 customAddrKeyword.placeholder = '주소를 입력해주세요';
	      });
    
	       var customNameKeyword = document.getElementById('customNameKeyword');
	       customNameKeyword.addEventListener('click', function() {
	    	   customNameKeyword.value = '';
	    	   customNameKeyword.placeholder = '별칭을 입력해주세요';
	        });
	       
    var homeKeywordInput = document.getElementById('homeAddrKeyword'); // Add quotes around the ID
    var companyKeywordInput = document.getElementById('companyAddrKeyword'); // Add quotes around the ID
    var customKeywordInput = document.getElementById('customAddrKeyword');
    var customNameInput = document.getElementById('customNameKeyword');
    
    var likeHomeAddrSpan= document.getElementById('likeHomeAddr');
    var likeCompanyAddrSpan = document.getElementById('likeCompanyAddr');
    var likeCustomAddrSpan = document.getElementById('likeCustomAddr');
    var likeCustomNameSpan = document.getElementById('likeCustomName');

    // db에 저장된 즐겨찾기 가져오기
    var likeHomeAddr = likeHomeAddrSpan.textContent.trim();
    console.log('likeHomeAddr:', likeHomeAddr);

    var likeCompanyAddr = likeCompanyAddrSpan.textContent.trim();
    console.log('likeCompanyAddr:', likeCompanyAddr);

    var likeCustomAddr = likeCustomAddrSpan.textContent.trim();
    console.log('likeCustomAddr:', likeCustomAddr);
    
    var likeCustomName = likeCustomNameSpan.textContent.trim();
    console.log('likeCustomName:', likeCustomName);


    //데이터가 있을 때만 처리
    if (homeKeywordInput && likeHomeAddr != null) {
    	 homeKeywordInput.value = likeHomeAddr;
    }
    
    if (companyKeywordInput && likeCompanyAddr != null) {
        companyKeywordInput.value = likeCompanyAddr;
    } 
    
    if (customKeywordInput && likeCustomAddr != null) {
        customKeywordInput.value = likeCustomAddr;
    } 
    
    if (customNameInput && likeCustomName != null) {
    	customNameInput.value = likeCustomName;
    }

});

</script>

</body>

</html>