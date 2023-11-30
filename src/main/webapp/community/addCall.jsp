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
            $( "#callbt" ).on("click" , function() {
                if(${callCode=='N'}){
                } else if (${callCode=='R'}) {
                    $("form").attr("method" , "POST").attr("action" , "/community/addReservation").submit();
                } else if (${callCode=='D'}) {
                    $("form").attr("method" , "POST").attr("action" , "/community/addDeal").submit();
                } else if (${callCode=='S'}) {
                    $("form").attr("method" , "POST").attr("action" , "/community/addShare").submit();
                }
            });
        });

        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#']").on("click" , function() {
                $("form")[0].reset();
            });
        });


    </script>
</head>
<body>
<div class="container">

    <h2 class="bg-default text-center">배차</h2><br/>
    ${callCode}
    <hr/>
    <form class="form-horizontal" enctype="multipart/form-data">

        <input type="hidden" class="form-control" id="callCode" name="callCode" value="${callCode}">

        <div class="form-group">
            <label for="userNo" class="col-sm-offset-1 col-sm-3 control-label">userNo</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="userNo" name="userNo">
            </div>
        </div>

        <div class="form-group">
            <label for="startAddr" class="col-sm-offset-1 col-sm-3 control-label">출발 도로명 주소</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="startAddr" name="startAddr">
            </div>
        </div>

        <div class="form-group">
            <label for="startKeyword" class="col-sm-offset-1 col-sm-3 control-label">출발 검색 키워드</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="startKeyword" name="startKeyword">
            </div>
        </div>

        <div class="form-group">
            <label for="startX" class="col-sm-offset-1 col-sm-3 control-label">출발 경도</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="startX" name="startX">
            </div>
        </div>

        <div class="form-group">
            <label for="startY" class="col-sm-offset-1 col-sm-3 control-label">출발 위도</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="startY" name="startY">
            </div>
        </div>

        <div class="form-group">
            <label for="endAddr" class="col-sm-offset-1 col-sm-3 control-label">도착 도로명 주소</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="endAddr" name="endAddr">
            </div>
        </div>

        <div class="form-group">
            <label for="endKeyword" class="col-sm-offset-1 col-sm-3 control-label">도착 검색 키워드</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="endKeyword" name="endKeyword">
            </div>
        </div>

        <div class="form-group">
            <label for="endX" class="col-sm-offset-1 col-sm-3 control-label">도착 경도</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="endX" name="endX">
            </div>
        </div>

        <div class="form-group">
            <label for="endY" class="col-sm-offset-1 col-sm-3 control-label">도착 위도</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="endY" name="endY">
            </div>
        </div>

        <div class="form-group">
            <label for="carOpt" class="col-sm-offset-1 col-sm-3 control-label">차량옵션</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="carOpt" name="carOpt">
            </div>
        </div>

        <div class="form-group">
            <label for="realPay" class="col-sm-offset-1 col-sm-3 control-label">금액</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="realPay" name="realPay">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="button" class="btn btn-primary" id="callbt">등&nbsp;록</button>
                <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
            </div>
        </div>
    </form>



</div>
</body>
</html>