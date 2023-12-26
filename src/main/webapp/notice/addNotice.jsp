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
<script src="/templates/scripts/bootstrap.min.js"></script>
<script src="/templates/scripts/custom.js"></script>

<script type="text/javascript">
$(function () {
	let notificationToast = new bootstrap.Toast($("#toast-notice-add"));
	let noticeTitleToast = new bootstrap.Toast($("#toast-notice-title-reject"));
	let noticeDetailToast = new bootstrap.Toast($("#toast-notice-detail-reject"));
	$("a:contains('등록')").on("click", function() {
		
		 
		if($("input:text[name='noticeTitle']").val() != ''){
			
			if($("textarea[name='noticeDetail']").val() != ''){
				
				
				notificationToast.show();
				
				setTimeout(function() {
		            $("form").submit();
		            
		        }, 500); 
			}else{
				noticeDetailToast.show()
			}
		}else{
			noticeTitleToast.show()
		}
      
    });
	
	
})
</script>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="/templates/_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="/templates/app/icons/icon-192x192.png">
</head>
<body class="theme-light">
	<form action="/notice/addNotice" method="post">
		<div id="page">
		<jsp:include page="/home/top.jsp" />
			<div class="page-content header-clear-medium">
				<div class="card card-style" style="margin-bottom: 15px;">
					<div class="content"style="margin-bottom: 9px; ">
						<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

						<h1 class="pb-2" style="width: 140px; display: inline-block;">
						<i class="has-bg rounded-s bi bg-teal-dark bi-list-columns" style="vertical-align:bottom !important; line-height: 0px!important;height: 30px !important;font-size: 30px !important; all:initial; display: inline-block;"></i>&nbsp;&nbsp;공지사항
						/
					</h1>
					
					
					<h3 class="font-400 mb-0"style="display: inline-block;">등록</h3>
					
					</div>
				</div>

				<div class="card card-style mb-3">
					<div class="content">
						<div class="form-custom form-label form-icon mb-3">
							<h5 class="font-700 mb-nl color-highlight"
								style="padding-bottom: 3px">제목</h5>

							<div class="divider bg-fade-blue" style="width: 9%;margin-bottom: 15px"></div>
							<i class="bi bi-pencil-fill font-12"></i> <input type="text"
								name="noticeTitle" class="form-control rounded-xs" id="c1"
								placeholder="입력해주세요." />


						</div>
						<div class="mb-3 pb-2"></div>
						<div class="form-custom form-label form-icon mb-3">
							<h5 class="font-700 mb-nl color-highlight"
								style="padding-bottom: 3px">내용</h5>
							<div class="divider bg-fade-blue" style="width: 9%;margin-bottom: 15px"></div>
							<i class="bi bi-pencil-fill font-12"></i>
							<textarea class="form-control rounded-xs" name="noticeDetail"
								placeholder="입력해주세요." id="c7"></textarea>

						</div>
					</div>
				</div>
				
				
				<a class="btn-full btn bg-blue-dark" 
					style="float: right; margin-right: 15px; padding-top: 5px; padding-bottom: 5px;">등록</a>
				

			</div>
		<div id="toast-notice-add"  class="toast toast-pill toast-bottom toast-s rounded-l bg-blue-dark shadow-bg shadow-bg-s " data-bs-delay="1000" style="width: 130px"><span class="font-12"><i class="bi bi-check font-20"></i>등록되었습니다!</span></div>
		
			<div id="toast-notice-title-reject"
					class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s"
					data-bs-delay="3000">
					<div class="align-self-center">
						<i
							class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
					</div>
					<div class="align-self-center">
						<strong class="font-13 mb-n2">미입력 오류</strong> <span
							class="font-10 mt-n1 opacity-70">공지사항 제목을 입력해주세요.</span>
					</div>
					<div class="align-self-center ms-auto">
						<button type="button"
							class="btn-close btn-close-white me-2 m-auto font-9"
							data-bs-dismiss="toast"></button>
					</div>
				</div>
				<div id="toast-notice-detail-reject"
					class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s"
					data-bs-delay="3000">
					<div class="align-self-center">
						<i
							class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
					</div>
					<div class="align-self-center">
						<strong class="font-13 mb-n2">미입력 오류</strong> <span
							class="font-10 mt-n1 opacity-70">공지사항 내용을 입력해주세요.</span>
					</div>
					<div class="align-self-center ms-auto">
						<button type="button"
							class="btn-close btn-close-white me-2 m-auto font-9"
							data-bs-dismiss="toast"></button>
					</div>
				</div>
		
		</div>
		
	</form>

</body>
</html>