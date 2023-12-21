<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>WebSocket Chat</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
    <link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

</head>
<body class="theme-light">

<div id="page">

    <div id="preloader">
        <div class="spinner-border color-highlight" role="status"></div>
    </div>

    <div class="header-bar header-fixed header-app header-center header-bar-detached">
        <a data-back-button="" href="#"><i class="bi bi-caret-left-fill font-11 color-theme ps-2"></i></a>
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

    <form id="messageForm">
    <div id="footer-bar" class="footer-bar footer-bar-detached">

        <div class="me-3 speach-icon">
            <a href="#" class="bg-gray-dark ms-1" data-bs-toggle="offcanvas" data-bs-target="#menu-upload"><i class="bi bi-plus font-23 pt-2"></i></a>
        </div>
        <div class="flex-fill speach-input">
            <input type="hidden" id="callNo" name="callNo" value="${callNo}">
            <input type="text" class="form-control bg-theme" id="content" name="content" placeholder="Enter your Message here">
            <input type="hidden" id="sender" name="sender" value="${user.nickName}">
        </div>
        <div class="ms-3 speach-icon">
            <a href="#" class="bg-blue-dark me-1" onclick="sendMessage()"><i class="bi bi-chevron-up pt-2"></i></a>
        </div>

    </div>
    </form>

    <div class="offcanvas offcanvas-bottom rounded-m offcanvas-detached bg-theme" id="menu-upload">
        <div class="content">
            <div class="d-flex pb-2">
                <div class="align-self-center">
                    <h5 class="mb-n1 font-12 color-highlight font-700 text-uppercase pt-1">Just tap and</h5>
                    <h1 class="font-700">Add to Chat</h1>
                </div>
                <div class="align-self-center ms-auto">
                    <a href="#" data-bs-dismiss="offcanvas" class="icon icon-m"><i class="bi bi-x-circle-fill color-red-dark font-18 me-n4"></i></a>
                </div>
            </div>
            <div class="list-group list-custom list-group-m rounded-xs list-group-flush bg-theme">
                <a href="#" class="list-group-item">
                    <i class="bi bi-file-arrow-up-fill color-theme opacity-30 font-16"></i>
                    <div class="font-500 ps-2">File</div>
                    <i class="bi bi-chevron-right pe-1"></i>
                </a>
                <a href="#" class="list-group-item">
                    <i class="bi bi-geo-alt-fill color-theme opacity-30 font-16"></i>
                    <div class="font-500 ps-2">Location</div>
                    <i class="bi bi-chevron-right pe-1"></i>
                </a>
            </div>
        </div>
    </div>

    <div class="page-content header-clear-medium">

        <%--<div class="card card-style">
            <div class="content">
                <div class="accordion accordion-m border-0" id="accordion-group-7">
                    <div class="accordion-item border border-fade-highlight rounded-bottom rounded-top rounded-m">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#accordion7-3" aria-expanded="false">
                            <i class="bi bi-check-circle-fill color-green-dark pe-3 font-14"></i>
                            <span class="font-600 font-13">합승 배차 정보</span>
                            <i class="bi bi-arrow-down-short font-20"></i>
                        </button>
                        <div id="accordion7-3" class="accordion-collapse collapse" data-bs-parent="#accordion-group-7" style="">
                            <p class="px-3 mb-0 pb-3 pt-1">
                            <div class="row">
                                <div class="col-12">
                                    배차 번호 : ${call.callNo}<br/>
                                    출발 : ${call.startAddr}<br/>
                                    도착 : ${call.endAddr}<br/>
                                </div>
                                <div class="col-9">
                                    출발 날짜 : ${share.shareDate} <br/>
                                    참여 인원 : ${share.firstShareCount} / ${share.maxShareCount}
                                </div>
                            </div>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- card card-style 끝 -->--%>

        <div class="content mt-0">
            <div id="chat">
                <div id="messages"></div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/javascript/community/chat.js"></script>
    <script src="/templates/scripts/bootstrap.min.js"></script>
    <script src="/templates/scripts/custom.js"></script>
</body>
</html>
