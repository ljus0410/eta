<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>결제 금액 입력</title>

</head>

<body>

	<h2>결제 금액 입력</h2>

	<form action="/callres/addRealPay" method="get">

		<input type="hidden" name="callNo" value="${callNo}"> <label
			for="money">금액:</label> <input type="number" name="money" required>

		<input type="submit" value="결제하기">

	</form>



</body>

</html>
