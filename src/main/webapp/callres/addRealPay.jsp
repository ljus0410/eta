<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>결제 금액 입력</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />

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
<link rel="manifest" href="_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">

</head>

<body class="theme-light">
	<div id="page">
		<div class="page-content header-clear-medium">
			<div class="card card-style">
				<div class="content">
					<h1 class="text-center font-800 font-22 mb-2">실결제금액을 입력해주세요</h1>
					<p class="text-center font-13 mt-n2 mb-2">입력 하지 않을 시 운행 종료되지
						않습니다</p>
					<div class="text-center mb-3 pt-3 pb-2">
						<form action="/callres/addRealPay" method="get">
						    <input type="hidden" name="callNo" value="${callNo}" />
						    <!-- 'name' 속성을 'money'로 설정해 사용자 입력값을 'money' 파라미터로 전송 -->
						    <input type="text" class="form-control rounded-xs" name="money" required placeholder="실결제금액 입력"/>
						   <div style="text-align: center;">
					            <button type="submit" class='btn rounded-sm btn-m gradient-green text-uppercase font-700 mt-4 btn-full shadow-bg shadow-bg-s'>결제하기</button>
					        </div>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/templates/bootstrap.min.js"></script>
	<script src="/templates/custom.js"></script>
</body>
</html>