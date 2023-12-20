<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>신고 등록</title>
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


	$(function () {
		let reportAddToast = new bootstrap.Toast($("#toast-report-add"));
		
		$("a:contains('등록')").on("click",function(){
			
			let data = {
					reportCategory	: $("select[name='reportCategory'] option:selected").val(),
					reportDetail	: $("textarea[name='reportDetail']").val(),
					badCallNo		: $("input:hidden[name='badCallNo']").val(),
					reportUserNo	: $("input:hidden[name='reportUserNo']").val()
			}
			$.ajax(
					{
						url : "/feedback/json/addReport",
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
			                	
			                	
			                		reportAddToast.show();
			    		            
			    		        
			                	
			                }
			                	
			            }
						
					})
					setTimeout(function() {
					window.parent.removeReport();
					window.parent.closeModal();	
					}, 500); 
		})
	})
</script>
</head>
<body class="theme-light">

<div class="mb-3 pb-2"></div>
	<div class="card card-style mb-3">
		<div class="content">

			<h1 class="font-24 font-800 mb-3">신고</h1>
			<div class="mb-3 pb-2"></div>
			<h5
				class="mb-n1 font-12 color-highlight font-700 text-uppercase pt-1">신고카테고리</h5>

			<div class="divider bg-fade-blue"
				style="width: 22%; margin-top: 5px; margin-bottom: 15px"></div>
			<div class="form-custom form-label form-icon mb-3">
				<i class="bi bi-check-circle font-13"></i> <select
					class="form-select rounded-xs" id="c6"
					aria-label="Floating label select example" name="reportCategory">
					<option value="선택">신고카테고리를 선택해주세요</option>
					<option value="폭언 및 욕설">폭언 및 욕설</option>
					<option value="성희롱 및 성추행">성희롱 및 성추행</option>
					<option value="요금 관련">요금 관련</option>
					<option value="호출 및 탑승 중 불편사항">호출 및 탑승 중 불편사항</option>
					<option value="기타">기타</option>
				</select> 
			</div>


			<h5
				class="mb-n1 font-12 color-highlight font-700 text-uppercase pt-1">내용</h5>

			<div class="divider bg-fade-blue"
				style="width: 8%; margin-top: 5px; margin-bottom: 15px"></div>
			<div class="form-custom form-label form-icon mb-3">

				<i class="bi bi-pencil-fill font-12"></i>
				<textarea class="form-control rounded-xs" name="reportDetail"
					placeholder="입력해주세요." id="c7"></textarea>

			</div>
			
			<div class="col-12 mb-4 pb-1" align="right" style="height: 15px; padding-right: 0">
				<a class="btn btn-xxs border-red-dark color-red-dark"
					style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; margin-right: 0px;font-size: 10px; border-radius: 12px">등록</a>
			</div>
			<input type="hidden" name="badCallNo" 
				value="${param.badCallNo }">
				<input type="hidden" name=reportUserNo 
				value="${param.userNo }">

		</div>
	</div>
	
	<div id="toast-report-add"  class="toast toast-pill toast-bottom toast-s rounded-l bg-green-dark shadow-bg shadow-bg-s " data-bs-delay="1000" style="width: 130px"><span class="font-12"><i class="bi bi-check font-20"></i>접수되었습니다!</span></div>
</body>
</html>