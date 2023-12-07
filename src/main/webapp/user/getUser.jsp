<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
  
  <tr>
    <td height="1" colspan="3" bgcolor="D6D6D6"></td>
  </tr>
  
  <tr>
    <td width="104" class="ct_write">
      이메일 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
    </td>
    <td bgcolor="D6D6D6" width="1"></td>
    <td class="ct_write01">${user.email}</td>
  </tr>

  <tr>
    <td height="1" colspan="3" bgcolor="D6D6D6"></td>
  </tr>
  
  <tr>
    <td width="104" class="ct_write">
      이름 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
    </td>
    <td bgcolor="D6D6D6" width="1"></td>
    <td class="ct_write01">${user.name}</td>
  </tr>
  
  <tr>
    <td height="1" colspan="3" bgcolor="D6D6D6"></td>
  </tr>
  
  <tr>
    <td width="104" class="ct_write">핸드폰</td>
    <td bgcolor="D6D6D6" width="1"></td>
    <td class="ct_write01">${user.phone}</td>
  </tr>
  
  <tr>
    <td height="1" colspan="3" bgcolor="D6D6D6"></td>
  </tr>

    <td height="1" colspan="3" bgcolor="D6D6D6"></td>
  </tr>
  
  <tr>
    <td width="104" class="ct_write">이메일 </td>
    <td bgcolor="D6D6D6" width="1"></td>
    <td class="ct_write01">${user.email}</td>
  </tr>

  <tr>
    <td height="1" colspan="3" bgcolor="D6D6D6"></td>
  </tr>
  
  <tr>
    <td width="104" class="ct_write">가입일자</td>
    <td bgcolor="D6D6D6" width="1"></td>
    <td class="ct_write01">${user.regDate}</td>
  </tr>
  
  <tr>
    <td height="1" colspan="3" bgcolor="D6D6D6"></td>
  </tr>
  
</table>
<a href="/user/listUser">list</a>
<a href="/user/deleteUserView?email=${user.email}">회원탈퇴</a>
<a href="/user/updatePwd?email=${user.email}">비밀번호변경</a>
</form>
</body>
</html>