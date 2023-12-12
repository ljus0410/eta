<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
<script type="text/javascript">
	$(function () {
		
		$("a:contains('업데이트')").on("click",function(){
			let data = {
					driverNo : ${star.driverNo},
					callNo : ${star.callNo},
					star :  $("select[name='star']").val()
			}
			$.ajax(
					{
						url : "/feedback/json/updateStar",
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
			                	alert('수정이 완료되었습니다!')
			                }
			                	
			            }
					})
		})
	})
</script>
</head>
<body>
<form name="detailform">
드라이버번호<input type="text" name ="driverNo" readonly="readonly" value ="${star.driverNo }"></br>
배차번호<input type="text" name ="callNo" readonly="readonly" value="${star.callNo }"></br>

<select name="star" >
	<option value="0" 
	${ ! empty star.star && star.star == 0 ? "selected" : "" }>선택안함</option>
	<option value="1" 
	${ ! empty star.star && star.star == 1 ? "selected" : "" }>1 점</option>
	<option value="2" 
	${ ! empty star.star && star.star == 2 ? "selected" : "" }>2 점</option>
	<option value="3" 
	${ ! empty star.star && star.star == 3 ? "selected" : "" }>3 점</option>
	<option value="4"
	${ ! empty star.star && star.star == 4 ? "selected" : "" }>4 점</option>
	<option value="5" 
	${ ! empty star.star && star.star == 5 ? "selected" : "" }>5 점</option>
</select>

<a>업데이트</a></br>
</form>
</body>
</html>
