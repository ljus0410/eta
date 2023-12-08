<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	td{
		height: 100px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
<script type="text/javascript">
$(function () {
	$("a:contains('신고처리')").on("click", function () {
		alert($("#reportNo").text().trim())
		let data = {
				reportNo	: $("#reportNo").text().trim()
		}
		$.ajax(
				{
					url : "/feedback/json/updateDisReportCode",
					method : "POST" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					 data		:  JSON.stringify(data),
					complete: function (xhr, status) {
		                // 요청이 완료되면 호출되는 콜백
		                if(xhr.status == 200){
		                	alert('신고처리가 완료되었습니다!');
		                	var newRow = '<a>처리완료</a>' ;
		                	$("a:contains('신고처리')").remove()
		                	$('input:text').after(newRow)
							
		                }
		                	
		            }
					
					
				})
		
	})
	
})
</script>
</head>
<body>

<c:forEach var="reportlist" items="${reportlist }" begin="0" step="1" varStatus="status">
		<c:choose>
			<c:when test="${status.index eq 0 && reportlist.reportCode ==2}">
			<input type="text" readonly="readonly" value="${reportlist.reportCode }">
			<a>신고처리</a>
			</c:when>
			<c:otherwise>
			<c:if test="${status.index eq 0}">
			<a>처리완료</a>
			</c:if>
			</c:otherwise>
		</c:choose>
</c:forEach>

<table id ="muhanlist">	
	<tr>
		<td>신고접수번호</td>
		<td>신고자</td>
		<td>신고일</td>
		<td>신고카테고리</td>
		<td>신고내용</td>
		<td>피신고자</td>
		
	</tr>
	<c:forEach var="reportlist" items="${reportlist }" begin="0" step="1" varStatus="status">
		<tr class = "list">
		<c:choose>
			<c:when test="${status.index eq 0}">
			<td id="reportNo">${reportlist.reportNo }</td>
			<td>${reportlist.reportUserNo }</td>
			<td>${reportlist.regDate }</td>
			<td>${reportlist.reportCategory }</td>
			<td>${reportlist.reportDetail }</td>
			</c:when>
			 <c:otherwise>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
             </c:otherwise>
		</c:choose>
			<td>${reportlist.badUserNo }<a href="/user/getUser?userNo=${reportlist.badUserNo }">상세보기</a></td>
		</tr>
	</c:forEach>
</table>
</body>
</html>