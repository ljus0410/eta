<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form id="login" method="post" action="/user/login">
<input id ="email" type="text" name="email" value=""><br>
<input id ="pwd" type="text" name="pwd" value=''>
<input id="submit" type="submit" name="submit" value="Enter"/>
<!-- <a href="/user/logon">Label</a> -->

</form>
 <table>
              <tr>
               <td width="10">&nbsp;</td>
                         <td width="70">
                            <a href="/user/kakao-login">
                            <img src="/images/kakao_login.png" width="70" height="20" border="0"></a>
                         </td>
               <td width="10">&nbsp;</td>
                  <td width="70">
                       <a href="/user/naver-login">
                   <img src="/images/btnD_short.png" width="70" height="20" border="0">


                      </td>
              </tr>
              </table>
</body>
</html>