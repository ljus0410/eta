<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eTa</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style>

/* 추가한 스타일 */
#phone, #authButton {
    display: inline-block; /* 인라인 블록으로 설정하여 같은 줄에 위치하도록 함 */
    vertical-align: middle; /* 수직 정렬을 중앙에 맞춤 */
    }       
.custom-border {
width: 45vw; 
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
height: 90px;
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
.custom-border4 {
    width: 40vw; 
    height: 150px;
    padding: 0px 15px 0px 40px;
    border: 1px solid #f0f0f0 !important; 
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    text-transform: uppercase;

}

.custom-border3 {
width: 40vw; 
height: 80px;
padding: 0px 15px 0px 40px;
border: 1px solid #f0f0f0 !important; 
display: flex;
align-items: center;
margin-bottom: 10px;
text-transform: uppercase;

}

.custom-checkbox {
position: absolute;
opacity: 0;
}
 .custom-border4 {
    width: 40vw; 
    height: 150px;
    padding: 0px 15px 0px 40px;
    border: 1px solid #f0f0f0 !important; 
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    text-transform: uppercase;

}
.custom-checkbox + label {
position: relative;
cursor: pointer;
width: 13px; /* 가로 크기 조절 */
height: 13px; /* 세로 크기 조절 */
display: inline-block;
}

.custom-checkbox + label::before {
content: '';
position: absolute;
left: 0;
top: 0;
width: 100%;
height: 100%;
border: 1px solid #ced4da !important;  /* 회색 테두리 스타일링 */
border-radius: 50%; /* 동그라미를 동그랗게 만들기 */
background-color: white; /* 동그라미 배경색 */

}

.custom-checkbox:checked + label::before {
background-color: #007bff; /* 클릭되었을 때의 배경색 */
content: '\2022'; /* 가운데 동그라미를 나타내는 유니코드 블랙 서클 (●) */
position: absolute;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
width: 13px; /* 동그라미의 크기를 조절합니다. */
height: 13px; /* 동그라미의 크기를 조절합니다. */
border-radius: 50%; /* 동그라미를 동그랗게 만듭니다. */
color: #fff; /* 가운데 동그라미의 텍스트 색상을 흰색으로 설정합니다. */
display: flex;
justify-content: center;
align-items: center;
}

.image-container {
display: grid;
grid-template-columns: repeat(4, 1fr);
gap: 1px;
align-items: center;
justify-content: center;
text-align: center; /* 이미지를 중앙에 정렬하기 위해 추가 */
}
.image-container img {
margin-right: 3px; /* 이미지 사이의 간격을 조정하세요 */
}
.selectedIcon path {
    fill: currentColor;
  }

.carOptStyle.selectedIcon {
    fill: currentColor;
}

   
</style>

<script type="text/javascript">

var messege;
var dupEEmail;
var nickNum;
var backAccountName;
var emailErr;
var moneyName = 0;
var Numer;
var birform;
var phoneCer = 0;

if ('driver' === '${user.role}') {
    document.addEventListener('DOMContentLoaded', function() {
        const userCarOpt = `${user.carOpt}`;
        
        // 초기 아이콘에 스타일 적용
        if (userCarOpt === '4') {
            document.getElementById('busIcon').classList.add('selectedIcon');
        } else if (userCarOpt === '6') {
            document.getElementById('busIcon2').classList.add('selectedIcon');
        } else if (userCarOpt === '8') {
            document.getElementById('busIcon3').classList.add('selectedIcon');
        } else if (userCarOpt === '0') {
            document.getElementById('busIcon4').classList.add('selectedIcon');
        }
        
        document.getElementById('carOptValue').value = userCarOpt;
    });
}




function handleIconClick(value, element) {
    // 선택된 아이콘의 값을 활용하거나, 원하는 동작 수행
    console.log('선택된 값:', value);
    var carOptValueElement = document.getElementById('carOptValue');
    if (carOptValueElement) {
        carOptValueElement.remove();
    }
    // 다른 모든 아이콘에서 선택 효과를 제거
    var icons = document.querySelectorAll('.carOptStyle');
    icons.forEach(icon => {
        icon.classList.remove('selectedIcon');
    });

    // Add 'selected' class to the clicked icon
    element.classList.add('selectedIcon');
    var radioBtn = document.querySelector('input[name="carOpt"][value="' + value + '"]');
    console.log('현재 선택된 라디오 버튼의 값:', radioBtn ? radioBtn.value : '없음');
    if (radioBtn) {
        radioBtn.checked = true;
    }
}

  


function updateUser() {
  var newName = $("#name2").val();
  var phone2 = $("#phone2").val();
  var account2 = $("#account2").val();
  var carNum2 = $("#carNum2").val();
  var bank_num = $("#bank_num").val();
  var gender2 = $("#gender2").val();
  var role = $('input[name="role"]').val();

  // 이름
  if (newName !== null && newName !== "") {
    $("#name").val(newName);
  }

  // 전화번호
  if (phone2 !== null && phone2 !== "") {
    $("#phone").val(phone2);
  }

  // 계좌
  if (account2 !== null && account2 !== "") {
    $("#account").val(account2);
  }



  // 차량 번호
  if (carNum2 !== null && carNum2 !== "") {
    $("#carNum").val(carNum2);
  }

  if (bank_num !== null && bank_num !== "") {
      $("#account").val(bank_num);
    }
  if (gender2 =='남') {
	     console.log("gender");
        $("#gender").val('0');
      }
  if (gender2 =='여') {
      console.log("gender");
       $("#gender").val('1');
     }
  
  if (phoneCer == 2) {
      userEnteredValue = "휴대폰 인증을 진행해세요";
        updateToastText();
        showToast();

      return;
    }

    if (role === "driver" && (moneyName == 2)) {
    	userEnteredValue = "예금주 인증을 진행해세요";
        updateToastText();
        showToast();
      console.log("예금주 불일치" + moneyName);

      return;
    }
    // form 제출
    $("form").attr("method", "POST").attr("action", "/user/updateUser").submit();

  }



  var messege;

  // Ajax 요청 함수
  function phone() {
    // Get the phone number from the input field
    var phone = $('#phone2').val();

    // Perform AJAX request using jQuery
    $.ajax({
      url: '/user/json/send-one', // Specify your server endpoint
      method: 'GET',
      data: {
        phone: phone
      },
      success: function(response) {
        // Handle the success response
        console.log(response.num);
        messege = response.num
        // You can update the UI here based on the response if needed
      },
      error: function(error) {
        // Handle the error
        console.error(error);
      }
    });
  }

  function handleBankClick(imgElement) {
    var bankCode = imgElement.getAttribute('data-bank-code');
    var bankName = imgElement.getAttribute("data-bank-name");

    console.log('Bank Code: ' + bankCode);
    console.log('Bank Name: ' + bankName);
    document.getElementById('bankCodeInput').value = bankCode;

    document.getElementById("bank").value = bankName;


    // bankname 함수 호출


    // 여기서 필요한 로직 수행
  }

  function bankname(bankCode) {
    console.log("bankCode: " + bankCode);
    // Get the phone number from the input field

    var bank_num = $('#bank_num').val();
    var bankCode = document.getElementById('bankCodeInput').value;
    var name = $('#accountname').val();
    console.log("번호 :" + bank_num);
    console.log("코드 :" + bankCode);
    console.log("이름 :" + name);
    // Perform AJAX request using jQuery
    $.ajax({
      url: '/user/json/bankName', // Specify your server endpoint
      method: 'GET',
      data: {
        bank_code: bankCode,
        bank_num: bank_num
      },
      success: function(response) {
          // Handle the success response
          console.log(response);

          var asdasdasd = $('#asdasdasd');
          backAccountName = response;
          if (name == backAccountName) {
            moneyName = 1;
            asdasdasd.text("인증완료").css('color', 'blue');
          } else {
            moneyName = 2;
            asdasdasd.text("예금주 불일치").css('color', 'red');
          }

        },
        error: function(error) {
           var asdasdasd = $('#asdasdasd');
           asdasdasd.text("일치하는 정보가 없습니다").css('color', 'red');
          // Handle the error
          console.error(error);
        }
      });
    }

  $(document).ready(function() {
    // 텍스트 입력란에 입력이 발생할 때마다 dupEmail 함수 호출
    $('#nickName').on('keyup', function() {
      console.log('닉네임 입력이 종료되었습니다.');
      dupNick();
    })
    function dupNick() {

      // Get the phone number from the input field

      var nick = $('#nickName').val();
      console.log("닉네임 :" + nick);

      // Perform AJAX request using jQuery
      $.ajax({
        url: '/user/json/dupNickName', // Specify your server endpoint
        method: 'GET',
        data: {
          nick: nick
        },
        success: function(response) {
          // Handle the success response
          console.log("response" + response);
          var resultText = $('#resultText2'); // resultText 변수 추가

          if (response === "1") {
            resultText.text("사용가능한 닉네임니다.").css('color', 'blue');
          } else {
            resultText.text("이미 사용중인 닉네임입니다.").css('color', 'red');
          }
        },
        error: function(error) {
          // Handle the error
          console.error(error);
        }
      });
    }
  });

  //은행값가저오기              
  function openModal() {
    // Bootstrap JavaScript 함수 호출
    var bankOffcanvas = new bootstrap.Offcanvas(document.getElementById('bank_list'));

    // Check if the offcanvas is currently shown
    if (bankOffcanvas._isShown) {
      // If shown, hide the offcanvas (close the modal)
      bankOffcanvas.hide();
    } else {
      // If not shown, show the offcanvas (open the modal)
      bankOffcanvas.show();
    }
  }

//인증번호
  function phoneCer() {
      console.log("num: " + messege);
      var userInput = document.getElementById('certify').value;
      userInput = parseInt(userInput);
      var resultText = $('#message');

      if (messege == userInput) {
        phoneCer = 1;
        console.log("입력값: " + userInput);
        resultText.text("일치합니다").css('color', 'blue');

        // 부트스트랩 JavaScript API를 사용하여 모달 닫기
        $('#phoneNum').offcanvas('hide');
        $('#phoneNum').on('hidden.bs.offcanvas', function() {


          // 입력 필드 비활성화
          $("#checkNum").text("인증완료").css("color", "blue");

        });
      } else {
        phoneCer = 2;
        console.log("틀린 입력값: " + userInput);
        resultText.text("불일치합니다.").css('color', 'red');
      }
    }




  

  
  
  
  
  document.addEventListener('DOMContentLoaded', function() {
      const petOptValue = ${user.petOpt}; // 이 값은 실제로 받아온 값으로 대체되어야 합니다.
      console.log("asdads"+petOptValue);
      // petOpt가 1인 경우 체크박스를 체크 상태로 설정
      if (petOptValue === true) {
          document.getElementById('animalOpt').checked = true;
          document.getElementById('animalOptValue').value = 1;
      }
  });

  function toggleCheckbox() {
    console.log("toggleCheckbox 함수 호출됨!");
        updateAnimalOptValue(); // 체크박스 상태 업데이트
      }



    function updateAnimalOptValue() {
       var animalOptCheckbox = document.getElementById('animalOpt');
         var img = document.querySelector('img');
         
         animalOptCheckbox.checked = !animalOptCheckbox.checked;
         
         console.log("Current animalOptCheckbox checked:", animalOptCheckbox.checked);
         
      var checkbox = document.getElementById("animalOpt");
      var valueInput = document.getElementById("animalOptValue"); // 추가: 값을 전달할 hidden input

      if (checkbox.checked) {
        // 체크되었을 때
        valueInput.value = "1";
        console.log("동물옵션" + valueInput.value);
      } else {
        // 체크되지 않았을 때
        valueInput.value = "0"; // 또는 다른 기본값으로 설정
        console.log("동물옵션" + valueInput.value);
      }
    }
    
    const rawDate = new Date(`${user.regDate}`);
    const year = rawDate.getFullYear();
    const month = (rawDate.getMonth() + 1).toString().padStart(2, '0');
    const day = rawDate.getDate().toString().padStart(2, '0');
    const formattedDate = `${year}-${month}-${day}`;

   
    
    function showInputAndButton() {
    	 console.log("showInputAndButton 함수 호출됨");
        // 이미지를 클릭하면 숨겨진 입력란과 버튼을 나타나게 함
        document.getElementById("accountname").style.display = "inline-block";
        document.getElementById("confirmation").style.display = "inline-block";
        console.log("showInputAndButton 함수 호출됨");
    }
    function showToast() {
        var toastElement = document.getElementById('addUserTa');
        var toast = new bootstrap.Toast(toastElement);
        toast.show();

      }
    var userEnteredValue
    function updateToastText() {
      // 사용자가 입력한 값을 각 요소에 적용
      document.getElementById('messgeInfo').textContent = userEnteredValue;

    }
 </script>
    
</head>
<body>
<jsp:include page="../home/top.jsp" />
<form>
<div id="page">
<div class="page-content header-clear-medium" >
        <input type="hidden" id="pwd" name="pwd" value="${user.pwd}">
        <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
       <div class="card card-style" style="margin-bottom: 15px;">
    <div class="content" style="margin-bottom: 9px; display: flex; justify-content: space-between; align-items: center;">
        <h1 class="pb-2" style="width: 140px;">
            <i class="has-bg rounded-s bi bg-green-dark bi-person-fill" style="vertical-align:bottom !important; line-height: 0px!important;height: 30px !important;font-size: 30px !important; all:initial; display: inline-block;"></i>&nbsp;&nbsp;내정보
              
        </h1>
       <div style="text-align: right;">

   <c:if test="${user.role ne 'driver'}">
   <fmt:formatNumber type="number" value="${user.myMoney}" var="formattedNumber" />
      <p class="font-12 color-highlight" style="margin-bottom: 0;text-align: left;">잔액: ${formattedNumber}원</p>
   </c:if>

   <p class="font-12 color-highlight" style="margin-bottom: 0;">가입일자: ${user.regDate.substring(0, 10)}</p>
            
</div>

    </div>
</div>



        <div class="card card-style">
      <div class="content">
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs " name="name2" id="name2" value="${user.name}"/>
          <input type="hidden" class="form-control rounded-xs " name="name" id="name" value=""/>
          <span>이름</span>
        </div>
        
        <div class="custom-border3 form-control rounded-xs" style="align-items: center;">
    <div style="display: flex;">
        <i style="font-size: 13px;" class="bi bi-currency-dollar font-12"></i>
        <span style="font-size: 13px; flex-direction: column; margin-bottom: 8px; margin-left:14px; color: gray;">전화번호</span>
    </div>
    <div style="justify-content: center; display: flex; align-items: center;">
        <div id="inputContainer">
            <input class="rounded-xs" value=""  name="phone" style="color: gray; margin-left: 10px; border: 1px solid #ced4da !important;" type="hidden" id="phone" />
            <input class="rounded-xs" value="${user.phone}"  name="phone2" style="color: gray; margin-left: 10px; border: 1px solid #ced4da !important;" type="text" id="phone2" />
            <a onclick="phone()" data-bs-toggle="offcanvas" data-bs-target="#phoneNum" style="width: 60px; height: 30px; line-height: 7px; white-space: nowrap;" class="btn-s btn bg-fade2-blue color-blue-dark" id=>인 증</a>
        </div>
    </div>
    <span id="checkNum" style="justify-content: flex-start; display: flex; margin-left: 40px; font-size: 11px;"></span>
    
    
</div>

        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-square font-12"></i>
          <input type="text" class="form-control rounded-xs" id="nickName" value="${user.nickName}" readonly name="nickName"/>
          <label for="nick" class="color-theme">NickName</label>
          <span>닉네임</span>        
        </div>
        
            <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-envelope font-14"></i>
          <input type="text" class="form-control rounded-xs" id="email" name="email" value="${user.email}" placeholder="이메일" readonly/>
         <label for="email" class="color-theme">Email</label>
           <span>이메일</span> 
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" name ="birth"id="birth" value="${user.birth}" readonly/>
          <span>생년월일</span>
        </div>
        <div class="form-custom form-label form-icon mb-3">
        <i class="bi bi-person-check-fill font-14"></i>
        <input type="text" class="form-control rounded-xs" name ="gender2"id="gender2" value="${user.gender eq 0 ? '남' : '여'}" readonly />      
         <input type="hidden" id="gender" name="gender" value="">   
        <span>성별</span>
        </div>
  
  <c:choose>
        <c:when test="${user.role eq 'passenger'}">
            <input type="hidden" name="role" value="passenger">
        </c:when>
        <c:when test="${user.role eq 'driver'}">
            <input type="hidden" name="role" value="driver">
        </c:when>
    </c:choose>
        
  <c:if test="${param.role eq 'driver' or user.role eq 'driver'}">
    <div class="custom-border1 form-control rounded-xs" style=" align-items: center;">
     <div style="display: flex;  ">
    <i style="font-size: 13px;"class="bi bi-123 font-12"></i>
    <span style="font-size: 13px;flex-direction: column;  margin-bottom: 8px; margin-left:14px; color: gray;">차량옵션</span>
   </div>
   
<div style="text-align: center;margin-left:3px;">
   
   
   <div style="margin-right:15px;">
   <input type="hidden" id="carOptValue" name="carOpt">
        <span id="busIcon" style="margin-left: 8px;" class="carOptStyle" onclick="handleIconClick('4', this)">
  <input style="display: none;" type="radio" value="4" class="form-check-input" name="carOpt">
  <svg style="flex-direction: column; " xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="gray" class="bi bi-car-front-fill" viewBox="0 0 16 16">
    <path d="M2.52 3.515A2.5 2.5 0 0 1 4.82 2h6.362c1 0 1.904.596 2.298 1.515l.792 1.848c.075.175.21.319.38.404.5.25.855.715.965 1.262l.335 1.679c.033.161.049.325.049.49v.413c0 .814-.39 1.543-1 1.997V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.338c-1.292.048-2.745.088-4 .088s-2.708-.04-4-.088V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.892c-.61-.454-1-1.183-1-1.997v-.413a2.5 2.5 0 0 1 .049-.49l.335-1.68c.11-.546.465-1.012.964-1.261a.807.807 0 0 0 .381-.404l.792-1.848ZM3 10a1 1 0 1 0 0-2 1 1 0 0 0 0 2m10 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2M6 8a1 1 0 0 0 0 2h4a1 1 0 1 0 0-2zM2.906 5.189a.51.51 0 0 0 .497.731c.91-.073 3.35-.17 4.597-.17 1.247 0 3.688.097 4.597.17a.51.51 0 0 0 .497-.731l-.956-1.913A.5.5 0 0 0 11.691 3H4.309a.5.5 0 0 0-.447.276L2.906 5.19Z" />
  </svg>
</span>


<span id="busIcon2" class="carOptStyle" style="margin-left: 30px; margin-right: 8px;" onclick="handleIconClick('6', this)">
  <input style="display: none;" type="radio" value="6" class="form-check-input" name="carOpt">
  <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="gray" class="bi bi-bus-front-fill" viewBox="0 0 16 16">
    <path d="M16 7a1 1 0 0 1-1 1v3.5c0 .818-.393 1.544-1 2v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5V14H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2a2.496 2.496 0 0 1-1-2V8a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1V2.64C1 1.452 1.845.408 3.064.268A43.608 43.608 0 0 1 8 0c2.1 0 3.792.136 4.936.268C14.155.408 15 1.452 15 2.64V4a1 1 0 0 1 1 1zM3.552 3.22A43.306 43.306 0 0 1 8 3c1.837 0 3.353.107 4.448.22a.5.5 0 0 0 .104-.994A44.304 44.304 0 0 0 8 2c-1.876 0-3.426.109-4.552.226a.5.5 0 1 0 .104.994ZM8 4c-1.876 0-3.426.109-4.552.226A.5.5 0 0 0 3 4.723v3.554a.5.5 0 0 0 .448.497C4.574 8.891 6.124 9 8 9c1.876 0 3.426-.109 4.552-.226A.5.5 0 0 0 13 8.277V4.723a.5.5 0 0 0-.448-.497A44.304 44.304 0 0 0 8 4m-3 7a1 1 0 1 0-2 0 1 1 0 0 0 2 0m8 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m-7 0a1 1 0 0 0 1 1h2a1 1 0 1 0 0-2H7a1 1 0 0 0-1 1" class="icon-path"></svg>
</span>

<span id="busIcon3" class="carOptStyle" style="margin-left: 30px; margin-right: 25px;" onclick="handleIconClick('8', this)">
    <input style="display: none;" type="radio" name="carOpt" value="8" style="margin-right: 9px;" class="form-check-input" name="carOpt" >
    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="gray" class="bi bi-bus-front-fill" viewBox="0 0 16 16">
        <path d="M16 7a1 1 0 0 1-1 1v3.5c0 .818-.393 1.544-1 2v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5V14H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2a2.496 2.496 0 0 1-1-2V8a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1V2.64C1 1.452 1.845.408 3.064.268A43.608 43.608 0 0 1 8 0c2.1 0 3.792.136 4.936.268C14.155.408 15 1.452 15 2.64V4a1 1 0 0 1 1 1zM3.552 3.22A43.306 43.306 0 0 1 8 3c1.837 0 3.353.107 4.448.22a.5.5 0 0 0 .104-.994A44.304 44.304 0 0 0 8 2c-1.876 0-3.426.109-4.552.226a.5.5 0 1 0 .104.994ZM8 4c-1.876 0-3.426.109-4.552.226A.5.5 0 0 0 3 4.723v3.554a.5.5 0 0 0 .448.497C4.574 8.891 6.124 9 8 9c1.876 0 3.426-.109 4.552-.226A.5.5 0 0 0 13 8.277V4.723a.5.5 0 0 0-.448-.497A44.304 44.304 0 0 0 8 4m-3 7a1 1 0 1 0-2 0 1 1 0 0 0 2 0m8 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m-7 0a1 1 0 0 0 1 1h2a1 1 0 1 0 0-2H7a1 1 0 0 0-1 1"/>
    </svg>
</span>

<span id="busIcon4" class="carOptStyle" style="margin-left: 15px; cursor: pointer;" onclick="handleIconClick('0', this)">
   <input style="display: none;" type="radio"  value="0" class="form-check-input" name="carOpt" >
   <label for="carOpt"></label><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="gray" class="bi bi-person-wheelchair" viewBox="0 0 16 16">
  <path d="M12 3a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3m-.663 2.146a1.5 1.5 0 0 0-.47-2.115l-2.5-1.508a1.5 1.5 0 0 0-1.676.086l-2.329 1.75a.866.866 0 0 0 1.051 1.375L7.361 3.37l.922.71-2.038 2.445A4.732 4.732 0 0 0 2.628 7.67l1.064 1.065a3.25 3.25 0 0 1 4.574 4.574l1.064 1.063a4.732 4.732 0 0 0 1.09-3.998l1.043-.292-.187 2.991a.872.872 0 1 0 1.741.098l.206-4.121A1 1 0 0 0 12.224 8h-2.79l1.903-2.854ZM3.023 9.48a3.25 3.25 0 0 0 4.496 4.496l1.077 1.077a4.75 4.75 0 0 1-6.65-6.65l1.077 1.078Z" />
</svg></span>
    </div>
<div style="margin-right: -27px; display: flex;justify-content: center; color: gray; font-size: 14px;">
<span style =" margin-right: 43px; margin-left: -21px;">4인</span>
<span style =" margin-right: 48px;">6인</span>
<span style =" margin-right: 45px; ">8인</span>
<span>장애인</span>
</div>
    </div> 

    </div> 
    
  
    
    <div class="custom-border2 form-control rounded-xs"  style="display: flex; align-items: center;">
     <div style="display: flex;  ">
    <i style="font-size: 13px;"class="bi bi-check-all font-12"></i>
    <span style="font-size: 13px;flex-direction: column;  margin-bottom: 8px; margin-left:14px; color: gray;">동물옵션</span>
   </div>
  <div style="display: flex; align-items: center; margin-left: auto;">
  <input class="form-check-input custom-checkbox" type="checkbox" value="1" id="animalOpt">
  <label for="animalOpt"></label>
  <img src="../images/pet.png" width="35" height="35" style="margin-right: 40px;" onclick="toggleCheckbox()">
   <input type="hidden" id="animalOptValue" name="petOpt" value="0">
</div>
</div>


        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-123 font-12"></i>
          <input type="text" class="form-control rounded-xs" id="carNum2" name="carNum2" value="${user.carNum}"/>
           <input type="hidden" class="form-control rounded-xs" id="carNum" name="carNum" />
          <label for="c2" class="color-theme">CarNum</label>
          <span></span>
        </div>
        
        
        
        
        <div class="custom-border4 form-control rounded-xs" style=" align-items: center;">
     <div style="display: flex;  ">
    <i style="font-size: 13px;"class="bi bi-currency-dollar font-12"></i>
    <span style="font-size: 13px;flex-direction: column;  margin-bottom: 8px; margin-left:14px; color: gray;">정산수단</span>
   </div>
        

<div style="margin-top:5px; margin-left:15px; justify-content: center; isplay: flex; align-items: center;">
      <input type="hidden" id="bankCodeInput" />

        <image src="../images/bank.png" onclick="openModal(); showInputAndButton()" style="margin-bottom:5px; width:25px; height:25px;">
        <input type="hidden" id="account" name="account" value="">
        <input type="text" id="bank" name="bank" value="${user.bank}" class="rounded-xs" readonly style="height:25px; width:60px; color:gray; border: 1px solid #ced4da !important;" placeholder="은행"/>
       <input class="rounded-xs"  name="account2" style="height:25px; color:gray;  border: 1px solid #ced4da !important;"type="text" id="bank_num" value="${user.account }"/>
            <div>
       <input class="rounded-xs" name="accountname" style="height:25px; color:gray; margin-left:15px; margin-top: 15px; border: 1px solid #ced4da !important; display:none;" type="text" id="accountname" placeholder="예금주"/>
      
<a onclick="bankname()" style="font-size: 10px; width: 60px; height: 25px; line-height: 7px;white-space: nowrap; display:none;" class="btn-s btn bg-fade2-blue color-blue-dark" id="confirmation">확인</a>
</div>
</div>
<span id="asdasdasd" style="justify-content: flex-start; display: flex; margin-left: 32px; font-size: 12px;"></span>
 
</diV>
 </c:if>
 
 
 
 
 
 
 
 
 
 <a href="#" onclick="updateUser()"class="btn btn-full gradient-blue shadow-bg shadow-bg-s mt-4">수정</a> 
 </div>
 </div>
 </div>
 </div>
 
   </form>
 

        
     
        
        
        
<div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px" id="phoneNum">
    <div class="content">
      <h5 class="mb-n1 font-12 color-highlight font-700 text-uppercase pt-1">Welcome</h5>
      <h1 class="font-24 font-800 mb-3">인증번호</h1>
      <div class="form-custom form-label form-border form-icon mb-3 bg-transparent">
        <i class="bi bi-at font-14"></i>
        <input type="text" class="form-control rounded-xs" id="certify" value="" placeholder="인증번호" />
        <label for="c1" class="color-theme">인증번호</label>
        <span id="message" style="margin-left: 10px;"></span>
      </div>
      <a href="#"  id ="message" onclick="phoneCer()" class="btn btn-full gradient-blue shadow-bg shadow-bg-s mt-4">확 인</a>
      <div class="row">      
      </div>
    </div>
   </div>

   
   <div class="offcanvas offcanvas-modal rounded-m offcanvas-detached bg-theme" style="width:340px" id="bank_list">
    <div class="content">
        <div class="pb-2">
            <div class="align-self-center">
                <h1 class="font-700">은행</h1>
                <div class="container">
                    <div class="image-container" style="justify-content-center;">
                        <img src="../images/신한.png"  data-bs-dismiss="offcanvas" data-bank-name="신한은행" data-bank-code="088" width="45" height="45" onclick="handleBankClick(this)">
                        <img src="../images/농협.png"  data-bs-dismiss="offcanvas" data-bank-name="농협은행" data-bank-code="011" width="45" height="45" onclick="handleBankClick(this)">
                        <img src="../images/국민.png"  data-bs-dismiss="offcanvas" data-bank-name="국민은행" data-bank-code="004" width="45" height="45" onclick="handleBankClick(this)">
                        <img src="../images/기업.png"  data-bs-dismiss="offcanvas" data-bank-name="기업은행" data-bank-code="003" width="45" height="45" onclick="handleBankClick(this)">
                    </div>
    <div class="text-container" style="display: flex; justify-content: space-around; margin-top: 4px;">
        <span style="margin-left:-14px;">신한은행</span>
        <span>농협은행</span>
        <span>국민은행</span>
        <span>기업은행</span>
    </div>
    <div class="image-container" style="justify-content-center;">
        <img src="../images/제일.png"  data-bs-dismiss="offcanvas" data-bank-name="sc제일은행" data-bank-code="023" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/광주.png"  data-bs-dismiss="offcanvas" data-bank-name="광주은행" data-bank-code="034" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/신협.png"   data-bs-dismiss="offcanvas" data-bank-name="신협은행" data-bank-code="048" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/우리.png"  data-bs-dismiss="offcanvas" data-bank-name="우리은행" data-bank-code="020" width="45" height="45" onclick="handleBankClick(this)">
    </div>
    <div class="text-container" style="display: flex; justify-content: space-around; margin-top: 4px;">
        <span style="margin-left:-14px;">sc제일은행</span>
        <span>광주은행</span>
        <span>신협은행</span>
        <span>우리은행</span>
    </div>
        <div class="image-container" style="justify-content-center;">
        <img src="../images/우체.png"  data-bs-dismiss="offcanvas" data-bank-name="우체국" data-bank-code="071" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/하나.png"  data-bs-dismiss="offcanvas" data-bank-name="하나은행" data-bank-code="081" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/카카오.png" data-bs-dismiss="offcanvas" data-bank-name="카카오" data-bank-code="090" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/케이.png"  data-bs-dismiss="offcanvas" data-bank-name="뱅크" data-bank-code="089" width="45" height="45" onclick="handleBankClick(this)">
    </div>
    <div class="text-container" style="display: flex; justify-content: space-around; margin-top: 4px;">
        <span style="margin-left:-14px;">우체국</span>
        <span>하나은행</span>
        <span style="margin-right:12px;">카카오</span>
        <span style="margin-right:15px;'">K뱅크</span>
    </div>
     <div class="image-container" style="justify-content-center;">
        <img src="../images/유안타.png"  data-bs-dismiss="offcanvas" data-bank-name="유안타증권" data-bank-code="209" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/현대.png"  data-bs-dismiss="offcanvas" data-bank-name="현대증권" data-bank-code="218" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/미래.png"  data-bs-dismiss="offcanvas" data-bank-name="미래에셋증권" data-bank-code="230" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/삼성.png"  data-bs-dismiss="offcanvas" data-bank-name="삼성증권" data-bank-code="240" width="45" height="45" onclick="handleBankClick(this)">
    </div>
    <div class="text-container" style="display: flex; justify-content: space-around; margin-top: 4px;">
        <span style="margin-left:-14px;">유안타증권</span>
        <span>현대증권</span>
        <span>미래에셋증권</span>
        <span>삼성증권</span>
    </div>
     <div class="image-container" style="justify-content-center;">
        <img src="../images/한국투자.png"  data-bs-dismiss="offcanvas" data-bank-name="한국투자" data-bank-code="243" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/교보.png"  data-bs-dismiss="offcanvas" data-bank-name="교보증권" data-bank-code="261" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/키움.png"  data-bs-dismiss="offcanvas" data-bank-name="키움증권" data-bank-code="264" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/sk.png"  data-bs-dismiss="offcanvas" data-bank-name="sk증권" data-bank-code="266" width="45" height="45" onclick="handleBankClick(this)">
    </div>
    <div class="text-container" style="display: flex; justify-content: space-around; margin-top: 4px;">
        <span style="margin-left:-14px;">한국투자</span>
        <span>교보증권</span>
        <span style="margin-right:12px;">키움증권</span>
        <span style="margin-right:12px;">sk증권</span>
    </div>
      <div class="image-container" style="justify-content-center;">
        <img src="../images/한화.png"  data-bs-dismiss="offcanvas" data-bank-name="한화증권" data-bank-code="269" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/대신.png"  data-bs-dismiss="offcanvas" data-bank-name="대신증권" data-bank-code="267" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/유진.png"  data-bs-dismiss="offcanvas" data-bank-name="유진투자증권" data-bank-code="280" width="45" height="45" onclick="handleBankClick(this)">
        <img src="../images/메리.png"  data-bs-dismiss="offcanvas" data-bank-name="메리츠증권" data-bank-code="287" width="45" height="45" onclick="handleBankClick(this)">
    </div>
    <div class="text-container" style="display: flex; justify-content: space-around; margin-top: 4px;">
        <span style="margin-left:-14px;">한화증권</span>
        <span>대신증권</span>
        <span>유진투자증권</span>
        <span>메리츠증권</span>
    </div>
</div>
    
</div>
</div>
     
      </div>
    </div>
    
 
    
<div id="addUserTa" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">
    <div class="align-self-center">
      <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
    </div>
    <div class="align-self-center">
      <strong id ="messgeInfo" class="font-13 mb-n2"></strong>
      <span class="font-10 mt-n1 opacity-70">Sign-up Failed. Try again.</span>
    </div>
    <div class="align-self-center ms-auto">
      <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
    </div>
  </div>
</body>
</html>