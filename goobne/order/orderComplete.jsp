<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ include file="//goobne/data/header.jsp" %>
</head>
<body>
<div id="container">

	<ul class="path">
		<li><a href="#none">홈</a></li>
		<li><a href="#none">주문하기</a></li>
		<li class="current"><a href="#none">주문완료</a></li>
	</ul>

	<div id="contents">
		<div class="titWrap">
			<h2 class="pTit">주문서작성/결제</h2>
			<div class="flR">
				<ul class="cartStep">
					<li>
						<div class="step"><span>01</span><strong>장바구니</strong></div>
					</li>
					<li>
						<div class="step"><span>02</span><strong>주문서작성/결제</strong></div>
					</li>
					<li class="on">
						<div class="step"><span>03</span><strong>주문완료</strong></div>
					</li>
				</ul>
			</div>
		</div>
		
		<table border="0" width="1000" align="center" cellspacing="0" >
			<tr height="50">
				<td width="25%" align="center">
					<div class="titWrap type02">
					<font size="6" face="궁서">
					<h3>대단히 고맙소..</h3></font>
					</div>
				<br/>
				</td>
			</tr>
			<tr height="50">
				<td width="25%" align="left">
					<font size="5"><b>주문 정보 결과</b></font>
				</td>
			</tr>
		</table>
		
		<table border="0" width="1000" align="center" cellspacing="0">
			<tr height="2">
				<td colspan="5" bgcolor="#BDBDBD"></td>
			</tr>
			
			<tr height="50">
				<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
					<span class="icon required"></span>
					<font size="2"><b>입금자명&nbsp;</b></font>
				</td>
				<td colspan="4" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
					&nbsp;&nbsp;${dtoOrderInfo.payerName }
				</td>
			</tr>
			
			<tr height="50">
				<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
					<span class="icon required"></span>
					<font size="2"><b>입금계좌번호&nbsp;</b></font>
				</td>
				<td colspan="4" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
					<font size="2">&nbsp;&nbsp;${dtoOrderInfo.bankName }</font>
				</td>
			</tr>
			
			<tr height="50">
				<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
					<span class="icon required"></span>
					<font size="2"><b>총 금액&nbsp;</b></font>
				</td>
				<td colspan="4" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
					<font size="2">&nbsp;&nbsp;
					<b><fmt:formatNumber value="${dtoOrderInfo.totalCost }" pattern=" #,###" /></b>원</font>
				</td>
			</tr>
		</table>
		
		<table border="0" width="1000" align="center" cellspacing="0"  style="margin-top: 10px;">
			<tr height="50">
				<td width="25%" align="left">
					<font size="5"><b>주문 상품</b></font>
				</td>
			</tr>
		</table>
		
		<table border="0" width="1000" align="center" cellspacing="0">
			<tr height="50">
				<td rowspan="2" width="15%" align="center" style="border-top: solid;border-top-color: #BDBDBD;border-top-width: 1px;border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
					<img alt="no found" src="${dtoProduct.pic1 }" style="height: 100px;width: 100px;">
				</td>
				<td width="70%" align="left" style="border-top: solid;border-top-color: #BDBDBD;border-top-width: 1px;border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
					<font size="2">&nbsp;&nbsp;${dtoProduct.productName }</font>
				</td>
				<td rowspan="2"  width="15%" align="center" style="border-top: solid;border-top-color: #BDBDBD;border-top-width: 1px;border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;border-left: solid;border-left-color: #BDBDBD;border-left-width: 1px;">
					<font size="2"><b>
					<fmt:formatNumber value="${dtoProduct.price*dtoOrderInfo.qty }" pattern=" #,###" />원</b></font>
				</td>
			</tr>
			<tr height="50">
				<td width="70%" align="left" style="border-bottom: solid;border-bottom-color: #BDBDBD; border-bottom-width: 1px;">
					<font size="2">&nbsp;&nbsp;1개 가격 :&nbsp;&nbsp;&nbsp;
					<fmt:formatNumber value="${dtoProduct.price }" pattern=" #,###" />원&nbsp;&nbsp;&nbsp;/
					&nbsp;&nbsp;&nbsp;수량 : &nbsp;&nbsp;&nbsp;${dtoOrderInfo.qty }개&nbsp;&nbsp;&nbsp;</font>
				</td>
			</tr>
			<tr height="2">
				<td colspan="5" bgcolor="#BDBDBD"></td>
			</tr>
		</table>
		
		<table border="0" width="1000" align="center" cellspacing="0">
			<tr>
				<td colspan="3" align="center">
					<input type="button" value="  돌아가기  " align="top" style="height: 50pt;width: 100pt;color: white;font-size: 18pt;background-color: #FF5E00;border: none;margin-top: 14px;" onclick="javascript:location.href='<%=cp%>/goobnemall/index.do';">
				</td>
			</tr>
		</table>
	</div>
</div>
	<br/><br/><br/><br/>
<%@ include file="//goobne/data/footer.jsp" %>

