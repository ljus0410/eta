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

<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
<script type="text/javascript">
$(function () {
	let reportCodeToast = new bootstrap.Toast($("#toast-reportCode-udpate"));
	$("a:contains('신고처리')").on("click", function () {
		
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
		                	reportCodeToast.show();
		                	var newRow = '<a class="btn btn-xxs border-red-dark color-red-dark" style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px;margin-right: 20px;" >처리완료</a>' ;
		                	$("a:contains('신고처리')").after(newRow)
		                	$("a:contains('신고처리')").remove()
		                	
							
		                }
		                	
		            }
					
					
				})
		
	})
	
	$(".userList td:last-child").on("click", function () {
		if($("#role").val() == "admin"){
		
		self.location ="/user/getadmin?userNo="+$(this).text()+"&reportNo="+$('#reportNo').text().trim();
		
		}
	})
	
	
})
</script>
</head>
<body>
<form name="detailform">
	<div id="page" >
		<jsp:include page="/home/top.jsp" />

<div class="page-content header-clear-medium">
			<input type="hidden" id="role" value="${user.role }">
			<div class="card card-style" style="margin-bottom: 15px;">
					<div class="content"style="margin-bottom: 9px; ">
					<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

					<h1 class="pb-2" style="width: 140px; display: inline-block;">
						<i class="has-bg rounded-s bi bg-red-dark bi-exclamation-circle" style="vertical-align:bottom !important; background-color: #d84558 !important; line-height: 0px!important;height: 30px !important;font-size: 30px !important; all:initial; display: inline-block;"></i>&nbsp;&nbsp;신고내역
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
			<c:forEach var="reportlist" items="${reportlist }" begin="0"
								step="1" varStatus="status">


								<c:if test="${status.index eq 0}">
									<p
										style="margin-bottom: 0px; margin-top: 15px; margin-right: 20px;"
										align="right">신고일 : ${reportlist.regDate }
								</c:if>
							</c:forEach>
					<div class="content">
					
						<div class="form-custom form-label form-icon mb-3">
							
							<table id="muhanlist">
								<tr>
									
									<td><h5>신고자</h5></td>
									<td></td>
									<td ><h5>피신고자</h5></td>

								</tr>
								<c:forEach var="reportlist" items="${reportlist }" begin="0"
									step="1" varStatus="status">
									<tr class="userList">
										<c:choose>
											<c:when test="${status.index eq 0}">

												<td >${reportlist.reportUserNo }</td>


											</c:when>
											<c:otherwise>
												<td ></td>


											</c:otherwise>
										</c:choose>
										<td style="width: 20px"></td>
										<td>${reportlist.badUserNo }</td>
									</tr>
								</c:forEach>
							</table>

							<c:forEach var="reportlist" items="${reportlist }" begin="0"
								step="1" varStatus="status">
								<tr class="list">

									<c:if test="${status.index eq 0}">


										<div class="form-custom form-label form-icon mb-3">
											<h5 class="font-700 mb-nl color-highlight"
												style="padding-bottom: 3px">카테고리</h5>

											<div class="divider bg-fade-blue"
												style="width: 18%; margin-bottom: 15px"></div>
											<p>${reportlist.reportCategory }
										</div>
										<div class="mb-3 pb-2"></div>
										<div class="form-custom form-label form-icon mb-3">
											<h5 class="font-700 mb-nl color-highlight"
												style="padding-bottom: 3px">내용</h5>
											<div class="divider bg-fade-blue"
												style="width: 9%; margin-bottom: 15px"></div>
											<p>${reportlist.reportDetail }
										</div>
									</c:if>
								</tr>
							</c:forEach>
						</div>

					</div>
					<c:if test="${user.role eq 'admin' }">
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
									style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px;margin-right: 20px;" >처리완료</a>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
				</div>
				</c:if>
			</div>

		</div>
	</div>
	<div id="toast-reportCode-udpate"  class="toast toast-pill toast-bottom toast-s rounded-l bg-blue-dark shadow-bg shadow-bg-s " data-bs-delay="1000" style="width: 130px"><span class="font-12"><i class="bi bi-check font-20"></i>처리되었습니다!</span></div>
</body>
</html>