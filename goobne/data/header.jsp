<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>굽네몰</title>


	
<link type="text/css" rel="stylesheet"
	href="http://www.goobnemall.com/static-root/resources/pc/css/main.css">

<!-- 메인 폰트, 데이터 담는 틀 UI 정보 다 들어가 있음 -->
<link type="text/css" rel="stylesheet" href="<%=cp %>/goobne/data/css/common.css">
<link type="text/css" rel="stylesheet" href="<%=cp %>/goobne/data/css/jquery.ui.css">
<link type="text/css" rel="stylesheet" href="<%=cp %>/goobne/data/css/jquery.ui.gnmall.css">
<link type="text/css" rel="stylesheet" href="<%=cp %>/goobne/data/css/contents.css">
<link type="text/css" rel="stylesheet" href="<%=cp %>/goobne/data/css/swiper.min.css">
<link type="text/css" rel="stylesheet" href="<%=cp %>/goobne/data/css/easy-autocomplete.css">
<link type="text/css" rel="stylesheet" href="<%=cp %>/goobne/data/css/easy-autocomplete.themes.css">
<link type="text/css" rel="stylesheet" href="<%=cp %>/goobne/data/css/font-awesome.min.css">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>

<script type="text/javascript" src="<%=cp %>/goobne/data/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=cp %>/goobne/data/js/jquery.ui.min.js"></script>

<!-- 이미지 슬라이딩 기능 포함-->
<script type="text/javascript" src="<%=cp %>/goobne/data/js/style.js"></script>
<script type="text/javascript" src="<%=cp %>/goobne/data/js/slides.jquery.js"></script>
<script type="text/javascript" src="<%=cp %>/goobne/data/js/user.js"></script>
<script type="text/javascript" src="<%=cp %>/goobne/data/js/swiper.min.js"></script>

<script type="text/javascript">

	function search() { 
		
		var f = document.myForm2;
		
		
		f.action = "<%=cp%>/goobnemall/product/search.do";
		f.submit();
		
	}

</script>

</head>
<body>

<div id="topAd" style="display: block; background-color: #F74B41;">
<div class="bg_rt" style="display: block; background-color: #ffc2b8;"></div>
	<div class="inner">
		<a href="#">
		<img src="http://www.goobnemall.com/static-root/cntnt/2020/07/01/485571cdf233444c8fcdd500292e3046.jpg"
		alt="첫구매시 추천상품이 100원"></a>
		<a href="#">
		<img src="http://www.goobnemall.com/static-root/cntnt/2020/07/15/68949e7e199f4c189f58693f6054fde4.jpg"
		alt="듀먼_영양화식_PC_TOP배너"></a>
		<button onclick="javascript:topBannerClose();" class="closeLyBtn1 btnImg">
		<span>오늘 하루 보이지 않음 | 닫기</span>
		</button>
	</div>
</div>

<div id="header">
	<div class="headerCont LGN_TP_GUEST clB">
		<h1>
			<a href="<%=cp%>/goobnemall/index.do"> 
			<img src="http://www.goobnemall.com/static-root/resources/pc/img/2017/logo.png"
			alt="굽네몰"></a>
		</h1>
	<div id="util">
		<ul>
		<c:choose>
			<c:when test="${empty sessionScope.customInfo.userId }">
			<li><a href="<%=cp%>/goobnemall/user/signin.do">로그인</a></li>
			</c:when>
			<c:otherwise>
			<li><a href="<%=cp%>/goobnemall/user/logout.do">로그아웃</a></li>
			</c:otherwise>
		</c:choose>
			<li><a href="<%=cp%>/goobnemall/user/signup.do">회원가입</a></li>			
		<c:choose>
			<c:when test="${empty sessionScope.customInfo.userId }">
			<li><a href="<%=cp%>/goobnemall/user/signin.do">마이페이지</a></li>
			</c:when>
			<c:otherwise>
			<li><a href="<%=cp%>/goobnemall/user/mypage.do">마이페이지</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${empty sessionScope.customInfo.userId }">
			<li><a href="<%=cp%>/goobnemall/user/signin.do">장바구니</a></li>
			</c:when>
			<c:otherwise>
			<li><a href="<%=cp%>/goobnemall/order/cart.do">장바구니</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${empty sessionScope.customInfo.userId }">
			<li><a href="<%=cp%>/goobnemall/user/signin.do">문의하기</a></li>
			</c:when>
			<c:otherwise>
			<li><a href="<%=cp%>/goobnemall/qna/list.do">문의하기</a></li>
			</c:otherwise>
		</c:choose>
		</ul>
	</div>
	<div class="headerBanner">
		<div class="listW">
			<ul>
				<li><a href="#"> <img src="http://www.goobnemall.com/static-root/cntnt/2019/12/03/0aa82cf6d4b14519b27af8574a25b314.jpg"
				alt="100%휴먼그레이드 자연영양식 듀먼"></a></li>
			</ul>
		</div>
		<div class="btnW">
			<a href="" class="btnImg btnPrev"></a> <a href="" class="btnImg btnNext"></a>
		</div>
	</div>
		<script type="text/javascript">
			topBnnerSlider(".headerBanner", 2500, "fade");
		</script>
		
	<form id="topSearchForm" name="myForm2" method="post">
		<input type="text" name="dummy" id="dummy" style="display: none">
		<div class="srchArea">
			<div class="active srchWrap">
				<input type="text" id="top_keyword" name="searchValue"
						class="keyword" title="검색어" value="" placeholder="검색어를 입력하세요"/>
				<button class="btnImg btnSrch" id="srchBtn"
					onclick="search();">
					<span>검색</span>
				</button>
			</div>
		</div>
	</form>
</div>

<div id="gnb">
	<div class="inner">
	<ul class="sub_ctg_dep">
		<li class="ctg_dep_tit"><a href="#" class="ctgTitle" id="">닭가슴살</a>
			<ul class="sub_ctg_dep02">
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=소스가 맛있는 닭가슴살';">
				소스가 맛있는 닭가슴살</a></li>
				<!-- <li><a href="#">소스가 맛있는 닭가슴살</a></li> -->
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=훈제 슬라이스';">
				훈제 슬라이스</a></li>
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=수비드';">
				수비드</a></li>
			</ul></li>
		<li class="ctg_dep_tit"><a href="#" class="ctgTitle" id="">소시지/햄</a>
			<ul class="sub_ctg_dep02">
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=후랑크';">
				후랑크</a></li>
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=닭가슴살햄';">
				닭가슴살햄</a></li>
			</ul></li>
		<li class="ctg_dep_tit"><a href="#" class="ctgTitle" id="">볼/스테이크/큐브</a>
			<ul class="sub_ctg_dep02">
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=닭가슴살볼';">
				닭가슴살볼</a></li>
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=오븐스테이크';">
				오븐스테이크</a></li>
			</ul></li>
		<li class="ctg_dep_tit"><a href="#" class="ctgTitle" id="">치밥/볶음밥</a>
			<ul class="sub_ctg_dep02">
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=치밥/볶음밥';">치밥/볶음밥 <span class="ic_new_ss">New</span></a></li>
<!-- 고치기 --> <li><a href="#">[특가]볼케이노치밥</a></li>
			</ul></li>
		<li class="ctg_dep_tit"><a href="#" class="ctgTitle" id="">소스/샐러드</a>
			<ul class="sub_ctg_dep02">
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=소스';">
				소스</a></li>
				<li><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category2=샐러드';">
				샐러드</a></li>
			</ul></li>
		<li class="ctg_dep_tit"><a href="#" class="ctgTitle" id="">모든판매상품</a>
			<ul class="sub_ctg_dep02">
				<li><a href="<%=cp%>/goobnemall/product/list.do">상품 모두 보기
					<span class="ic_new_ss">New</span></a></li>
			</ul></li>
		<li class="ctg_dep_tit"><a href="#" class="ctgTitle" id="">제작자 보기</a>
			<ul class="sub_ctg_dep02">
				<li><a href="#">안다현</a></li>
				<li><a href="#">이예리</a></li>
				<li><a href="#">임의빈</a></li>
				<li><a href="#">정민철</a></li>
			</ul></li>
		<div class="ctg_dep_close" id="btnGnbClose">닫기</div>
	</ul>
		
	<ul class="gnb">
		<li class="ctgTop"><a href="#showMeue" class="gnbDep1 sub_ctg">
			<span id="btnGnbOpen">전체보기</span>
			</a></li>
		<li class=""><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category1=닭가슴살';"
			onclick=""
			class="gnbDep1"> <span>닭가슴살</span>
			</a></li>
		<li class=""><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category1=소시지/햄';"
			onclick=""
			class="gnbDep1"> <span>소시지/햄</span>
			</a></li>
		<li class=""><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category1=볼/스테이크';"
			onclick=""
			class="gnbDep1"> <span>볼/스테이크</span>
			</a></li>
		<li class=""><a href="javascript:location.href='<%=cp%>/goobnemall/product/list.do?category1=치밥/볶음밥';"
			onclick=""
			class="gnbDep1"> <span>치밥/볶음밥</span>
			</a></li>
	</ul><div class="bgDep2"></div>
	</div>
</div>	
</div>