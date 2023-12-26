$(function (){

    $("#passengerOffer").on("keyup", function (){
        let value = $("#passengerOffer").val();

        let offer = parseFloat(value.replace(/,/g, ''));
        let numberWithCommas = Math.floor(offer).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');

         $("#passengerOffer").val(numberWithCommas);
    })

    //폼 제출
    $( "#dealSubmit" ).on("click" , function() {

        let preMoney = parseFloat($("#money").val().replace(/,/g, '')); // 문자열을 숫자로 변환
        let TPay = parseFloat($("#myMoney").val().replace(/,/g, '')); // 문자열을 숫자로 변환
        let offer = parseFloat($("#passengerOffer").val().replace(/,/g, ''));

        if (offer > TPay && offer > preMoney) {
            $('#dealTpayError').addClass('fade show');
        } else if (offer < preMoney && offer < TPay) {

            let message = '<strong class="font-12 mb-n2">금액이 잘못 입력되었습니다.</strong>\n' +
                '<span class="font-10 mt-n1 opacity-70">선결제 금액을 확인해주세요</span>'
            $("#messageAlert").html("");
            $("#messageAlert").html(message);
            $('#dealAlert').addClass('fade show');

        } else if (offer > preMoney && offer < TPay) {
            $("#money").val($("#money").val().replace(/,/g, ''));
            $("#myMoney").val($("#myMoney").val().replace(/,/g, ''));
            $("#passengerOffer").val($("#passengerOffer").val().replace(/,/g, ''));
            $("form").attr("method" , "POST").attr("action" , "/community/addDealReq").submit();
        }
    })

    //리셋
    $("a[href='#']").on("click" , function() {
        $("form")[0].reset();
    });

    //잔여 Tpay
    $.ajax({
        url: "/community/json/getMyMoney",
        type: "GET",
        dataType: "json",
        success: function (response){
            let receiveInt = parseInt(response);
            let myMoney = Math.floor(receiveInt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            $("#myMoney").val(myMoney)
        }
    })
    
    $.ajax({
      url:"/community/json/getDeal",
      type: "GET",
      dataType: "json",
      success: function (response){
          let callNo = response.callNo;
          $("#callNo").val(callNo);
          let money = Math.floor(response.realPay).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
          $("#money").val(money)
      }
    })

})

function payRequest(){
    var message = '충전할 금액을 입력하세요';
    $("#dealTpayError").removeClass("fade show")

    $("#alertMessage").text(message);

    setTimeout(() => {
        $("#chargeAlert").addClass("fade show");
    }, 500);


    $("#payOk").on("click", function (){
        let money = $("#moneyInput").val();
        if(money !== null && money < 10000){
            var message = '10,000원 이상 충전 가능합니다';
            messageAlert(message);
        } else if (money !== null && money >= 10000) {
            TpayCharge(money);
        }
    })
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
        // pg : 'html5_inicis',
        pg: 'kakaopay',
        pay_method: 'card',
        merchant_uid: "merchant_" + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
        name: 'Tpay 충전',
        amount: Tpay,
        buyer_name: userName,
        buyer_email: userEmail,
        buyer_tel: userPhone  //필수입력
        //buyer_postcode : '123-456',
        //m_redirect_url : 'https://eta.pe.kr/pay/json/addChargeMobile'
    }, function (rsp) { // callback
        if (rsp.success) {

            var message = Tpay + '원 충전이 완료되었습니다';

            let result = '<div className="align-self-center">'+
                                '<i className="icon icon-s bg-green-light rounded-l bi bi-check font-28 me-2"></i>'+
                                '</div>'+
                                '<div className="align-self-center ps-1">'+
                                    '<span className="font-10 mt-n1 opacity-70">'+message+'</span>'+
                                '</div>'+
                                '<div className="align-self-center ms-auto">'+
                                '<button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>'+
                                '</div>'
            $("#dealAlert").html("");
            $("#dealAlert").html(result);

            addCharge(Tpay, userNo);

        } else {
            var message = '충전이 실패하였습니다';
            messageAlert(message);

        }
    });
}

function messageAlert(message) {

    let result = '<span class="font-11 mt-n1 opacity-70">'+message+'</span>'
    $("#messageAlert").html("");
    $("#messageAlert").html(result);

    $('#dealAlert').addClass('fade show');
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
                messageAlert(response.message);
                location.reload();
            } else {
                messageAlert(response.message);
            }
        },
        error: function (error) {
            console.error('addCharge() 실패', error);
        }
    });

}
