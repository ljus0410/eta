<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet">
<link rel="manifest" href="_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180"
	href="app/icons/icon-192x192.png">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
.record-container {
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
	margin-bottom: 10px;
	cursor: pointer;
}

.record-container p {
	margin-right: 20px;
}

.content p {
	margin-top: 3px; /* 상단 간격을 줄임 */
	margin-bottom: 3px; /* 하단 간격을 줄임 */
}

.w-100 {
	margin-bottom: 15px; /* 각 결과 항목 사이의 거리를 조정 */
}
</style>
</head>
<body class="theme-light">
	<div id="page">
		<jsp:include page="/home/top.jsp" />
		<div class="page-content header-clear-medium">
			<div class="card card-style">
				<div class="content">
					<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->
					<h6 class="font-700 mb-n1 color-highlight">Reservation List</h6>
					<h1 class="pb-2">
						<i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;예약
					</h1>

				</div>
			</div>
			<c:choose>
				<c:when test="${not empty list}">
					<c:forEach var="record" items="${list}" varStatus="status">
						<div class="w-100" data-callno="${record.callNo}">
							<div class="card card-style mb-0">
								<div class="content">
									<div
										style="display: flex; align-items: center; margin-bottom: 10px;">
										<img src="/images/taxi.png"
											style="height: 1.5em; margin-right: 10px;">
										<h4 class="font-20 font-800" style="margin-bottom: 0;">택시</h4>
									</div>
									<div style="margin-left: 2.5em;">
										<h4 class="font-18 font-600">예약 시간 : ${record.callDate}</h4>
										<p>출발: ${record.startKeyword}</p>
										<p>도착: ${record.endKeyword}</p>
										<p>금액: ${record.realPay}</p>
										<p>배차 번호 : ${record.callNo}</p>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="text-center" style="color: grey; margin-top: 50px;">기록이
						존재하지 않습니다</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<script>
        $(function() {
            $(".w-100").on("click", function() {
                var role = "${user.role}";
                var callNo = $(this).data("callno");
                var url = role === 'passenger' ? '/callres/getRecordPassenger' : '/callres/getRecordDriver';
                var newUrl = url + "?callNo=" + callNo;
                window.location.href = newUrl;
            });
        });
    </script>
	<script src="/templates/scripts/bootstrap.min.js"></script>
	<script src="/templates/scripts/custom.js"></script>
</body>
</html>
