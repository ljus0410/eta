<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
    <title>상품목록</title>
    <meta charset="UTF-8">

    <!-- 참조 : http://getbootstrap.com/css/ -->
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

        var loading = false; // 요청 중인지 확인하는 변수
        var currentPage = 1; // 현재 페이지 번호
        var threshold = 100; // 스크롤 이벤트가 발생하는 임계값(px)

        $(function() {
            // Ajax 요청
            $.ajax({
                url: "/product/json/listProduct",
                method: "POST",
                data: { currentPage : currentPage }, // 서버로 전달할 데이터
                dataType: "json",
                success: function(data) {
                    if (data.length > 0) {
                        $.each(data, function(index, item) {
                            var newRow = '<tr>' +
                                '<td align="center">' + (index+1) + '<input type="hidden" name="prodNo" value="' + item.prodNo + '"></td>' +
                                '<td align="left" style="width: 100px"><img src="/images/uploadFiles/' + item.fileName + '" style="height: 100px;display: block; margin: 0 auto;"></td>' +
                                '<td align="left">' + item.prodName + '</td>' +
                                '<td align="left">' + item.price + '</td>' +
                                '<td align="left">' + item.prodCount + '</td>' +
                                '<td align="left">';

                            if (item.prodCount != '0') {
                                newRow += '판매중';
                            } else if (item.proTranCode == '0') {
                                if (user.role == 'user') {
                                    newRow += '재고없음';
                                } else if (user.role == 'admin') {
                                    newRow += item.proTranCode;
                                }
                                if (item.proTranCode == '구매완료') {
                                    if (user.role == 'admin') {
                                        newRow += '<a href="/purchase/updateTranCodeByProd?prodNo=' + item.prodNo + '&proTranCode=' + item.proTranCode + '">배송하기</a>';
                                    }
                                }
                            }

                            newRow += '</td>' +
                                '<input type="hidden" name="' + item.prodName + '" value="' + item.prodNo + '">' +
                                '</tr>';

                            // 새로운 행을 테이블에 추가
                            $('table tbody').append(newRow);
                        });
                    }
                }
            });

        });



        $(window).scroll(function() {
            // 스크롤 위치 확인
            var scrollPosition = $(window).scrollTop() + $(window).height();

            // 스크롤 위치가 임계값에 도달하고 요청 중이 아닐 때 데이터를 요청
            if (scrollPosition >= $(document).height() - threshold && !loading) {
                loading = true;
                currentPage++;

                // Ajax 요청
                $.ajax({
                    url: "/product/json/listProduct",
                    method: "POST",
                    data: { currentPage: currentPage }, // 서버로 전달할 데이터
                    dataType: "json",
                    success: function(data) {
                        loading = false;
                        if (data.length > 0) {
                            $.each(data, function(index, item) {
                                var newRow = '<tr>' +
                                    '<td align="center">' + (index+1+(currentPage-1)*5) + '<input type="hidden" name="prodNo" value="' + item.prodNo + '"></td>' +
                                    '<td align="left" style="width: 100px"><img src="/images/uploadFiles/' + item.fileName + '" style="height: 100px;display: block; margin: 0 auto;"></td>' +
                                    '<td align="left">' + item.prodName + '</td>' +
                                    '<td align="left">' + item.price + '</td>' +
                                    '<td align="left">' + item.prodCount + '</td>' +
                                    '<td align="left">';

                                if (item.prodCount != '0') {
                                    newRow += '판매중';
                                } else if (item.proTranCode == '0') {
                                    if (user.role == 'user') {
                                        newRow += '재고없음';
                                    } else if (user.role == 'admin') {
                                        newRow += item.proTranCode;
                                    }
                                    if (item.proTranCode == '구매완료') {
                                        if (user.role == 'admin') {
                                            newRow += '<a href="/purchase/updateTranCodeByProd?prodNo=' + item.prodNo + '&proTranCode=' + item.proTranCode + '">배송하기</a>';
                                        }
                                    }
                                }

                                newRow += '</td>' +
                                    '<input type="hidden" name="' + item.prodName + '" value="' + item.prodNo + '">' +
                                    '</tr>';

                                // 새로운 행을 테이블에 추가
                                $('table tbody').append(newRow);
                            });
                        }
                    },
                    error: function(error) {
                        loading = false;
                        console.error("데이터를 가져오는 중 오류가 발생했습니다.");
                    }
                });
            }
        });

        $(function() {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "td:nth-child(3)" ).on("click" , function() {
                if(${user.role=='admin'}) {
                    self.location ="/product/updateProduct?prodNo="+$("input:hidden[name='"+$(this).html()+"']").val()
                }else {
                    self.location ="/product/getProduct?prodNo="+$("input:hidden[name='"+$(this).html()+"']").val()
                }

            });
        });

    </script>
</head>
<body>

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
            <th align="left">출발</th>
            <th align="left">도착</th>
        </tr>
        </thead>

        <tbody>
        <c:set var="i" value="0"/>
        <c:forEach var="call" items="${list}">
            <c:set var="i" value="${i+1}"/>
            <tr>
                <td align="center">${ i }<input type="hidden" name="prodNo" value="${call.callNo}"></td>
                <td align="left">${call.startAddr}</td>
                <td align="left">${call.endAddr}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
