<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>

<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>Duo Mobile PWA Kit</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="/templates/icons/icon-192x192.png">
 <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/templates/scripts/bootstrap.min.js"></script>
<script src="/templates/scripts/custom.js"></script>

  <style>
        .dropdown-menu {
      background-color: transparent; /* 배경을 투명으로 만듭니다. */
      border: none; /* 테두리 제거 */
    }

       .dropdown-menu a {
      color: rgba(0, 0, 0, 0.8); /* 메뉴 텍스트 색상을 검은색으로 설정합니다. */
    }
  </style>
  
  
  <script type="text/javascript">
  $(document).ready(function() {
      // id가 "logoutLink"인 요소에 클릭 이벤트를 추가 
      $("#logOutButton").on("click", function() {
          // 쿠키에서 토큰 값을 가져옴
          var naverAccessToken = getCookie("naverAccessToken");
           console.log("Naver Access Token:", naverAccessToken);
          // 로그아웃 URL 구성 (토큰 값이 있다면 추가)
          var logoutUrl = "/user/kakao-logOut" + (naverAccessToken ? "?token=" + encodeURIComponent(naverAccessToken) : "");

          // 페이지 이동
          window.location.href = logoutUrl;
      });

      // 쿠키에서 특정 이름의 값을 가져오는 함수
      function getCookie(name) {
          var value = "; " + document.cookie;
          var parts = value.split("; " + name + "=");
          if (parts.length == 2) return parts.pop().split(";").shift();
      }
  
  });
  
  $(document).ready(function() {
  $(function() {
	  //로그인
       document.getElementById('loginButton').addEventListener('click', function(event) {
        event.preventDefault(); // 기본 동작을 막음 (링크의 href로 이동하는 것을 막음)

        // 오프캔버스 모달을 토글
        var menuLoginOffcanvas = new bootstrap.Offcanvas(document.getElementById('menu-login'));
        menuLoginOffcanvas.show();
    });
  });
  
  $(function() {
    //즐겨찾기
    $(".getLike-AddrList").on("click", function() {
    	 alert('즐겨찾기을 클릭했습니다!');
        self.location = "/callreq/likeAddress?userNo=${user.userNo}";
    });
    //신고내역
    $(".report-list").on("click", function() {
    	alert('신고내역 클릭했습니다!');
        self.location = "/feedback/listReport"
    }); 
    //내정보
    $(".get-User").on("click", function() {
    	alert('내정보 클릭했습니다!');
        self.location = "/user/getUser?userNo=${user.userNo}"
    });
    
    //Tpay 이용내역
    $(".tpay-charge").on("click", function() {
    	 alert('이용내역 클릭했습니다!');
        self.location = "/pay/TpayList?userNo=${user.userNo}&month=all"
    });
    
    //공지사항
    $(".info-notice").on("click", function() {
    	alert('공지사항 클릭했습니다!');
        self.location = "/notice/listNotice"
    });
    
    //합승
    $(".taxi-toge").on("click", function() {
    	alert('합승 클릭했습니다!');
        self.location = "/community/getShareList"
    });
    
    //예약 
    $(".reserva-tion").on("click", function() {
    	alert('예약 클릭했습니다!');
        self.location = "/callres/getReservationList"
    });
    //회원리스트
    $(".user-list").on("click", function() {
    	alert('user 클릭했습니다!');
        self.location = "/user/listUser"
    });
    //이용내역=getRecordList?
    $(".get-use").on("click", function() {
    	alert('이용내역 클릭했습니다!');
        self.location = "/callres/getRecordList"
    });
    //운행기록=getCallResList?
    $(".get-driving").on("click", function() {
    	alert('운행기록 클릭했습니다!');
        self.location = "/callres/getCallResList"
    });
    //정산내역
    $(".my-money").on("click", function() {
    	alert('정산내역 클릭했습니다!');
        self.location =  "/pay/myCashList?userNo=${user.userNo}&month=all"
    }); 
    //정산승인
    $(".settlement-approval").on("click", function() {
    	alert('정산승인 클릭했습니다!');
        self.location = "/pay/cashDriverList?month=all"
    });
    //회원가입
    $('#createAccountLink').on('click', function() {
    	alert('회원가입 클릭했습니다!');
        self.location = "/user/addUser"
    });


  
  document.getElementById("dropdownMenuButton").addEventListener("click", function(e) {
      e.preventDefault(); // 클릭 이벤트의 기본 동작을 막음
      e.stopPropagation(); // 이벤트 버블링을 중지
      // 여기에 드롭다운 메뉴를 표시하는 로직 추가 가능
    });
});
  });
  //로그인 부분
  $(document).ready(function() {
	    $("#loginBtn").on("click", function() {
	        var id = $("#c1").val();
	        var pw = $("#c2").val();
	        var warningMessage = $("#warningMessage"); // 메시지를 동적으로 변경할 요소

	        if (id == null || id.length < 1) {
	            // 얼럿(alert) 대신 모달(offcanvas) 표시
	            warningMessage.text('ID를 입력하지 않으셨습니다.');
	            $('#loginWarning').offcanvas('show');
	            $("#c1").focus();
	            return;
	        }

	        if (pw == null || pw.length < 1) {
	            // 얼럿(alert) 대신 모달(offcanvas) 표시
	            warningMessage.text('패스워드를 입력하지 않으셨습니다.');
	            $('#loginWarning').offcanvas('show');
	            $("#c2").focus();
	            return;
	        }

	        // 서버로 로그인 요청을 보냄
	        $.ajax({
	            type: "POST",
	            url: "/user/json/login", // 수정이 필요할 수 있음
	            contentType: "application/json",
	            data: JSON.stringify({
	                email: id,
	                pwd: pw
	            }),
	            success: function(data) {
	            	console.log("data: "+data.success);
	            	 if (data.success) {
	                     // 성공 메시지 처리
	                     showSuccessModal(data.success);
	                 } else if (data.fail || data.ment) {
	                     // 실패 메시지 처리 (fail 또는 ment 중 하나라도 존재할 경우)
	                     showLoginFailed(data.fail || data.ment);
	            	    }
	            	},
	            error: function(xhr, status, error) {
	                // 서버 오류 등의 예외 처리
	                showLoginFailed("서버 오류가 발생했습니다");//이메일과 비밀번호를 확인해 주세요
	                console.error("Ajax request failed:", status, error);
	            }
	        });
	    });
	});

  
  function showSuccessModal(message) {
	    // 모달에 동적으로 메시지 설정
	    var menuSuccess = new bootstrap.Offcanvas(document.getElementById('menu-success'));
	    var successMessage = menuSuccess._element.querySelector('.opacity-90'); // 성공 메시지가 있는 요소 선택
	    successMessage.textContent = message;
	    menuSuccess.show();
	}


  $( function() {
      $("#confirmationButton").on("click" , function() {
    	  $("form").attr("method", "POST").attr("action", "/user/login").submit();
      });
    });

	        
  function showLoginFailed(message) {
	    // 모달에 동적으로 메시지 설정 및 표시
	    var loginWarning = new bootstrap.Offcanvas(document.getElementById('menu-warning'));
	    var warningMessage = document.getElementById('menu-warning').querySelector('.opacity-60'); // 경고 메시지가 있는 요소 선택
	    warningMessage.textContent = message;
	    loginWarning.show();
	}



    </script>
  
</head>

<body class="theme-light">
 
<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
 

   
    <div class="header-bar header-fixed header-app header-center header-bar-detached">
      <a class="bi bi-list" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample" style="font-size: 30px;"></a>
      <a href="#" class="header-title">eTa</a>
     <c:choose>
        <c:when test="${user.role eq null}">
            <!-- 로그인이 안 된 경우 -->
            <a class="btn btn-outline-light me-2" id="loginButton">Login</a>

        </c:when>
        <c:otherwise>
            <!-- 로그인 된 경우 -->
            
                <a id="logOutButton" class="btn btn-outline-light me-2">Logout</a>
         
        </c:otherwise>
    </c:choose>
</div>

 <div id="footer-bar" class="footer-bar footer-bar-detached">
    <a data-back-button href="#"><i class="bi bi-caret-left-fill font-16 color-theme ps-2"></i><span>Back</span></a>
        <a href="/home.jsp"><i class="bi bi-house-fill font-16"></i><span>Home</span></a>
        <a href="#offcanvasExample" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample"><i class="bi bi-list"></i><span>Menu</span></a>
    </div>
    
  <div id="menu-main" data-menu-active="nav-comps" data-menu-load="menu-main.html"
    style="width:280px;" class="offcanvas offcanvas-start offcanvas-detached rounded-m">
  </div>
  <!-- Menu Highlights-->
  <div id="menu-color" data-menu-load="menu-highlights.html"
    style="height:340px" class="offcanvas offcanvas-bottom offcanvas-detached rounded-m">
  </div>
    
    <div id="menu-main" data-menu-active="nav-comps" data-menu-load="menu-main.html"
    style="width:280px;" class="offcanvas offcanvas-start offcanvas-detached rounded-m">
  </div>
  <!-- Menu Highlights-->
  <div id="menu-color" data-menu-load="menu-highlights.html"
    style="height:340px" class="offcanvas offcanvas-bottom offcanvas-detached rounded-m">
  </div>

<div class="offcanvas offcanvas-start offcanvas-detached rounded-m" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel" style="width: 300px;">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasExampleLabel">Menu</h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  
  
<div class="offcanvas-body">
    <!-- Driver일 경우에만 공지사항 메뉴를 표시 -->
    <c:if test="${user.role eq 'driver' or user.role eq null}">
        <i class="bi bi-info-square-fill color-blue-dark pe-3 font-20"></i> 
        <a class="info-notice" style="font-size: 18px;"><strong>공지사항</strong></a><br>
        
    </c:if>

    <!-- Passenger일 경우에만 이용내역 메뉴를 표시 -->
    <c:if test="${user.role eq 'passenger'}">
        <i class="bi bi bi-currency-dollar color-yellow-light pe-3 font-20"></i>
        <a class="tpay-charge" style="font-size: 18px;"><strong>Tpay 이용내역</strong></a><br>
        <i class="bi bi-info-square-fill color-blue-dark pe-3 font-20"></i> 
        <a class="info-notice" style="font-size: 18px;"><strong>공지사항</strong></a><br>
        <i class="bi bi-person-plus-fill color-green-dark pe-3 font-20"></i> 
        <a class="taxi-toge" style="font-size: 18px;"><strong>합승</strong></a><br>
        <i class="bi bi-calendar-date color-orange-light pe-3 font-20"></i> 
        <a class="reserva-tion" style="font-size: 18px;"><strong>예약</strong></a><br>
    </c:if>

    <!-- Admin일 경우에는 모든 메뉴 표시 -->
    <c:if test="${user.role eq 'admin'}">
        <i class="bi bi-info-square-fill color-blue-dark pe-3 font-20"></i> 
        <a class="info-notice" style="font-size: 18px;"><strong>공지사항</strong></a><br>
        <i class="bi bi-check-circle-fill color-black-dark pe-3 font-20"></i> 
        <a class="report-list" style="font-size: 18px;"><strong>신고내역</strong></a><br>
        <i class="bi bi-person-lines-fill color-purple-dark pe-3 font-20"></i> 
        <a class="user-list" style="font-size: 18px;"><strong>회원리스트</strong></a><br>
        <i class="bi bi-cash-stack color-yellow-dark pe-3 font-20"></i> 
        <a class="settlement-approval" style="font-size: 18px;"><strong>정산승인</strong></a><br>
    </c:if>
</div>

<div class="dropdown dropend">
<a id="dropdownMenuButton" data-bs-toggle="dropdown" style="font-size: 18px;">
    <c:if test="${user.role ne null and user.role ne 'admin'}">
        <i class="bi bi-person-square color-black pe-3 font-20"></i>
        <strong>
            <c:choose>
                <c:when test="${user.role eq 'passenger'}">My Page</c:when>
                <c:when test="${user.role eq 'driver'}">Driver Page</c:when>
            </c:choose>
        </strong>
    </c:if>
</a>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
        <c:if test="${user.role eq 'passenger'}">
            <li><a class="dropdown-item getLike-AddrList" href="#">즐겨찾기</a></li>
        </c:if>
        <li>
            <c:choose>
                <c:when test="${user.role eq 'passenger'}">
                <a class="dropdown-item get-use" href="#">이용내역</a></c:when>
                <c:otherwise>
                <a class="dropdown-item get-driving" href="#">운행기록</a>
                </c:otherwise>
            </c:choose>
        </li>
        <li>
            <c:choose>
                <c:when test="${user.role eq 'passenger'}">
                <a class="dropdown-item report-list" href="#">신고내역</a></c:when>
                <c:otherwise>
                <a class="dropdown-item my-money" href="#">정산내역</a>
                </c:otherwise>
            </c:choose>
        </li>
        <li><a class="dropdown-item get-User" href="#">회원정보</a></li>
    </ul>
</div>
  <br>
  <br>
  <br>
  <br>
  <br>

  </div>
  

    
<form>
<div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px" id="menu-login">
    <div class="content">
      <h5 class="mb-n1 font-12 color-highlight font-700 text-uppercase pt-1">Welcome</h5>
      <h1 class="font-24 font-800 mb-3">Login</h1>
      <div class="form-custom form-label form-border form-icon mb-3 bg-transparent">
        <i class="bi bi-person-circle font-13"></i>
        <input type="text" class="form-control rounded-xs" id="c1" name="email" placeholder="email" />
      </div>
      <div class="form-custom form-label form-border form-icon mb-4 bg-transparent">
        <i class="bi bi-asterisk font-13"></i>
        <input type="password" class="form-control rounded-xs" id="c2" name="pwd" placeholder="Password"/>

      </div>
      <a href="#" id="loginBtn" class="btn btn-full gradient-green shadow-bg shadow-bg-s mt-4">SIGN IN</a>
      <div class="row">
        <div class="col-6 text-start">
          <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-forgot" class="font-11 color-theme opacity-40 pt-3 d-block">Forgot Password?</a>
        </div>
        <div class="col-6 text-end">
          <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-register" class="font-11 color-theme opacity-40 pt-3 d-block" id="createAccountLink">>Create Account</a>
        </div>
      </div>
    </div>
   </div>
   
   
  
   <!-- 로그인 실패 모달 -->
 <div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px" id="menu-warning">
     <div class="gradient-red px-3 py-3">
       <div class="d-flex mt-1">
         <div class="align-self-center">
          <i class="bi bi-x-circle-fill font-22 pe-2 scale-box color-white"></i>
        </div>
         <div class="align-self-center">
           <h1 class="font-800 color-white mb-0">Warning</h1>
         </div>
       </div>
       <p class="color-white opacity-60 pt-2">
         Something's not right. You can add extra actions to this sheet or just tap to dismiss.
       </p>
       <a href="#"  data-bs-dismiss="offcanvas" class="default-link btn btn-full btn-s bg-white color-black">Try again...</a>
     </div>
  </div>
  
 <div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px" id="menu-success">
     <div class="gradient-green px-3 py-3">
       <div class="d-flex mt-1">
         <div class="align-self-center">
          <i class="bi bi-check-circle-fill font-22 pe-2 scale-box color-white"></i>
        </div>
         <div class="align-self-center">
           <h1 class="font-700 color-white mb-0">Success</h1>
         </div>
       </div>
       <p class="color-white opacity-90 pt-2">
         Your task was successfully completed! Great work! Tap the button to dismiss this box.
       </p>
      <a href="#" data-bs-dismiss="offcanvas" class="default-link btn btn-full btn-s bg-white color-black" id="confirmationButton">확인</a>
  </div>
  </div>
 
 </form>
 
 

</body>
</html>