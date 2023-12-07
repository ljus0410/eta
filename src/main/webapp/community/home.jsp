<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

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
            padding: 100px;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="/community/addCall?callCode=N">일반</a>
    <hr/>
    <a href="/community/addReservation">예약</a>
    <hr/>
    <a href="/community/addDeal">딜</a>
    <hr/>
    <a href="/community/addCall?callCode=S">합승</a>
    <hr/>
    <a href="/community/getDealList">딜 리스트</a>
    <hr/>
    <a href="/community/getShareList">합승 리스트</a>
    <hr/>
    <a href="/community/getDealReq">딜 상세</a>
    <hr/>
    <hr/>
</div>
</body>
</html>