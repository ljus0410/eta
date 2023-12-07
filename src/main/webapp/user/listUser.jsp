<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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