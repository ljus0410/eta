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

    <div class="page-content header-clear-medium">
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
