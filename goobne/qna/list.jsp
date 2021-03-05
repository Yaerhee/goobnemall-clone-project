<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	/* post방식일때 한글깨짐 방지 */
	request.setCharacterEncoding("UTF-8");
	
	// http://127.0.0.1:8080/study/까지의 주소를 가지고있음
	
%>
<%@ include file="//goobne/data/header.jsp" %>
<style type="text/css">

a { text-decoration: none; color: black; }
a:visited { text-decoration: none; }
a:hover { text-decoration: none; }
a:focus { text-decoration: none; }
a:hover, a:active { text-decoration: none; }
font{
	font-family: 나눔고딕;

}


</style>

<script type="text/javascript">

	function sendIt() {
		
		var f = document.searchForm;
		
		f.action = "<%=cp %>/goobnemall/qna/list.do";
		f.submit();
	}
	
</script>

</head>
<body>
<div id="container" class="haveSNB">

	<br/>
	<table border="0" align="center" width="1000px" cellspacing="0" cellpadding="0">
		<tr height="50">
			<td>
				<font size="6" style="padding-left: 10px;"><b>
				<a href="<%=cp %>/goobnemall/qna/list.do">QNA 게시판</a></b></font><br/><br/>
				<font size="2" style="padding-left: 10px;color: #5D5D5D;">의문사항을 남겨주세요. 빠른 시일내에 답변드리겠습니다.</font>
			</td>
		</tr>
		<tr height="50" >
			<td align="right" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #8C8C8C;">
				<input type="button" value=" 글쓰기 " onclick="javascript:location.href='<%=cp%>/goobnemall/qna/created.do'"
				style="padding: 10px; color: white; background-color: #f9732e; border: 0px; outline: none;"/>
			</td>
		</tr>
	</table>
	
	<table border="0" align="center" width="1000px" cellspacing="0" cellpadding="0">
		<tr height="50" align="center">
			<td width="10%">
				<font>번호</font>
			</td>
			<td width="60%">
				<font>제목</font>
			</td>
			<td width="15%">
				<font>작성자</font>
			</td>
			<td width="15%">
				<font>작성일</font>
			</td>
		</tr>
		
		<tr height="40" bgcolor="#F6F6F6">
			<td align="center" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<input type="text" value="공지" readonly="readonly" onfocus="this.blur()"
				style="border: none;border: solid;border-width: 1px;border-color: #F15F5F;background-color: #FFD8D8;
				width: 50px;height: 20px;text-align: center;"/>
			</td>
			<td align="left" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<a href="https://m.mosanfs.co.kr/web/product/big/201908/11b74cb2bf7230aab90f60d1230cf6fd.jpg">
					<font color="#F15F5F" style="font-weight: 700;">[폐업기념] 5분에게 깍두기치밥을 무료로 드립니다!</font>
				</a>
			</td>
			<td align="center" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<font>관리자</font>
			</td>
			<td align="center" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<font>2020.11.10</font>
			</td>
		</tr>
		
		<c:forEach var="dto" items="${lists }">
		<tr height="40">
			<td align="center" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<font>${dto.qnaNum }</font>
			</td>
			<td align="left" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<font><a href="${articleUrl }&qnaNum=${dto.qnaNum }">${dto.subject }</a></font>
			</td>
			<td align="center" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<font>${dto.id }</font>
			</td>
			<td align="center" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<font>${dto.created }</font>
			</td>
		</tr>
		</c:forEach>
		
		<tr height="50" bgcolor="#F6F6F6">
			<td colspan="4" align="center" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<c:if test="${dataCount != 0 }">
				<font>${pageIndexList }</font>
				</c:if>
				<c:if test="${dataCount == 0 }">
				<font>등록된 문의글이 없습니다.</font>
				</c:if>
			</td>
		</tr>
		
		<tr height="5" bgcolor="#F6F6F6">
			<td valign="middle" colspan="4" align="center" style="border-bottom: solid;border-bottom-width: 1px;border-bottom-color: #EAEAEA;">
				<form action="" name="searchForm" method="post">
					<select name="searchKey"
					style="width: 70px;height: 25px; font-family: inherit;">
						<option value="subject" >제목</option>
						<option value="id">ID</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="searchValue"
					style="width: 130px; height: 15px; font-family: inherit;"/>
					<input type="button" value=" 검 색 " onclick="sendIt(); "
					style="width: 70px;height: 25px; font-family: inherit; background-color: #ffffff; outline: none;"/>
				</form>
			</td>
		</tr>
		
		<tr height="50">
			<td colspan="4" align="right">
				<input type="button" value=" 돌아가기 " onclick="javascript:location.href='<%=cp%>/goobnemall/index.do'"
				style="padding: 10px; color: white; background-color: #f9732e; border: 0px; outline: none;"/>
			</td>
		</tr>
		<tr height="50px"></tr>
	</table>
</div>


<%@ include file="//goobne/data/footer.jsp" %>
