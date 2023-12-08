<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
})
</script>
</head>
<body>
<form action="/home" method = "post">

승객번호<input type="text" name ="passengerNo" readonly="readonly" value ="${blacklist.passengerNo }"></br>

<input type="radio" name="blacklistCode" value="false"
${ ! empty blacklist.blacklistCode && blacklist.blacklistCode eq "false" ? "checked" : "" }>비활성화
<input type="radio" name="blacklistCode" value="true"
${ ! empty blacklist.blacklistCode && blacklist.blacklistCode eq "true" ? "checked" : "" }>활성화


</form>
</body>
</html>