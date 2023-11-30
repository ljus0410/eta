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

    <div class="page-header">
        <h3 class="text-info">상세 조회</h3>
    </div>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>배차코드</strong></div>
        <div class="col-xs-8 col-md-4">${call.callCode}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>금액</strong></div>
        <div class="col-xs-8 col-md-4">${call.realPay}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>출발 도로명 주소</strong></div>
        <div class="col-xs-8 col-md-4">${call.startAddr}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>출발 검색 키워드</strong></div>
        <div class="col-xs-8 col-md-4">${call.startKeyword}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>출발 X</strong></div>
        <div class="col-xs-8 col-md-4">${call.startX}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>출발 Y</strong></div>
        <div class="col-xs-8 col-md-4">${call.startY}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>도착 도로명 주소</strong></div>
        <div class="col-xs-8 col-md-4">${call.endAddr}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>도착 검색 키워드</strong></div>
        <div class="col-xs-8 col-md-4">${call.endKeyword}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>도착 X</strong></div>
        <div class="col-xs-8 col-md-4">${call.endX}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>도착 Y</strong></div>
        <div class="col-xs-8 col-md-4">${call.endY}</div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>예약 시간</strong></div>
        <div class="col-xs-8 col-md-4">${call.callDate}</div>
    </div>
    <hr/>

    </form>



</div>
</body>
</html>