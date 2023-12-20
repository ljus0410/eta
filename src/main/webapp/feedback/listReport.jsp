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
	        				code :  $("input[name='code']:checked").val(),
	        				currentPage : $("#currentPage").val(),
	        				searchCondition : $("select[name='searchCondition'] option:selected").val(),
	        				searchKeyword : $("input:text[name='searchKeyword']").val()
	        		}
				$.ajax( 
						{
						url : "/feedback/json/listReport",
						method : "POST" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data		:  JSON.stringify(data),
						success : function(reportList, status) {
							$.each(reportList, function (index, report) {
					            // 새로운 행 추가
					            var newRow = '<tr class="list '+(report.reportNo)+'">' +
					                '<td>' + report.reportNo + '</td>' +
					                '<td>' + (report.reportCode == 1 ? '<h5 class="mb-0"><span class="badge bg-highlight color-white" style="background-color: #BB4758 !important">처리전</span></h5>' : report.reportCode == 2 ? '<h5 class="mb-0"><span class="badge bg-highlight color-white" style="background-color: #A7CA65 !important">처리</span></h5>' : report.reportCode == 3 ? '<h5 class="mb-0"><span class="badge bg-highlight color-white">처리완료</span></h5>' : '') + '</td>' +
					                '<td>' + report.reportUserNo + '</td>' +
					                '<td>' + report.badCallNo + '</td>' +
					                '<td>' + report.reportCategory + '</td>' +
					               ' <td style="display: none">' +report.reportRole + '</td>' +
					                '</tr>';
					            // 적절한 위치에 행 추가
					            $('#muhanlist').append(newRow);
					            isAjaxInProgress = false;	
					        });
								   
							},
							error: function (xhr, status, error) {
						        console.error("Error:", xhr);
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
			
		$("form").attr("method","POST").attr("action","/feedback/listReport").submit();
	})
	$(document).on("click","tr", function () {
		if($(this).hasClass("list") === true) {
			self.location="/feedback/getReport?reportNo="+$(this).children().eq(0).text()+"&badCallNo="+$(this).children().eq(3).text()+"&reportRole="+$(this).children().eq(5).text()
			}
	})
	
})

</script>
</head>
<body class="theme-light">
	<form name="detailform">
	<div id="page" >
		<jsp:include page="/home/top.jsp" />
		
		
	<div class="page-content header-clear-medium" >
				<div class="card card-style" style="margin-bottom: 15px;">
					<div class="content"style="margin-bottom: 9px; ">
						<!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

						<h1 class="pb-2" style="width: 140px; display: inline-block;">
							<i class="has-bg rounded-s bi bg-red-dark bi-exclamation-circle" style="vertical-align:bottom !important; background-color: #d84558 !important; line-height: 0px!important;height: 30px !important;font-size: 30px !important; all:initial; display: inline-block;"></i>&nbsp;&nbsp;신고내역
						</h1>

					</div>
				</div>

				<div class="card overflow-visible card-style">
					<div class="content mb-0">
						<div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
							<div align="left">
							<input type="radio" name="code" value="0"
								${ ! empty search.code && search.code == 0 ? "checked" : "" }>모두
							<input type="radio" name="code" value="1"
								${ ! empty search.code && search.code == 1 ? "checked" : "" }>처리전
							<input type="radio" name="code" value="2"
								${ ! empty search.code && search.code == 2 ? "checked" : "" }>처리
							<input type="radio" name="code" value="3"
								${ ! empty search.code && search.code == 3 ? "checked" : "" }>처리완료
							</div>
							<select name="searchCondition" class="form-select rounded-xs" style=" width: 63%;margin-bottom: 5px">
								<option value="선택"
									${ ! empty search.searchCondition && search.searchCondition == '선택' ? "selected" : "" }>
									신고카테고리</option>
								<option value="폭언 및 욕설"
									${ ! empty search.searchCondition && search.searchCondition == '폭언 및 욕설' ? "selected" : "" }>
									폭언 및 욕설</option>
								<option value="성희롱 및 성추행"
									${ ! empty search.searchCondition && search.searchCondition == '성희롱 및 성추행' ? "selected" : "" }>
									성희롱 및 성추행</option>
								<option value="요금 관련"
									${ ! empty search.searchCondition && search.searchCondition == '요금 관련' ? "selected" : "" }>
									요금 관련</option>
								<option value="호출 및 탑승 중 불편사항"
									${ ! empty search.searchCondition && search.searchCondition == '호출 및 탑승 중 불편사항' ? "selected" : "" }>
									호출 및 탑승 중 불편사항</option>
								<option value="기타"
									${ ! empty search.searchCondition && search.searchCondition == '기타' ? "selected" : "" }>
									기타</option>
							</select>
								<input type="text" class="form-control rounded-xs"
								style="width: 40%; display: ${user.role eq 'admin' ? 'inline-block' : 'none' }"  name="searchKeyword"
								value="${!empty search.searchKeyword ? search.searchKeyword : ''}" >
								
								<a class="btn btn-xxs border-blue-dark color-blue-dark"
								style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; margin-left: 5px;">검색</a>
						</div>
						<div class="mb-3 pb-2"></div>
						<div class="mb-3 pb-2"></div>
						<div class="mb-3 pb-2"></div>
						
						<div class="table-responsive">
							<table class="table color-theme mb-2" id="muhanlist">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">상태</th>
										<th scope="col">신고자</th>
										<th scope="col">배차번호</th>
										<th scope="col">카테고리</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="reportlist" items="${reportlist }" begin="0"
										step="1" varStatus="status">
										<tr class="list ${reportlist.reportNo }">
											<td>${reportlist.reportNo }</td>
											
											<td>${reportlist.reportCode == 1 ? '<h5 class="mb-0"><span class="badge bg-highlight color-white" style="background-color: #BB4758 !important">처리전</span></h5>' : reportlist.reportCode == 2 ? '<h5 class="mb-0"><span class="badge bg-highlight color-white" style="background-color: #A7CA65 !important">처리</span></h5>' : reportlist.reportCode == 3 ? '<h5 class="mb-0"><span class="badge bg-highlight color-white">처리완료</span></h5>' : ''}</td>
											
											<td>${reportlist.reportUserNo }</td>
											<td>${reportlist.badCallNo }</td>
											<td>${reportlist.reportCategory }</td>
											<td style="display: none;">${reportlist.reportRole}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<input type="hidden" id="currentPage" name="currentPage" value=1>



			</div>
		</div>
	</form>
</body>
</html>