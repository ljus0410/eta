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
            $("form").attr("method" , "POST").attr("action" , "/community/addShareReq").submit();
        }

    </script>
</head>
<body>
<div class="container">

    <h2 class="bg-default text-center">합승배차</h2><br/>
    <form class="form-horizontal" enctype="multipart/form-data">

        <div class="form-group">
            <div class="col-sm-4">
                <input type="hidden" class="form-control" id="callNo" name="callNo" value="${callNo}">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-4">
                <input type="hidden" class="form-control" id="firstSharePassengerNo" name="firstSharePassengerNo" value="${userNo}">
            </div>
        </div>

        <div class="form-group">
            <label for="firstShareCount" class="col-sm-offset-1 col-sm-3 control-label">최초 신청 인원수</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="firstShareCount" name="firstShareCount">
            </div>
        </div>

        <div class="form-group">
            <label for="startShareCount" class="col-sm-offset-1 col-sm-3 control-label">출발 최소 인원수</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="startShareCount" name="startShareCount">
            </div>
        </div>

        <div class="form-group">
            <label for="maxShareCount" class="col-sm-offset-1 col-sm-3 control-label">최대 탑승 인원수</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="maxShareCount" name="maxShareCount" value="${maxShareCount}" readonly>
            </div>
        </div>

        <div class="form-group">
            <label for="shareDate" class="col-sm-offset-1 col-sm-3 control-label">출발 시간</label>
            <div class="col-sm-4">
                <input type="time" class="form-control" id="shareDate" name="shareDate">
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