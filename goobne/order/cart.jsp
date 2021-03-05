<%@page import="com.goobne.CustomInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.goobne.CartDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");//한글깨짐방지
CustomInfo info = (CustomInfo)session.getAttribute("customInfo");


%>
<%@ include file="//goobne/data/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장바구니 페이지</title>
<script type="text/javascript">

	function chk() {
		var x = document.myFrom;
		if(x.qty.value==1){
			x.qty.value=1;
		}
		
	}
	
	function sendIt(){
		var f = document.myForm;
		f.action = "<%=cp%>/goobnemall/order_cart.do";
		f.submit();
	}
	

</script>

</head>
<body>

<div id="container">
	<ul class="path">
				<li><a href="#none">홈</a></li>
				<li class=""><a href="#none">장바구니</a></li>
				<li class=""><a href="#none">일반배송</a></li>
				<li class="current"><a href="#none">장바구니</a></li><!-- 현재 카테고리 li.current  -->
	</ul>
	
	<div id="contents">
	<form action="" name="myForm">
	<div class="titWrap">
		<h2 class="pTit">장바구니</h2>
		
		<div class="flR">
			<ul class="cartStep">
				<li class="on">
				<div class="step"><span>01</span><strong>장바구니</strong></div>
				</li><!-- 현재단계 : li.on -->
				
				<li>
				<div class="step"><span>02</span><strong>주문서작성/결제</strong></div>
				</li>
				
				<li class="last">
				<div class="step"><span>03</span><strong>주문완료</strong></div>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="cartTab">
				<ul>
					<li class="on"><a href="/view/bsk/cart">일반배송<strong>${lists.size() }</strong></a></li>
				</ul>
				<p class="noti01"><i class="icon notice"></i> 배송지별 총주문금액이 <span class="fc01">총 30,000원 이상 시에는 배송비가 무료</span>입니다.</p>
	</div>
	


	<div class="titWrap type02">
		<h3 class="tit02">일반배송 장바구니</h3>
	</div>
	
	<div class="cartTbl">
		<table>
			<caption>장바구니</caption>
				<colgroup>
					<col width="30px">
					<col width="*">
					<col width="140px">
					<col width="110px">
				</colgroup>
			
			<thead>
				<tr>
					<th scope="col" class="alR"><input type="checkbox" title="전체선택" class="bskPrdctChk bskPrdctAll" checked="true"></th>
					<th scope="col">상품</th>
					<th scope="col">상품금액</th>
				</tr>
			</thead>
			
			<tbody>
	<c:forEach var="dto" items="${lists }" varStatus="status" >
	<tr class="productRow">
				<td class="alR">
				<input type="checkbox" title="상품선택" class="bskPrdctChk bskPrdctItm" name="prdct_id" value="5D8I1BJLZ" checked="true">
				
				</td>
			<td class="item ">				
			<!-- 상품정보 -->
			<div class="itemWrap">
				<div class="imgArea">
					<a href="<%=cp %>/goobnemall/product/listdetail.do_cart?num=${dto.num}" class="itemImg">
					<img src="${dto.pic1}">
					</a>
				</div><!-- //imgArea -->
				
		<div class="infoArea">
				<div class="itemTit">
					<p class="name">
					<a href="<%=cp %>/goobnemall/product/listdetail.do_cart?num=${dto.num}">${dto.productName }</a>
					</p>
				</div><!-- //itemTit -->

			<div class="selectedItem">
				<!-- 선택된 상품 리스트 -->
			<ul>
				<li class="productItemRow">
				
				<!-- 여기서부턴 반복하면 될듯 -->
					<div class="itemName">
						<a href="<%=cp %>/goobnemall/product/listdetail.do_cart?num=${dto.num}">${dto.productName }</a>
					</div>
	
					<div class="itemQuantity">
						<div class="itemQuant">
							<input type="text" name="qty" value="${dto.qty }" size="3">
								<button class="btnPlus" type="button"
								onclick="javascript:location.href='<%=cp%>/goobnemall/order/cart_update.do?num=${dto.num}&qty=${dto.qty+1 }';">
								</button>
								<button class="btnMinus" type="button"
								onclick="javascript:location.href='<%=cp%>/goobnemall/order/cart_update.do?num=${dto.num}&qty=${dto.qty-1 }';">
								</button>
						</div>
								<button class="btnE sub" type="button">&nbsp;<span class="chngQty">변경</span></button>
					</div>
		
					<div class="itemPrice"><span class="price"><strong><fmt:formatNumber value="${dto.price }" pattern=" #,###" /></strong>원</span></div>
	
					<div class="itemDelete">
						<script>
							function deleteCheck() {
								var f = document.myForm;
								var result = confirm("장바구니에서 삭제하시겠습니까?");
								if(result) {
									location.href="<%=cp%>/goobnemall/order/delete.do?num=${dto.num}";
								}
							}
						</script>
						
						<a href="javascript:deleteCheck();" 
						class="btnImg delItem removeProductItemBtn"><span>제품 삭제</span></a>
					</div>
				</li>
			</ul>
			</div>
		</div>
	</div>
			</td>
		<td><span class="price"><strong><fmt:formatNumber value="${dto.price }" pattern=" #,###" /></strong>원</span></td>
		
	</tr>
	</c:forEach>
		</tbody>
	</table>
	</div><!-- cart 닫힘 -->
	
	<div class="cartPriceSum" id="cartPriceSum">
		<dl><dt>총상품금액</dt>
			<dd><span class="price"><strong><fmt:formatNumber value="${totPrice }" pattern=" #,###" /></strong>원</span></dd>
		</dl>
		
		<dl><dt><i class="iconCart plus"><span>더하기</span></i> 배송비</dt>
	<c:choose>
		<c:when test="${totPrice<=30000 }">
			<dd><span class="price"><strong>3,000</strong>원</span></dd>
		</c:when>
		<c:otherwise>
			<dd><span class="price"><strong>0</strong>원</span></dd>
		</c:otherwise>
	</c:choose>
		</dl>
		
		<dl class="total"><dt><i class="iconCart equal"><span>는</span></i> 총주문금액</dt>
		<dd>		
		<c:choose>
			<c:when test="${totPrice<=30000 }">
				<span class="price"><strong><fmt:formatNumber value="${totPrice+3000 }" pattern=" #,###" /></strong>원</span>
			</c:when>
			<c:otherwise>
				<span class="price"><strong><fmt:formatNumber value="${totPrice}" pattern=" #,###" /></strong>원</span>
			</c:otherwise>
		</c:choose>
		</dd></dl>
		
		<div class="free_dc ">
			<c:choose>
				<c:when test="${totPrice<=30000 }">
					<p class="tit" align="right">&nbsp;&nbsp;&nbsp;&nbsp;
					<em>${30000-totPrice }</em>원을 더 담으시면 배송비무료!</p>
				</c:when>
				<c:otherwise>
					<p class="tit" align="right">&nbsp;&nbsp;&nbsp;&nbsp;
					배송비무료!</p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<div class="noti02">
		<p class="tit">※ 배송비 안내</p>
		<p class="cont"><br/>
		주문 시 <strong class="fc88">주문 총금액이 30,000원 이하이면 배송료 3,000원이 부과</strong>되며,<br/>택배의 경우에는 사정에 따라 일요일을
		제외한 1~2일 추가기간이 소요될 수 있습니다. (도서/산간지역 등)<br>

		</p>
	</div>
	
	<div class="btnWrap cart">
		<a href="#" class="btnM sub2" id="continueShopping" onclick="history.back(-1); return false;">쇼핑계속하기</a>
		<a href="#" class="btnM" id="orderAllPrdct" onclick="sendIt();">전체상품주문</a>
	</div>
	
	<div class="btnWrap cart" style="margin-top: 20px;display:block" id="noNpayPosition"></div>
	<a href="#">
		<center><img src="http://www.goobnemall.com/static-root/resources/pc/img/member/bn_Npay_2019.jpg" alt="첫구매 100원 딜"></center>
		</a>
	<br/><br/>
	
	</form>
	</div>
	</div>

</body>
</html>
<%@ include file="//goobne/data/footer.jsp" %>

