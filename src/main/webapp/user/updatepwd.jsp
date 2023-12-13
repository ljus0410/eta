<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../home/top.jsp" />
<form id="login" method="post" action="/user/updatePwd">
<%-- <input id ="pwd" type="text" name="pwd" value="${user.pwd}"><br> --%>
<input id ="pwd" type="text" name="pwd" value=''>
<input id="submit" type="submit" name="submit" value="Enter"/>
<!-- <a href="/user/logon">Label</a> -->
<input type="hidden" name="email" value="${user.email}">

</form>
</body>
</html>