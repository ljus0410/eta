
var messege;
var dupEEmail;
var nickNum;
var backAccountName;
var emailErr;
var moneyName = 0;
var Numer;
var birform;
var phoneCer;

// Ajax 요청 함수
function phone() {
  // Get the phone number from the input field
  var phone = $('#phone').val();

  // Perform AJAX request using jQuery
  $.ajax({
    url: '/user/json/send-one', // Specify your server endpoint
    method: 'GET',
    data: {
      phone: phone
    },
    success: function(response) {
      // Handle the success response
      console.log("phone: " + phone);
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
//인증번호
function addInput() {
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
        alert("일치");
        moneyName = 1;
        asdasdasd.text("예금주 일치").css('color', 'blue');
      } else {
        alert("불일치");
        moneyName = 2;
        asdasdasd.text("예금주 불일치").css('color', 'red');
      }

    },
    error: function(error) {
      // Handle the error
      console.error(error);
    }
  });
}
$(document).ready(function() {
  // 텍스트 입력란에 입력이 발생할 때마다 dupEmail 함수 호출
  $('#emailel').on('keyup', function() {
    console.log('이메일 입력이 종료되었습니다.');
    dupEmail();
  })
  function dupEmail() {

    // Get the phone number from the input field

    var email = $('#emailel').val();
    console.log("이메일 :" + email);
    var resultText = $('#resultText'); // resultText 변수 추가

    if (/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      emailErr = 0;
      console.log("emailErr" + emailErr);
      $.ajax({
        url: '/user/json/dupEmail', // Specify your server endpoint
        method: 'GET',
        data: {
          email: email
        },
        success: function(data) {
          // Handle the success response
          console.log("dupEEmail" + data);
          dupEEmail = data;

          if (dupEEmail === "1") {
            resultText.text("사용가능한 이메일입니다.").css('color', 'blue');
          } else {
            resultText.text("이미 사용중인 이메일입니다.").css('color', 'red');
          }
        },
        error: function(error) {
          // Handle the error
          console.error(error);
        }
      });


    } else {
      emailErr = 2;
      console.log("emailErr" + emailErr);
      resultText.text("올바른 이메일 형식이 아닙니다.").css('color', 'red');
    }
    // Perform AJAX request using jQuery

  }
});

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
      success: function(data) {
        // Handle the success response
        console.log("response" + data);
        nickNum = data;
        var resultText = $('#resultText2'); // resultText 변수 추가

        nickNum

        if (nickNum === "1") {
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


//      document.getElementById("gender").value = "0";
//여자 남자

document.addEventListener("DOMContentLoaded", function() {
  // 초기값을 여 (1)로 설정
  toggleGenderLabel(document.getElementById("genderch"));
});

function toggleGenderLabel(checkbox) {
  var label = document.getElementById("genderLabel");
  var gender = document.getElementById("genderch");

  if (checkbox.checked) {
    label.innerText = "남";
    gender.value = "0";
    console.log("Gender Value: " + gender.value);
    document.getElementById("gender").value = "0";
  } else {
    label.innerText = "여";
    gender.value = "1";
    console.log("Gender Value: " + gender.value);
    document.getElementById("gender").value = "1";
  }
}






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

//비밀번호 일치여부       
$(document).ready(function() {
  // 텍스트 입력란에 입력이 발생할 때마다 dupEmail 함수 호출
  $('#confirmPassword').on('input', function() {
    console.log('비밀번호 입력이 종료되었습니다.');

    // 페이지 로드 시에 매번 비밀번호를 다시 가져오도록 변경
    var password = $('#password').val();
    console.log("비밀번호" + password);

    // 확인 비밀번호 입력란의 값
    var confirmPassword = $(this).val();
    console.log("비밀번호확인" + confirmPassword);

    // 비밀번호와 확인 비밀번호 비교
    if (password === confirmPassword) {
      $("#checkPasswordMatch").text("비밀번호가 일치합니다.").css("color", "blue");
    } else {
      $("#checkPasswordMatch").text("비밀번호가 일치하지 않습니다.").css("color", "red");
    }
  });
});






function updateAnimalOptValue() {
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




$(document).ready(function() {
  $("#password").on("input", function() {
    var password = $(this).val();
    var message = $("#passwordMessage");

    // 비밀번호 길이가 8자 이상이고, 특수문자를 포함하는지 확인
    if (password.length >= 8 && /[!@#$%^&*(),.?":{}|<>]/.test(password)) {
      Numer = 0;
      message.text("조건 만족").css('color', 'blue');
    } else {
      Numer = 2;
      message.text("조건 불만족").css('color', 'red');
    }
  });
});

$(document).ready(function() {
  $("#birthdate").on("input", function() {
    var birthdate = $(this).val();
    var message = $("#birthdatemessa");

    // 생년월일이 8자리의 숫자인지 확인
    if (/^\d{8}$/.test(birthdate)) {
      birform = 1;
      // 생년월일이 8자리의 숫자이면서 'YYYYMMDD' 형식에 맞을 때

      // 결과를 출력하거나 원하는 작업을 수행할 수 있습니다.
      console.log("생년월일: ");
      message.text("조건만족").css('color', 'blue');
    } else {
      // 형식에 맞지 않을 때의 처리
      birform = 2;
      message.text("YYYYMMDD.").css('color', 'red');
    }
  });
});



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


$(function adUser() {
  $("#addUser").on("click", function() {

    var email = $('#emailel').val();
    var pwd12 = $('#password').val();
    var confirmPassword12 = $('#confirmPassword').val();
    var name = $('#name').val();
    var pet = $('#petOpt').val();
    var car = $('input[name="carOpt"]').val();
    var carNum = $('#carNum').val();
    var role = $('input[name="role"]').val();
    var account = $('#bank_num').val();
    var accountname12 = $('#accountname').val();
    var birth = $('#birthdate').val();
    var phone = $('#phone').val();



    if (name == null || name.length < 1) {
      userEnteredValue = "이름을 입력하세여";
      updateToastText();
      showToast();

      return;
    }

    if (email == null || email.length < 1) {
      userEnteredValue = "이메일을 입력하세여";
      updateToastText();
      showToast();
      return;
    }

    if (emailErr == 2) {
      console.log("이메일형식 x" + emailErr);

      return;
    }

    if (dupEEmail == 2) {
      console.log("이메일중복" + dupEEmail);
      return;
    }



    if (pwd12 == null || pwd12.length < 1) {
      userEnteredValue = "비밀번호을 입력하세여";
      updateToastText();
      showToast();
      return;

    }

    if (confirmPassword12 == null || pwd12.length < 1) {
      userEnteredValue = "비밀번호확인을 입력하세여";
      updateToastText();
      showToast();
      return;
    }
    if (Numer == 2) {
      userEnteredValue = "비밀번호 불일치";
      updateToastText();
      showToast();
      return;
    }

    if (confirmPassword12 != pwd12) {
      console.log("비밀번호 확인일치" + confirmPassword12);
      return;
    }

    if (nickNum == null || birth.length < 1) {
      userEnteredValue = "닉네임을 입력하세여";
      updateToastText();
      showToast();
      return;
    }
    if (nickNum == 2) {
      console.log("닉네임중복" + nickNum);
      return;
    }
    if (birth === null || birth.length < 1) {
      userEnteredValue = "생년월일 입력하세여";
      updateToastText();
      showToast();
      return;
    }

    if (birform == 2) {
      console.log("role 안되" + birth);

      return;
    }
    if (phone === null || birth.length < 1) {
      userEnteredValue = "전화번호를 입력하세여";
      updateToastText();
      showToast();
      return;
    }

    if (phoneCer == 2) {
      console.log("인증번호" + phoneCer);

      return;
    }



    if (role === "driver" && (carNum === null || carNum.length < 1)) {
      userEnteredValue = "차량번호를 입력하세여";
      updateToastText();
      showToast();
      return;
    }

    if (role === "driver" && (account === null || account.length < 1)) {
      userEnteredValue = "계좌번호를 입력하세여";
      updateToastText();
      showToast();
      return;
    }
    if (role === "driver" && (moneyName == 0)) {
      console.log("예금주 인증" + moneyName);

      return;
    }
    if (role === "driver" && (moneyName == 2)) {
      console.log("예금주 불일치" + moneyName);

      return;
    }



    $("form").attr("method", "POST").attr("action", "/user/addUser").submit();

  });
});

$(document).ready(function() {
  $("#blockButton").on("click", function() {
    // 여기서 user.userNo 가져오기
    var userNo = ${ user.userNo }; // 예시로 사용, 실제로는 적절한 방식으로 가져와야 함
    console.log("No : " + userNo);
    // AJAX 요청 보내기
    $.ajax({
      type: "GET",
      url: "../feedback/json/addBlock/" + userNo,
      success: function(response) {
        console.log("response" + response);

      },
      error: function(error) {
        console.error("에러 발생: ", error);
      }
    });
  });
});



function updateUser() {
  var newName = $("#name2").val();

  if (newName !== null) {
    $("#name").val(newName);
  } else {
    $("#name").val("#name2").val();
  }

  var phone2 = $("#phone2").val();

  if (phone2 !== null) {
    $("#phone").val(phone2);
  } else {
    $("#phone").val("#phone2").val();
  }




  // form 제출
  $("form").attr("method", "POST").attr("action", "/user/updateUser").submit();

}

//readonly
document.getElementById("birth").disabled = true;
document.getElementById("gender").disabled = true;
document.getElementById("nickName").disabled = true;
document.getElementById("email").disabled = true;

var messege;

// Ajax 요청 함수
function phone() {
  // Get the phone number from the input field
  var phone = $('#phone').val();

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
      if (name === response) {
        alert("일치");
      } else {
        alert("불일치");
      }
      // You can update the UI here based on the response if needed
    },
    error: function(error) {
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


//      document.getElementById("gender").value = "0";
//여자 남자




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
function addInput() {
  console.log("num: " + messege);
  var userInput = document.getElementById('certify').value;
  userInput = parseInt(userInput);
  var resultText = $('#message');

  if (messege == userInput) {
    console.log("입력값: " + userInput);
    resultText.text("일치합니다").css('color', 'blue');

    // 부트스트랩 JavaScript API를 사용하여 모달 닫기
    $('#menu-forgot').offcanvas('hide');
    $('#menu-forgot').on('hidden.bs.offcanvas', function() {
      // 입력 필드 비활성화
      $('#phone2').prop('disabled', true);
    });
  } else {
    console.log("틀린 입력값: " + userInput);
    resultText.text("불일치합니다.").css('color', 'red');
  }
}



function updateAnimalOptValue() {
  var checkbox = document.getElementById("petOpt");
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


  