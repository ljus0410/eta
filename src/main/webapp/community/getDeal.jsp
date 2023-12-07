<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>getDeal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ///// Bootstrap, jQuery CDN ///// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
        @font-face {
            font-family: 'NanumSquare';
            src: url('https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css');
            font-weight: normal;
            font-style: normal;
        }

        body {
            font-family: NanumSquare;
            font-weight:300;
        }

        .driver-list {
            max-height: 100px;
            overflow-y: auto;
        }

    </style>

    <script>
        $(function() {
            $( "#delete" ).on("click" , function() {
                self.location="/community/deleteDealReq?callNo="+${dealReq.callNo};
            });

            $( "#select" ).on("click" , function() {
                alert("driver 선택")
            });
        });
    </script>

</head>
<body>
<div class="container">

    <div class="page-header">
        <h3 class="text-info">상세 조회</h3>
    </div>

    <div class="row">
        <div class="col-xs-offset-8 col-xs-4"><button type="button" class="btn btn-primary" id="delete">삭제</button></div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>배차 코드</strong></div>
        <div class="col-xs-8 col-md-4">${call.callCode}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>금액</strong></div>
        <div class="col-xs-8 col-md-4">${call.realPay}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>출발</strong></div>
        <div class="col-xs-8 col-md-4">${call.startAddr}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>도착</strong></div>
        <div class="col-xs-8 col-md-4">${call.endAddr}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>경로옵션</strong></div>
        <div class="col-xs-8 col-md-4">${call.routeOpt}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>제시 금액</strong></div>
        <div class="col-xs-8 col-md-4">${dealReq.passengerOffer}</div>
    </div>
    <hr/>
    <c:choose>
        <c:when test="${empty list}">
            <p>참여한 driver가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <ul class="driver-list"> <!-- .driver-list 클래스 추가 -->
                <c:forEach var="driver" items="${list}">
                    <li class="list-group-item">
                        <input type="radio" name="driverNo" id="driverNo"> ${driver.userNo} : ${driver.driverOffer} /
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>

    <div class="row">
        <div class="col-xs-offset-8 col-xs-4"><button type="button" class="btn btn-primary" id="select">선택</button></div>
    </div>



</div>
</body>
</html>