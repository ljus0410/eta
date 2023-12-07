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
<form id="login" method="post" action="/user/addUser">
    <input id="email" type="text" name="email" value="${(kakaoProfile != null) ? kakaoProfile.getKakao_account().getEmail() : ''} ${(naverProfile != null) ? naverProfile.getResponse().getEmail() : ''}"><br>
    <input id="nickName" type="text" name="nickName" value="${(kakaoProfile != null) ? kakaoProfile.getProperties().getNickname() : ''}"><br>
    <input id="pwd" type="text" name="pwd" value=''><br>
    <input id="birth" type="text" name="birth" value=''><br>
    <input id="phone" type="text" name="phone" value=''><button id="authButton">인증</button><br> <!-- 버튼을 입력란 옆에 위치 -->
    <input id="bank" type="text" name="bank" value=''><br>
    <input id="role" type="text" name="role" value='passenger'><br>
    <input id="name" type="text" name="name" value=''><br>
    <input id="submit" type="submit" name="submit" value="Enter"/>
    <!-- <a href="/user/logon">Label</a> -->
</form>

</body>
</html>
