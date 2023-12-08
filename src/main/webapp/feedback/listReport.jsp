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
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
<script type="text/javascript">
$(function () {
	$("a:contains('검색')").on("click", function () {
			
		$("form").attr("method","POST").attr("action","/feedback/listReport").submit();
	})
	
})

</script>
</head>
<body>
	<form name="detailform">
		<input type="radio" name="code" value = "0"
		${ ! empty search.code && search.code == 0 ? "checked" : "" }>모두
		<input type="radio" name="code" value = "1"
		${ ! empty search.code && search.code == 1 ? "checked" : "" }>미처리
		<input type="radio" name="code" value = "2"
		${ ! empty search.code && search.code == 2 ? "checked" : "" }>처리중
		<input type="radio" name="code" value = "3"
		${ ! empty search.code && search.code == 3 ? "checked" : "" }>처리완료
		
		<select 	name="searchCondition" >
			<option value="선택" 
			${ ! empty search.searchCondition && search.searchCondition == '선택' ? "selected" : "" }>
			신고카테고리를 선택해주세요</option>
			<option value="폭언 및 욕설" 
			${ ! empty search.searchCondition && search.searchCondition == '폭언 및 욕설' ? "selected" : "" }>
			폭언 및 욕설</option>
			<option value="성희롱 및 성추행" 
			${ ! empty search.searchCondition && search.searchCondition == '성희롱 및 성추행' ? "selected" : "" }>
			성희롱 및 성추행</option>
			<option value="요금 관련"
			${ ! empty search.searchCondition && search.searchCondition == '요금 관련' ? "selected" : "" } >
			요금 관련</option>
			<option value="호출 및 탑승 중 불편사항" 
			${ ! empty search.searchCondition && search.searchCondition == '호출 및 탑승 중 불편사항' ? "selected" : "" }>
			호출 및 탑승 중 불편사항</option>
			<option value="기타" 
			${ ! empty search.searchCondition && search.searchCondition == '기타' ? "selected" : "" }>
			기타</option>
		</select>
		<input 	type="text" name="searchKeyword"  value="${!empty search.searchKeyword ? search.searchKeyword : ""}">
		<a>검색</a>
		<table id ="muhanlist">	
			<tr>
				<td>넘버</td>
				<td>처리상태</td>
				<td>신고접수번호</td>
				<td>신고자</td>
				<td>피신고배차번호</td>
				<td>신고카테고리</td>
				
			</tr>
			<c:forEach var="reportlist" items="${reportlist }" begin="0" step="1" varStatus="status">
				<tr class = "list${reportlist.reportNo }">
					<td>${status.count }&nbsp;&nbsp;<a href="/feedback/getReport?reportNo=${reportlist.reportNo }&badCallNo=${reportlist.badCallNo}&reportRole=${reportlist.reportRole}">상세보기</a></td>
					<td>${reportlist.reportCode }</td>
					<td>${reportlist.reportNo }</td>
					<td>${reportlist.reportUserNo }</td>
					<td>${reportlist.badCallNo }</td>
					<td>${reportlist.reportCategory }</td>
				</tr>
			</c:forEach>
			<input type="hidden" id="currentPage"name ="currentPage" value=1></br>
		</table>
	</form>
</body>
</html>