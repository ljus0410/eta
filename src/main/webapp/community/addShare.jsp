<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>eTa</title>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>

    <script src="/javascript/community/addShare.js"></script>

</head>

<body class="theme-light">

<div id="page">

    <jsp:include page="../home/top.jsp" />

    <div class="page-content header-clear-medium">

        <div class="card card-style">

            <div class="content">

                <form class="demo-animation needs-validation m-0" novalidate>

                    <input type="hidden" class="form-control" id="callNo" name="callNo" value="${callNo}">

                    <div class="form-custom form-label form-icon mb-3">
                        <i class="bi bi-credit-card font-12"></i>
                        <input type="text" class="form-control rounded-xs" id="firstShareCount"  name="firstShareCount"/>
                        <label for="firstShareCount" class="form-label-always-active color-theme">최초 신청 인원수</label>
                    </div>

                    <div class="form-custom form-label form-icon mb-3">
                        <i class="bi bi-currency-dollar font-12"></i>
                        <input type="text" class="form-control rounded-xs" id="startShareCount"  name="startShareCount"/>
                        <label for="startShareCount" class="form-label-always-active color-theme">출발 최소 인원수</label>
                    </div>

                    <div class="form-custom form-label form-icon mb-3">
                        <i class="bi bi-cash font-12"></i>
                        <input type="text" class="form-control rounded-xs" id="maxShareCount"  name="maxShareCount" value="${maxShareCount}" readonly/>
                        <label for="maxShareCount" class="form-label-always-active color-theme">최대 탑승 인원수</label>
                    </div>

                    <div class="form-custom form-label form-icon mb-3">
                        <i class="bi bi-cash font-12"></i>
                        <input type="time" class="form-control rounded-xs" id="shareTime"  name="shareTime"/>
                        <label for="shareTime" class="form-label-always-active color-theme">출발 시간</label>
                    </div>

                    <input type="hidden" class="form-control rounded-xs" id="shareDate"  name="shareDate"/>

                    <button class="btn btn-full bg-blue-dark rounded-xs text-uppercase font-700 w-100 btn-s mt-4" type="submit" id="shareButton">합승</button>

                </form>

            </div><!-- content -->

        </div><!-- card card-style -->

    </div><!-- page-content header-clear-medium -->

    <!--Warning Toast Bar-->
    <div id="firstError" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-10 mt-n1 opacity-70">출발 최소 인원수는 최초 신청 인원수 이상이어야 합니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->
    <!--Warning Toast Bar-->
    <div id="startError" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-10 mt-n1 opacity-70">최초 신청 인원수는 최대 탑승 인원수 이하여야 합니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->
    <!--Warning Toast Bar-->
    <div id="maxError" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-10 mt-n1 opacity-70">출발 최소 인원수는 최대 탑승 인원수 이하여야 합니다.</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!--Warning Toast Bar 끝 -->

    <!--Warning Toast Bar-->
    <div id="timeError" class="toast toast-bar toast-top rounded-l bg-red-dark shadow-bg shadow-bg-s" data-bs-delay="3000">

        <div class="align-self-center">
            <i class="icon icon-s bg-white color-red-dark rounded-l shadow-s bi bi-exclamation-triangle-fill font-22 me-3"></i>
        </div>

        <div class="align-self-center">
            <span class="font-10 mt-n1 opacity-70">출발 날짜를 확인해주세요</span>
        </div>

        <div class="align-self-center ms-auto">
            <button type="button" class="btn-close btn-close-white me-2 m-auto font-9" data-bs-dismiss="toast"></button>
        </div>

    </div>
    <!-- Warning Toast Bar 끝 -->

</div><!-- page -->

</body>
</html>