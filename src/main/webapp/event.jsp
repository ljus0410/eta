<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>eTa</title>

    <style>

        .card-style2 {
            width: 600px; /* 넓이를 원하는 값으로 조절 */
            overflow: hidden;
            border-radius: 10px;
            margin: 0px 15px 30px 15px;
            border: none;
            box-shadow: rgba(0, 0, 0, 0.03) 0px 20px 25px -5px, rgba(0, 0, 0, 0.02) 0px 10px 10px -5px;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }
        
        .musicBtn {
          text-align: right; /* Align buttons to the left */
          margin-bottom: 5px; /* Add some margin below the buttons */
          margin-left: 5px;
      }

    </style>

</head>

<body class="theme-light">

<div id="page">

    <jsp:include page="/home/top.jsp" />

    <div class="page-content header-clear-medium">
      <audio autoplay id="music">
          <source src="/templates/audio/eta.mp3" type="audio/mp3">
      </audio>
               <div class="content px-2 text-center mb-0">
            <div class="row me-0 ms-0 mb-0">
              <div class="col-12 pe-0 ps-0">
              <div class="musicBtn">
                <a onclick="play()" class="musicBtn"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#585858" class="bi bi-play-circle" viewBox="0 0 16 16">
                  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"></path>
                  <path d="M6.271 5.055a.5.5 0 0 1 .52.038l3.5 2.5a.5.5 0 0 1 0 .814l-3.5 2.5A.5.5 0 0 1 6 10.5v-5a.5.5 0 0 1 .271-.445"></path>
                </svg></a>
                <a onclick="stop()" class="musicBtn"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#585858" class="bi bi-stop-circle" viewBox="0 0 16 16">
                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"></path>
                    <path d="M5 6.5A1.5 1.5 0 0 1 6.5 5h3A1.5 1.5 0 0 1 11 6.5v3A1.5 1.5 0 0 1 9.5 11h-3A1.5 1.5 0 0 1 5 9.5z"></path>
                  </svg></a>
                  </div>
                <div class="card card-style" style="margin: 0px 0px 20px 0px;">
                  <img src="/templates/images/pictures/gift.png"
                    class="img-fluid">
                                    
                </div>
              </div>
            </div>
          </div>

                <div class="d-flex justify-content-center">
                    <div class="form-custom card-style2 form-label form-icon mb-1">
                        <input type="text" class="form-control rounded-xs" placeholder="eTa 이벤트 당첨!" readonly/>
                    </div>
                </div>
         </div>

</div>
<script>
function messageAlert(message) {
    var toastContainer = document.createElement('div');
      toastContainer.innerHTML = '<div id="notification-bar-5" class="notification-bar glass-effect detached rounded-s shadow-l fade show" data-bs-delay="15000">' +
          '<div class="toast-body px-3 py-3">' +
          '<div class="d-flex">' +
          '<div class="align-self-center">' + 
          '<span class="icon icon-xxs rounded-xs bg-fade-green scale-box"><i class="bi bi-exclamation-triangle color-green-dark font-16"></i></span>' +
          '</div>' +
          '<div class="align-self-center">' +
          '<h5 class="font-16 ps-2 ms-1 mb-0">'+message+'</h5>' +
          '</div>' +
          '</div><br>' +
          '<a href="#" data-bs-dismiss="toast" id="ok" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">확인</a>' +
          '</div>' +
          '</div>';

      document.body.appendChild(toastContainer.firstChild); // body에 토스트 알림창 추가

      document.getElementById('ok').addEventListener('click', function () {
    	  document.getElementById('notification-bar-5').remove();
        
      });
      $('.toast').toast('show'); // Bootstrap 토스트 표시 함수 호출
 }

document.addEventListener('DOMContentLoaded', function() {
	  // URL 파라미터를 추출하는 함수
	  function getParameterByName(name, url) {
	    if (!url) url = window.location.href;
	    name = name.replace(/[\[\]]/g, '\\$&');
	    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
	        results = regex.exec(url);
	    if (!results) return null;
	    if (!results[2]) return '';
	    return decodeURIComponent(results[2].replace(/\+/g, ' '));
	  }

	  // hitCt 값을 추출
	  var hitCt = getParameterByName('hitCt');

	  // hitCt 값을 사용하여 작업 수행
	  if (hitCt) {
	    // alert("이벤트 당첨!");
	    messageAlert('축하합니다! ' + hitCt + '번 째 eTa 방문자 이벤트 당첨!');
	  }
	});


var audio = document.getElementById("music");

 function play() {
   if (!audio.paused) {
         audio.pause();
         isPlaying = false;
     } else {
         audio.play();
         isPlaying = true;
     }
  }
 
 function stop() {
     audio.pause();
       audio.currentTime = 0;
       isPlaying = false;
    }
 
</script>


</body>
</html>