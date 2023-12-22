<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="refresh" content="5;url=/">

<style type="text/css">
.visual { 
	width:100%; margin:0 auto; height: calc(100svh - 55px); position: relative; overflow: hidden;
	}
.visual img {
	 height: 100%;
	 width:100%;
	 object-fit: cover; /* 이미지를 자르고 가운데 정렬 */
  	 object-position: 48% 52%;
	 
	 }
#errorTitle {
	color: #D4D6D5;
	position: absolute;
	left: 38%;
	bottom: 20%
}

#errorDetail {
	color: #D4D6D5;
	position: absolute;
	left: 8%;
	bottom: 10%
}


</style>
<script type="text/javascript">
let sec = 5;
function getTime() {
	let date = new Date();	// 현재 날짜와 시간
		//초
	
	let timeBoard = document.getElementById("errorDetail"); // 값이 입력될 공간
	
	let time = sec + "초 후 Home 화면으로 이동합니다. "
	
	timeBoard.innerHTML = time;	// 출력
	sec = sec -1;
	setTimeout(getTime, 1000);	//1000밀리초(1초) 마다 반복
}
</script>

<meta charset="UTF-8">
<title>403</title>
</head>
<body onload="getTime()">
<jsp:include page="/home/top.jsp" />
<div class="visual">
<h1 id="errorTitle">403 오류</h1>
<h1 id="errorDetail"></h1>
<img alt="" src="/images/errorTaxi.png" >
</div>
</body>
</html>