const socket = new SockJS('/ws');
const stompClient = Stomp.over(socket);

stompClient.connect({}, function (frame) {

    stompClient.subscribe('/topic/deal/' + $("#userNo").val(), function (response) {
        const messages = JSON.parse(response.body);

        appendDeal(messages.callNo, messages.content);
    });
});

function appendDeal(callNo, message) {
    let htmlContent =
    '<div id="acceptDeal" class="notification-bar glass-effect detached rounded-s shadow-l fade show" data-bs-delay="15000">' +
        '<div class="toast-body px-3 py-3">' +
            '<div class="d-flex">' +
                '<div class="align-self-center">' +
                    '<span class="icon icon-xxs rounded-xs bg-fade-red scale-box"><i class="bi bi-exclamation-triangle color-red-dark font-16"></i></span>' +
                '</div>' +
                '<div class="align-self-center">' +
                    '<h5 class="font-16 ps-2 ms-1 mb-0">' + message + '</h5>' +
                '</div>' +
            '</div>' +
            '<p class="font-12 pt-2 mb-3"></p>' +
            '<div class="row">' +
                '<div class="col-6">' +
                    '<a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border border-fade-red color-red-dark" aria-label="Close">취소</a>' +
                '</div>' +
                '<div class="col-6">' +
                    '<a href="#" data-bs-dismiss="toast" class="btn btn-s text-uppercase rounded-xs font-11 font-700 btn-full btn-border bg-red-dark color-red-dark" aria-label="Close"  onclick="start('+callNo+')">확인</a>' +
                '</div>' +
            '</div>' +
        '</div>' +
    '</div>'

    $("#here").append(htmlContent);
}

$(function (){

    $(".offerButton").on("click", function (){
        // 현재 클릭한 버튼의 부모 행(tr)을 찾아서
        let row = $(this).closest('div.card');
        // 부모 행에서 배차 번호와 제시 금액을 가져오기
        let callNo = row.find('.callNo').text().trim();
        let passengerOffer = row.find('.passengerOffer').text().trim();
        let currentDate = new Date();
        let limitDate = new Date(row.find('#limitDate').text());

        let dealCode = $("#dealCode").val();

        if (currentDate > limitDate) {
            $('#timeOver').addClass('fade show');
        } else {
            if (dealCode=="true") {
                $('#alreadyDealAlert').addClass('fade show');
            } else {
                $('#offerAlert').addClass('fade show');
                $("#reqButton").off("click").on("click", function () {
                    $("form")[0].reset();
                    let driverOffer = parseFloat($("#driverOffer").val());

                    if (driverOffer > passengerOffer) {
                        $('#dealOfferError').addClass('fade show');
                        return;
                    } else if(driverOffer < passengerOffer) {
                        sendDataToServer(driverOffer, callNo, () => {
                            self.location = "/community/getDealList";
                        });
                    }
                })
            }
        }
    });

});

function sendDataToServer(driverOffer, callNo, callback) {
    // AJAX 요청 설정
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/community/json/addDealDriver', true);
    xhr.setRequestHeader('Content-Type', 'application/json');

    const data = {
        driverOffer: driverOffer,
        callNo: callNo
    };

    // AJAX 요청 수행
    xhr.onload = function () {
        if (xhr.status === 200) {
            const response = JSON.parse(xhr.responseText);
            console.log(response);
            if (callback) {
                callback();
            }
        } else {
            console.error('서버에 데이터 전송 실패');
        }
    };

    xhr.send(JSON.stringify(data));
}

function deleteDealDriver(){
    $("#deleteDealAlert").addClass('fade show');
    $("#deleteDeal").on("click", function() {
        $.ajax({
            url: "/community/json/deleteDealReq",
            type: "GET",
            dataType: "json",
            success: function (response){
                console.log(response); // 콘솔에 출력

                location.reload();
            }
        })
    })

}

function start(callNo) {
    let userNo = $("#userNo").val();

    const data = {
        callNo: callNo,
        userNo: userNo
    };
    $.ajax({
        url: "/community/json/deleteDealOther",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        data: JSON.stringify(data),
        success: function (response){
            alert("여기")
            self.location="/callres/callAccept?callNo=" + callNo;
        }
    })

}