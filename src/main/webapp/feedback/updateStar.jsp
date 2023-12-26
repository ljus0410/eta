<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>eTa</title>

<script type="text/javascript">
window.closeModal = function() {
	 $( '#menu-report' ).offcanvas( 'hide' );
	}
window.removeReport= function () {
	$( "#reportButtom").remove();
	}

function setStar(star) {
	let starValue = star;
	for (let i = 1; i <= 5; i++) {
        let starSpan = $("#star" + i).siblings("span");

        if (i <= starValue) {
            // 선택한 별 이하의 별에 클래스 추가
            starSpan.removeClass("is-unchecked color-gray-dark bi bi-star");
            starSpan.addClass("is-checked color-yellow-dark bi bi-star-fill");
        } else {
            // 선택하지 않은 별에 클래스 추가
            starSpan.removeClass("is-checked color-yellow-dark bi bi-star-fill");
            starSpan.addClass("is-unchecked color-gray-dark bi bi-star");
        }
	 	}
}
	$(function () {
		setStar(${star.star})
		let starFixToast = new bootstrap.Toast($("#toast-star-fix"));
		
		$($("input:radio[name='star']")[${star.star -1}]).attr("checked", true)
		
		$("a:contains('수정')").on("click",function(){
			let data = {
					driverNo : ${star.driverNo},
					callNo : ${star.callNo},
					star :  $("input:radio[checked='checked']").val()
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
			                	starFixToast.show()
			                }
			                	
			            }
					})
		})
		
		$("input:radio[name='star']").on("click",function(){
			
			$("input:radio[checked='checked']").removeAttr("checked");
			$(this).attr("checked", true)
			let starValue = $(this).val();
			setStar(starValue);
			
		})
		let reportActivate = new bootstrap.Offcanvas($("#menu-report"))
		$("a:contains('신고')").on("click",function(){
			
			reportActivate.show();
		})
	})
</script>
</head>
<body class="theme-light">
	

				<div class="card card-style mb-3">
					<div class="content">

						<input type="hidden" name="driverNo" value="${star.driverNo }">
						<input type="hidden" name="callNo" value="${star.callNo }">
						<i class="has-bg rounded-s bi bg-blue-dark bi-person-fill"
							style="font-size: 20px"></i>&nbsp;
						<h5 class="font-300 mb-0" style="display: inline-block;">${star.driverNo }</h5>

						<div class="mb-3 pb-2"></div>
						<div class="rating" align="center">
							<label class="rating__label rating__label--full" for="star1"
								style="padding: 2px"> <input type="radio" id="star1"
								class="rating__input" name="star" value="1"
								style="display: none"> <span
								class="is-unchecked color-gray-dark bi bi-star"
								style="font-size: 30px"></span>
							</label> <label class="rating__label rating__label--full" for="star2"
								style="padding: 2px"> <input type="radio" id="star2"
								class="rating__input" name="star" value="2"
								style="display: none"> <span
								class="is-unchecked color-gray-dark bi bi-star"
								style="font-size: 30px"></span>
							</label> <label class="rating__label rating__label--full" for="star3"
								style="padding: 2px"> <input type="radio" id="star3"
								class="rating__input" name="star" value="3"
								style="display: none"> <span
								class="is-unchecked color-gray-dark bi bi-star"
								style="font-size: 30px"></span>
							</label> <label class="rating__label rating__label--full" for="star4"
								style="padding: 2px"> <input type="radio" id="star4"
								class="rating__input" name="star" value="4"
								style="display: none"> <span
								class="is-unchecked color-gray-dark bi bi-star"
								style="font-size: 30px"></span>
							</label> <label class="rating__label rating__label--full" for="star5"
								style="padding: 2px"> <input type="radio" id="star5"
								class="rating__input" name="star" value="5"
								style="display: none"> <span
								class="is-unchecked color-gray-dark bi bi-star"
								style="font-size: 30px"></span>
							</label>
						</div>
						<div class="mb-3 pb-2"></div>
						<div class="mb-3 pb-2"></div>
						<div align="right">
							<a class="btn btn-xxs border-blue-dark color-blue-dark"
								style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; margin-right: 10px">수정</a>

							<a class="btn btn-xxs border-red-dark color-red-dark" id = "reportButtom"
								style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; margin-right: 10px">신고</a>
						</div>
					</div>

				</div>
			


			<div
				class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme"
				style="width: 340px;" id="menu-report">
				<div class="content">
					<iframe
						src="/feedback/addReport?badCallNo=${star.callNo }&userNo=${user.userNo}"
						style="width: 100%; height: 400px; border: none;"></iframe>
				</div>
			</div>
		
		<div id="toast-star-fix"
			class="toast toast-pill toast-bottom toast-s rounded-l bg-green-dark shadow-bg shadow-bg-s "
			data-bs-delay="1000" style="width: 130px">
			<span class="font-12"><i class="bi bi-check font-20"></i>수정되었습니다!</span>
		</div>
	
</body>
</html>
