<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
    <title>딜 목록 조회</title>
    <meta charset="UTF-8">

    <!-- 참조 : http://getbootstrap.com/css/ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ///// Bootstrap, jQuery CDN ///// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">

    <style>

        @font-face {
            font-family: 'NanumSquare';
            src: url('https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css');
            font-weight: normal;
            font-style: normal;
        }

        body {
            font-family: NanumSquare;
            font-weight:250;
        }

        .deal-list {
            max-height: 450px;
            overflow-y: auto;
        }

    </style>

    <script>

        // 모달 열기 함수
        function openModal(callNo, passengerOffer) {
            Swal.fire({
                title: '제시하기',
                input: 'text',
                inputPlaceholder: '제시금액을 입력하세요', // 입력 필드에 표시되는 플레이스홀더
                showCancelButton: true,
                confirmButtonText: '확인',
                cancelButtonText: '취소',
            }).then((result) => {
                if (result.isConfirmed) {
                    // 확인 버튼이 눌렸을 때, 입력된 값에 대한 처리 수행
                    const inputValue = result.value;
                    // AJAX 요청 수행
                    if (parseFloat(inputValue) > parseFloat(passengerOffer)) {
                        Swal.fire({
                            title: '알림',
                            text: '입력된 금액이 제시 금액을 초과합니다.',
                            icon: 'info',
                            confirmButtonText: '확인'
                        });
                    } else {
                        // AJAX 요청 수행
                        sendDataToServer(inputValue, callNo, () => {
                            // AJAX 요청이 완료된 후에 페이지 reload
                            self.location = "/community/getDealList";
                        });
                    }
                }
            });
        }



        function sendDataToServer(inputValue, callNo, callback) {
            // AJAX 요청 설정
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '/community/json/addDealDriver', true);
            xhr.setRequestHeader('Content-Type', 'application/json');

            const data = {
                    driverOffer: inputValue,
                    callNo: callNo
            };

            // AJAX 요청 수행
            xhr.onload = function () {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    console.log(response);
                    if (callback) {
                        callback();
                    }
                } else {
                    console.error('서버에 데이터 전송 실패');
                }
            };

            xhr.send(JSON.stringify(data));
        }

        function deleteDealDriver(){
            Swal.fire({
                title: '택시비 딜 참여를 취소하시겠습니까?',
                showCancelButton: true,
                confirmButtonText: '확인',
                cancelButtonText: '취소',
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "/community/json/deleteDealReq",
                        type: "GET",
                        dataType: "json",
                        success: function (response){
                            console.log(response); // 콘솔에 출력

                            location.reload();
                        }
                    })
                }
            });

        }
        $(function (){
            $(".reqbt").on("click", function (){
                // 현재 클릭한 버튼의 부모 행(tr)을 찾아서
                var row = $(this).closest('tr');

                // 부모 행에서 배차 번호와 제시 금액을 가져오기
                var callNo = row.find('.callNo').text();
                var passengerOffer = row.find('.passengerOffer').text();

                if (${user.dealCode}) {
                    alert("이미 다른 딜 배차에 참여 중 입니다.");
                } else {
                    openModal(callNo, passengerOffer);
                }
            });
        });


    </script>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>

<div class="container">
    <div class="page-header text-info">
        <h3>딜 목록 조회</h3>
    </div>

    <div class="row">
        <div class="col-md-6 text-left">
            <p class="text-primary">
                전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
            </p>
        </div>
    </div>
    <div class="deal-list">
    <table class="table table-hover">
        <thead>
        <tr>
            <th align="center"></th>
            <th align="center"></th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="call" items="${callList}" varStatus="status">
            <tr>
                <td class="align-items-center col-xs-10">
                    배차 번호 : ${call.callNo}<br/>
                    출발 : ${call.startAddr}<br/>
                    도착 : ${call.endAddr}<br/>

                    <!-- dealList에서 동일한 인덱스의 요소에 액세스 -->
                    <c:set var="deal" value="${dealList[status.index]}"/>

                    <!-- dealList 정보 표시 -->
                    배차 번호 : <span class="callNo">${deal.callNo}</span><br/>
                    제시 금액 : <span class="passengerOffer">${deal.passengerOffer}</span><br/>
                </td>
                <td class="align-items-center col-xs-2">
                    <c:if test="${deal.callNo==callNo}">
                        <button type="button" onclick="deleteDealDriver()" class="delbt btn btn-sm">
                            삭제
                        </button>
                    </c:if>
                    <c:if test="${deal.callNo!=callNo || callNo==null}">
                        <button type="button" class="reqbt btn btn-sm">
                            제시
                        </button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
</div>
</div>

</body>
</html>
