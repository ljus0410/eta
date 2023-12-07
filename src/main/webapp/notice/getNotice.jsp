<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
<script type="text/javascript">
$(function () {
	$("a:contains('공지사항 삭제')").on("click",function(){
		if(confirm("해당 공지사항을 삭제 하시겠습니까?")){
			alert("정상적으로 삭제되었습니다.");
			self.location ="/notice/deleteNotice?noticeNo=${notice.noticeNo}";
		}else{
			alert("삭제 취소");
		}
		
	})
	
	$("a:contains('공지사항 수정')").on("click",function(){
			self.location ="/notice/updateNotice?noticeNo=${notice.noticeNo}";
		
	})
})
</script>
</head>
<body>
<table>	
	<tr>
		<td>공지사항번호</td>
		<td>제목</td>
		<td>내용</td>
		<td>날짜</td>
		
	</tr>
	
	<tr class = "list">
		<td>${notice.noticeNo }</td>
		<td>${notice.noticeTitle }</td>
		<td>${notice.noticeTitle }</td>
		<td>${notice.noticeDate }</td>
	</tr>
	
	<a>공지사항 삭제</a></br>
	<a>공지사항 수정</a>
</table>
</body>
</html>