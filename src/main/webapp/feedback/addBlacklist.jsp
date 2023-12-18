<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>Insert title here</title>
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
<link rel="manifest" href="/templates/_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180"
	href="/templates/app/icons/icon-192x192.png">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/templates/scripts/bootstrap.min.js"></script>
<script src="/templates/scripts/custom.js"></script>
<script type="text/javascript">
	
window.closeModal = function() {
	 $( '#menu-register' ).offcanvas( 'hide' );
	}
window.removeReport= function () {
	$( "button:contains('신고')").remove();
	}


$(function () {
	
	$('input:checkbox').on( "click", function(){
		let data = {
				driverNo :  $("input:hidden[name=driverNo]").val(),
				passengerNo : $(this).closest("div").find("input:hidden[name=passengerNo]").val(),
				callNo : $("input:hidden[name=callNo]").val()
		}
		if($(this).attr("checked") == 'checked'){
			
			$(this).removeAttr("checked")
			$.ajax(
				{
					url : "/feedback/json/deleteBlacklist",
					method : "POST" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					 data		:  JSON.stringify(data),
					success: function (result) {
		                // 요청이 완료되면 호출되는 콜백
	                	if(result === 1){
	                		alert('블랙리스트 취소하였습니다.');	
	                	}
		               	
		            }
				})
		}else{
			$(this).attr("checked",true)
			
			$.ajax(
				{
					url : "/feedback/json/addBlacklist",
					method : "POST" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					 data		:  JSON.stringify(data),
					
					success: function (result) {
		                // 요청이 완료되면 호출되는 콜백
	                	if(result === 1){
	                		alert('블랙리스트 등록하였습니다.');		
	                	}  	
		            }
				})
		}
		
		
	})
	
	
})
</script>
</head>
<body class="theme-light">
	<form action="/home" method="post">
		<div id="page">
			<jsp:include page="/home/top.jsp" />
			<div class="page-content header-clear-medium">
				<div class="card card-style" style="margin-bottom: 15px;">
					<div class="content" style="margin-bottom: 9px;">
						<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

						<h1 class="pb-2" style="width: 200px; display: inline-block;">
							<i class="has-bg rounded-s bi bg-yellow-dark bi-star">&nbsp;</i>&nbsp;&nbsp;블랙리스트관리
							/
						</h1>

						<c:forEach var="blacklistList" items="${blacklistList }" begin="0"
							step="1" varStatus="status">
							<c:if test="${status.index eq 0 }">
							<input type="hidden" name="driverNo" value="${blacklistList.driverNo }">
							<input type="hidden" name="callNo" value="${blacklistList.callNo }">
								<h3 class="font-400 mb-0" style="display: inline-block;">배차번호
									: ${blacklistList.callNo }</h3>
							</c:if>
						</c:forEach>

					</div>
				</div>
				<div class="card card-style mb-3">
					<div class="content">
						<div class="mb-3 pb-2"></div>
						
						<h3 class="font-400 mb-0" align="center">운행중 불편하셨던 손님은<p></p>블랙리스트로 관리할 수 있습니다 :)</h3>
						<div class="mb-3 pb-2"></div>
						<div class="mb-3 pb-2"></div>
						<c:forEach var="blacklistList" items="${blacklistList }" begin="0"
							step="1" varStatus="status">

							<div id="${blacklistList.passengerNo } list" style="padding-bottom: 10px;vertical-align: center; ">
								<i class="has-bg rounded-s bi bg-blue-dark bi-person-fill"
									style="font-size: 20px"></i>&nbsp;
								<h5 class="font-300 mb-0" style="display: inline-block;">${blacklistList.passengerNo }</h5>
								
									
					
										<div class="ms-auto align-self-center" style="display: inline-block; ">
											<div class="form-switch ios-switch switch-blue switch-s">
												<input type="hidden" name="blacklistCode" value =${blacklistList.blacklistCode }>
												<input type="hidden" name="passengerNo" value="${blacklistList.passengerNo }">
												<input type="checkbox" class="ios-input" id="switch-4a${blacklistList.passengerNo }" ${ ! empty blacklistList.blacklistCode && blacklistList.blacklistCode eq "true" ? "checked='checked'" : "" }>
												<label class="custom-control-label" for="switch-4a${blacklistList.passengerNo }"></label>
											</div>
										</div>
								
							</div>
						</c:forEach>
						<div class="mb-3 pb-2"></div>
						<div class="mb-3 pb-2"></div>
						<div align="right">
							

							<button type="button"
								class="btn btn-xxs border-red-dark color-red-dark"
								data-bs-toggle="offcanvas" data-bs-target="#menu-register"
								style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; margin-right: 0px">신고</button>
						</div>
					</div>

				</div>
			</div>
			<div
				class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme"
				style="width: 340px;" id="menu-register">
				<div class="content">
					<c:forEach var="blacklistList" items="${blacklistList }" begin="0"
						step="1" varStatus="status">
						<c:if test="${status.index eq 0 }">
							<iframe
								src="/feedback/addReport?badCallNo=${blacklistList.callNo }&${param.userNo}"
								style="width: 100%; height: 400px; border: none;"></iframe>
						</c:if>
					</c:forEach>
					
				</div>
			</div>
		</div>
	</form>
</body>
</html>