$(function (){

    //폼 제출
    $( "#shareButton" ).on("click" , function() {


        let userInputTime = $("#shareTime").val();
        let userInputHours = parseInt(userInputTime.split(":")[0]);
        let userInputMinutes = parseInt(userInputTime.split(":")[1]);

        let currentTime = new Date();
        let currentHours = currentTime.getHours();
        let currentMinutes = currentTime.getMinutes();

        if (userInputHours < currentHours || (userInputHours === currentHours && userInputMinutes <= currentMinutes)) {

            currentTime.setDate(currentTime.getDate() + 1);
            userInputTime = currentTime.toISOString().split("T")[0] + " " + userInputTime+":00";
            $("#shareDate").val(userInputTime);
        } else {
            userInputTime = currentTime.toISOString().split("T")[0] + " " + userInputTime+":00";
            $("#shareDate").val(userInputTime);
        }

        let firstShareCount=parseFloat($("#firstShareCount").val());
        let startShareCount=parseFloat($("#startShareCount").val());
        let maxShareCount=parseFloat($("#maxShareCount").val());

        if (firstShareCount > startShareCount) {
            $('#firstError').addClass('fade show');
            return;
        } else if (firstShareCount > maxShareCount) {
            $('#startError').addClass('fade show');
            return;
        } else if (startShareCount > maxShareCount){
            $('#maxError').addClass('fade show');
            return;
        } else if (firstShareCount <= startShareCount && firstShareCount < maxShareCount && startShareCount <= maxShareCount) {
            $("form").attr("method" , "POST").attr("action" , "/community/addShareReq").submit();

        }
    })

    //취소
    $("a[href='#']").on("click" , function() {
        $("form")[0].reset();
    });
})