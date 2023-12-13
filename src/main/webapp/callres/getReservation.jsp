<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="manifest" href="_manifest.json">
    <meta id="theme-check" name="theme-color" content="#FFFFFF">
    <link rel="apple-touch-icon" sizes="180x180" href="app/icons/icon-192x192.png">
</head>
<body>
    <div class="page-content header-clear-medium">
        <div class="card card-style">
            <div class="content">
                <h6 class="font-700 mb-n1 color-highlight">Driver and Passenger Info</h6>
                <h1 class="pb-2">Call & User Details</h1>
                <ul class="mb-0 ps-3">
                    <li>${call.callDate}</li>
                    <li>${call.startKeyword}</li>
                    <li>${call.endKeyword}</li>
                    <li>${call.callNo}</li>

                    <c:if test="${user.role == 'driver'}">
                        driver 정보
                        <li>${user.phone}</li>
                        <li>${user.carNum}</li>
                        
                    </c:if>

                    <c:if test="${user.role == 'passenger'}">
                        passenger 정보
                        <li>${user.userNo}</li>
                        <li>${user.phone}</li>
                        <button onclick="startDriving()">운행 시작</button>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>

    <script>
        function startDriving() {
            var callNo = ${call.callNo}
            window.location.href = '/callres/startReservationDriving?callNo=' + callNo;
        }
    </script>
</body>
</html>
