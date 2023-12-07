<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>addReservation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ///// Bootstrap, jQuery CDN ///// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
        @font-face {
            font-family: 'NanumSquare';
            src: url('https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css');
            font-weight: normal;
            font-style: normal;
        }

        body {
            font-family: NanumSquare;
            font-weight:300;
            padding-top: 100px;
        }
    </style>

    <script type="text/javascript">

        $(function() {

            $( "button.btn.btn-primary" ).on("click" , function() {
                let callDate =$("#resdate").val()+' '+$("#restime").val()+":00"
                $("#callDate").val(callDate);

                let confirmDate = new Date(callDate);
                let now = new Date();

                if (confirmDate < now) {
                    alert("출발 날짜와 시간을 확인해주세요");
                } else {
                    /* $("form").attr("method" , "POST").attr("action" , "/community/addReservationReq").submit(); */
                    alert("배차 탐색 화면으로 이동")
                }

            });

            $("a[href='#']").on("click" , function() {
                $("form")[0].reset();
            });
        });

        $(function() {
            var today = new Date();

            var yyyy = today.getFullYear();
            var mm = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 패딩합니다.
            var dd = String(today.getDate()).padStart(2, '0'); // 일도 두 자리로 패딩합니다.
            var formattedDate = yyyy + '-' + mm + '-' + dd;

            $("#resdate").attr("min", formattedDate);
        })
    </script>

</head>

<body>
<div class="container">

    <h2 class="bg-default text-center">예약배차</h2><br/>

    <form class="form-horizontal">

        <div class="form-group">
            <input type="hidden" class="form-control" id="callCode" name="callCode" value="${call.callCode}">
            <input type="hidden" class="form-control" id="routeOpt" name="routeOpt" value="${call.routeOpt}">
            <input type="hidden" class="form-control" id="realPay" name="realPay" value="${call.realPay}">
            <input type="hidden" class="form-control" id="startAddr" name="startAddr" value="${call.startAddr}">
            <input type="hidden" class="form-control" id="startKeyword" name="startKeyword" value="${call.startKeyword}">
            <input type="hidden" class="form-control" id="startX" name="startX" value="${call.startX}">
            <input type="hidden" class="form-control" id="startY" name="startY" value="${call.startY}">
            <input type="hidden" class="form-control" id="endAddr" name="endAddr" value="${call.endAddr}">
            <input type="hidden" class="form-control" id="endKeyword" name="endKeyword" value="${call.endKeyword}">
            <input type="hidden" class="form-control" id="endX" name="endX" value="${call.endX}">
            <input type="hidden" class="form-control" id="endY" name="endY" value="${call.endY}">
            <input type="hidden" class="form-control" id="callDate" name="callDate">
            <input type="hidden" class="form-control" id="carOpt" name="carOpt" value="${call.carOpt}">
            <input type="hidden" class="form-control" id="petOpt" name="petOpt" value="${call.petOpt}">
        </div>

        <hr/>
        <div class="form-group">
            <div class="col-xs-12">
                <label for="resdate" class="control-label">예약 날짜</label>
                <input type="date" class="form-control" id="resdate" name="resdate">
            </div>
        </div>

        <hr/>

        <div class="form-group">
            <div class="col-xs-12">
                <label for="restime" class="control-label">예약 시간</label>
                <input type="time" class="form-control" id="restime" name="restime">
            </div>
        </div>

        <hr/>

        <div class="form-group">
            <div class="col-xs-12 text-center">
                <button type="button" class="btn btn-primary"  >등&nbsp;록</button>
                <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
            </div>
        </div>

    </form>



</div>
</body>

</html>