<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Insert title here</title>



<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>



<style>
.record-container {
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
	margin-bottom: 10px;
	cursor: pointer; /* 마우스 커서를 포인터로 설정 */
}

.record-container p {
	margin-right: 20px;
}
</style>

</head>

<body>



	<div>

		<c:forEach var="record" items="${list}" varStatus="status">

			<div class="record-container" data-callno="${record.callNo}">

				<p>날짜/시간: ${record.callDate}</p>

				<p>출발: ${record.startKeyword}</p>

				<p>도착: ${record.endKeyword}</p>

				<p>예약배차번호: ${record.callNo}</p>

			</div>

		</c:forEach>

	</div>



	<script>
		$(function() {

			$(".record-container")
					.on(
							"click",
							function() {

								var role = "${user.role}"; // 현재 사용자의 역할

								var callNo = $(this).data("callno"); // callNo 값

								var url = role === 'passenger' ? '/callres/getRecordPassenger'
										: '/callres/getRecordDriver';

								// URL 생성

								var newUrl = url + "?callNo=" + callNo;

								// 페이지 리디렉션

								window.location.href = newUrl;

							});

		});
	</script>



</body>

</html>