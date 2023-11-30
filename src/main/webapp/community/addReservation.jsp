<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
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
            padding: 100px;
        }
    </style>

    <script type="text/javascript">

        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-primary" ).on("click" , function() {
                fncAddReservationReq();
            });
        });

        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#']").on("click" , function() {
                $("form")[0].reset();
            });
        });

        function fncAddReservationReq(){
            $("form").attr("method" , "POST").attr("action" , "/community/addReservationReq").submit();
        }

    </script>
</head>
<body>
<div class="container">

    <h2 class="bg-default text-center">예약배차</h2><br/>
    <form class="form-horizontal" enctype="multipart/form-data">
        <div class="form-group">
            <input type="hidden" class="form-control" id="callCode" name="callCode" value="${call.callCode}">
            <input type="hidden" class="form-control" id="realPay" name="realPay" value="${call.realPay}">
            <input type="hidden" class="form-control" id="startAddr" name="startAddr" value="${call.startAddr}">
            <input type="hidden" class="form-control" id="startKeyword" name="startKeyword" value="${call.startKeyword}">
            <input type="hidden" class="form-control" id="startX" name="startX" value="${call.startX}">
            <input type="hidden" class="form-control" id="startY" name="startY" value="${call.startY}">
            <input type="hidden" class="form-control" id="endAddr" name="endAddr" value="${call.endAddr}">
            <input type="hidden" class="form-control" id="endKeyword" name="endKeyword" value="${call.endKeyword}">
            <input type="hidden" class="form-control" id="endX" name="endX" value="${call.endX}">
            <input type="hidden" class="form-control" id="endY" name="endY" value="${call.endY}">
        </div>

        <div class="form-group">
            <label for="callDate" class="col-sm-offset-1 col-sm-3 control-label">예약날짜</label>
            <div class="col-sm-4">
                <input type="date" class="form-control" id="callDate" name="callDate">
            </div>
        </div>

        <div class="form-group">
            <label for="callTime" class="col-sm-offset-1 col-sm-3 control-label">예약시간</label>
            <div class="col-sm-4">
                <input type="time" class="form-control" id="callTime" name="callTime">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="button" class="btn btn-primary"  >등&nbsp;록</button>
                <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
            </div>
        </div>

    </form>



</div>
</body>
</html>