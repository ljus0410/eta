<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>공지사항 등록</title>
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
	<div class="page-content header-clear-medium">
		<div class="card card-style">
			<div class="content">
				<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->
				
				<h1 class="pb-2"><i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;공지사항 / 등록</h1>
				
			</div>
		</div>

		<div class="card card-style mb-3">
					<div class="content">
						<div class="form-custom form-label form-icon mb-3">
							<h5 class="font-700 mb-nl color-highlight" style="padding-bottom: 3px">제목</h5>
							
							<div class="divider bg-fade-blue" style="width: 9%"></div>
							<i class="bi bi-pencil-fill font-12"></i> <input type="text"
								name="noticeTitle" class="form-control rounded-xs" id="c1"
								placeholder="입력해주세요." required />
							

						</div>
						<div class="mb-3 pb-2"></div>
						<div class="form-custom form-label form-icon mb-3">
						<h5 class="font-700 mb-nl color-highlight" style="padding-bottom: 3px">내용</h5>
						<div class="divider bg-fade-blue" style="width: 9%"></div>
							<i class="bi bi-pencil-fill font-12"></i>
							<textarea class="form-control rounded-xs" name="noticeDetail"
								placeholder="입력해주세요." id="c7"></textarea>
							
						</div>
					</div>
				</div>

				<button class="btn-full btn bg-fade2-blue color-blue-dark" type="submit" style="float: right; margin-right: 15px;">등록하기</button>
				
			
		</div>
		
	</div>
	</form>
</body>
</html>