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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="/templates/_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="/templates/app/icons/icon-192x192.png">
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
<form name="detailform">
	<div id="page" >
		<jsp:include page="/home/top.jsp" />
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


<div class="page-content header-clear-medium">
			<div class="card card-style" style="margin-bottom: 15px;">
					<div class="content"style="margin-bottom: 9px; ">
					<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

					<h1 class="pb-2" style="width: 140px; display: inline-block;">
						<i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;신고내역
						/
					</h1>
					<c:forEach var="reportlist" items="${reportlist }" begin="0" step="1" varStatus="status">
						<c:if test="${status.index eq 0}">
					<h3 class="font-400 mb-0"style="display: inline-block;" id="reportNo">${reportlist.reportNo }</h3>
					</c:if>
					</c:forEach>
				</div>
			</div>
			<div class="card card-style mb-3">
			<div class="mb-3 pb-2"></div>
					

					<div class="content">
						<div class="form-custom form-label form-icon mb-3">
							<table id="muhanlist">
								<tr>
									
									<td>신고자</td>
									<td>신고일</td>
									<td>신고카테고리</td>
									<td>신고내용</td>
									<td>피신고자</td>

								</tr>
								<c:forEach var="reportlist" items="${reportlist }" begin="0"
									step="1" varStatus="status">
									<tr class="list">
										<c:choose>
											<c:when test="${status.index eq 0}">

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
												
											</c:otherwise>
										</c:choose>
										<td>${reportlist.badUserNo }<a
											href="/user/getUser?userNo=${reportlist.badUserNo }">상세보기</a></td>
									</tr>
								</c:forEach>
							</table>
							
						</div>
						
					</div>
					<div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
					<c:forEach var="reportlist" items="${reportlist }" begin="0"
						step="1" varStatus="status">
						<c:choose>
							<c:when test="${status.index eq 0 && reportlist.reportCode ==2}">
								
								<a class="btn btn-xxs border-blue-dark color-blue-dark"
									style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px;margin-right: 20px ">신고처리</a>
							</c:when>
							<c:otherwise>
								<c:if test="${status.index eq 0}">
									<a class="btn btn-xxs border-red-dark color-red-dark"
									style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px;margin-right: 20px">처리완료</a>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
				</div>
			</div>

		</div>
	</div>
</body>
</html>