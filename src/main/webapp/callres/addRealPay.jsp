<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>결제 금액 입력</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />

<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/css/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">

</head>

<body class="theme-light">

	<h2>결제 금액 입력</h2>

<div id="page">
<div class="page-content header-clear-medium">
	<div class="card card-style">
		<div class="content">
			<h1 class="text-center font-800 font-22 mb-2">Account Verification</h1>
			<p class="text-center font-13 mt-n2 mb-2">Enter your One Time Passcode below</p>
			<div class="text-center mb-3 pt-3 pb-2">
				<form action="/callres/addRealPay" method="get">
				<input type="hidden" name="callNo" value="${callNo}"/> <label
						for="money">금액:</label> <input type="number" name="money" required>
					<input type="submit" value="결제하기">
				</form>
			</div>
			<a href="#" data-menu="menu-verified" class='btn rounded-sm btn-m gradient-green text-uppercase font-700 mt-4 btn-full shadow-bg shadow-bg-s'>Verify</a>
			<p class="pt-2 font-11 text-center pt-4">
				Didn't receive your code? <a href="#">Resend OTP</a>
		</div>
	</div>
</div>
</div>

<script src="/javascript/callres/bootstrap.min.js"></script>
<script src="/javascript/callres/custom.js"></script>

</body>

</html>
