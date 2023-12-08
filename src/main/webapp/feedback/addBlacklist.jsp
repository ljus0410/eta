<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	window.closeModal = function() {
	 $( '#reportModal' ).modal( 'hide' );
	}
$(function () {
	
	let data = {
			driverNo : ${blacklist.driverNo},
			passengerNo : ${blacklist.passengerNo},
			callNo : ${blacklist.callNo}
	}
	
	$('input:radio[value=false]').on( "click", function(){
		
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
		
	})
	$('input:radio[value=true]').on( "click", function(){
		
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
	})
	$('a:contains("홈")').on("click",function(){
		self.location = "/"
	})
})
</script>
</head>
<body>
<form action="/home" method = "post">
<a>홈</a></br></br>
<c:forEach var="blacklistList" items="${blacklistList }" begin="0" step="1" varStatus="status">
		
	<div id = "${blacklistList.passengerNo } list">
		승객번호<input type="text" name ="passengerNo" readonly="readonly" value ="${blacklistList.passengerNo }"></br>
		<input type="radio" name="blacklistCode${blacklistList.passengerNo }" value="false"
		${ ! empty blacklistList.blacklistCode && blacklistList.blacklistCode eq "false" ? "checked" : "" }>비활성화
		<input type="radio" name="blacklistCode${blacklistList.passengerNo }" value="true"
		${ ! empty blacklistList.blacklistCode && blacklistList.blacklistCode eq "true" ? "checked" : "" }>활성화</br>
	</div>
</c:forEach>

<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#reportModal">
    신고하기
</button>

<div class="modal" id="reportModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 모달 헤더 -->
            <div class="modal-header">
                <h4 class="modal-title">신고하기</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- 모달 내용 (iframe으로 JSP 페이지 띄우기) -->
            <div class="modal-body">
                <iframe src="/feedback/addReport?badCallNo=" style="width: 100%; height: 400px; border: none;"></iframe>
            </div>

            <!-- 모달 닫기 버튼 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
            </div>

        </div>
    </div>
</div>
</form>
</body>
</html>