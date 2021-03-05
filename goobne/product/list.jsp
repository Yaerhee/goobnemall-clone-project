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
	
<%@ include file="//goobne/data/header.jsp" %>
	
<%@ include file="//goobne/data/categoryhead.jsp" %>
<script type="text/javascript">

	function sendIt(){
		var f = document.myForm;
		f.action = "<%=cp%>/goobnemall/product/listdetail.do";
		f.submit();

	}
</script>

	<br />
	<br />
	<form action="" name="myForm" method="post">

		<div class="mainContBox">
			<div class="titWrap">
				<h1 class="tit">굽네몰의 모든 제품을 구경해보세요!</h1>
				<p class="cmnt">
					<a href="<%=cp%>/goobnemall/product/list.do">더보기</a>
				</p>
				<br />
				<br />
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
								<span class="text-muted">&#9733; &#9733; &#9733; &#9733;
									&#9733;</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</form>
<%@ include file="//goobne/data/footer.jsp" %>

