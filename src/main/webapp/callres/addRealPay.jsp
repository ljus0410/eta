<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>eta</title>
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
						않습니다</p><input type="hidden" name="realPay" value="${call.realPay}" />
					<div class="text-center mb-3 pt-3 pb-2">
						<form>
						    <input type="hidden" name="callNo" value="${callNo}" />
						    <!-- 'name' 속성을 'money'로 설정해 사용자 입력값을 'money' 파라미터로 전송 -->
						    <input type="text" class="form-control rounded-xs" name="money" required placeholder="실결제금액 입력"/>
						   <div style="text-align: center;">
					            <button type="button" onclick="validateForm()" class='btn rounded-sm btn-m gradient-green text-uppercase font-700 mt-4 btn-full shadow-bg shadow-bg-s'>결제하기</button>
					        </div>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	function validateForm() {
	    var moneyValue = document.getElementsByName("money")[0].value;
	    var realPay = document.getElementsByName("realPay")[0].value;

	    if (parseFloat(moneyValue) > parseFloat(realPay) + 10000) {
	     //   alert(parseFloat(realPay) + 10000);
	     //   alert(moneyValue);
	        messageAlert("실결제금액을 정확히 입력해주세요.");
	    } else {
	     //   alert(moneyValue);

	        // 폼 속성 설정
	        var form = document.forms[0];
	        form.method = "GET";
	        form.action = "/callres/addRealPay";

	        // 폼 제출
	        form.submit();
	    }
	}
	function messageAlert(message) {
	    var toastContainer = document.createElement('div');
	      toastContainer.innerHTML = '<div id="notification-bar-5" class="notification-bar glass-effect detached rounded-s shadow-l fade show" data-bs-delay="15000">' +
	          '<div class="toast-body px-3 py-3">' +
	          '<div class="d-flex">' +
	          '<div class="align-self-center">' +
	          '<span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>' +
	          '</div>' +
	          '<div class="align-self-center">' +
	          '<h5 class="font-16 ps-2 ms-1 mb-0">'+message+'</h5>' +
	          '</div>' +
	          '</div><br>' +
	          '<a href="#" data-bs-dismiss="toast" id="confirmBtn" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">확인</a>' +
	          '</div>' +
	          '</div>';

	      document.body.appendChild(toastContainer.firstChild); // body에 토스트 알림창 추가
	      
	      document.getElementById('confirmBtn').addEventListener('click', function () {
	          // Remove the toast element from the DOM
	          document.getElementById('notification-bar-5').remove();
	      });
	      $('.toast').toast('show'); // Bootstrap 토스트 표시 함수 호출
	 }

</script>
	<script src="/templates/bootstrap.min.js"></script>
	<script src="/templates/custom.js"></script>
</body>
</html>