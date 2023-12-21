<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML>
<html lang="en">
<head>

    <title>eTa</title>

    <!-- templates 적용 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
    <link rel="stylesheet" type="text/css" href="../../templates/styles/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../templates/fonts/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="../../templates/styles/style.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="manifest" href="../../_manifest.json">
    <meta id="theme-check" name="theme-color" content="#FFFFFF">
    <link rel="apple-touch-icon" sizes="180x180" href="../../templates/icons/icon-192x192.png">

    <!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

    <style>
        .dropdown-menu {
            background-color: transparent; /* 배경을 투명으로 만듭니다. */
            border: none; /* 테두리 제거 */
        }

        .dropdown-menu a {
            color: rgba(0, 0, 0, 0.8); /* 메뉴 텍스트 색상을 검은색으로 설정합니다. */
        }

        .content2 {
            position: relative;
            margin: 15px 15px 15px 15px;
        }
    </style>

</head>

<body class="theme-light">

<div id="preloader">
    <div class="spinner-border color-highlight" role="status"></div>
</div>

<div class="header-bar header-fixed header-app header-center header-bar-detached">
    <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-main" class="bi bi-list" style="font-size: 30px;"></a>
    <a href="/home.jsp" class="header-title color-theme font-13">eTa</a>

    <c:choose>
        <c:when test="${user.role eq null}">
            <!-- 로그인이 안 된 경우 -->
            <a id="loginButton" class="btn btn-outline-light me-2" >Login</a>
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
    <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-main"><i class="bi bi-list"></i><span>Menu</span></a>
</div>

<div id="menu-main" data-menu-active="nav-comps" data-menu-load="../home/menu.jsp" style="width:280px;"
     class="offcanvas offcanvas-start offcanvas-detached rounded-m" aria-modal="true" role="dialog">
</div>

<form>
    <div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px" id="menu-login">
        <div class="content">
            <h5 class="mb-n1 font-12 color-highlight font-700 text-uppercase pt-1">Welcome</h5>
            <h1 class="font-24 font-800 mb-3">Login</h1>
            <div class="form-custom form-label form-border form-icon mb-3 bg-transparent">
                <i class="bi bi-person-circle font-13"></i>
                <input type="text" class="form-control rounded-xs" id="email" name="email" placeholder="email" />
            </div>
            <div class="form-custom form-label form-border form-icon mb-4 bg-transparent">
                <i class="bi bi-asterisk font-13"></i>
                <input type="password" class="form-control rounded-xs" id="pwd" name="pwd" placeholder="Password"/>
            </div>

            <div style="text-align: center; margin: -18px auto 0;">
                <a href="#" id="loginBtn" style="color: white; width: 250px; display: inline-block;" class="btn-full gradient-blue mt-1">SIGN IN</a>

                <a href="#" id="kakao" class="btn-full mt-1">
                    <img src="/images/kakao.png" class="btn-full" data-bs-toggle="offcanvas" data-bs-target="#menu-kakao" style="width: 250px; height: 24px; display: block; margin: 0 auto;" />
                </a>

                <a href="#" id="naver" class="btn-full mt-1">
                    <img src="/images/naver.png" class="btn-full" data-bs-toggle="offcanvas" data-bs-target="#menu-role" style="width: 250px; height: 24px; display: block; margin: 0 auto;" />
                </a>
            </div>

            <div class="row" style="margin: -18px auto 0;">
                <div class="col-6 text-start">
                    <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-forgot" class="font-11 color-theme opacity-40 pt-3 d-block">비밀번호 찾기</a>
                </div>
                <div class="col-6 text-end">
                    <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-role" class="font-11 color-theme opacity-40 pt-3 d-block">회원가입</a>
                </div>
            </div>
        </div>
    </div>
</form>


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
        <a href="#"  data-bs-dismiss="offcanvas" class="default-link btn btn-full btn-s bg-white color-black">확인</a>
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


<div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px" id="menu-register">
    <div class="content">
        <h5 class="mb-n1 font-12 color-highlight font-700 text-uppercase pt-1">Welcome</h5>
        <h1 class="font-24 font-800 mb-3">내정보</h1>
        <div class="form-custom form-label form-border form-icon mb-3 bg-transparent">
            <i class="bi bi-person-circle font-13"></i>
            <input type="text" class="form-control rounded-xs readonly" id="c1" value = "${user.name}" readonly />
            <label for="c1" class="color-theme">Name</label>
            <span>name</span>
        </div>
        <div class="form-custom form-label form-border form-icon mb-3 bg-transparent">
            <i class="bi bi-at font-17"></i>
            <input type="text" class="form-control rounded-xs readonly" id="c2" value = "${user.email}" readonly   />
            <label for="c1" class="color-theme">Email</label>
            <span>email</span>
        </div>

        <c:if test="${user.role eq 'passenger'}">
            <div class="form-custom form-label form-border form-icon mb-4 bg-transparent">
                <i class="bi bi bi-currency-dollar font-13"></i>
                <input type="text" class="form-control rounded-xs readonly" id="c3" value ="${user.myMoney}원" readonly />
                <label for="c2" class="color-theme">myMoney</label>
                <span>Tpay</span>
            </div>
        </c:if>
        <a href="#" class="btn btn-full get-User gradient-blue shadow-bg shadow-bg-s mt-4">더보기</a>
    </div>
</div>





<div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px" id="menu-register2">
    <div class="content">
        <h1 class="font-24 font-800 mb-3">비밀번호변경</h1>

        <div class="form-custom form-label form-border form-icon mb-3 bg-transparent">
            <i class="bi bi-person-circle font-13"></i>
            <input type="password" class="form-control rounded-xs" id="ca1" value="${user.pwd}" readonly/>
        </div>

        <div class="form-custom form-label form-border form-icon mb-3 bg-transparent">
            <i class="bi bi-at font-17"></i>
            <input type="password" class="form-control rounded-xs" id="ca2" placeholder="비밀번호 확인" value='' oninput="checkPassword()" />
            <div id="passwordMatchMessage" style="font-size: 10px; color: red;"></div>
        </div>
    </div>
</div>




<div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px; height:240px;" id="menu-role">
    <div class="content2 text-center">
        <div class="d-flex pb-2">
            <div class="align-self-center">
                <h4 class="font-700">회원가입</h4>
            </div>
        </div>
        <div class="list-group list-custom list-group-m rounded-xs list-group-flush bg-theme">
        </div>
    </div>
    <div class="card card-style" style="display: flex; align-items: flex-start; margin-top:-20px;">

        <div class="content mb-0">
            <div class="row" style="display: flex; align-items: center;">

                <div class="col text-center" id="passenger">
                    <img src="../images/신한.png" style="width: 100%; height: auto;" class="preload-img img-fluid rounded-l" alt="img">
                    <p style = "align-left:40px;" class="font-600 color-theme font-12 pb-3">passenger</p>
                </div>

                <div class="col text-center" id="driver">
                    <img src="../images/신한.png" style="width: 100%; height: auto;" class="preload-img img-fluid rounded-l" alt="img">
                    <p  class="font-600 color-theme font-12 pb-3">driver</p>
                </div>

            </div>
        </div>
    </div>
</div>

<div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px; height:240px;" id="menu-kakao">
    <div class="content2 text-center">
        <div class="d-flex pb-2">
            <div class="align-self-center">
                <h4 class="font-700">회원가입</h4>
            </div>
        </div>
        <div class="list-group list-custom list-group-m rounded-xs list-group-flush bg-theme">
        </div>
    </div>
    <div class="card card-style" style="display: flex; align-items: flex-start; margin-top:-20px;">

        <div class="content mb-0">
            <div class="row" style="display: flex; align-items: center;">

                <div class="col text-center" id="kakaopaseen">
                    <img src="../images/신한.png" style="width: 100%; height: auto;" class="preload-img img-fluid rounded-l" alt="img">
                    <p style = "align-left:40px;" class="font-600 color-theme font-12 pb-3">passenger</p>
                </div>

                <div class="col text-center" id="kakaodriver">
                    <img src="../images/신한.png" style="width: 100%; height: auto;" class="preload-img img-fluid rounded-l" alt="img">
                    <p  class="font-600 color-theme font-12 pb-3">driver</p>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- templates 적용 -->
<script src="../../templates/scripts/bootstrap.min.js"></script>
<script src="../../templates/scripts/custom.js"></script>
<!-- templates 적용 끝 -->
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

                self.location = "/callreq/likeAddress?userNo=${user.userNo}";
            });
            //신고내역
            $(".report-list").on("click", function() {

                self.location = "/feedback/listReport"
            });
            //내정보
            $(".get-User").on("click", function() {

                self.location = "/user/getUser?userNo=${user.userNo}"
            });

            //Tpay 이용내역
            $(".tpay-charge").on("click", function() {

                self.location = "/pay/TpayList?userNo=${user.userNo}&month=all"
            });

            //공지사항
            $(".info-notice").on("click", function() {

                self.location = "/notice/listNotice"
            });

            //합승
            $(".taxi-toge").on("click", function() {

                self.location = "/community/getShareList"
            });

            //예약
            $(".reserva-tion").on("click", function() {

                self.location = "/callres/getReservationList"
            });
            //회원리스트
            $(".user-list").on("click", function() {

                self.location = "/user/listUser"
            });
            //이용내역=getRecordList?
            $(".get-use").on("click", function() {

                self.location = "/callres/getRecordList"
            });
            //운행기록=getCallResList?
            $(".get-driving").on("click", function() {

                self.location = "/callres/getRecordList"
            });
            //정산내역
            $(".my-money").on("click", function() {

                self.location =  "/pay/myCashList?userNo=${user.userNo}&month=all"
            });
            //정산승인
            $(".settlement-approval").on("click", function() {

                self.location = "/pay/cashDriverList?month=all"
            });
            //회원가입
            $('#createAccountLink').on('click', function() {

                self.location = "/user/addUser"
            });

            $('#naver').on('click', function() {

                self.location = "/user/naver-login"
            });

            $('#kakaopaseen').on('click', function() {

                self.location = "/user/kakao-login?role=passenger"
            });
            $('#kakaodriver').on('click', function() {

                self.location = "/user/kakao-login?role=driver"
            });
            $('#passenger').on('click', function() {

                self.location = "/user/addUser?role=passenger"
            });
            $('#driver').on('click', function() {

                self.location = "/user/addUser?role=driver"
            });


            document.getElementById(topdropdown).addEventListener("click", function(e) {
                e.preventDefault(); // 클릭 이벤트의 기본 동작을 막음
                e.stopPropagation(); // 이벤트 버블링을 중지
                // 여기에 드롭다운 메뉴를 표시하는 로직 추가 가능
            });
        });
    });
    //로그인 부분
    $(document).ready(function() {
        $("#loginBtn").on("click", function() {
            var id = $("#email").val();
            var pw = $("#pwd").val();
            var warningMessage = $("#warningMessage"); // 메시지를 동적으로 변경할 요소

            if (id == null || id.length < 1) {
                // 얼럿(alert) 대신 모달(offcanvas) 표시
                warningMessage.text('이메일를 입력하지 않으셨습니다.');
                $('#loginWarning').offcanvas('show');
                $("#email").focus();
                return;
            }

            if (pw == null || pw.length < 1) {
                // 얼럿(alert) 대신 모달(offcanvas) 표시
                warningMessage.text('패스워드를 입력하지 않으셨습니다.');
                $('#loginWarning').offcanvas('show');
                $("#pwd").focus();
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
                        showLoginFailedBlock(data.ment, data.block.unblockDateStr, data.block.blockCount, data.report.reportCategory, data.report.regDate)
                    }
                },
                error: function(xhr, status, error) {
                    // 서버 오류 등의 예외 처리
                    showLoginFailed("일치하는 정보가 없습니다");//이메일과 비밀번호를 확인해 주세요
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
    
    function showLoginFailedBlock(ment, unblockDate, blockCount, reportCategory, reportRegDate) {
        // 모달에 동적으로 메시지 설정 및 표시
        var loginWarning = new bootstrap.Offcanvas(document.getElementById('menu-warning'));
        var warningTitle = document.getElementById('menu-warning').querySelector('h1'); // 경고 메시지 타이틀 요소 선택
        var warningMessage = document.getElementById('menu-warning').querySelector('p');
        warningTitle.textContent = ment;
        if(blockCount == '4'){
        	warningMessage.innerHTML = '<p class="color-white opacity-60 pt-2">귀하는 '+reportRegDate+' 이용한 서비스에서</br>'+reportCategory+'사유로 신고가 접수되어 비활성화 처리되었습니다.</br></br>현재 누적 비활성화 횟수 '+blockCount+'회로</br>영구정지되어 본 서비스 이용이 불가합니다.</p>'
        }else{
        	warningMessage.innerHTML = '<p class="color-white opacity-60 pt-2">귀하는 '+reportRegDate+' 이용한 서비스에서</br>'+reportCategory+'사유로 신고가 접수되어 비활성화 처리되었습니다.</br></br>현재 누적 비활성화 횟수 '+blockCount+'회로</br>'+unblockDate+' 이후 본 서비스 이용 가능합니다.</p>'	
        }
        
        
        loginWarning.show();
    }


    //비밀번호 확인
    function checkPassword() {
        var password1 = document.getElementById('ca1').value;
        var password2 = document.getElementById('ca2').value;
        var passwordMatchMessage = document.getElementById('passwordMatchMessage');

        if (password2 === "") {
            passwordMatchMessage.innerHTML = '비밀번호를 입력하세요.';
            passwordMatchMessage.style.color = 'red';  // 일치하지 않을 때의 메시지 색상
            return;
        }

        // 비밀번호 일치 여부 확인
        if (password1 === password2) {
            passwordMatchMessage.innerHTML = '비밀번호가 일치합니다.';
            passwordMatchMessage.style.color = 'blue';  // 일치할 때의 메시지 색상
            submitForm();
        } else {
            passwordMatchMessage.innerHTML = '비밀번호가 일치하지 않습니다.';
            passwordMatchMessage.style.color = 'red';  // 일치하지 않을 때의 메시지 색상
        }
    }
    function submitForm() {
        // 비밀번호가 일치하면 현재 페이지를 지정된 URL로 전환
        self.location = "/user/updatePwd"
    }

    function deleteUserView(){
        self.location = "/user/deleteUserView"
    }
</script>

</body>
</html>