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
	window.closeModal = function() {
	 $( '#reportModal' ).modal( 'hide' );
	}
$(function () {
		
		$("a:contains('추가하기')").on("click",function(){
			let data = {
					driverNo : ${star.driverNo},
					callNo : ${star.callNo},
					star :  $("select[name='star']").val()
			}
			$.ajax(
					{
						url : "/feedback/json/addStar",
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
			                	alert('등록되었습니다!')
			                }
			                	
			            }
					})
		})
		$('a:contains("홈")').on("click",function(){
		self.location = "/"
	})
</script>
</head>
<body>
<form name="detailform">
<a>홈</a></br></br>
드라이버번호<input type="text" name ="driverNo" readonly="readonly" value ="${star.driverNo }"></br>
배차번호<input type="text" name ="callNo" readonly="readonly" value="${star.callNo }"></br>

<select 	name="star" >
	<option value="0" >선택안함</option>
	<option value="1" >1 점</option>
	<option value="2" >2 점</option>
	<option value="3" >3 점</option>
	<option value="4" >4 점</option>
	<option value="5" >5 점</option>
</select>
<a>추가하기</a>

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
                <iframe src="/feedback/addReport?badCallNo=${star.callNo }" style="width: 100%; height: 400px; border: none;"></iframe>
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