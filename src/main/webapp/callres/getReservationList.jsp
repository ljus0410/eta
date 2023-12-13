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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        .record-container {
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .record-container p {
            margin-right: 20px;
        }
    </style>
</head>
<body class="theme-light">
    <div id="page">
        <div class="page-content header-clear-medium">
            <c:forEach var="record" items="${list}" varStatus="status">
                <div class="align-self-center">
                    <span class="icon icon-xxl gradient-red color-white shadow-bg shadow-bg-s rounded-m">
                        <i class="bi bi-heart-fill font-24"></i>
                    </span>
                </div>
                <div class="w-100" data-callno="${record.callNo}">
                    <div class="card card-style mb-0">
                        <div class="content">
                            <h4 class="font-20 font-800">날짜/시간: ${record.callNo}</h4>
                            <p class="mt-0">호출: ${record.callCode}</p>
                            <p class="mt-0">출발: ${record.startKeyword}</p>
                            <p class="mt-0">도착: ${record.endKeyword}</p>
                            <p class="mt-0">금액: ${record.realPay}</p>
                            <p class="mt-0">금액: ${record.callNo}</p>
                            <p class="mt-0">금액: ${record.callDate}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <script>
        $(function() {
            $(".w-100").on("click", function() {
                var role = "${user.role}";
                var callNo = $(this).data("callno");
                var url = role === 'passenger' ? '/callres/getRecordPassenger' : '/callres/getRecordDriver';
                var newUrl = url + "?callNo=" + callNo;
                window.location.href = newUrl;
            });
        });
    </script>
    <script src="/javascript/callres/bootstrap.min.js"></script>
    <script src="/javascript/callres/custom.js"></script>
</body>
</html>
