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
            border-radius: 30px;
            margin: 0px 15px 30px 15px;
            border: none;
            box-shadow: rgba(0, 0, 0, 0.03) 0px 20px 25px -5px, rgba(0, 0, 0, 0.02) 0px 10px 10px -5px;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }

    </style>

    <script>

        function inputAddress(callCode) {

            if (${!user.shareCode && !user.dealCode}) {
                self.location = "/callreq/inputAddress?userNo=${user.userNo }&callCode="+callCode;
            } else {
                if(callCode === 'N'){
                    $("#alert").addClass("fade show");
                } else if(callCode === 'D'){
                    if (${user.dealCode}) {
                        self.location = "/community/getDealReq";
                    } else {
                        $("#alert").addClass("fade show");
                    }
                } else if(callCode === 'S'){
                    if (${user.shareCode}) {
                        self.location = "/community/getShareList";
                    } else {
                        $("#alert").addClass("fade show");
                    }
                } else if(callCode === 'R'){
                    self.location = "/callreq/inputAddress?userNo=${user.userNo }&callCode=R"
                }
            }
        }

        function reservationList() {
            window.location.href = '/callres/getReservationList';
        }

        function getDealList() {
            window.location.href = '/community/getDealList';
        }

        function call() {
            self.location="/callres/getRequest";
        }

    </script>

</head>

<body class="theme-light">

<div id="page">

    <jsp:include page="/home/top.jsp" />

    <div class="page-content header-clear-medium">

        <c:choose>
            <c:when test="${empty user.role}">
                <div class="d-flex justify-content-center" style="padding-top: 150px">
                    <div class="form-custom card-style2 form-label form-icon mb-1">
                        <input type="text" class="form-control rounded-xs" onclick="loginHome()" placeholder="가자!!"/>
                    </div>
                </div>
            </c:when>

            <c:when test="${user.role eq 'passenger'}">
                <div class="d-flex justify-content-center">
                    <div class="form-custom card-style2 form-label form-icon mb-1">
                        <input type="text" class="form-control rounded-xs" onclick="inputAddress('N')" placeholder="가자!!"/>
                    </div>
                </div>

                <div class="content px-2 text-center mb-0">
                    <div class="row me-0 ms-0 mb-0">
                        <div class="col-4 ps-0 pe-0" onclick="inputAddress('R')">
                            <div class="card card-style">
                                <img src="/templates/images/pictures/23.jpg" class="img-fluid">
                                <div class="content pb-0">
                                    <p class="mb-0">예약</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 pe-0 ps-0" onclick="inputAddress('D')">
                            <div class="card card-style">
                                <img src="/templates/images/pictures/2.jpg" class="img-fluid">
                                <div class="content pb-0">
                                    <p class="mb-0">딜</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 pe-0 ps-0" onclick="inputAddress('S')">
                            <div class="card card-style">
                                <img src="/templates/images/pictures/5.jpg" class="img-fluid">
                                <div class="content pb-0">
                                    <p class="mb-0">합승</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>

            <c:when test="${user.role eq 'driver'}">
                <div class="row mb-0">
                    <div class="col-4 pe-0" onclick="call()">
                        <div class="card card-style me-2">
                            <img src="/templates/images/pictures/21.jpg" class="img-fluid">
                            <div class="content pb-0">
                                <p>일반</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-4 pe-0" onclick="reservationList()">
                        <div class="card card-style me-2">
                            <img src="/templates/images/pictures/21.jpg" class="img-fluid">
                            <div class="content pb-0">
                                <p>예약</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-4 ps-0" onclick="getDealList()">
                        <div class="card card-style ms-2">
                            <img src="/templates/images/pictures/22.jpg" class="img-fluid">
                            <div class="content pb-0">
                                <p>딜</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
        </c:choose>

    </div>


    <div id="alert" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-10 mt-n1 opacity-70">참여 중인 배차가 있습니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>

    <div id="loginAlert" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-10 mt-n1 opacity-70">로그인 후 이용바랍니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>

</div>



</body>
</html>