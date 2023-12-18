<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>공지사항 상세보기</title>
<link rel="stylesheet" type="text/css"
	href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css"
	href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet">
<link rel="manifest" href="/templates/_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180"
	href="/templates/app/icons/icon-192x192.png">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function () {
	$("a:contains('삭제')").on("click",function(){
		if(confirm("해당 공지사항을 삭제 하시겠습니까?")){
			alert("정상적으로 삭제되었습니다.");
			self.location ="/notice/deleteNotice?noticeNo=${notice.noticeNo}";
		}else{
			alert("삭제 취소");
		}
		
	})
	
	$("a:contains('수정')").on("click",function(){
			self.location ="/notice/updateNotice?noticeNo=${notice.noticeNo}";
		
	})
})
</script>
</head>
<body class="theme-light">
	<div id="page">
	<jsp:include page="/home/top.jsp" />
		<div class="page-content header-clear-medium">
			<div class="card card-style" style="margin-bottom: 15px;">
					<div class="content"style="margin-bottom: 9px; ">
					<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

					<h1 class="pb-2" style="width: 140px; display: inline-block;">
						<i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;공지사항
						/
					</h1>
					<h3 class="font-400 mb-0"style="display: inline-block;">${notice.noticeNo }</h3>

				</div>
			</div>
			<div class="card card-style mb-3">
				
				<p style="margin-bottom : 0px; margin-top: 15px; margin-right: 20px;" align ="right">작성일 : ${notice.noticeDate }
				<div class="content">
					<div class="form-custom form-label form-icon mb-3">
						<h5 class="font-700 mb-nl color-highlight"
							style="padding-bottom: 3px">제목</h5>

						<div class="divider bg-fade-blue" style="width: 9%;margin-bottom: 15px"></div>
						<p>${notice.noticeTitle }
					</div>
					<div class="mb-3 pb-2"></div>
					<div class="form-custom form-label form-icon mb-3">
						<h5 class="font-700 mb-nl color-highlight"
							style="padding-bottom: 3px">내용</h5>
						<div class="divider bg-fade-blue" style="width: 9%;margin-bottom: 15px"></div>
						<p>${notice.noticeDetail }
					</div>
				</div>
				<c:if test="${user.role eq 'admin'}">
				<div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
					<a class="btn btn-xxs border-blue-dark color-blue-dark"
									style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px;margin-right: 10px ">수정</a>
					<a class="btn btn-xxs border-red-dark color-red-dark"
									style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px;margin-right: 20px">삭제</a>
				</div>
				</c:if>
			</div>

		</div>
	</div>
</body>
</html>