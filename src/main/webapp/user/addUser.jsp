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
.custom-border {
    width: 40vw; 
    height: 53px;
    padding: 0px 15px 0px 40px;
    border: 1px solid #f0f0f0 !important; 
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    text-transform: uppercase;

}
.custom-border1 {
    width: 40vw; 
    height: 80px;
    padding: 0px 15px 0px 40px;
    border: 1px solid #f0f0f0 !important; 
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    text-transform: uppercase;

}

.custom-border2 {
    width: 40vw; 
    height: 80px;
    padding: 0px 15px 0px 40px;
    border: 1px solid #f0f0f0 !important; 
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    text-transform: uppercase;

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
        
        function toggleGenderLabel() {
            var label = document.getElementById("genderLabel");
            var checkbox = document.getElementById("c3a");

            if (checkbox.checked) {
                label.innerText = "남";
            } else {
                label.innerText = "여";
            }
        }   
    </script>
</head>
<body class="theme-light">
<jsp:include page="../home/top.jsp" />



<div id="page">


<div class="page-content header-clear-medium">

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
          <i class="bi bi-calendar-date font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c5" placeholder="생년월일(ex 19000821)"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
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
        
        <div class="custom-border form-control rounded-xs" style="display: flex; align-items: center;">
    <i class="bi bi-person-check-fill font-12"></i>
    <span style="font-size: 12px; margin-right: -4px;">성별</span>
    <div class="form-check form-check-custom" style="margin-left: 130px;">
    <input class="form-check-input" type="checkbox" value="" id="c3a" onclick="toggleGenderLabel()">
    <label class="form-check-label" for="c3a" id="genderLabel">성별</label>
    <i class="is-checked color-green-dark bi bi-gender-male"></i>
    <i class="is-unchecked color-blue-dark bi bi-gender-female"></i>
</div>
</div>


    
    <div class="custom-border1 form-control rounded-xs" style=" align-items: center;">
    <i class="bi bi-123 font-12"></i>
    <span style="font-size: 12px; margin-right: -4px;">차량옵션</span>
    
    
    <div class ="form-check-inline" style="margin-left:-15px ;display: flex; align-items: center;">
  <div class="form-check form-check-inline form-check-custom">
  <input class="form-check-input"  style="margin-right: 20px ;" type="checkbox" value="" id="c22">
  <label class="form-check-label"  style="font-size: 10px;   white-space: nowrap;"for="c22">4인</label>
  <i class="is-checked color-green-dark bi bi-check-square" style="width: 10px; left: 45px;"></i>
  <i class="is-unchecked color-highlight bi bi-square" style="width: 10px; left: 45px;"></i>
</div>

<div class="form-check form-check-custom">
  <input class="form-check-input" type="checkbox" value="" id="c23">
  <label class="form-check-label" style="font-size: 10px;   white-space: nowrap;" for="c23">6인</label>
  <i class="is-checked color-green-dark bi bi-check-square" style="width: 10px; left: 45px;"></i>
  <i class="is-unchecked color-highlight bi bi-square" style="width: 10px; left: 45px;"></i>
</div>


<div class="form-check form-check-custom" >
  <input class="form-check-input" type="checkbox" value="" id="c24">
  <label class="form-check-label" style="font-size: 10px;   white-space: nowrap;" for="c24">8인</label>
  <i class="is-checked color-green-dark bi bi-check-square" style="width: 10px; left: 45px;"></i>
  <i class="is-unchecked color-highlight bi bi-square" style="width: 10px; left: 45px;"></i>
</div>

<div class="form-check form-check-custom">
  <input class="form-check-input" type="checkbox" value="" id="c25">
  <label class="form-check-label" style="font-size: 10px;   white-space: nowrap;"for="c25" >장애인</label>
  <i class="is-checked color-green-dark bi bi-check-square" style="width: 10px; left: 45px;"></i>
  <i class="is-unchecked color-highlight bi bi-square" style="width: 10px; left: 45px;"></i>
</div>
  </div>
    </div>    
    
    
    
    
  <div class="custom-border form-control rounded-xs" style="display: flex; align-items: center;">
    <i class="bi bi-check-all font-12"></i>
    <span style="font-size: 12px; margin-right: -4px; white-space: nowrap; width: 100px;">동물옵션</span>
     <div class="form-check form-check-custom" style="margin-left: 90px;">
              <input class="form-check-input" type="checkbox" value="" id="cqv3">
              <label class="form-check-label" style="white-space: nowrap;" for="cqv3">옵션여부</label>
              <i class="is-checked color-green-dark bi bi-check2 font-16"></i>
              <i class="is-unchecked color-red-dark bi bi-x font-18"></i>
            </div>
  </div>

        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-123 font-12"></i>
          <input type="text" class="form-control rounded-xs" id="c11" placeholder="차량번호"/>
          <label for="c2" class="color-theme">Password</label>
          <span>(required)</span>
        </div>
        
        
        
        <div class="custom-border2 form-control form-icon rounded-xs" style="display: flex;align-items: center;">
        <i class="bi bi-currency-dollar font-12"></i>
        <span style="font-size: 12px; margin-right: -4px;">정산수단</span>  
        <select id="bankName" name="bankName">
        <option value="00">은행명</option>
        <option value="004">KB국민은행</option>
        <option value="023">SC제일은행</option>
        <option value="039">경남은행</option>
        <option value="034">광주은행</option>
        <option value="003">기업은행</option>
        <option value="011">농협</option>
        <option value="031">대구은행</option>
        <option value="032">부산은행</option>
        <option value="002">산업은행</option>
        <option value="007">수협</option>
        <option value="088">신한은행</option>
        <option value="048">신협</option>
        <option value="005">외환은행</option>
        <option value="020">우리은행</option>
      </select> 
      <input type="text" id="accountNumber" name="accountNumber"
        placeholder="계좌번호('-'제외)" >
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
</div>
</body>
</html>
