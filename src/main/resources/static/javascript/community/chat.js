$(function() {
  
  $.ajax({
            url: "/community/json/getShareReqPassenger?callNo="+$("#callNo").val(),
            type: "GET",
            dataType: "json",
            success: function (response){
                    let receiveInt = parseInt(response);
                    
                      if($("#userNo").text()==receiveInt) {
                        var newRow = '<button type="button" class="btn-xxs btn border-blue-dark color-blue-dark" onclick="startShare('+$("#callNo").val()+')">'
                      + '배차'
                      + '</button>'

                      // 적절한 위치에 행 추가
                      $('#shareStartButton').append(newRow);
                      } else {
                        var newRow = '<button type="button" class="btn-xxs btn border-blue-dark color-blue-dark" onclick="startShareOther('+$("#callNo").val()+')">'
                      + '배차'
                      + '</button>'

                      // 적절한 위치에 행 추가
                      $('#shareStartButton').append(newRow);
                      }
                      
            }
        })
})


// resources/static/js/chat.js
const socket = new SockJS('/ws');
const stompClient = Stomp.over(socket);

stompClient.connect({}, function (frame) {
    stompClient.send("/chat/start/"+$("#callNo").val(), {}, JSON.stringify({
        sender: "사용자명",
        content: "입장했습니다.",
        callNo: $("#callNo").val(),
        time: "현재시간"
    }));

    stompClient.subscribe('/topic/messages/' + $("#callNo").val(), function (response) {
        const messages = JSON.parse(response.body);

        if(Array.isArray(messages)) {
            messages.forEach(function (message) {
                appendMessage(message.content,message.sender,message.time);
            });
        } else {
            appendMessage(messages.content,messages.sender,messages.time);
        }
    });
});

document.getElementById('content').addEventListener('keydown', function (e) {
    // Check if the pressed key is Enter (key code 13)
    if (e.keyCode === 13) {
        // Prevent the default behavior (form submission)
        e.preventDefault();
        // Call your custom function or do nothing
        // You can choose to call sendMessage() or do something else
        // For now, let's just log a message
        console.log("Enter key pressed, but not calling sendMessage()");
    }
});

$(document).ready(function() {
        // id가 "logoutLink"인 요소에 클릭 이벤트를 추가
        $("#logOutButton").on("click", function() {
            // 쿠키에서 토큰 값을 가져옴
            var naverAccessToken = getCookie("naverAccessToken");
            console.log("Naver Access Token:", naverAccessToken);
            // 로그아웃 URL 구성 (토큰 값이 있다면 추가)
            var logoutUrl = "/user/kakao-logOut" + (naverAccessToken ? "?token=" + encodeURIComponent(naverAccessToken) : "");

            // 페이지 이동
            window.location.href = logoutUrl;
        });

        // 쿠키에서 특정 이름의 값을 가져오는 함수
        function getCookie(name) {
            var value = "; " + document.cookie;
            var parts = value.split("; " + name + "=");
            if (parts.length == 2) return parts.pop().split(";").shift();
        }

    });
    
function startShare(callNo) {
  
   const message = {
        callNo: callNo,
        content: "합승"
      };
  
  /*stompClient.send("/chat/"+$("#callNo").val(), {}, JSON.stringify(message));*/
  self.location="/community/startShareReq?callNo="+callNo;
}

function startShareOther(callNo) {
  self.location="/callres/drivingP.jsp?callNo="+callNo;
}
    
function sendMessage() {
    const sender = document.getElementById('sender').value;
    const content = document.getElementById('content').value;
    const callNo = document.getElementById('callNo').value;
    const timestamp = new Date();
    const time = String(timestamp.getHours()).padStart(2, "0")
        + ":"
        + String(timestamp.getMinutes()).padStart(2, "0");

    if (!content || content==="") {
        alert("메시지를 입력해주세요.");
        return;
    }

    const message = {
        sender: sender,
        content: content,
        callNo: callNo,
        time: time
    };

    stompClient.send("/chat/"+$("#callNo").val(), {}, JSON.stringify(message));

}
function insertMessage(message) {
    $("#messages").append(message);
    $("#content").val("");
    $(".message:last").scrollTop($("#messages")[0].scrollHeight);
}

function appendMessage(message,sender,time) {


    if(sender==$("#sender").val()){
        var htmlContent = '<div class="d-flex mb-3 pb-1 message" style="justify-content: end;">' +
            '<div className="ms-auto" style="display: flex; align-items: flex-end;">' +
            '<div style="padding-right: 10px;">'+
            '<p class="text-end font-700 font-12 mb-0 pt-1">'+time+'</p>'+
            '</div>' +
            '<div class="bg-gray-light rounded-m p-2" style="border-bottom-right-radius:0px!important">' +
            '<p class="d-block p-1 px-2 color-black font-14">' +
            message +
            '</p>' +
            '</div>' +
            '</div>' +
            '</div>';
    } else {
        var htmlContent = '<div class="mb-3 pb-1 message"  style="justify-content: start;">' +
            '<div>'+
            sender +
            '</div>'+
            '<div style="display: flex; align-items: flex-end;">' +
            '<div class="gradient-green rounded-m p-2" style="border-bottom-left-radius:0px!important">' +
            '<p class="d-block p-1 ps-2 pe-3 color-white font-14">' +
            message +
            '</p>' +
            '</div>' +
            '<div style="padding-left: 10px;">'+
            '<p class="text-end font-700 font-12 mb-0 pt-1" style="padding-top: 10px;">'+time+'</p>'+
            '</div>' +
            '</div>' +
            '</div>';
    }
    insertMessage(htmlContent);
}

function capturePhoto() {
    var input = document.createElement('input');
    input.type = 'file';
    input.accept = 'image/*';

    input.addEventListener('change', function (event) {
        var file = event.target.files[0];
        var formData = new FormData();
        formData.append('photo', file);

        // 이미지를 서버로 업로드하고, 채팅 메시지로 전송하는 함수 호출
        uploadAndSendMessage(formData);
    });

    input.click();
}

function uploadAndSendMessage(formData) {
    // 서버로 이미지 업로드 요청을 보내는 코드
    $.ajax({
        url: '/community/json/upload', // 업로드를 처리할 서버 엔드포인트
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
            // 업로드 성공 시 채팅 메시지로 이미지 표시
            var imageUrl = response.imageUrl;
            var content = '<img src="' + imageUrl + '" alt="Photo">';
            insertMessage(content);
        },
        error: function (error) {
            console.error('Image upload failed:', error);
        }
    });
}