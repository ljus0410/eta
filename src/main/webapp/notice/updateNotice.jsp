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
	$("a:contains('초기화')").on("click",function(){
		$("form")[0].reset();
		
	})
	
	$("a:contains('수정')").on("click",function(){
			$("form").attr("method","post").attr("action","/notice/updateNotice").submit();
		
	})
})
</script>
</head>
<body>
<form name = "detailform">
<table>	
	
	<tr class = "list">
		<input type="hidden" name ="noticeNo" value="${notice.noticeNo }" readonly="readonly"></br>
		공지사항작성일<input type="text" name ="noticeDate" value="${notice.noticeDate }" readonly="readonly"></br>
		공지사항제목<input type="text" name ="noticeTitle" value="${notice.noticeTitle }"></br>
		공지사항내용<input type="text" name ="noticeDetail" value="${notice.noticeDetail }">
	</tr>
	
	</br><a>초기화</a></br>
	<a>수정</a>
</table>
</form>
</body>
</html>