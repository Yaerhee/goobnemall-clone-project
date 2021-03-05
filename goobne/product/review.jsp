<%@page import="com.goobne.CustomInfo"%>
<%@page import="com.goobne.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.util.MyUtil"%>
<%@page import="com.goobne.ReviewDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");//한글깨짐방지
	CustomInfo info = (CustomInfo)session.getAttribute("customInfo");


%>
<%@ include file="//goobne/data/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 후기</title>

<script type="text/javascript">

	function sendIt(){
		var f = document.myForm;
		
		if (!f.subject.value) {
			alert("제목을 입력해주세요!");
			f.subject.focus();
			return;
		}
		
		if (!f.score.value) {
			alert("점수를 입력해주세요!");
			f.subject.focus();
			return;
		}
		if (f.score.value<1 || f.score.value>5) {
			alert("점수는 1~5 사이입니다.");
			f.subject.focus();
			return;
		}
		
		
		if (!f.content.value) {
			alert("내용을 입력해주세요!");
			f.content.focus();
			return;
		}
		
		f.action = "<%=cp%>/goobnemall/product/review_ok.do";
		f.submit();
		
		
	}


</script>
</head>
<body>
<div id="container">
<br/><br/>
<table width="560" border="2" cellpadding="0" cellspacing="0"
	 bordercolor="#d6d4d6" align="center">
<tr height="40" align="center">
	<td style="padding-left: 20px;">
	<h2><b>상품 후기</b></h2>
	</td>
</tr>
</table>
<br/>

<form action="" name="myForm" method="post">

<c:if test="${orderNum!=0}">
<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">

<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>

<tr align="center">
	<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left: 20px;">
	작성자
	</td>
	<td width="80%" style="padding-left: 10px;" align="left">
	<input type="text" name="name" size="35" maxlength="20" class="boxTF" value="${name }" readonly="readonly"/>
	</td>
</tr>

<tr><td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td></tr>

<tr align="center">
	<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left: 20px;">
	제목
	</td>
	<td width="80%" style="padding-left: 10px;" align="left">
	<input type="text" name="subject" size="35" maxlength="20" class="boxTF"/>
	</td>
</tr>
<tr><td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td></tr>
<tr align="center">
	<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left: 20px;">
	점수
	</td>
	<td width="80%" style="padding-left: 10px;" align="left">
	<input type="radio" name="score" value="5" checked="checked">매우 만족
	<input type="radio" name="score" value="4" >약간 만족
	<input type="radio" name="score" value="3">보통
	<input type="radio" name="score" value="2">불만족
	<input type="radio" name="score" value="1">매우 불만족
	</td>
</tr>

<tr><td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td></tr>
<tr align="center">
	<td width="20%" bgcolor="#eeeeee" style="padding-left: 20px;padding-top: 5px"
	valign="top">
	내&nbsp;&nbsp;&nbsp;&nbsp;용
	</td>
	<td width="80%" style="padding-left: 10px;" align="left">
	<textarea rows="7" cols="60" name="content" class="boxTA" ></textarea>
	</td>
</tr>

<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
</table>

<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">
<tr align="center">
	<td height="40" class="orderBtnWrap btn3 alC">
	<br/><br/>
	<button class="btnBuy" onclick="sendIt();">등록</button>
	<button class="btnCart openLyBtn" onclick="javascript:location.href='<%=cp%>/goobnemall/product/list.do';">작성 취소</button>
	<br/><br/><br/>
	<input type="hidden" value="${productNum }" name="productNum"/>
	<input type="hidden" value="${orderNum }" name="orderNum"/>
	
	</td>
</tr> 
</table>
</c:if>
<c:if test="${orderNum==0 }">
<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">
	<tr>
		<td colspan="2" height="1" bgcolor="black" align="center"><h1>상품을 구매해야지 후기를 작성할 수 있습니다!!</h1></td>
	</tr>
</table>
</c:if>
<!-- ----------------------------------------------------------------------- -->
<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">
<tr>
	<td colspan="2" height="1" bgcolor="#dbdbdb" align="center"><h4>상품명 : ${productName }</h4></td>
</tr>
<tr>
	<td colspan="2" height="1" bgcolor="#dbdbdb" align="center"><h4>평점 : ${score }</h4></td>
</tr>

<c:forEach var="dto" items="${lists }">
	<input type="hidden" value="${dto.reviewNum }"/>
<tr><td colspan="2" height="1" bgcolor="#dbdbdb" align="center"></td></tr>
<tr>
	<td width="100%" bgcolor="#eeeeee" style="padding-left: 20px;padding-top: 5px;padding-bottom: 5px;"
	valign="top">
	 작성자ID : ${dto.id.substring(0,dto.id.length()-4)}****
	<br/><br/>
	작성일 :${dto.created } &nbsp;&nbsp;&nbsp;  상품명 : ${dto.productName }
	<br/><br/>
	제목 : ${dto.subject }
	<br/><br/>
		<c:if test="${dto.score==5 }">점수 : ★★★★★</c:if>
		<c:if test="${dto.score==4 }">점수 : ★★★★☆</c:if>
		<c:if test="${dto.score==3 }">점수 : ★★★☆☆</c:if>
		<c:if test="${dto.score==2 }">점수 : ★★☆☆☆</c:if>
		<c:if test="${dto.score==1 }">점수 : ★☆☆☆☆</c:if>
	</td>
	
	
</tr>
<tr>
	<td style="padding-left: 10px;padding-top: 5px;padding-bottom: 5px;">&nbsp;&nbsp;${dto.content }</td>
</tr>
<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
</c:forEach>
<tr>
	<td align="center">
			<c:if test="${dataCount!=0 }">
				${pageIndexList }
			</c:if>
			<c:if test="${dataCount==0 }">
				등록된 게시물이 없습니다.
			</c:if>
	</td>
</tr>
</table>
</form>
</div>

<br/><br/>
<%@ include file="//goobne/data/footer.jsp" %>
