<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>addDeal</title>
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

            $("a[href='#']").on("click" , function() {
                $("form")[0].reset();
            });
        });

    </script>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
<script>

    $(function (){

        $( "button.btn.btn-primary" ).on("click" , function() {

            let preMoney = parseFloat($("#money").val()); // 문자열을 숫자로 변환
            let TPay = parseFloat($("#myMoney").val()); // 문자열을 숫자로 변환
            let offer = parseFloat($("#passengerOffer").val()); // 문자열을 숫자로 변환

            console.log(preMoney);
            console.log(TPay);
            console.log(offer);

            if (offer > TPay && offer > preMoney) {
                Swal.fire({
                    title: '알림',
                    text: '잔여 TPay가 부족합니다.',
                    icon: 'info',
                    showCancelButton: true,
                    confirmButtonText: '충전',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '/pay/addCharge';
                    }
                });
                return;
            } else if (offer < preMoney && offer < TPay) {
                alert("금액이 잘못 입력되었습니다.\n선결제 금액을 확인해주세요");
                return;
            } else if (offer > preMoney && offer < TPay) {
                $("form").attr("method" , "POST").attr("action" , "/community/addDealReq").submit();
            }
        })
    })
</script>
<div class="container">

    <h2 class="bg-default text-center">딜배차</h2><br/>
    <form class="form-horizontal" enctype="multipart/form-data">

        <div class="form-group">
            <div class="col-sm-4">
                <input type="hidden" class="form-control" id="callNo" name="callNo" value="${callNo}">
            </div>
        </div>

        <div class="form-group">
            <label for="money" class="col-sm-offset-1 col-sm-3 control-label">선결제 금액</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="money" name="money" value="${money}" readonly>
            </div>
        </div>

        <div class="form-group">
            <label for="myMoney" class="col-sm-offset-1 col-sm-3 control-label">잔여 Tpay</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="myMoney" name="myMoney" value="${myMoney}" readonly>
            </div>
        </div>

        <div class="form-group">
            <label for="passengerOffer" class="col-sm-offset-1 col-sm-3 control-label">제시금액</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="passengerOffer" name="passengerOffer">
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