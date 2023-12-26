<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>eTa</title>
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
	$("a:contains('초기화')").on("click",function(){
		 document.updateNoticeform.reset();
		
	})
	
	$("a:contains('수정')").on("click",function(){
			$("form[name='updateNoticeform']").attr("method","post").attr("action","/notice/updateNotice").submit();
		
	})
})
</script>
</head>
<body>
	<form name="updateNoticeform">
		<div id="page">
			<jsp:include page="/home/top.jsp" /> 
			<div class="page-content header-clear-medium">
				<div class="card card-style" style="margin-bottom: 15px;">
					<div class="content" style="margin-bottom: 9px;">
						<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

						<h1 class="pb-2" style="width: 140px; display: inline-block;">
							<i class="has-bg rounded-s bi bg-teal-dark bi-list-columns" style="vertical-align:bottom !important; line-height: 0px!important;height: 30px !important;font-size: 30px !important; all:initial; display: inline-block;"></i>&nbsp;&nbsp;공지사항
							/
						</h1>
						<h3 class="font-400 mb-0" style="display: inline-block;">수정</h3>

					</div>
				</div>
				<div class="card card-style mb-3">
					<div class="content">
						<div class="form-custom form-label form-icon mb-3">
							<h5 class="font-700 mb-nl color-highlight"
								style="padding-bottom: 3px">제목</h5>

							<div class="divider bg-fade-blue"
								style="width: 9%; margin-bottom: 15px"></div>
							<i class="bi bi-pencil-fill font-12"></i> <input type="text"
								name="noticeTitle" class="form-control rounded-xs" id="c1"
								required value="${notice.noticeTitle }" />


						</div>
						<div class="mb-3 pb-2"></div>
						<div class="form-custom form-label form-icon mb-3">
							<h5 class="font-700 mb-nl color-highlight"
								style="padding-bottom: 3px">내용</h5>
							<div class="divider bg-fade-blue"
								style="width: 9%; margin-bottom: 15px"></div>
							<i class="bi bi-pencil-fill font-12"></i>
							<textarea class="form-control rounded-xs" name="noticeDetail"
								id="c7">${notice.noticeDetail }</textarea>

						</div>
						<div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
							<a class="btn btn-xxs border-blue-dark color-blue-dark"
								style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; margin-right: 10px">수정</a>
							<a class="btn btn-xxs border-red-dark color-red-dark"
								style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 15px; padding-right: 15px;">초기화</a>
						</div>
					</div>
					<input type="hidden" name="noticeNo" value="${notice.noticeNo }"
						/>
				</div>

			</div>
		</div>
	</form>
	<script src="/templates/scripts/bootstrap.min.js"></script>

</body>
</html>