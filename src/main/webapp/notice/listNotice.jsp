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
				
				$.ajax( 
						{
						url : "/notice/json/listNotice/"+$("#currentPage").val() ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(noticeList , status) {
							$.each(noticeList, function (index, notice) {
					            // 새로운 행 추가
					            var newRow = '<tr class="appendlist"'+(index+1)+'>' +
					                '<td>' + (index + 1) + '&nbsp;&nbsp;<a href="/notice/getNotice?noticeNo=' + notice.noticeNo + '">상세보기</a></td>' +
					                '<td>' + notice.noticeTitle + '</td>' +
					                '<td>' + notice.noticeDate + '</td>' +
					                '</tr>';

					            // 적절한 위치에 행 추가
					            $('#muhanlist').append(newRow);
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
})

</script>
</head>
<body>
<table id ="muhanlist">	
	<tr>
		<td>넘버</td>
		<td>제목</td>
		<td>날짜</td>
		
	</tr>
	<c:forEach var="noticelist" items="${noticelist }" begin="0" step="1" varStatus="status">
		<tr class = "list">
			<td>${status.count }&nbsp;&nbsp;<a href="/notice/getNotice?noticeNo=${noticelist.noticeNo }">상세보기</a></td>
			<td>${noticelist.noticeTitle }</td>
			<td>${noticelist.noticeDate }</td>
		</tr>
	</c:forEach>
	<input type="hidden" id="currentPage"name ="currentPage" value=1></br>
	<a href="../notice/addNotice">공지사항 등록</a>
</table>
</body>
</html>