<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${user.role eq null}">
  <div class="card card-style bg-23 mb-3 rounded-m mt-3" data-card-height="150" style="height: 150px;">
    <div class="card-top m-3">
      <a href="#" data-bs-dismiss="offcanvas" class="icon icon-xs bg-theme rounded-s color-theme float-end"><i class="bi bi-caret-left-fill"></i></a>
    </div>
    <div class="card-bottom p-3">
      <h1 class="color-white font-20 font-700 mb-n2">eTa</h1>
      <p class="color-white font-12 opacity-70 mb-n1">로그인 후 이용해주세요.</p>
    </div>
    <div class="card-overlay bg-gradient-fade rounded-0">
      <img src="/templates/images/pictures/taxi11.png" class="img-fluid">
    </div>
  </div>

  <span class="menu-divider">MENU</span>
  <div class="menu-list">
    <div class="card card-style rounded-m p-3 py-2 mb-0">
      <a href="/notice/listNotice" id="listNotice"><i class="gradient-red shadow-bg shadow-bg-xs bi bi-info-square-fill"></i><span>공지사항</span><i class="bi bi-chevron-right"></i></a>
    </div>
  </div>
</c:if>


<c:if test="${user.role eq 'passenger'}">
  <div class="bg-theme mx-3 rounded-m shadow-m mt-3 mb-3">
    <div class="d-flex px-2 pb-2 pt-2">
      <div class="ps-2 align-self-center">
        <h5 class="ps-1 mb-0 line-height-xs pt-1">${user.name}</h5>
        <h6 class="ps-1 mb-0 font-400 opacity-40">${user.role}</h6>
      </div>
      <div class="ms-auto">
        <a href="#" data-bs-toggle="dropdown" class="icon icon-m ps-3" aria-expanded="false"><i class="bi bi-three-dots-vertical font-18 color-theme"></i></a>
        <div class="dropdown-menu bg-transparent border-0 mt-n1 ms-3" style="margin: 0px;">
          <div class="card card-style rounded-m shadow-xl mt-1 me-1">
            <div class="list-group list-custom list-group-s list-group-flush rounded-xs px-3 py-1">
              <a href="#" class="color-theme opacity-70 list-group-item py-1" data-bs-toggle="offcanvas" data-bs-target="#menu-info"><strong class="font-500 font-12">내 정보</strong></a>
              <a href="#" class="color-theme opacity-70 list-group-item py-1" data-bs-toggle="offcanvas" data-bs-target="#menu-newPwd"><strong class="font-500 font-12">비밀번호 변경</strong></a>
              <a href="#" class="color-theme opacity-70 list-group-item py-1" onclick="deleteUserView()"><strong class="font-500 font-12">회원 탈퇴</strong></a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <span class="menu-divider mt-4">MY PAGE</span>
  <div class="menu-list">
    <div class="card card-style rounded-m p-3 py-2 mb-0">
      <a href="/callreq/likeAddress?userNo=${user.userNo}" id="likeAddress"><i class="gradient-magenta shadow-bg shadow-bg-xs bi bi-heart-fill"></i><span>즐겨찾기</span><i class="bi bi-chevron-right"></i></a>
      <a href="/callres/getRecordList?month=all" id="getRecordList"><i class="gradient-blue shadow-bg shadow-bg-xs bi bi-card-list"></i><span>이용내역</span><i class="bi bi-chevron-right"></i></a>
      <a href="/pay/TpayList?userNo=${user.userNo}&month=all" id="TpayList"><i class="gradient-green shadow-bg shadow-bg-xs bi bi-currency-dollar"></i><span>Tpay 이용내역</span><i class="bi bi-chevron-right"></i></a>
      <a href="/feedback/listReport" id="listReport"><i class="gradient-orange shadow-bg shadow-bg-xs bi bi-list-check"></i><span>신고내역</span><i class="bi bi-chevron-right"></i></a>
      </div>
  </div>

  <span class="menu-divider mt-4">MENU</span>
  <div class="menu-list">
    <div class="card card-style rounded-m p-3 py-2 mb-0">
      <a href="/community/getShareList" id="getShareList"><i class="gradient-brown shadow-bg shadow-bg-xs bi bi-person-plus-fill"></i><span>합승</span><i class="bi bi-chevron-right"></i></a>
      <a href="/callres/getReservationList" id="getReservationList"><i class="gradient-yellow shadow-bg shadow-bg-xs bi bi-calendar-date"></i><span>예약</span><i class="bi bi-chevron-right"></i></a>
      <a href="/notice/listNotice" id="listNotice"><i class="gradient-red shadow-bg shadow-bg-xs bi bi-info-square-fill"></i><span>공지사항</span><i class="bi bi-chevron-right"></i></a>
    </div>
  </div>
</c:if>


<c:if test="${user.role eq 'driver'}">
  <div class="bg-theme mx-3 rounded-m shadow-m mt-3 mb-3">
    <div class="d-flex px-2 pb-2 pt-2">
      <div class="ps-2 align-self-center">
        <h5 class="ps-1 mb-0 line-height-xs pt-1">${user.name}</h5>
        <h6 class="ps-1 mb-0 font-400 opacity-40">${user.role}</h6>
      </div>
      <div class="ms-auto">
        <a href="#" data-bs-toggle="dropdown" class="icon icon-m ps-3" aria-expanded="false"><i class="bi bi-three-dots-vertical font-18 color-theme"></i></a>
        <div class="dropdown-menu bg-transparent border-0 mt-n1 ms-3" style="margin: 0px;">
          <div class="card card-style rounded-m shadow-xl mt-1 me-1">
            <div class="list-group list-custom list-group-s list-group-flush rounded-xs px-3 py-1">
              <a href="#" class="color-theme opacity-70 list-group-item py-1" data-bs-toggle="offcanvas" data-bs-target="#menu-info"><strong class="font-500 font-12">내 정보</strong></a>
              <a href="#" class="color-theme opacity-70 list-group-item py-1" data-bs-toggle="offcanvas" data-bs-target="#menu-newPwd"><strong class="font-500 font-12">비밀번호 변경</strong></a>
              <a href="/user/deleteUserView" class="color-theme opacity-70 list-group-item py-1"><strong class="font-500 font-12">회원 탈퇴</strong></a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <span class="menu-divider mt-4">My Page</span>
  <div class="menu-list">
    <div class="card card-style rounded-m p-3 py-2 mb-0">
      <a href="/callres/getRecordList?month=all" id="callRecord"><i class="gradient-blue shadow-bg shadow-bg-xs bi bi-card-list"></i><span>운행 기록</span><i class="bi bi-chevron-right"></i></a>
      <a href="/pay/myCashList?userNo=${user.userNo}&month=all" id="cashList"><i class="gradient-green shadow-bg shadow-bg-xs bi bi-currency-dollar"></i><span>정산 내역</span><i class="bi bi-chevron-right"></i></a>
      <a href="/feedback/listReport" id="report"><i class="gradient-orange shadow-bg shadow-bg-xs bi bi-list-check"></i><span>신고내역</span><i class="bi bi-chevron-right"></i></a>
    </div>
  </div>

  <span class="menu-divider mt-4">MENU</span>
  <div class="menu-list">
    <div class="card card-style rounded-m p-3 py-2 mb-0">
      <a href="/community/getDealList" id="getDealList"><i class="gradient-brown shadow-bg shadow-bg-xs bi bi-person-plus-fill"></i><span>택시비 딜</span><i class="bi bi-chevron-right"></i></a>
      <a href="/callres/getReservationList" id="getReservationList"><i class="gradient-yellow shadow-bg shadow-bg-xs bi bi-calendar-date"></i><span>예약</span><i class="bi bi-chevron-right"></i></a>
      <a href="/notice/listNotice" id="notice"><i class="gradient-red shadow-bg shadow-bg-xs bi bi-info-square-fill"></i><span>공지사항</span><i class="bi bi-chevron-right"></i></a>
    </div>
  </div>
</c:if>


<c:if test="${user.role eq 'admin'}">
  <div class="bg-theme mx-3 rounded-m shadow-m mt-3 mb-3">
    <div class="d-flex px-2 pb-2 pt-2">
      <div class="ps-2 align-self-center">
        <h5 class="ps-1 mb-0 line-height-xs pt-1">${user.name}</h5>
        <h6 class="ps-1 mb-0 font-400 opacity-40">${user.role}</h6>
      </div>
      <div class="ms-auto">
        <a href="#" data-bs-toggle="dropdown" class="icon icon-m ps-3" aria-expanded="false"><i class="bi bi-three-dots-vertical font-18 color-theme"></i></a>
        <div class="dropdown-menu bg-transparent border-0 mt-n1 ms-3" style="margin: 0px;">
          <div class="card card-style rounded-m shadow-xl mt-1 me-1">
            <div class="list-group list-custom list-group-s list-group-flush rounded-xs px-3 py-1">
              <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-info"class="color-theme opacity-70 list-group-item py-1"><strong class="font-500 font-12">내 정보</strong></a>
              <a href="#" data-bs-toggle="offcanvas" data-bs-target="#menu-newPwd" class="color-theme opacity-70 list-group-item py-1"><strong class="font-500 font-12">비밀번호 변경</strong></a>
              <a href="/user/deleteUserView" class="color-theme opacity-70 list-group-item py-1"><strong class="font-500 font-12">회원 탈퇴</strong></a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <span class="menu-divider">MENU</span>
  <div class="menu-list">
    <div class="card card-style rounded-m p-3 py-2 mb-0">
    <a href="/notice/listNotice" id="notice"><i class="gradient-red shadow-bg shadow-bg-xs bi bi-info-square-fill"></i><span>공지사항</span><i class="bi bi-chevron-right"></i></a>
    <a href="/feedback/listReport" id="listReport"><i class="gradient-orange shadow-bg shadow-bg-xs bi bi-list-check"></i><span>신고내역</span><i class="bi bi-chevron-right"></i></a>
    <a href="/pay/cashDriverList?month=all" id="cashDriverList"><i class="gradient-red shadow-bg shadow-bg-xs bi bi-info-square-fill"></i><span>정산승인</span><i class="bi bi-chevron-right"></i></a>
    <a href="/user/listUser" id="listUser"><i class="gradient-orange shadow-bg shadow-bg-xs bi bi-list-check"></i><span>회원리스트</span><i class="bi bi-chevron-right"></i></a>
    <a href="/callres/getCallResList?month=all" id="getCallResList"><i class="gradient-orange shadow-bg shadow-bg-xs bi bi-list-check"></i><span>운행기록</span><i class="bi bi-chevron-right"></i></a>
    </div>
  </div>

</c:if>