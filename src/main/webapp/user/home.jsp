<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

<a href="/user/getUser?userNo=${user.userNo}">유저정보</a>
<a href="#" id="logoutLink">로그아웃</a>


<!-- JavaScript 코드 -->
<script>
$(document).ready(function() {
    // id가 "logoutLink"인 요소에 클릭 이벤트를 추가
    $("#logoutLink").on("click", function() {
        // 쿠키에서 토큰 값을 가져옴
        var naverAccessToken = getCookie("naverAccessToken");
         console.log("Naver Access Token:", naverAccessToken);
        // 로그아웃 URL 구성 (토큰 값이 있다면 추가)
        var logoutUrl = "/user/kakao-logOut" + (naverAccessToken ? "?token=" + encodeURIComponent(naverAccessToken) : "");

        // 페이지 이동
        window.location.href = logoutUrl;
    });

    // 쿠키에서 특정 이름의 값을 가져오는 함수
    function getCookie(name) {
        var value = "; " + document.cookie;
        var parts = value.split("; " + name + "=");
        if (parts.length == 2) return parts.pop().split(";").shift();
    }
});
</script>

</body>
</html>
