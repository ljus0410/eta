$(function() {

    //폼 제출
    $( "#submitbt" ).on("click" , function() {
        let callDate =$("#resdate").val()+' '+$("#restime").val()+":00"
        $("#callDate").val(callDate);

        let confirmDate = new Date(callDate);
        let now = new Date();

        if (confirmDate < now) {
            $('#toast-top-2').removeClass('toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s')
                .addClass('toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s fade show');
        } else {
            $("form").attr("method" , "POST").attr("action" , "/community/addReservationReq").submit();
        }
    });

    //리셋
    $("a[href='#']").on("click" , function() {
        $("form")[0].reset();
    });

});

//날짜선택 당일 이후만 가능하게하는 로직
$(function() {
    var today = new Date();

    var yyyy = today.getFullYear();
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var dd = String(today.getDate()).padStart(2, '0');
    var formattedDate = yyyy + '-' + mm + '-' + dd;

    $("#resdate").attr("min", formattedDate);
})