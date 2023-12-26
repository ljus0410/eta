<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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

    <script>
    
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
    
        $(function (){

            $.ajax({
                url: "/community/json/getShareCallNo",
                type: "GET",
                dataType: "json",
                success: function (response) {
                    if (response != null){
                        if (response.maxShareCount==0) {
                            let receiveInt = parseInt(response.callNo);
                            $("#"+receiveInt+" .shareOffer").removeClass("btn-xxs btn border-blue-dark color-blue-dark shareOffer")
                                .addClass("btn btn-xxs border-red-dark color-red-dark")
                                .attr("onclick","deleteShareOther()").text("삭제");
                        }
                    }
                }
            })

            $("#chat").on("click", function () {
                if(${user.shareCode}) {
                    $.ajax({
                        url: "/community/json/getShare",
                        type: "GET",
                        dataType: "json",
                        success: function (JSONData){
                            var shareDateValue = JSONData.shareDate;
                            var shareDate = new Date(shareDateValue);
                            var callNo = JSONData.callNo;
                            var currentDate = new Date();

                            var tenMinutesAgo = new Date(shareDate.getTime() - 60 * 60 * 1000);

                            if (currentDate > tenMinutesAgo && currentDate < shareDate) {
                                self.location="/community/chat?callNo="+callNo;
                            } else if (currentDate < tenMinutesAgo ) {
                                $('#beforeShare').addClass('fade show');
                            } else if (currentDate > shareDate) {
                                $('#timeOver').addClass('fade show');
                            }
                        }
                    })
                        .fail(function () {
                            $("#cancelShare").addClass("fade show")
                        })
                } else {
                    $('#noShareAlert').addClass('fade show');
                }
            })
        })

        function deleteShare() {
            $("#deleteShare").addClass("fade show");

        }

        function deleteShareReq() {
            self.location ="/community/deleteShareReq"
        }

        function deleteShareOther(){
            $('#shareReq').removeClass('fade show');
            $("#deleteShareReq").addClass('fade show');
            $("#resultDelete").on("click", function() {
                $.ajax({
                    url: "/community/json/deleteShareReqOther",
                    type: "GET",
                    dataType: "json",
                    success: function (response){
                        console.log(response); // 콘솔에 출력

                        location.reload();
                    }
                })
            })

        }

        $(function () {
            $(".shareOffer").on("click", function () {

                let shareCode = $("#shareCode").val();

                var row = $(this).closest('div.card');

                // 부모 행에서 배차 번호와 제시 금액을 가져오기
                var callNo = row.find('.callNo').text().trim();
                let totalCount = parseInt(row.find(".totalShareCount").val());
                let maxCount =parseInt(row.find(".maxCount").val());



                if (shareCode=="true") {
                    $("#alreadyShareAlert").addClass("fade show");
                } else {
                    $('#shareReq').addClass('fade show');
                    $(".offerbt").off("click").on("click", function () {
                        let passengerCount = parseInt($("#passengerCount").val());
                        if ((passengerCount + totalCount) > maxCount) {
                            $("form")[0].reset();
                            $("#shareCountOver").addClass("fade show");
                        } else {
                            sendDataToServer(passengerCount, callNo, () => {
                                // AJAX 요청이 완료된 후에 페이지 reload
                                self.location ="/community/getShareList"
                            });
                        }
                    })
                }

            })
        })

        function sendDataToServer(inputValue, callNo, callback) {
            // AJAX 요청 설정
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '/community/json/addSharePassenger', true);
            xhr.setRequestHeader('Content-Type', 'application/json');

            const data = {
                firstShareCount: inputValue,
                callNo: callNo
            };

            // AJAX 요청 수행
            xhr.onload = function () {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    console.log(response);
                    if (callback) {
                        callback();
                    }
                } else {
                    console.error('서버에 데이터 전송 실패');
                }
            };

            xhr.send(JSON.stringify(data));
        }

    </script>

</head>

<body class="theme-light">

<div id="page">

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
        <a href="/community/getShareList" class="active-nav"><i class="bi bi-card-list font-16"></i><span>List</span></a>
        <a href="/home.jsp"><i class="bi bi-house-fill font-16"></i><span>Home</span></a>
        <a href="#" id="chat"><i class="bi bi-chat font-16"></i><span>Chat</span></a>
        <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-main"><i class="bi bi-list"></i><span>Menu</span></a>
    </div>

    <div id="menu-main" data-menu-active="nav-comps" data-menu-load="../home/menu.jsp" style="width:280px;"
         class="offcanvas offcanvas-start offcanvas-detached rounded-m" aria-modal="true" role="dialog">
    </div>

    <div class="page-content header-clear-medium">

        <input type="hidden" id="shareCode" value="${user.shareCode}">
        <input type="hidden" id="userNo" value="${user.userNo}">
        <div class="card card-style">
            <div class="content">
                <h2 class="pb-2" style=" margin-top: 10px;">합승 리스트 조회</h2>
            </div>
        </div><!-- card card-style 끝 -->

        <c:forEach var="call" items="${callList}" varStatus="status">
            <div class="card card-style" style="margin-bottom: 10px;">
                <div class="content">
                    <div class="row">
                        <div class="col-12">
                            배차 번호 : <span class="callNo">${call.callNo}</span><br/>
                            출발 : ${call.startAddr}<br/>
                            도착 : ${call.endAddr}<br/>
                        </div>
                        <div class="col-9">
                            <c:set var="share" value="${shareList[status.index]}"/>
                            <input type="hidden" class="totalShareCount" value="${share.firstShareCount}">
                            <input type="hidden" class="maxCount" value="${share.maxShareCount}">
                            출발 날짜 : ${share.shareDate} <br/>
                            참여 인원 : ${share.firstShareCount} / ${share.maxShareCount}
                        </div>
                        <div class="col-3" style="margin-top: 10px; float: right;" id="${call.callNo}">
                            <c:if test="${user.shareCode && user.userNo==share.firstSharePassengerNo}">
                                <button type="button" onclick="deleteShare()" class="btn btn-xxs border-red-dark color-red-dark">
                                    삭제
                                </button>
                            </c:if>
                            <c:if test="${user.userNo!=share.firstSharePassengerNo}">
                                <button type="button" class="btn-xxs btn border-blue-dark color-blue-dark shareOffer" id="${call.callNo}">
                                    참여
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div> <!-- page-content header-clear-medium -->

    <!-- iOS Toast Bar-->
    <div id="shareReq" class="notification-bar glass-effect detached rounded-s shadow-l" data-bs-delay="15000">
        <div class="toast-body px-3 py-3">
            <div class="d-flex">
                <div class="align-self-center">
                    <span class="icon icon-xxs rounded-xs bg-fade-green scale-box"><i class="bi bi-exclamation-triangle color-green-dark font-16"></i></span>
                </div>
                <div class="align-self-center">
                    <h5 class="font-16 ps-2 ms-1 mb-0">참여 인원수</h5>
                </div>
            </div>
            <p class="font-12 pt-2 mb-3">
            </p>
            <div class="align-self-center">
                <form class="demo-animation needs-validation m-0" novalidate>
                    <input type="text" class="form-control rounded-xs" id="passengerCount" name="passengerCount" placeholder="참여할 인원수를 입력하세요."/>
                </form>
            </div>
            <p class="font-12 pt-2 mb-3">
            </p>
            <div class="row">
                <div class="col-6">
                    <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-green color-green-dark" aria-label="Close">취소</a>
                </div>
                <div class="col-6">
                    <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-green-dark color-green-dark offerbt" aria-label="Close">참여</a>
                </div>
            </div>
        </div>
    </div>
    <!-- iOS Toast Bar 끝-->

    <!-- iOS Toast Bar-->
    <div id="deleteShareReq" class="notification-bar glass-effect detached rounded-s shadow-l" data-bs-delay="15000">
        <div class="toast-body px-3 py-3">
            <div class="d-flex">
                <div class="align-self-center">
                    <span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>
                </div>
                <div class="align-self-center">
                    <h5 class="font-16 ps-2 ms-1 mb-0">합승 참여를 취소하시겠습니까?</h5>
                </div>
            </div>
            <p class="font-12 pt-2 mb-3">
            </p>
            <div class="row">
                <div class="col-6">
                    <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">취소</a>
                </div>
                <div class="col-6">
                    <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-red-dark color-red-dark" aria-label="Close" id="resultDelete">확인</a>
                </div>
            </div>
        </div>
    </div>
    <!-- iOS Toast Bar 끝-->

    <!-- iOS Toast Bar-->
    <div id="deleteShare" class="notification-bar glass-effect detached rounded-s shadow-l" data-bs-delay="15000">
        <div class="toast-body px-3 py-3">
            <div class="d-flex">
                <div class="align-self-center">
                    <span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>
                </div>
                <div class="align-self-center">
                    <h5 class="font-16 ps-2 ms-1 mb-0">합승 글을 삭제하시겠습니까?</h5>
                </div>
            </div>
            <p class="font-12 pt-2 mb-3">
            </p>
            <div class="row">
                <div class="col-6">
                    <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">취소</a>
                </div>
                <div class="col-6">
                    <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-red-dark color-red-dark" aria-label="Close" onclick="deleteShareReq()">확인</a>
                </div>
            </div>
        </div>
    </div>
    <!-- iOS Toast Bar 끝-->

    <!--Warning Toast Bar-->
    <div id="shareCountOver" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-11 mt-n1 opacity-70">입력된 참여 인원수가<br/> 최대 참여 인원수를 초과합니다</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->
    
    <!--Warning Toast Bar-->
    <div id="cancelShare" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-11 mt-n1 opacity-70">참여한 합승이 취소되었습니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->

    <!--Warning Toast Bar-->
    <div id="alreadyShareAlert" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-11 mt-n1 opacity-70">이미 참여한 합승이 있습니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->

    <!--Warning Toast Bar-->
    <div id="noShareAlert" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-11 mt-n1 opacity-70">참여한 합승이 없습니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->

    <!--Warning Toast Bar-->
    <div id="timeOver" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-11 mt-n1 opacity-70">시간이 지났습니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->

    <!--Warning Toast Bar-->
    <div id="beforeShare" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-11 mt-n1 opacity-70">아직 시간이 되지 않았습니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->

</div> <!-- page -->

<!-- templates 적용 -->
<script src="../../templates/scripts/bootstrap.min.js"></script>
<script src="../../templates/scripts/custom.js"></script>
<!-- templates 적용 끝 -->
</body>
</html>