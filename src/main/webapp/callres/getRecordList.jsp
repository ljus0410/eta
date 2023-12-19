<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
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

<script type="text/javascript">

$(function () {
	function countCurrentPage() {
		let count =  $("#currentPage").val();
	    let newcount = parseInt(count) + 1;
	    $("#currentPage").val(newcount);
	}
	let isAjaxInProgress = false;
	let lastScroll = 0;

	$(document).scroll(function(e){
	    //현재 높이 저장
	    var currentScroll = $(this).scrollTop();
	    //전체 문서의 높이
	    var documentHeight = $(document).height();

	    //(현재 화면상단 + 현재 화면 높이)
	    var nowHeight = $(this).scrollTop() + $(window).height();


	    //스크롤이 아래로 내려갔을때만 해당 이벤트 진행.
	    if(currentScroll > lastScroll){

	        //nowHeight을 통해 현재 화면의 끝이 어디까지 내려왔는지 파악가능 
	        //즉 전체 문서의 높이에 일정량 근접했을때 글 더 불러오기)
	        if(documentHeight < (nowHeight + (documentHeight*0.05))){
	            console.log("이제 여기서 데이터를 더 불러와 주면 된다.");
	            if (!isAjaxInProgress) {
                    isAjaxInProgress = true;
	            countCurrentPage();
	            if($("#currentPage").val() <= ${resultPage.maxPage}){
	            	let data = {
	        				
	        				currentPage : $("#currentPage").val(),
	        				searchKeyword : $("input:text[name='searchKeyword']").val()
	        		}
				
				$.ajax( 
						{
						url : "/callres/json/listRecord/"+$("#currentPage").val() ,
						method : "POST" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data		:  JSON.stringify(data),
						success : function(calllist , status) {
							$.each(calllist, function (index, record) {
					            // 새로운 행 추가
					           var newDiv = '<div class="w-100" data-callno="' + record.callNo + '">' +
                        						'<div class="card card-style mb-0">' +
                            						'<div class="content">' +
                                						'<div style="display: flex; align-items: center; margin-bottom: 10px;">' +
                                    						'<img src="/images/taxi.png" style="height: 1.5em; margin-right: 10px;">' +
                                    						'<h4 class="font-20 font-800" style="margin-bottom: 0;">택시</h4>' +
                                						'</div>' +
                                						'<div style="margin-left: 2.5em;">' +
                                    						'<p>날짜/시간: ' + record.callDate + '</p>' +
                                    						'<p>호출: ' + record.callCode + '</p>' +
                                    						'<p>출발: ' + record.startKeyword + '</p>' +
                                    						'<p>도착: ' + record.endKeyword + '</p>' +
                                    						'<p>금액: ' + record.realPay + '</p>' +
                                						'</div>' +
                            							'</div>' +
                        							'</div>' +
                    							'</div>';


					            // 적절한 위치에 행 추가word
					            $('.page-content').append(newDiv); // 'page-content' 클래스 내에 추가
					            isAjaxInProgress = false;
					        });
								   
							}  
						
					});
				
	        	}else{
	        		isAjaxInProgress = true;
	        		}
	        	}
	        }
	    }

	    //현재위치 최신화
	    lastScroll = currentScroll;

	});
	
	$("a:contains('검색')").on("click", function () {
		
		$("form").attr("method","POST").attr("action","/callres/getCallResList").submit();
	}) 
	$(document).on("click","tr", function () {
		
		self.location="/callres/getRecord?calleNo="+$(this).children().eq(0).text()
	})
	

})

</script>


<style>
.record-container {
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
	margin-bottom: 10px;
	cursor: pointer; /* 마우 스 커서를 포인터로 설정 */
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


					<c:if test="${user.role == 'driver'}">
						<h1 class="pb-2">
							<i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;운행기록
						</h1>

					</c:if>

					<c:if test="${user.role == 'passenger'}">
						<h1 class="pb-2">
							<i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;이용기록
						</h1>

					</c:if>

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
										<p>날짜/시간: ${record.callDate}</p>
										<p>호출: ${record.callCode}</p>
										<p>출발: ${record.startKeyword}</p>
										<p>도착: ${record.endKeyword}</p>
										<p>금액: ${record.realPay}</p>
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

			$(".w-100")
					.on(
							"click",
							function() {

								var role = "${user.role}"; // 현재 사용자의 역할

								var callNo = $(this).data("callno"); // callNo 값

								var url = role === 'passenger' ? '/callres/getRecordPassenger'
										: '/callres/getRecordDriver';
								
								var newUrl = url + "?callNo=" + callNo;

								// 페이지 리디렉션

								window.location.href = newUrl;

							});
		});
	</script>

	<script src="/templates/scripts/bootstrap.min.js"></script>
	<script src="/templates/scripts/custom.js"></script>

</body>

</html>

