<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

${call.callDate}
${call.startKeyword }
${call.endKeyword }
${call.callNo }

<c:if test="${user.role == 'driver'}">
driver 정보
${user.phone }
${user.carNum }
</c:if>

<c:if test="${user.role == 'passenger'}">
passenger 정보
${user.userNo }
${user.phone }

</c:if>

<button onclick="startDriving()">운행 시작</button>
<script>
function startDriving() {
    var callNo = ${call.callNo}
    window.location.href = '/callres/startReservationDriving?callNo=' + callNo;
}
</script>

</body>
</html>