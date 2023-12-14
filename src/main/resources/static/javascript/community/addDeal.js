$(function() {

    $("a[href='#']").on("click" , function() {
        $("form")[0].reset();
    });

});

$(function (){

    $( "#submitbt" ).on("click" , function() {

        let preMoney = parseFloat($("#money").val()); // 문자열을 숫자로 변환
        let TPay = parseFloat($("#myMoney").val()); // 문자열을 숫자로 변환
        let offer = parseFloat($("#passengerOffer").val()); // 문자열을 숫자로 변환

        if (offer > TPay && offer > preMoney) {
            $('#notification-bar-5').removeClass('notification-bar glass-effect detached rounded-s shadow-l')
                .addClass('notification-bar glass-effect detached rounded-s shadow-l fade show');
            return;
        } else if (offer < preMoney && offer < TPay) {
            $('#toast-top-2').removeClass('toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s')
                .addClass('toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s fade show');
            return;
        } else if (offer > preMoney && offer < TPay) {
            $("form").attr("method" , "POST").attr("action" , "/community/addDealReq").submit();
        }
    })
})

$(function () {
    $.ajax({
        url: "/community/json/getMyMoney",
        type: "GET",
        dataType: "json",
        success: function (response){
            console.log(response)
            var receivedInt = parseInt(response);
            $("#myMoney").val(receivedInt)
        }
    })
})

function payRequest(){

    var userInput = prompt("충전할 금액을 입력하세요 :");

    if(userInput !== null && userInput < 10000){
        alert("10000원 이상 충전이 가능합니다.");
        payRequest();

    } else if (userInput !== null && userInput >= 10000) {

        TpayCharge(userInput);

    } else {
        alert("충전이 취소되었습니다.");
    }

}
function TpayCharge(Tpay) {

    var IMP = window.IMP;
    IMP.init("imp16061541");

    var No = document.getElementById('userNo');
    var userNo = No.value;
    var name = document.getElementById('name');
    var userName = name.value;
    var phone = document.getElementById('phone');
    var userPhone = phone.value;
    var email = document.getElementById('email');
    var userEmail = email.value;

    //alert(userNo, userName, userPhone, userEmail);

    // IMP.request_pay(param, callback) 결제창 호출
    IMP.request_pay({ // param
        pg : 'html5_inicis',
        pay_method : 'card',
        merchant_uid: "merchant_" + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
        name : 'Tpay 충전',
        amount : Tpay,
        buyer_name : userName,
        buyer_email : userEmail,
        buyer_tel : userPhone,  //필수입력
        //buyer_postcode : '123-456',
        //m_redirect_url : '{/purchase/addPurchase.jsp}' // 예: https://www.my-service.com/payments/complete/mobile
    }, function (rsp) { // callback
        if (rsp.success) {
            alert(Tpay+"원 충전이 완료되었습니다.");
            addCharge(Tpay, userNo);

        } else {
            alert("충전이 실패하였습니다.");
        }
    });
}

function addCharge(Tpay, userNo){
    $.ajax({
        type: 'POST',
        url: '/pay/json/addCharge',
        data: {
            Tpay: Tpay,
            userNo: userNo
        },
        success: function (response) {
            console.log("addCharge() 성공");
            if (response.success) {
                alert(response.message);
                $.ajax({
                    url: "/community/json/getMyMoney",
                    type: "GET",
                    dataType: "json",
                    success: function (response){
                        console.log(response)
                        var receivedInt = parseInt(response);
                        $("#myMoney").val(receivedInt)
                    }
                })
            } else {
                alert(response.message);
            }
        },
        error: function (error) {
            console.error('addCharge() 실패', error);
        }
    });

}