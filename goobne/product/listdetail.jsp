<%@page import="com.goobne.CustomInfo"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
	
	
%>
<%@ include file="//goobne/data/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function () {
	    // 개수 증량
	
	    $(".btnPlus").click(function () {
	    	change(1);
	    });
	
	    // 개수 감소
	    $(".btnMinus").click(function () {
	    	change(-1);
	    });
	
	});
	
	function change(num) {
        var f = document.myForm;
        var y = Number(f.qty.value) + num;
        if (y < 1) {
            y = 1;
            alert("최소 주문 수량은 1개 이상입니다.");
        }
        f.qty.value = y;
        f.price.value = Number(f.qty.value)*Number(f.pricetmp.value);
		
		
    }
	
	$(document).ready(function () {
        // 개수 증량

        var x = document.myForm;
		var y = Number(x.qty.value)+num;
		if(y<1)y=1;
		x.qty.value =y;
        $(".btnPlus").click(function () {
        	change(1);
        });

        // 개수 감소
        $(".btnMinus").click(function () {
        	change(-1);
        });

    });

	function fimg(csrc){
		window.document.images["img1"].src=csrc;
	}
	
	function sendIt_Review(){
		var f = document.myForm;
		if(<%=info==null%>){
			alert("로그인 먼저 해주세요");
			f.action = "<%=cp%>/goobnemall/user/signin.do";
			f.submit();
		}else{
			f.action = "<%=cp%>/goobnemall/product/review.do";
			f.submit();
		}
		
	}
	function sendIt_Order(){
		var f = document.myForm;
		if(<%=info==null%>){
			alert("로그인 먼저 해주세요");
			f.action = "<%=cp%>/goobnemall/user/signin.do";
			f.submit();
		}else{
			
			f.action = "<%=cp%>/goobnemall/order/order.do";
			f.submit();
		}
		
	}
	function sendIt_Cart(){
		var f = document.myForm;
		if(<%=info==null%>){
			alert("로그인 먼저 해주세요");
			f.action = "<%=cp%>/goobnemall/user/signin.do";
			f.submit();
		}else{
			alert("장바구니에 담겼습니다.");
			f.action = "<%=cp%>/goobnemall/order/cart_ok.do";
			f.submit();
		}
		
	}
</script>


</head>
<body>
<br/>
<form action="" name="myForm" method="post" >

<div id="container">
<div id="contents">
	<div class="prdtDtlSum">
	<!-- 상단 왼쪽 -->
	<div class="prdtDtlSumLeft">

	<div class="pdImgArea">
	<div class="prdtImgWrap">
		<img src="${dto.pic1 }" width="300" height="300" name="img1" />
		<span class="discountWrap_thumb w350">
		<span class="discountWrap"><span class="discount">
		<strong>30</strong>%</span></span></span>
	</div>

	<div class="prdtImgList">
		<ul style="width: 535px">
		<li><img src="${dto.pic1}" width="80"
			height="80" onmouseover="fimg('${dto.pic1}')" /></li>
		<li><img src="${dto.pic2}" width="80"
			height="80" onmouseover="fimg('${dto.pic2}')"/></li>
		<li><img src="${dto.pic3}" width="80"
			height="80" onmouseover="fimg('${dto.pic3}')"/></li>
		<li><img src="${dto.pic4}" width="80"
			height="80" onmouseover="fimg('${dto.pic4}')"/></li>
		</ul>

	<div class="btnWrap">
		<a href="#none" class="btnImg btnPrev"><span>이전</span></a> 
		<a href="#none" class="btnImg btnNext"><span>다음</span></a>
	</div>
	</div>
	</div>

	<div class="shareArea">
		<p class="tit">공유하기</p>
		<ul><li><a href="#" class="btnImg facebook"><span>페이스북</span></a></li>
		<li><a href="#" class="btnImg naver"><span>네이버블로그</span></a></li>
		<li><a href="#" class="btnImg kakao"><span>카카오스토리</span></a></li>
		<li><a href="#" class="btnImg url"><span>URL</span></a></li></ul>
	</div>

	<div class="pdReviewArea">
		<div class="titArea">
			<p class="pdTit">
			상품점수
			<span class="score ">${score }</span>
			<strong class="fc01 fs20 hide">0</strong>
			</p>
	
				<button class="btnBuy" onclick="sendIt_Review();">후기 보러가기</button>
				<input type="hidden" name="productNum" value="${dto.productNum }"/>
			
		</div>
		<!-- 여기 후기 및 평점 출력해야함 -->

		</div>

	</div>

	<!-- 상단 오른쪽 -->
	<div class="prdtDtlSumRight">

	<!-- 정보 영역 -->
	<div class="pdInfoArea">
	<div class="prdtCode">
		<dl><dt>상품코드 :</dt><dd>${dto.productNum}</dd></dl>
	</div>
	
	<div class="prdtTitWrap">
		<p class="prdtCmnt"></p>
		<h2 class="prdtTit">${dto.productName }</h2>
	</div>

	<div class="dpIconWrap">
	<span class="icoDisplay typeC">할인</span>
	</div>

	<!-- 영양분석표 -->
	<div class="nutritionWrap">
	<a href="#none" class="btnD openLyBtn">영양분석표</a>
		<div class="nutritionLy lyWrap">
		<a href="#none" class="btnImg closeLyBtn"><span>레이어 닫기</span></a>
		
		<div class="lyTit">영양정보</div>
		<div class="lyCont"><br/>
		<h3 align="center">그게 왜 궁금해요...?</h3><br/>
		<img src="<%=cp %>/goobne/data/images/saddak.png" width="180" height="150"/>
		</div>
		</div><!-- 영양정보 끝 -->
	</div>

	<div class="prdtInfoWrap">
		<dl><dt>판매가</dt>
			<dd><span class="primecost"><strong><fmt:formatNumber value="${dto.price*1.3}" pattern="#,###" /></strong>원</span>
				<span class="price"> <strong>
				<fmt:formatNumber value="${dto.price}" pattern="#,###" /></strong>원</span>
				<!-- 할인되어서 청구되는 금액 -->
	
	<div class="nutritionLy saleWrap lyWrap">
		<a href="#none" class="btnImg closeLyBtn"><span>레이어 닫기</span></a>
	
	</div></dd></dl>

	<dl>
		<dt>배송비</dt><dd>3,000원 (30,000원이상 구매 시 무료배송)</dd>
	</dl>
	<dl>
		<dt>제조사/원산지</dt><dd>상세설명참고</dd>
	</dl>
	<dl>
		<dt>중량</dt><dd>1팩/${dto.amount }g</dd>
	</dl>
	<dl>
		<dt>보관방법</dt><dd>
		<span class="fc01">냉동보관 -18℃이하</span></dd>
	</dl>
	</div>
	
	</div><!-- 정보영역 끝 -->
	
	<div class="pdOrderWrap ">

	<h6 class="tit">소스</h6>
	<div class="selectOption" id="prSourceItemSelect">
		<a href="#none" class="selectOptionBtn"> 
		<span>소스 상품을 선택하세요.</span></a>
	
	<ul class="optionList">
	
	<!-- 이거 반복문으로 될것 같은데 왜 죄다 수정하고있지 ㅋㅋ? -->
	
	<li>
		<a href="#none" class="optionWrap" id="optWrap"> 
		<span class="optionName">볼케이노 소스(290g) 1개</span> 
		<span class="optionPrice"> <span class="discnt"></span> 
		<span class="price"> 4,300원</span></span>
		</a>
	</li>
	<li>
		<a href="#none" class="optionWrap" id="optWrap"> 
		<span class="optionName">볼케이노 소스(290g) 3개</span> 
		<span class="optionPrice"> <span class="discnt"></span> 
		<span class="price"> 12,900원</span></span>
		</a>
	</li>
	<li>
		<a href="#none" class="optionWrap" id="optWrap"> 
		<span class="optionName">갈비천왕 소스(290g) 1개</span> 
		<span class="optionPrice"> <span class="discnt"></span> 
		<span class="price"> 4,300원</span></span>
		</a>
	</li>
	<li>
		<a href="#none" class="optionWrap" id="optWrap"> 
		<span class="optionName">갈비천왕 소스(290g) 3개</span> 
		<span class="optionPrice"> <span class="discnt"></span> 
		<span class="price"> 12,900원</span></span>
		</a>
	</li>
	
	</ul>
	</div>

	<div class="selectedItem">
		<ul id="prItemList">
			<li id="pritem_001" class="prdctItmMst">
			<input type="hidden" name="itm_id" value="001">
			<input type="hidden" name="pcs_qty" value="1">
		
		<div class="itemName">${dto.productName }</div>
		
		<div class="itemQuantity">
			<div class="itemQuant">
			<input type="text" title="수량" value="1" class="quant" name="qty">
				 <button type="button" class="btnPlus">
                                                    <span>plus</span></button>
                                                <button type="button" class="btnMinus">
                                                    <span>minus</span></button>
			</div>
		</div>
		
		<div class="itemPrice"><span class="price">
		<strong><fmt:formatNumber value="${dto.price}" pattern="#,###" /></strong>
		원</span></div>
		<div class="itemDelete"></div>
			</li>
		</ul>
	</div>

	<div class="deliveryDate">
	<div class="deliDate">
		<dl><dt>배송예정일</dt>
		<dd id="dlv_arrvl_dt_txt">2020.11.20
		</dd></dl>
			<p></p>
			<p class="fc04" style="margin-top: 15px;">현재 일부 출고지연이 발생하여
			지정하신 희망배송일보다 1~2일 더 소요될 수 있습니다.</p>
	</div>

	
	</div>

	<div class="totalPrice">
	<div class="buyCount"></div>총주문상품금액
	
	<div class="tooltipWrap">
	
		<span class="icon tooltipBtn"><span>안내보기</span></span>
		
		<div class="tooltipLyr sizeM">
			<div class="tooltipTit">총주문상품금액</div>
			<div class="tooltipCont">총주문상품금액은 배송비가 포함되어 있지 않습니다. 
			결제시 배송비와 포장비가 추가될 수 있습니다.
			</div>
		
		</div>
	</div>
	<!------------------------------------------------------------ 금액 변하게 수정함 -->
	<input type="hidden" name="pricetmp" value="${dto.price}"/>
	<span class="price"><strong id="totalPrice">
		<input name="price" pattern="\d{1,2}([\.,][\d{1,2}])?"
		style="border:0px; color: #f9732e; font-size: 27px; font-weight: bold;" 
		value="${dto.price}"/>
	</strong>원</span>
	<!------------------------------------------------------------ 금액 변하게 수정함 -->

	</div>

	<div class="orderBtnWrap btn3 alC">
		<button class="btnWish" style="display: none;">위시리스트</button>
		<button class="btnCart openLyBtn" onclick="sendIt_Cart();">장바구니 담기</button>
		
	<div class="nutritionLy lyWrap cartPop">
		<a href="#none" class="btnImg closeLyBtn"><span>레이어닫기</span></a>
		
		<div class="lyCont mgT10">
			<span class="fs13">상품을 장바구니에 담았습니다. <br>
			<strong class="fc33 fs14">장바구니로 이동하시겠습니까?</strong></span>
			
			<div class="mgT10">
			<a href="#" onclick="$('.closeLyBtn').click(); return false;"
				class="btnD">계속 쇼핑</a> <a href="#"
				onclick="goCart('ONE'); return false;" class="btnD sub" >
				장바구니확인</a>
			</div>
		</div>
	</div>
		
		<button class="btnBuy" onclick="sendIt_Order();">구매하기</button>
		<br/><br/>
		
		<a href="/view/event/X4N7DFJQ6MH0DVV4/read?evnt_id=SZ1XHK58I&evntType=CMT&evntSt=20&brdId=I93CH23GL&pageNum=1">
		<img src="http://www.goobnemall.com/static-root/resources/pc/img/member/bn_Npay_2019.jpg"
		alt="첫구매 100원 딜">
		</a>
	</div>
	
	<div id="npay_position" style="margin:20px auto 0; width:285px; display:block">
	<div>
		<p class="fc04"
		style="margin-top:10px;margin-bottom:5px;text-align:center;">※ 네이버페이 결제시
		<span style="font-weight: bold">배송일지정이 불가능</span>합니다.</p>
	</div>
	
	<script type="text/javascript"
		src="https://pay.naver.com/customer/js/naverPayButton.js"
		charset="UTF-8">
	</script>
	<script type="text/javascript">//<![CDATA[
		naver.NaverPayButton.apply({
		BUTTON_KEY: "3413438F-C339-4E8D-AE42-CB1F37F4373A", // 네이버페이에서 할당받은 버튼
		TYPE: "A", // 템플릿을 확인하시고 원하는 타입의 버튼을 선택
		COLOR: 1, // 버튼의 색 설정
		COUNT: 2, // 버튼 개수 설정. 구매하기 버튼(장바구니 페이지)만 있으면 1, 찜하기 버튼(상품 상세
		ENABLE: "Y", // 품절등과 같은 이유에 따라 버튼을 비활성화할 필요가 있을 경우
		//BUY_BUTTON_HANDLER: buy_nc, // 구매하기 버튼 이벤트 Handler 함수 등록, 품절인 경우
		//BUY_BUTTON_LINK_URL:"/rest/ord/naverPayOrder", // 링크 주소 (필요한 경우만 사용)
		//WISHLIST_BUTTON_HANDLER: wishlist_nc, // 찜하기 버튼 이벤트 Handler 함수 등록
		WISHLIST_BUTTON_LINK_URL: "https://pay.naver.com/customer/wishlistPopup.nhn", // 찜하기 팝업
		"": ""
	});</script>

	</div>

	</div></div></div></div>
</div>
</form>


</body>
</html>