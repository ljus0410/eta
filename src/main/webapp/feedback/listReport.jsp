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
					            var newRow = '<tr class="appendlist"'+(index+1)+'>' +
					                '<td>' + (index + 1) + '&nbsp;&nbsp;<a href="/feedback/getReport?reportNo=' + report.reportNo + '&badCallNo='+report.badCallNo+'&reportRole='+report.reportRole+'">상세보기</a></td>' +
					                '<td>' + report.reportCode + '</td>' +
					                '<td>' + report.reportNo + '</td>' +
					                '<td>' + report.reportUserNo + '</td>' +
					                '<td>' + report.badCallNo + '</td>' +
					                '<td>' + report.reportCategory + '</td>' +
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
	
})

</script>
</head>
<body>
	<form name="detailform">
		<input type="radio" name="code" value = "0"
		${ ! empty search.code && search.code == 0 ? "checked" : "" }>모두
		<input type="radio" name="code" value = "1"
		${ ! empty search.code && search.code == 1 ? "checked" : "" }>미처리
		<input type="radio" name="code" value = "2"
		${ ! empty search.code && search.code == 2 ? "checked" : "" }>처리중
		<input type="radio" name="code" value = "3"
		${ ! empty search.code && search.code == 3 ? "checked" : "" }>처리완료
		
		<select 	name="searchCondition" >
			<option value="선택" 
			${ ! empty search.searchCondition && search.searchCondition == '선택' ? "selected" : "" }>
			신고카테고리를 선택해주세요</option>
			<option value="폭언 및 욕설" 
			${ ! empty search.searchCondition && search.searchCondition == '폭언 및 욕설' ? "selected" : "" }>
			폭언 및 욕설</option>
			<option value="성희롱 및 성추행" 
			${ ! empty search.searchCondition && search.searchCondition == '성희롱 및 성추행' ? "selected" : "" }>
			성희롱 및 성추행</option>
			<option value="요금 관련"
			${ ! empty search.searchCondition && search.searchCondition == '요금 관련' ? "selected" : "" } >
			요금 관련</option>
			<option value="호출 및 탑승 중 불편사항" 
			${ ! empty search.searchCondition && search.searchCondition == '호출 및 탑승 중 불편사항' ? "selected" : "" }>
			호출 및 탑승 중 불편사항</option>
			<option value="기타" 
			${ ! empty search.searchCondition && search.searchCondition == '기타' ? "selected" : "" }>
			기타</option>
		</select>
		<input 	type="text" name="searchKeyword"  value="${!empty search.searchKeyword ? search.searchKeyword : ""}">
		<a>검색</a>
		<table id ="muhanlist">	
			<tr>
				<td>넘버</td>
				<td>처리상태</td>
				<td>신고접수번호</td>
				<td>신고자</td>
				<td>피신고배차번호</td>
				<td>신고카테고리</td>
				
			</tr>
			<c:forEach var="reportlist" items="${reportlist }" begin="0" step="1" varStatus="status">
				<tr class = "list${reportlist.reportNo }">
					<td>${status.count }&nbsp;&nbsp;<a href="/feedback/getReport?reportNo=${reportlist.reportNo }&badCallNo=${reportlist.badCallNo}&reportRole=${reportlist.reportRole}">상세보기</a></td>
					<td>${reportlist.reportCode }</td>
					<td>${reportlist.reportNo }</td>
					<td>${reportlist.reportUserNo }</td>
					<td>${reportlist.badCallNo }</td>
					<td>${reportlist.reportCategory }</td>
				</tr>
			</c:forEach>
			<input type="hidden" id="currentPage"name ="currentPage" value=1></br>
		</table>
	</form>
</body>
</html>