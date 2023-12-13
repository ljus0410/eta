<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        /* 추가한 스타일 */
        #phone, #authButton {
            display: inline-block; /* 인라인 블록으로 설정하여 같은 줄에 위치하도록 함 */
            vertical-align: middle; /* 수직 정렬을 중앙에 맞춤 */
        }
    </style>
    <script>
        $(document).ready(function () {
            // 버튼에 대한 클릭 이벤트 처리
            $("#authButton").on("click", function () {
            	 event.preventDefault();   
            	  sendAjaxRequest(); // 기본 동작 방지
            });

            // Ajax 요청 함수
            function sendAjaxRequest() {
                // Get the phone number from the input field
                var phone = $('#phone').val();

                // Perform AJAX request using jQuery
                $.ajax({
                    url: '/user/json/send-one', // Specify your server endpoint
                    method: 'GET',
                    data: {
                        phone: phone
                    },
                    success: function (response) {
                        // Handle the success response
                        console.log(response);
                        // You can update the UI here based on the response if needed
                    },
                    error: function (error) {
                        // Handle the error
                        console.error(error);
                    }
                });
            }
        });
    </script>
</head>
<body>
<jsp:include page="../home/top.jsp" />



<div id="page">

<div class="card card-style">
      <div class="content">
        <h1 class="text-center font-800 font-30 mb-2">Sign In</h1>
        <p class="text-center font-13 mt-n2 mb-3">Enter your Credentials</p>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c1" placeholder="이름"/>
          <span>(required)</span>
        </div>
         <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-envelope font-14"></i>
          <input type="text" class="form-control rounded-xs" id="c2" placeholder="이메일"/>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-unlock font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c31" placeholder="비밀번호"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-lock font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c3" placeholder="비밀번호 확인"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-square font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c4" placeholder="닉네임"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-calendar-date" font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c5" placeholder="생년월일(ex 19000821)"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
<div class="form-custom form-label form-icon mb-3 d-flex align-items-center">
    <i class="bi bi-person-fill font-12"></i>
    <input type="text" class="form-control rounded-m" id="c6" placeholder="성별" readonly>
</div>
<div class="form-check form-check-inline d-flex align-items-center">
    <input class="form-check-input" type="checkbox" id="maleCheckbox" value="male">
    <label class="form-check-label" for="maleCheckbox">남성</label>
</div>
<div class="form-check form-check-inline d-flex align-items-center">
    <input class="form-check-input" type="checkbox" id="femaleCheckbox" value="female">
    <label class="form-check-label" for="femaleCheckbox">여성</label>
</div>




        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-telephone font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c7" placeholder="전화번호('-' 제외)"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-asterisk font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c8" placeholder="phone 인증"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-check2-square font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c9" placeholder="차량옵션"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-check2-all font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c10" placeholder="동물옵션"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-123 font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c11" placeholder="차량번호"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-currency-dollar font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c12" placeholder="정산수단"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        
        
        
        <a href="#" class='btn rounded-sm btn-m gradient-green text-uppercase font-700 mt-4 mb-3 btn-full shadow-bg shadow-bg-s'>Sign In</a>
        <div class="d-flex">
          <div>
            <a href="page-forgot-1.html" class="color-theme opacity-30 font-12">Recover Account</a>
          </div>
          <div class="ms-auto">
            <a href="page-register-1.html" class="color-theme opacity-30 font-12">Create Account</a>
          </div>
        </div>
      </div>
    </div>
    
</div>
</body>
</html>
