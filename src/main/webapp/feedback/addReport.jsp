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
		
		$("a:contains('신고등록')").on("click",function(){
			let data = {
					reportCategory	: $("select[name='reportCategory'] option:selected").val(),
					reportDetail	: $("input[name='reportDetail']").val(),
					badCallNo		: $("input[name='badCallNo']").val()
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
			                	alert('신고가 접수되었습니다!');
			                	
			                }
			                	
			            }
						
					})
					window.parent.closeModal();	
		})
	})
</script>
</head>
<body>
<form name="detailform">
신고카테고리
<select 	name="reportCategory" >
	<option value="선택" >신고카테고리를 선택해주세요</option>
	<option value="폭언 및 욕설" >폭언 및 욕설</option>
	<option value="성희롱 및 성추행" >성희롱 및 성추행</option>
	<option value="요금 관련" >요금 관련</option>
	<option value="호출 및 탑승 중 불편사항" >호출 및 탑승 중 불편사항</option>
	<option value="기타" >기타</option>
</select></br>
신고내용<input type="text" name ="reportDetail"></br>
배차번호<input type="text" name ="badCallNo" readonly="readonly" value="${param.badCallNo }"></br>

<a>신고등록</a></br>
</form>
</body>
</html>