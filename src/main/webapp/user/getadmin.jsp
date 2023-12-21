<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style>

/* 추가한 스타일 */
#phone, #authButton {
    display: inline-block; /* 인라인 블록으로 설정하여 같은 줄에 위치하도록 함 */
    vertical-align: middle; /* 수직 정렬을 중앙에 맞춤 */
    }       
.custom-border {
width: 45vw; 
height: 53px;
padding: 0px 15px 0px 40px;
border: 1px solid #f0f0f0 !important; 
display: flex;
align-items: center;
margin-bottom: 10px;
text-transform: uppercase;

}
.custom-border1 {
width: 40vw; 
height: 90px;
padding: 0px 15px 0px 40px;
border: 1px solid #f0f0f0 !important; 
display: flex;
align-items: center;
margin-bottom: 10px;
text-transform: uppercase;

}

.custom-border2 {
width: 40vw; 
height: 80px;
padding: 0px 15px 0px 40px;
border: 1px solid #f0f0f0 !important; 
display: flex;
align-items: center;
margin-bottom: 10px;
text-transform: uppercase;

}

.custom-border3 {
width: 40vw; 
height: 80px;
padding: 0px 15px 0px 40px;
border: 1px solid #f0f0f0 !important; 
display: flex;
align-items: center;
margin-bottom: 10px;
text-transform: uppercase;

}
.custom-checkbox {
position: absolute;
opacity: 0;
}

.custom-checkbox + label {
position: relative;
cursor: pointer;
width: 13px; /* 가로 크기 조절 */
height: 13px; /* 세로 크기 조절 */
display: inline-block;
}

.custom-checkbox + label::before {
content: '';
position: absolute;
left: 0;
top: 0;
width: 100%;
height: 100%;
border: 1px solid #ced4da !important;  /* 회색 테두리 스타일링 */
border-radius: 50%; /* 동그라미를 동그랗게 만들기 */
background-color: white; /* 동그라미 배경색 */

}

.custom-checkbox:checked + label::before {
background-color: #007bff; /* 클릭되었을 때의 배경색 */
content: '\2022'; /* 가운데 동그라미를 나타내는 유니코드 블랙 서클 (●) */
position: absolute;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
width: 13px; /* 동그라미의 크기를 조절합니다. */
height: 13px; /* 동그라미의 크기를 조절합니다. */
border-radius: 50%; /* 동그라미를 동그랗게 만듭니다. */
color: #fff; /* 가운데 동그라미의 텍스트 색상을 흰색으로 설정합니다. */
display: flex;
justify-content: center;
align-items: center;
}

.image-container {
display: grid;
grid-template-columns: repeat(4, 1fr);
gap: 1px;
align-items: center;
justify-content: center;
text-align: center; /* 이미지를 중앙에 정렬하기 위해 추가 */
}
.image-container img {
margin-right: 3px; /* 이미지 사이의 간격을 조정하세요 */
}
</style>

<script type="text/javascript">


 
 $(document).ready(function() { 
      $("#block").on("click", function() {
          alert("비활성화");
          // 여기서 usersNo 가져오기
          var usersNo = $("#usersNo").val();
          let reportNo = ${reportNo }
          console.log("No : " + usersNo);
          // AJAX 요청 보내기
          $.ajax({
              type: "GET",
              url: "/feedback/json/addBlock/" + usersNo+"/"+reportNo,
              success: function(response) {
                alert("비활성화 적용 :"+response+"회")
                
                  console.log("블록 추가 성공!"+response);
                if (response >= 4) {
                	console.log("비활성화 4회 이상");
                    $("#block").prop('disabled', true);
                }
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

<form>
<jsp:include page="../home/top.jsp" />
<div class="page-content header-clear-medium" >
        
        
       <div class="card card-style" style="margin-bottom: 15px;">
    <div class="content" style="margin-bottom: 9px; display: flex; justify-content: space-between; align-items: center;">
        <h1 class="pb-2" style="width: 140px;">
            <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns"></i>&nbsp;&nbsp;회원정보
        </h1>
    <div style="text-align: right;">
      <p class="font-12 color-highlight" style="margin-bottom: 0;text-align: left;">${users.role }</p>
   <p class="font-12 color-highlight" style="margin-bottom: 0;">가입일자: ${users.regDate}</p>
            
</div>
    </div>
</div>



        <div class="card card-style">
      <div class="content">
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs " name="name2" id="name2" value="${users.name}" readonly/>
          <span>이름</span>
        </div>
        
        


        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs " name="name2" id="name2" value="${users.phone}" readonly/>
          <input type="hidden" class="form-control rounded-xs " name="name" id="name" value=""/>
          <span>전화번호</span>
        </div>

        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-square font-12"></i>
          <input type="text" class="form-control rounded-xs" id="nickName" value="${users.nickName}" readonly name="nickName"/>
          <label for="nick" class="color-theme">NickName</label>
          <span>닉네임</span>        
        </div>
        
            <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-envelope font-14"></i>
          <input type="text" class="form-control rounded-xs" id="email" name="email" value="${users.email}" placeholder="이메일" readonly/>
         <label for="email" class="color-theme">Email</label>
           <span>이메일</span> 
        </div>
        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-person-circle font-14"></i>
          <input type="text" class="form-control rounded-xs" id="birth" value="${users.birth}" readonly/>
          <span>생년월일</span>
        </div>
        
        <div class="form-custom form-label form-icon mb-3">
        <i class="bi bi-person-check-fill font-14"></i>
        <input type="text" class="form-control rounded-xs" id="gernder" value="${users.gender eq 0 ? '남' : '여'}" readonly />      
        <span>성별</span>
        </div>
  

        
 <c:if test="${users.role eq 'driver'}">
    <div class="custom-border1 form-control rounded-xs" style=" align-items: center;">
     <div style="display: flex;  ">
    <i style="font-size: 13px;"class="bi bi-123 font-12"></i>
    <span style="font-size: 13px;flex-direction: column;  margin-bottom: 8px; margin-left:14px; color: gray;">차량옵션</span>
   </div>
   
   <div style="text-align: center;">
   
        <span class="carOptStyle"><input  disabled type="radio"  value="4" ${users.gender == '4' ? 'checked' : ''}  class="form-check-input" name="carOpt"  checked> <svg style="flex-direction: column;" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-car-front-fill" viewBox="0 0 16 16">
  <path d="M2.52 3.515A2.5 2.5 0 0 1 4.82 2h6.362c1 0 1.904.596 2.298 1.515l.792 1.848c.075.175.21.319.38.404.5.25.855.715.965 1.262l.335 1.679c.033.161.049.325.049.49v.413c0 .814-.39 1.543-1 1.997V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.338c-1.292.048-2.745.088-4 .088s-2.708-.04-4-.088V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.892c-.61-.454-1-1.183-1-1.997v-.413a2.5 2.5 0 0 1 .049-.49l.335-1.68c.11-.546.465-1.012.964-1.261a.807.807 0 0 0 .381-.404l.792-1.848ZM3 10a1 1 0 1 0 0-2 1 1 0 0 0 0 2m10 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2M6 8a1 1 0 0 0 0 2h4a1 1 0 1 0 0-2zM2.906 5.189a.51.51 0 0 0 .497.731c.91-.073 3.35-.17 4.597-.17 1.247 0 3.688.097 4.597.17a.51.51 0 0 0 .497-.731l-.956-1.913A.5.5 0 0 0 11.691 3H4.309a.5.5 0 0 0-.447.276L2.906 5.19Z"/>
</svg> </span>


<span class="carOptStyle" style =" margin-right: 9px;"><input disabled type="radio"  value="6" ${users.gender == '6' ? 'checked' : ''} class="form-check-input" name="carOpt" > <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-truck-front-fill" viewBox="0 0 16 16">
  <path d="M3.5 0A2.5 2.5 0 0 0 1 2.5v9c0 .818.393 1.544 1 2v2a.5.5 0 0 0 .5.5h2a.5.5 0 0 0 .5-.5V14h6v1.5a.5.5 0 0 0 .5.5h2a.5.5 0 0 0 .5-.5v-2c.607-.456 1-1.182 1-2v-9A2.5 2.5 0 0 0 12.5 0zM3 3a1 1 0 0 1 1-1h8a1 1 0 0 1 1 1v3.9c0 .625-.562 1.092-1.17.994C10.925 7.747 9.208 7.5 8 7.5c-1.208 0-2.925.247-3.83.394A1.008 1.008 0 0 1 3 6.9zm1 9a1 1 0 1 1 0-2 1 1 0 0 1 0 2m8 0a1 1 0 1 1 0-2 1 1 0 0 1 0 2m-5-2h2a1 1 0 1 1 0 2H7a1 1 0 1 1 0-2"/>
</svg></span>

<span class="carOptStyle"style =" margin-right: 9px;"><input disabled type="radio"  name="carOpt" value="8" ${users.gender == '8' ? 'checked' : ''} style =" margin-right: 9px;" class="form-check-input" name="carOpt" ><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bus-front-fill" viewBox="0 0 16 16">
  <path d="M16 7a1 1 0 0 1-1 1v3.5c0 .818-.393 1.544-1 2v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5V14H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2a2.496 2.496 0 0 1-1-2V8a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1V2.64C1 1.452 1.845.408 3.064.268A43.608 43.608 0 0 1 8 0c2.1 0 3.792.136 4.936.268C14.155.408 15 1.452 15 2.64V4a1 1 0 0 1 1 1zM3.552 3.22A43.306 43.306 0 0 1 8 3c1.837 0 3.353.107 4.448.22a.5.5 0 0 0 .104-.994A44.304 44.304 0 0 0 8 2c-1.876 0-3.426.109-4.552.226a.5.5 0 1 0 .104.994ZM8 4c-1.876 0-3.426.109-4.552.226A.5.5 0 0 0 3 4.723v3.554a.5.5 0 0 0 .448.497C4.574 8.891 6.124 9 8 9c1.876 0 3.426-.109 4.552-.226A.5.5 0 0 0 13 8.277V4.723a.5.5 0 0 0-.448-.497A44.304 44.304 0 0 0 8 4m-3 7a1 1 0 1 0-2 0 1 1 0 0 0 2 0m8 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m-7 0a1 1 0 0 0 1 1h2a1 1 0 1 0 0-2H7a1 1 0 0 0-1 1"/>
</svg></span>

<span class="carOptStyle" style="margin-right: 9px; cursor: pointer;">
   <input disabled class="form-check-input custom-checkbox" type="checkbox" value="0" ${users.gender == '0' ? 'checked' : ''} name="carOpt" id="carOpt">
   <label for="carOpt"></label><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-wheelchair" viewBox="0 0 16 16">
  <path d="M12 3a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3m-.663 2.146a1.5 1.5 0 0 0-.47-2.115l-2.5-1.508a1.5 1.5 0 0 0-1.676.086l-2.329 1.75a.866.866 0 0 0 1.051 1.375L7.361 3.37l.922.71-2.038 2.445A4.732 4.732 0 0 0 2.628 7.67l1.064 1.065a3.25 3.25 0 0 1 4.574 4.574l1.064 1.063a4.732 4.732 0 0 0 1.09-3.998l1.043-.292-.187 2.991a.872.872 0 1 0 1.741.098l.206-4.121A1 1 0 0 0 12.224 8h-2.79l1.903-2.854ZM3.023 9.48a3.25 3.25 0 0 0 4.496 4.496l1.077 1.077a4.75 4.75 0 0 1-6.65-6.65l1.077 1.078Z"/>
</svg></span>
<div style="margin-right: -37px; display: flex;justify-content: center; color: gray; font-size: 14px;">
<span style =" margin-right: 30px; margin-left: -21px;">4인</span>
<span style =" margin-right: 45px;">6인</span>
<span style =" margin-right: 26px; ">8인</span>
<span>장애인</span>
</div>
    </div> 
    </div> 
    
  
    
    <div class="custom-border2 form-control rounded-xs"  style="display: flex; align-items: center;">
     <div style="display: flex;  ">
    <i style="font-size: 13px;"class="bi bi-check-all font-12"></i>
    <span style="font-size: 13px;flex-direction: column;  margin-bottom: 8px; margin-left:14px; color: gray;">동물옵션</span>
   </div>
  <div style="display: flex; align-items: center; margin-left: auto;">
  <input class="form-check-input custom-checkbox" type="checkbox" value="1" id="petOpt" onclick="updateAnimalOptValue()" ${users.petOpt == '1' ? 'checked' : ''}>
  <label for="petOpt"></label>
  <img src="../images/pet.png" width="35" height="35" style="margin-right: 40px;">
   <input type="hidden" id="animalOptValue" name="petOpt" value="0">
</div>
</div>


        <div class="form-custom form-label form-icon mb-3">
          <i class="bi bi-123 font-12"></i>
          <input readonly type="text" class="form-control rounded-xs" id="carNum" name="carNum" placeholder="차량번호"/>
          <label for="c2" class="color-theme">CarNum</label>
          <span>(required)</span>
        </div>
        
        
        
        
        <div class="custom-border2 form-control rounded-xs" style=" align-items: center;">
     <div style="display: flex;  ">
    <i style="font-size: 13px;"class="bi bi-currency-dollar font-12"></i>
    <span style="font-size: 12px;flex-direction: column;  margin-bottom: 8px; margin-left:14px; color: gray;">정산수단</span>
   </div>
        
 
  <div style="justify-content: center; isplay: flex; align-items: center;">
     <span style="font-size: 11px;flex-direction: column;  margin-bottom: 8px; margin-left:14px; color: gray;">은행명</span>
     <input readonly class="rounded-xs" name="accountname" style="color:gray; margin-left:10px; border: 1px solid #ced4da !important;"type="text" value = "${users.bank}" id="bank" />    
    </div>
      <div style="justify-content: center; isplay: flex; align-items: center;">
      <span style="font-size: 11px;flex-direction: column;  margin-bottom: 8px; margin-left:14px; color: gray;">계좌번호</span>
       <input readonly class="rounded-xs" name="account" style="color:gray; margin-left:10px; border: 1px solid #ced4da !important;"type="text" id="bank_num" value = "${users.account}" />


  </div>
</diV>
 </c:if>
 <input type="hidden" id="usersNo" value="${users.userNo}">
 <c:if test="${!empty reportNo }">
	 <c:if test="${block >= 4}">
	 <a href="#" id="blocks" style ="opacity: 0.5;" class="btn btn-full gradient-blue shadow-bg shadow-bg-s mt-4">비활성화</a> 
	 </c:if>
	 <c:if test="${block < 4}">
	 <a class="btn btn-full gradient-blue shadow-bg shadow-bg-s mt-4" id="block">비활성화</a>
	</c:if>
</c:if>
 </div>
 </div>
 </div>


        
     </form>
        
        

  
    

</body>
</html>