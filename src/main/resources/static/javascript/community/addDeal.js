$(function (){

    //폼 제출
    $( "#dealSubmit" ).on("click" , function() {

        let preMoney = parseFloat($("#money").val()); // 문자열을 숫자로 변환
        let TPay = parseFloat($("#myMoney").val()); // 문자열을 숫자로 변환
        let offer = parseFloat($("#passengerOffer").val()); // 문자열을 숫자로 변환

        if (offer > TPay && offer > preMoney) {
            $('#dealTpayError').addClass('fade show');
            return;
        } else if (offer < preMoney && offer < TPay) {
            $('#dealAlert').addClass('fade show');
            return;
        } else if (offer > preMoney && offer < TPay) {
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
            $("#myMoney").val(receiveInt)
        }
    })
    
})
