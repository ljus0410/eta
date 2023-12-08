<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>  
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">
$(function() {
    
    $("input[name='searchKeyword']").autocomplete({
          source: function(request, response) {
              $.ajax({
             url : "/user/json/autoList",  
            method : "POST",
            data : JSON.stringify({
            currentPage: 0,
            pageSize: 0,
            searchKeyword: request.term, //현재 압력된 검색어
            searchCondition: $("select[name= 'searchCondition']").val()
          }),
        contentType: "application/json",
        dataType:"json",
        success: function(data){
          console.log("data"+data.lstName )
          console.log("data"+data.list)
          if($("select[name= 'searchCondition']").val()=="0"){
            response(data.list);
          }else if($("select[name= 'searchCondition']").val()=="1"){
            response(data.listName);
          }
        }
        });
      },
      minLength: 1
  });
 });

</script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td align="right">
      <select name="searchCondition" class="ct_input_g" style="width:80px">
        <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
        <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
      </select>
      <input type="text" name="searchKeyword" 
            value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
            class="ct_input_g" style="width:200px; height:20px" > 
    </td>
    <td align="right" width="70">
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="17" height="23"></td>
          <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
            검색
          </td>
          <td width="14" height="23"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td colspan="11" >
      전체  passenger${passenger} 건수, 현재 driver ${driver}수
    </td>
  </tr>
  <tr>
    <td class="ct_list_b" width="100">No</td>
    <td class="ct_line02"></td>
    <td class="ct_list_b" width="150">
      회원ID<br>
      <h7 >(id click:상세정보)</h7>
    </td>
    <td class="ct_line02"></td>
    <td class="ct_list_b" width="150">회원명</td>
    <td class="ct_line02"></td>
    <td class="ct_list_b">이메일</td>    
  </tr>
  <tr>
    <td colspan="11" bgcolor="808285" height="1"></td>
  </tr>
    
  <c:set var="i" value="0" />
  <c:forEach var="user" items="${list}">
    <c:set var="i" value="${ i+1 }" />
    <tr class="ct_list_pop">
      <td align="center">${ i }</td>
      <td></td>
      <td align="left">${user.email}</td>
      <td></td>
      <td align="left">${user.name}</td>
      <td></td>
      <td align="left">${user.nickName}
      </td>
    </tr>
    <tr>
      <!-- //////////////////////////// 추가 , 변경된 부분 /////////////////////////////
      <td colspan="11" bgcolor="D6D7D6" height="1"></td>
      ////////////////////////////////////////////////////////////////////////////////////////////  -->
      <td id="${user.email}" colspan="11" bgcolor="D6D7D6" height="1"></td>
    </tr>

  </c:forEach>
</table>

<a href="/user/listUser">list</a>

</form>
</body>
</html>