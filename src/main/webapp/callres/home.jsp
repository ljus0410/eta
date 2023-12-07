<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery , Bootstrap CDN -->

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- Bootstrap Dropdown Hover CSS -->

<!-- CSS 추가 : 툴바에 화면 가리는 현상 해결 : 주석처리 전, 후 확인-->

<style>

body {

padding-top : 70px;

}

</style>

<!-- ///////////////////////// JavaScript ////////////////////////// -->


<script>

function sendRequestP() {

window.location.href = '/callres/getRecordPassenger?callNo=1001';

}

function sendRequestD() {

window.location.href = '/callres/getRecordDriver?callNo=1000';

}

function list() {

window.location.href = '/callres/getRecordList';

}

function callAccept() {

window.location.href = '/callres/callAccept?callNo=1004';

}

function ReservationList() {

window.location.href = '/callres/getReservationList';

}

</script>

  


</head>

<body>

  

<button onclick="sendRequestP()">P레코드 조회</button>

<button onclick="sendRequestD()">D레코드 조회</button>

<button onclick="list()">Recordlist조회</button>

<button onclick="callAccept()">수락</button>

<button onclick="ReservationList()">reservationList</button>

  

  

  

</body>

  

</html>