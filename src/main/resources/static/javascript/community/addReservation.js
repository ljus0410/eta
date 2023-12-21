$(function() {

    //폼 제출
    $( "#reservationSubmit" ).on("click" , function() {
        let callDate =$("#resDate").val()+' '+$("#resTime").val()+":00"
        $("#callDate").val(callDate);

        let confirmDate = new Date(callDate);
        let now = new Date();

        if (confirmDate < now || $("#resTime").val() == "") {
            $('#reservationAlert').addClass('fade show');
        } else {
            $("form").attr("method" , "POST").attr("action" , "/community/addReservationReq").submit();
        }
    });

    //리셋
    $("a[href='#']").on("click" , function() {
        $("form")[0].reset();
    });

    //당일 이후만 날짜 선택 가능
    let today = new Date();

    let yyyy = today.getFullYear();
    let mm = String(today.getMonth() + 1).padStart(2, '0');
    let dd = String(today.getDate()).padStart(2, '0');
    let formattedDate = yyyy + '-' + mm + '-' + dd;

    $("#resDate").attr("min", formattedDate);

});