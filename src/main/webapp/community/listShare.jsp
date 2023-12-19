<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>합승 리스트 조회</title>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script>
        $(function (){
            $.ajax({
                url: "/community/json/getShareCallNo",
                type: "GET",
                dataType: "json",
                success: function (response) {
                    let receiveInt = parseInt(response);
                    $("#"+receiveInt+" #reqbt").removeClass("btn-xxs btn border-blue-dark color-blue-dark")
                        .addClass("btn btn-xxs border-red-dark color-red-dark")
                        .attr("onclick","deleteShare()").text("삭제");
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
                            alert("에러가 발생했습니다");
                        })
                } else {
                    $('#noShareAlert').addClass('fade show');
                }
            })
        })

        function deleteShare() {
            self.location ="/community/deleteShareReq"
        }

        $(function () {
            $("#reqbt").on("click", function () {
                var row = $(this).closest('div.card');

                // 부모 행에서 배차 번호와 제시 금액을 가져오기
                var callNo = row.find('.callNo').text().trim();
                alert(callNo);
                $('#shareReq').addClass('fade show');
                $(".offerbt").off("click").on("click", function () {
                    $("form")[0].reset();
                    let passengerCount = parseFloat($("#passengerCount").val());
                    sendDataToServer(passengerCount, callNo, () => {
                        // AJAX 요청이 완료된 후에 페이지 reload
                        self.location ="/community/getShareList"
                    });
                })
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

    <jsp:include page="../community/top.jsp" />

    <div class="page-content header-clear-medium">

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
                                <button type="button" class="btn-xxs btn border-blue-dark color-blue-dark" id="reqbt">
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
    <div id="notification-bar-6" class="notification-bar glass-effect detached rounded-s shadow-l" data-bs-delay="15000">
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
                    <a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-red-dark color-red-dark delbt" aria-label="Close">확인</a>
                </div>
            </div>
        </div>
    </div>
    <!-- iOS Toast Bar 끝-->

    <!--Warning Toast Bar-->
    <div id="toast-top-2" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

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
    <div id="toast-top-3" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

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

</body>
</html>