<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>  
<style type="text/css">
  td{
    height: 100px;
  }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">

  
/*  $("input[name='searchKeyword']").autocomplete({
      source: function(request, response) {
        $.ajax({
          url: "/user/json/autoList",
          method: "POST",
          data: JSON.stringify({
            currentPage: 0,
            pageSize: 0,
            searchKeyword: request.term,
          }),
          contentType: "application/json",
          dataType: "json",
          success: function(data) {
            console.log("data", data.listName);
            response(data.list); // 자동 완성 항목 배열
          },
          error: function(xhr, status, error) {
            console.error("Error:", error);
          }
        });
      },
      minLength: 1
    }); */
    
    $(function() {
         
         //초기 로딩 시 스크롤바의 높이와 문서의 높이를 비교 스크롤 아래 가면 데이터 로딩
      /*   if($(window).height() == $(document).height()){
          
           loadMoreDate()
           
         }  */
         //현재 페이지와 무한스크롤 활성화 여부
         let currentPage = 1;
         let infiniteScrollEnabled = true;
         
         //무한스크롤(스크롤생성 event??)
         window.addEventListener("scroll", function() {      
         
        //문서의 전체높이
         let scrollHeight = document.documentElement.scrollHeight;
         
        //window.innerHeight = 핸재보이는 브라우저 창 높이
        //window.scrollY 현재 스크롤 바 위치
         let scrollPosition = window.innerHeight + window.scrollY;
       
        
        ///체크해가면서 window와 document확인
    
         

         if (infiniteScrollEnabled && scrollHeight - scrollPosition <10) {
              infiniteScrollEnabled = false; // 중복 요청을 막기 위해 활성화 상태를 비활성화로 변경
              loadMoreData();
            }
          });
        
        
         function loadMoreData() {
              let currentPageValue = parseInt($('input[name="currentPage"]').val());
              let searchKeywordValue = $('input[name="searchKeyword"]').val();
              currentPageValue++;

              $('input[name="currentPage"]').val(currentPageValue);
              if($("#currentPage").val() <= ${resultPage.maxPage}){
                  let data = {
                    
                    currentPage : $("#currentPage").val(),
                    searchKeyword : $("input:text[name='searchKeyword']").val()
                }
              
              $.ajax({
                  url: "/user/json/autoList",
                  data   :  JSON.stringify(data),
                  method: "POST",
                  contentType: "application/json",
                  dataType: "json",
                  success: function (data, status) {
                      let userList = data.list;
                      let resultPage = data;

                      userList.forEach(function (user) {
                    	  var newRow = '<tr class="list" data-user-no="' + user.userNo + '">' +
                          '<td>' + user.userNo + '</td>' +
                          '<td>' + user.name + '</td>' +
                          '<td>' + user.email + '</td>' +
                          '</tr>';

                          // 적절한 위치에 행 추가
                          $('#muhanlist').append(newRow);
                          $(".list").on("click", function () {
                              var clickedUserNo = $(this).data("user-no");
                              console.log("Clicked userNo: " + clickedUserNo);

                              // 클릭된 행의 데이터를 사용하여 페이지 이동
                              self.location = "/user/getadmin?userNo=" + clickedUserNo;
                            });
                          });
                       
                      infiniteScrollEnabled = true;
                      
                            
                  },
                  
              });
          }

      
 }
    
    });
     
     
     $( function() {
          $(".list").on("click" , function() {

            var userNo = $(this).data("user-no");
            console.log("userNo :"+userNo);
            
            self.location = "/user/getadmin?userNo="+userNo
                
           
          });
          
          $("a:contains('검색')").on("click", function () {
        	    
        	    $("form").attr("method","POST").attr("action","/user/listUser").submit();
        	  }) 
        });
</script>
</head>
<body>

<body class="theme-light">
   <jsp:include page="../home/top.jsp" />
  <form>
    <div id="page" >
 >
      <div class="page-content header-clear-medium" >
        <div class="card card-style" style="margin-bottom: 15px;">
          <div class="content"style="margin-bottom: 9px; ">
            <!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

            <h1 class="pb-2" style="width: 140px; white-space: nowrap; display: inline-block;">
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;회원 리스트
            </h1>
          </div>
        </div>

       <div class="card overflow-visible card-style">
          <div class="content mb-0">
            <div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
              <a style=" font-size: 9px; display: inline-block; padding-top: 5px; padding-bottom: 5px; float: left; margin-top: 2px">passenger : ${passenger}명 , driver :${driver}명</a>
              <div>
              <input type="text" class="form-control rounded-xs"
                style="width: 35%; display: inline-block" name="searchKeyword" id="searchKeyword"
                value="${!empty search.searchKeyword ? search.searchKeyword : ''}">
            
                    <a class="btn btn-xxs border-blue-dark color-blue-dark"
                style="display: inline-block; padding-top: 5px; padding-bottom: 5px; padding-left: 20px; padding-right: 20px;margin-left: 5px; ">검색</a>
            </div>
            </div>

            <div class="table-responsive">
              <table class="table color-theme mb-2" id="muhanlist">
                <thead>
                  <tr>
                    <th scope="col">번호</th>
                    <th scope="col">이름</th>
                    <th scope="col">이메일</th>
                  </tr>
                </thead>
                <tbody>
                  <c:set var="i" value="0" />
                  <c:forEach var="user" items="${list}">
                   <c:set var="i" value="${ i+1 }" />                 
                    <tr class="list" data-user-no="${user.userNo}">
                      <td>${user.userNo}</td>
                      <td>${user.name}</td>
                      <td>${user.email}</td>
                    </tr>
                 </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
          <input type="hidden" id="currentPage" name="currentPage" value=1>
      </div>
    </div>
  </form>
</body>
</html>