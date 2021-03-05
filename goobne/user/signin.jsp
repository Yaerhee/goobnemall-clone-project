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
	
<%@ include file="//goobne/data/header.jsp"%>
<!-- 헤더까지 로딩 끝 -->

<script type="text/javascript">
	
	function enterkey() {
	
   		if (window.event.keyCode == 13) {

         // 엔터키가 눌렸을 때 실행할 내용
        sendIt();
    }
}

	function sendIt() {
		
		var f = document.myForm;
		
		if (!f.id.value) {
			alert("아이디를 입력해주세요!");
			f.id.focus();
			return;
		}
		
		if (!f.pwd.value) {
			alert("비밀번호를 입력해주세요!");
			f.pwd.focus();
			return;
		}

		f.action = "<%=cp %>/goobnemall/user/signin_ok.do";
		f.submit();
	
	}
	
</script>

<div id="container">
	<form action="" method="post" class="form-horizontal" name="myForm">
	<ul class="path">
			<li><a href="<%=cp %>/goobnemall/index.do">
			홈</a></li>
			<li class="current"><a href="<%=cp %>/goobnemall/user/signin.do">
			로그인</a></li>
	</ul>

	<!-- contents -->
	<div id="contents">

	<div class="titWrap">
		<h2 class="pTit">로그인</h2> 
	</div>

	<div class="loginCont">

	<!-- 회원 로그인 -->
	<div class="flL">
		<div class="titWrap">
			<h3 class="tit">회원 로그인</h3>
		</div>
		
		<div class="inputWrap">
			<input type="text" class="lgn placeholder required" name="id"
			 style="width:308px" placeholder="아이디를 입력해주세요." title="아이디를 입력해주세요." aria-required="true">
			<input type="password" onkeypress="enterkey();" class="lgn placeholder required" name="pwd" 
			style="width:308px" placeholder="비밀번호를 입력해주세요." title="비밀번호를 입력해주세요." aria-required="true">
			<button type="button" class="btnLgn" onClick="sendIt();">로그인</button>
		</div>
	
	<div>
		<span class="chkW mgR20"><input type="checkbox" id="gn_lild" name="gn_lild" value="EHMP" checked=""><label for="gn_lild">자동 로그인</label></span>
		<span class="chkW"><input type="checkbox" id="mrkt_rcv_yn" name="mrkt_rcv_yn" value="Y" checked=""><label for="mrkt_rcv_yn">혜택 알림받기</label></span>
	
		<div class="tooltipWrap">
			<span class="icon tooltipBtn"><span>안내보기</span></span>
			<div class="tooltipLyr" style="left:0;">
			<div class="tooltipTit">혜택 알림받기</div>
			<div class="tooltipCont">마케팅 수신동의하시면 이벤트 특가정보 및 공지사항 등의 알림을 받을 수 있습니다. 
			알림해지는 로그인 후 마이페이지에서 해지하실 수 있습니다.
			</div></div>
		</div>
	</div>

	<div class="list01 mgT20">
		<ul>
			<li>아직 굽네몰 회원이 아니신가요? <a href="<%=cp %>/goobnemall/user/signup.do" class="btnF flR">회원가입</a></li>
			<li>회원 아이디 또는 비밀번호를 잊으셨나요? <a href="javascript:alert('서비스 준비중입니다.');" class="btnF flR">아이디/비밀번호찾기</a></li>
		</ul>
	</div>

</div>
<div class="flR">
	<div class="titWrap">
		<h3 class="tit">비회원(주문/배송 조회)</h3>
	</div>
	
	<div class="inputWrap">
		<input type="text" name="ord_id" class="lgn placeholder required" 
		style="width:268px" title="주문번호를 입력해 주세요." placeholder="주문번호를 입력해 주세요." aria-required="true">
		<input type="text" name="mble" class="lgn placeholder required" 
		style="width:268px" title="휴대번호('-'없이)를 입력해 주세요." placeholder="휴대번호('-'없이)를 입력해 주세요." aria-required="true">
		<button type="button" class="btnLgn"
		onclick="alert('서비스 준비중입니다.');">주문/배송<br>조회</button>
	</div>

	<div class="list01 mgT20">
		<ul>
			<li>주문번호와 주문 시 입력한 휴대번호를 입력해 주세요.</li>
			<li>비회원 주문/배송조회 가능 기간은 <strong>배송완료일로 부터 90일</strong>입니다.</li>
			<li>90일 이후 주문이나 주문번호를 잊으신 경우에는 <span class="fc01">고객센터 1688-9247</span>로 문의해 주시기 바랍니다.</li>
		</ul>
	</div>
</div>	
</div>



	<div class="btnWrap otherAcc">
		<a href="javascript:alert('준비중입니다.');" class="btnLogin naver"><img src="http://www.goobnemall.com/static-root/resources/pc/img/member/btn_login_naver.png" alt="네이버 계정으로 로그인"></a>
		<a href="javascript:alert('준비중입니다.');" class="btnLogin kakao"><img src="http://www.goobnemall.com/static-root/resources/pc/img/member/btn_login_kakao.png" alt="카카오 계정으로 로그인"></a>
	</div>
	
	<div class="memberBenefit">
		<div>
			<p class="tit">신규 가입 후 첫구매시</p>
			<p class="cmnt">100원 딜 혜택</p>
			<img src="http://www.goobnemall.com/static-root/resources/pc/img/2017/img_memberbn01.png" alt="">
		</div>
		
		<div>
			<p class="tit">신규 가입시</p>
			<p class="cmnt">무료배송 쿠폰 지급</p>
			<img src="http://www.goobnemall.com/static-root/resources/pc/img/2017/img_memberbn02.png" alt="">
		</div>
		
		<div>
			<p class="tit">회원 등급별 혜택</p>
			<p class="cmnt">최대 10% 구매 적립금 지급</p>
			<img src="http://www.goobnemall.com/static-root/resources/pc/img/2017/img_memberbn03_1.png" alt="">
		</div>
		
		<div>
			<p class="tit">모든 회원(사업자회원제외)</p>
			<p class="cmnt">생일시 3,000원 굽머니 지급</p>
			<img src="http://www.goobnemall.com/static-root/resources/pc/img/2017/img_memberbn04.png" alt="">
		</div>
			
		</div>
		</div>
	</form>
</div>

<%@ include file="//goobne/data/footer.jsp"%>
