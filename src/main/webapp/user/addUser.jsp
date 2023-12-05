<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

<form id="login" method="post" action="/user/addUser">
    <input id="email" type="text" name="email" value="${(kakaoProfile != null) ? kakaoProfile.getKakao_account().getEmail() : ''} ${(naverProfile != null) ? naverProfile.getResponse().getEmail() : ''}"><br>
    <input id="nickName" type="text" name="nickName" value="${(kakaoProfile != null) ? kakaoProfile.getProperties().getNickname() : ''}"><br>
    <input id="pwd" type="text" name="pwd" value=''><br>
    <input id="birth" type="text" name="birth" value=''><br>
    <input id="phone" type="text" name="phone" value=''><br>
    <input id="bank" type="text" name="bank" value=''><br>
    <input id="role" type="text" name="role" value='passenger'><br>
    <input id="name" type="text" name="name" value=''><br>
    <input id="submit" type="submit" name="submit" value="Enter"/>
    <!-- <a href="/user/logon">Label</a> -->
</form>

</body>
</html>
