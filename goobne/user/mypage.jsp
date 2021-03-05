<%@page import="com.goobne.CustomInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	CustomInfo info = (CustomInfo)session.getAttribute("customInfo");

%>
<%@ include file="//goobne/data/header.jsp" %>

<!-- 마이페이지 내용 -->

<!-- 왼쪽 바 부분 시작 -->
	<div id="container" class="haveSNB">
		<ul class="path">
			<li><a href="/">홈</a></li>
			<li class="current"><a>마이페이지</a></li>
		</ul>
		<!-- 상단 -->
		<div id="snb">
			<div class="snbTit mypg">
				<h2>
					<a href="#">마이페이지</a>
				</h2>
			</div>
			<ul class="snb haveSub">
				<li><span class="snbDep2">나의 쇼핑정보</span>
					<ul class="snbDep3">
						<li><a href="#">주문내역조회</a></li>
						<li><a href="#">미입금내역 조회</a></li>
						<li><a href="#">취소/교환/반품 조회</a></li>

						<li><a href='#'>배송지 관리</a></li>
						<li style="display: none;"><a href='#'>위시리스트</a></li>
					</ul></li>

				<li><span class="snbDep2">나의 통장현황</span>
					<ul class="snbDep3">
						<li><a href="#">굽머니</a></li>
						<li><a href="#">쿠폰</a></li>
						<li><a href="#">적립금</a></li>
						<li><a href="#">예치금</a></li>
					</ul></li>
				<li><span class="snbDep2">나의 활동관리</span>
					<ul class="snbDep3">
						<li><a href="#">>시식후기</a></li>
						<li><a href="#">상품 Q&amp;A</a></li>
						<li><a href="#">1:1 상담문의</a></li>
					</ul></li>

			</ul>
		</div>

	<!-- 컨텐츠 부분 -->
	<div id="contents">
		<div class="titWrap">
			<h3 class="pTit">나의 쇼핑정보</h3>
		</div>

		<div class="myShoppingInfo">
			<div class="NEWmy">
				<div class="myInfo">
					<div class="img">
						<img src="http://www.goobnemall.com/static-root/cntnt/2017/07/20/201357885c914295b67611de4fee31d0.png"
						alt="패밀리 등급" />
					</div>
						<!-- ##등급별 이미지 
							VIP : icon_vip.png / 골드(Gold) : icon_gold.png / 실버(SILVER) : icon_silver.png / 패밀리(FAMILY) : icon_family.png 
							비회원 이미지(2016-01-27 추가) : icon_nonMember.png 
							트레이너 : icon_trainer.png / 사업자 : icon_business.png
					-->
					<div class="cont">
						<p><em class="name"><%=info.getUserId() %></em>님의 멤버십 등급은 <em class="grade">${grade }</em>입니다.</p>
						<a href="#" class="btnD">회원등급혜택</a>
					</div>
				</div>
					<div class="mileage">
						<ul>
						<li><i class="myIcon coupon"></i> <span class="tit">할인쿠폰</span>
							<span class="num"><strong>2</strong>장</span></li>
						<li><i class="myIcon reserve"></i> <span class="tit">적립금</span>
							<span class="num"><strong>0</strong>원</span></li>
						<li><i class="myIcon deposit"></i> <span class="tit">예치금</span>
							<span class="num"><strong>0</strong>원</span></li>
						<li><i class="myIcon money"></i> <span class="tit">굽머니</span>
							<span class="num"><strong>0</strong>원</span></li>
						</ul>
					</div>
			</div>
				<div class="NEWmy clB">
					<div class="status flL">
						<dl><dt><strong>주문/배송</strong>현황</dt>
							<dd><ul class="step">
								<li>주문접수 <strong class="num">0</strong></li>
								<li>결제완료 <strong class="num">0</strong></li>
								<li>상품준비중 <strong class="num">0</strong></li>
								<li>배송중 <strong class="num">0</strong></li>
								<li>배송완료 <strong class="num">0</strong></li>
							</ul></dd>
						</dl>
						<dl>
							<dt><strong>교환/반품</strong>현황</dt>
							<dd><ul class="step">
								<li>반품진행 <strong class="num">0</strong></li>
								<li>교환진행 <strong class="num">0</strong></li>
								<li>환불/교환완료 <strong class="num">0</strong></li>
							</ul>
						</dd>
					</dl>
				</div>

				<div class="status02">
					<dl class="h95">
						<dt><strong>문의</strong>현황</dt>
							<dd><ul class="list01">
							<li>1:1 상담문의 답변이 등록되었습니다. 
							<span class="flR"><a href="#"><strong class="num">0</strong></a>건</span></li>
							</ul></dd>
					</dl>
				</div>
			</div>
		</div>

		<!-- 쇼핑 정보 -->
		<div class="titWrap type02">
			<h4 class="flL tit valB">최근주문내역조회</h4>
		</div>

		<div class="prdtTbl bdLR">
			<div class="myTbl">
				<table>
					<caption>주문내역현황</caption>
					<colgroup>
						<!-- 여기에 주문 목록 출력하게 해야함 -->
						<col width="150px" />
						<col width="30px" />
						<col width="80px" />
						<col width="*" />
						<col width="120px" />
						<col width="120px" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">주문일자/주문번호</th>
							<th scope="col" colspan="3">구매내역</th>
							<th scope="col">총결제금액</th>
							<th scope="col">배송구분</th>
							<th scope="col">후기</th>
						</tr>
						
						<c:forEach var="dto" items="${listsOrderInfoDto }" varStatus="status">
						<tr height="40px" align="center">
							<td scope="col">${dto.orderDate } / ${dto.orderNum }</td>
							<td scope="col" colspan="3">
								<a href="<%=cp%>/goobnemall/product/listdetail.do?productNum=${listsProductDto.get(status.index).getProductNum() }">
								<b>${listsProductDto.get(status.index).getProductName() }</b>
								</a>
							</td>
							<td scope="col"><fmt:formatNumber value="${dto.totalCost }" pattern="#,###"/>원</td>
							<td scope="col">${dto.orderState }</td>
							<td scope="col">
							<a href="javascript:location.href='<%=cp%>/goobnemall/product/review.do?orderNum=${dto.orderNum}&productNum=${listsProductDto.get(status.index).getProductNum() }';"> 작성 </a>
</td>
							
						</tr>
						</c:forEach>
						
					</thead>
					<tr align="left" bgcolor="#FF8224" bordercolor="#FF8224">
							<td colspan="7" align="right" bgcolor="#FF8224">
								<h2><font color="white">총결제금액 : <fmt:formatNumber value="${totalAllCost }" pattern="#,###"/> 원</font></h2>
							</td>
						</tr>
					<tbody id="ord-std-tbody">

					</tbody>
				</table>
			</div>
		</div>
		
		<div class="titWrap type06">
			<h4 class="tit">나의 회원정보</h4>
		</div>
		<div class="myInfo">
			<ul><li>
				<div class="info">
					<i class="myIcon phone"></i>
					<!-- 여기부터도 로그인 한 회원정보 불러와야함 -->
						<p class="tit">휴대폰</p>
						<p>${buyerTel1 }-${buyerTel2 }-${buyerTel3 }</p>
						<p class="fc99">수신동의안함</p>
				</div>
				<div class="edit">
					<span class="date">최종수정일 : ${created }</span>
					<a href="javascript:alert('준비중입니다.');" class="btnF">정보수정</a>
				</div></li>
				
				<li>
				<div class="info">
					<i class="myIcon email"></i>
					<p class="tit">이메일</p>
					<p>&nbsp;${buyerEmail1 }@${buyerEmail2 }</p>
					<p class="fc99">수신동의안함</p>
				</div>
				<div class="edit">
					<span class="date">최종수정일 : ${created }</span> 
					<a href="<%=cp %>/goobnemall/user/withdrawal.do" class="btnF">회원탈퇴</a>
				</div></li>
				
				<li>
				<div class="info">
					<i class="myIcon addr"></i>
					<p class="tit">배송지관리</p>
					<p class="cont">자주 사용하는 배송지 주소를 입력해두세요! 쇼핑이 편해집니다.</p>
				</div>
				<div class="edit">
				<span class="date">최종수정일 : ${created }</span>
				<a href="javascript:alert('준비중입니다.');" class="btnF">배송지관리</a>
				</div></li>
				</ul>
			</div>

		</div>

	</div>

	<!-- 주문 목록 -->

<br/><br/><br/><br/><br/><br/>

<%@ include file="//goobne/data/footer.jsp" %>


