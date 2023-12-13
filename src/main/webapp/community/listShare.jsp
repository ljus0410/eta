<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
    <title>합승 목록 조회</title>
    <meta charset="UTF-8">

    <!-- 참조 : http://getbootstrap.com/css/ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ///// Bootstrap, jQuery CDN ///// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
        }

    </style>

    <script>

        $(function() {
            // JavaScript에서 callNos 배열 사용 예시
            for (let i = 0; i < callNos.length; i++) {
                console.log(callNos[i]);
                $.ajax({
                    url: "/community/json/getShareall?callNo="+callNos[i],
                    type: "GET",
                    dataType: "json",
                    success: function (JSONData) {
                        var shareDateValue = JSONData.shareDate;
                        var shareDate = new Date(shareDateValue);
                        var currentDate = new Date();

                        if (currentDate > shareDate) {
                            let currentCallNo = callNos[i];
                            $.ajax({
                                url: "/community/json/deleteShareReq?callNo="+currentCallNo,
                                type: "GET",
                                dataType: "json",
                                success: function (JSONData) {
                                    console.log(JSONData)
                                    self.location="/community/getShareList"
                                }
                            })
                        }
                    }
                })
            }
        });

        $(function (){
            $("#chat").on("click", function () {
                alert(${user.shareCode});
                if(${user.shareCode}) {


                    $.ajax({
                        url: "/community/json/getShare",
                        type: "GET",
                        dataType: "json",
                        success: function (JSONData){
                            var shareDateValue = JSONData.shareDate;
                            var shareDate = new Date(shareDateValue);
                            var callNo = JSONData.callNo;
                            var currentDate = new Date();

                            var tenMinutesAgo = new Date(shareDate.getTime() - 10 * 60 * 1000);

                            if (currentDate > tenMinutesAgo && currentDate < shareDate) {
                                alert("dd")
                            } else if (currentDate < tenMinutesAgo ) {
                                alert("아직 시간이 되지 않았습니다.");
                            } else if (currentDate > shareDate) {
                                alert("시간이 지났습니다.");
                            }
                        }
                    })
                        .fail(function () {
                            alert("에러가 발생했습니다");
                        })
                } else {
                    alert("참여한 합승이 없습니다.")
                }
            })
        })

        function deleteShare() {
            self.location ="/community/deleteShareReq"
        }

        function openModal(callNo) {
            Swal.fire({
                title: '참여하기',
                input: 'text',
                inputPlaceholder: '참여인원수를 입력하세요', // 입력 필드에 표시되는 플레이스홀더
                showCancelButton: true,
                confirmButtonText: '확인',
                cancelButtonText: '취소',
            }).then((result) => {
                if (result.isConfirmed) {
                    // 확인 버튼이 눌렸을 때, 입력된 값에 대한 처리 수행
                    const inputValue = result.value;
                    // AJAX 요청 수행
                    sendDataToServer(inputValue, callNo, () => {
                        // AJAX 요청이 완료된 후에 페이지 reload
                        self.location ="/community/getShareList"
                    });
                }
            });
        }

        function sendDataToServer(inputValue, callNo, callback) {
            // AJAX 요청 설정
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '/community/json/addSharePassenger', true);
            xhr.setRequestHeader('Content-Type', 'application/json');

            const data = {
                firstShareCount: inputValue,
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
    </script>


</head>
<body>
<jsp:include page="/home/top.jsp" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
<div class="container">
    <div class="page-header text-info">
        <h3>합승목록조회</h3>
    </div>

    <div class="row">
        <div class="col-md-6 text-left">
            <p class="text-primary">
                전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
            </p>
        </div>

        <div class="col-md-6 text-right">
            <form class="form-inline" name="detailForm">
                <div class="form-group">
                    <select class="form-control" name="searchCondition">
                        <option value="0" ${ ! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>출발</option>
                        <option value="1" ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>도착</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="sr-only" for="searchKeyword">검색어</label>
                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어"
                           value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                </div>

                <button type="submit" class="btn btn-default">검색</button>

                <input type="hidden" id="currentPage" name="currentPage" value=""/>
            </form>
        </div>
    </div>

    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th align="center">No</th>
            <th align="center">No</th>
        </tr>
        </thead>

        <tbody>
        <script>
            // JSP에서 JavaScript로 데이터 전달
            var callNos = []; // callNo 값을 저장할 배열

            <c:forEach var="call" items="${callList}">
            callNos.push(${call.callNo}); // 배열에 callNo 값을 추가
            </c:forEach>
        </script>
        <c:forEach var="call" items="${callList}" varStatus="status">
            <tr>
                <td>
                    배차 번호 : ${call.callNo}<br/>
                    출발 : ${call.startAddr}<br/>
                    도착 : ${call.startAddr}<br/>

                    <!-- dealList에서 동일한 인덱스의 요소에 액세스 -->
                    <c:set var="share" value="${shareList[status.index]}"/>

                    <!-- dealList 정보 표시 -->
                    배차 번호 : ${share.firstSharePassengerNo}<br/>
                    제시 금액 : ${share.shareDate}<br/>
                </td>
                <td>
                    <c:if test="${user.userNo==share.firstSharePassengerNo}">
                        <button type="button" onclick="deleteShare()">
                            삭제 하기
                        </button>
                    </c:if>
                    <c:if test="${user.userNo!=share.firstSharePassengerNo}">
                        <button type="button" onclick="openModal(${call.callNo})">
                            제시 하기
                        </button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
    <button type="button" class="btn btn-primary" id="chat">채팅</button>
</div>

</body>
</html>
