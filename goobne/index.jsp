<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">

<%@ include file="data/header.jsp" %>


<!-- 이미지 슬라이딩 -->
<div class="mainBanner">
	<div class="imgSliderWrap listW">
		<ul class="sliderImg">
			<li style="background-color:; background-image: url('http://www.goobnemall.com/static-root/cntnt/2020/11/02/dec046c0146741ef9b940d01269543d2.jpg'); 
			background-position: left; background-repeat: no-repeat">
				<a href="#" onclick="" title="">
				<img src="http://www.goobnemall.com/static-root/cntnt/2020/11/03/1fd20d1432574125b08167ef1a5a7ae8.jpg"
				alt="소맛닭 텐텐딜_pc"></a>
			</li>
			
			<li style="background-color:; background-image: url('http://www.goobnemall.com/static-root/cntnt/2020/11/06/48d63dae6fd04f4da99c90859c7d40f5.jpg'); 
			background-position: center top; background-repeat: no-repeat">
				<a href="#" onclick="" title="">
				<img src="http://www.goobnemall.com/static-root/cntnt/2020/11/06/69f7d33e08de4e0d800c82cb183fab42.jpg"
				alt="볼 인싸템_pc"></a>
			</li>
			
			<li style="background-color:; background-image: url('http://www.goobnemall.com/static-root/cntnt/2020/11/05/eb6795b19fe64c019a2b1d6c8c968eb2.jpg'); 
			background-position: center top; background-repeat: no-repeat">
				<a href="#" onclick="" title="">
				<img src="http://www.goobnemall.com/static-root/cntnt/2020/11/05/f6492f9755bc4b6bbc05f61b3c7c364c.jpg"
				alt="첫구매 추천_pc"></a>
			</li>
			
			<li style="background-color:; background-image: url('http://www.goobnemall.com/static-root/cntnt/2020/10/30/f48f52df7c214088b34038b59d38b6f5.jpg'); 
			background-position: center top; background-repeat: no-repeat">
				<a href="#" onclick="" title="">
				<img src="http://www.goobnemall.com/static-root/cntnt/2020/10/30/c88ed8ed6c31476b86a065340bf33886.jpg"
				alt="반해브리또_pc"></a>
			</li>
			
			<li style="background-color:; background-image: url('http://www.goobnemall.com/static-root/cntnt/2020/10/26/e247b834776f4c0aba8581476be5192c.jpg'); 
			background-position: center top; background-repeat: no-repeat">
				<a href="#" onclick="" title="">
				<img src="http://www.goobnemall.com/static-root/cntnt/2020/10/26/5c5f036cea7d459c9565e7b1dbe5e586.jpg"
				alt="친추이벤트_pc"></a>
			</li>
			
			<li style="background-color:; background-image: url('http://www.goobnemall.com/static-root/cntnt/2020/09/08/c5eac5c9be6443f09cc0a49d608d5431.jpg'); 
			background-position: center top; background-repeat: no-repeat">
				<a href="#" onclick="" title="">
				<img src="http://www.goobnemall.com/static-root/cntnt/2020/09/17/d2f69a14d87d404ab58fa148baaf5756.jpg"
				alt="소맛닭 1주년 앵콜_pc"></a>
			</li>
			<li style="background-color:; background-image: url('http://www.goobnemall.com/static-root/cntnt/2020/10/30/f0e8a82ccbc04c10a7a818d655664cc9.jpg'); 
			background-position: center top; background-repeat: no-repeat">
				<a href="#" onclick="" title="">
				<img src="http://www.goobnemall.com/static-root/cntnt/2020/10/30/3f72491d61b04ee3a1f385db86a7a049.jpg"
				alt="신제품리뷰_호빵,바게트_pc"></a>
			</li>
		</ul>
	</div>
	
	<div class="ctrl">
		<span class="prev"><a href="#prevB">&nbsp;</a></span> <span><strong>1</strong>/7</span>
		<span class="next"><a href="#nextB">&nbsp;</a></span> 
		<span class="pause" id="pause">&nbsp;</span>
	</div>
	<div class="pagingW"></div>
	
</div>

	<script type="text/javascript">
		bannerSlider(".mainBanner", 3500, "fade");
	</script>

	<!-- 아이템 리스트 -->
	<br/><br/>
<div class="mainContBox">
	<div class="titWrap">
		<h1 class="tit">굽네몰의 신제품을 구경해보세요!</h1>
		<p class="cmnt"><a href="<%=cp%>/goobnemall/product/list.do">더보기</a></p><br/><br/>
	</div>

	<div class="row">
		<c:forEach var="dto" items="${lists }">
		<div class="col-lg-4 col-md-4 mb-4">
			<div class="card h-100">
				<a href="javascript:location.href='<%=cp%>/goobnemall/product/listdetail.do?productNum=${dto.productNum}';">
					<img class="card-img-top" src="${dto.pic1 }"></a>		
					<div class="card-body">
						<h5 class="card-title">
							<a href="javascript:location.href='<%=cp%>/goobnemall/product/listdetail.do?productNum=${dto.productNum}';">
							${dto.productName }<span class="ic_new_ss"></span></a>
						</h5>
						<h6>
							<!-- fmt option 활용하여 가격 출력 format 수정 -->
							<fmt:formatNumber value="${dto.price }" pattern="￦ #,###원" />
						</h6>
					</div>
				<div class="card-footer">
					<span class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9733;</span>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
</div>

<%@ include file="data/footer.jsp" %>


