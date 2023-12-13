<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
    $("#blockButton").on("click", function() {
        // 여기서 user.userNo 가져오기
        var userNo = ${user.userNo}; // 예시로 사용, 실제로는 적절한 방식으로 가져와야 함
        console.log("No : "+userNo);
        // AJAX 요청 보내기
        $.ajax({
            type: "GET",
            url: "../feedback/json/addBlock/" + userNo,
            success: function(response) {
                console.log("response"+response);
               
            },
            error: function(error) {
                console.error("에러 발생: ", error);
            }
        });
    });
});
 
 </script>
    
</head>
<body>
<jsp:include page="../home/top.jsp" />
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
<button id="blockButton">블록 추가</button> <br/>
<div id="resultContainer"></div>
<a href="/user/listUser">list</a>
<a href="/user/deleteUserView?email=${user.email}">회원탈퇴</a>
<a href="/user/updatePwd?email=${user.email}">비밀번호변경</a>
<a href ="/user/kakao-logOut">로그아웃</a>
</form>
</body>
</html>