<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>별점 수정</title>
<link rel="stylesheet" type="text/css"
	href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css"
	href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet">
<link rel="manifest" href="/templates/_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180"
	href="/templates/app/icons/icon-192x192.png">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/templates/scripts/bootstrap.min.js"></script>
<script src="/templates/scripts/custom.js"></script>

<script type="text/javascript">
window.closeModal = function() {
	 $( '#menu-report' ).offcanvas( 'hide' );
	}
	window.removeReport= function () {
	$( "button:contains('신고')").remove();
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
			                	alert('수정이 완료되었습니다!')
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
	})
</script>
</head>
<body class="theme-light">
<form name="detailform">


<div id="page">
			<div class="page-content header-clear-medium">
				
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

							<button type="button"
								class="btn btn-xxs border-red-dark color-red-dark"
								data-bs-toggle="offcanvas" data-bs-target="#menu-report"
								style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; margin-right: 0px">신고</button>
						</div>
					</div>

				</div>
			</div>


			<div
				class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme"
				style="width: 340px;" id="menu-report">
				<div class="content">
					<iframe
						src="/feedback/addReport?badCallNo=${star.callNo }&${param.userNo}"
						style="width: 100%; height: 400px; border: none;"></iframe>
				</div>
			</div>
		</div>
</form>
</body>
</html>
