<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/notice/addNotice" method = "post">
공지사항제목<input type="text" name ="noticeTitle"></br>
공지사항내용<input type="text" name ="noticeDetail">
<input id="submit" type="submit" name="submit" value="등록하기"/>
</form>
</body>
</html>