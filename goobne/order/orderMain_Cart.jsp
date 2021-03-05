<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ include file="//goobne/data/header.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	function sendIt(){
		
		var f=document.myForm;
		
		if(!f.buyerName.value){
			alert("이름을 입력하세요.");
			f.buyerName.focus();
			return;
		}
		
		if(!f.buyerTel1.value||!f.buyerTel2.value||!f.buyerTel3.value){
			alert("전화번호를 올바르게 입력하세요.");
			f.buyerTel2.focus();
			return;
		}
		
		if(!f.buyerEmail1.value||!f.buyerEmail2.value){
			alert("이메일을 올바르게 입력하세요.");
			f.buyerEmail1.focus();
			return;
		}
		
		if(!f.getterName.value){
			alert("받는 사람 이름을 입력하세요.");
			f.getterName.focus();
			return;
		}
		
		if(!f.getterTel1.value||!f.getterTel2.value||!f.getterTel3.value){
			alert("받는 사람의 전화번호를 올바르게 입력하세요.");
			f.getterTel2.focus();
			return;
		} 
		
		if(!f.getterZip.value){
			alert("주소를 검색하세요.");
			f.getterZip.focus();
			return;
		}
		
		var payWayValue;

		for(var i=0;i<f.payWay.length;i++){
			if(f.payWay[i].checked==true){
				payWayValue=f.payWay[i].value;
				break;
			}
		}
		
		if(payWayValue==null){
			alert("결제수단을 선택하세요.");
			return;
		}
		
		if(!f.payerName.value){
			alert("입금자 명을 입력하세요.");
			f.payerName.focus();
			return;
		}
		
		if(!f.bankName.value){
			alert("나한테 돈 내놓을 계좌를 선택하세요.");
			return;
		}
		
		f.action="<%=cp%>/goobnemall/order/orderCompleteCart.do";
		f.submit();
	}

	function emailCheck(){
		
		var f=document.myForm;
		var clength=f.buyerEmailSel.options.length;
		var cvalue=f.buyerEmailSel.selectedIndex;
		
		f.buyerEmail2.value="";
		
		if(cvalue==(clength-1)){
			f.buyerEmail2.readOnly=false;
			f.buyerEmail2.focus();
			f.buyerEmail2.style.backgroundColor="white";
		}else{
			f.buyerEmail2.value=f.buyerEmailSel.options[cvalue].value;
			f.buyerEmail2.readOnly=true;
			f.buyerEmail2.style.backgroundColor="#EAEAEA";
		}
	}
	
	/* 
	var f=document.myForm;
		var table = document.getElementById("withoutBankbook");
		
		for(var i=0;i<f.payWay.length;i++){
			if(f.payWay[i].checked==true){
				alert(f.payWay[i].value+" 서비스는 준비중입니다.");
				f.payWay[i].checked=false
				break;
			}
		}
		
		if(f.payWay[2].checked==false){
			table.style.display="none";
		}*/
	
	function sameInfoCheck(){
		
		var f=document.myForm;
		
		if(f.sameInfo.checked){
			f.getterName.value=f.buyerName.value;
			f.getterTel1.value=f.buyerTel1.value;
			f.getterTel2.value=f.buyerTel2.value;
			f.getterTel3.value=f.buyerTel3.value;
		}else{
			f.getterName.value="";
			f.getterTel1.value="";
			f.getterTel2.value="";
			f.getterTel3.value="";
		}
	}
	
	function alertPayWay(){
		
		var f=document.myForm;
		var table = document.getElementById("withoutBankbook");
		
		for(var i=0;i<f.payWay.length;i++){
			if(f.payWay[i].checked==true){
				alert(f.payWay[i].value+" 서비스는 준비중입니다.");
				f.payWay[i].checked=false
				break;
			}
		}
		
		if(f.payWay[2].checked==false){
			table.style.display="none";
		}
	}
	
	function showOrHideTable(){
		
		var f=document.myForm;
		var table = document.getElementById("withoutBankbook");
		
		if(f.payWay[2].checked==true){
			table.style.display="block";
		}
	}
	
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<form action="" name="myForm" method="post">
<div id="container">

	<ul class="path">
		<li><a href="#none">홈</a></li>
		<li><a href="#none">장바구니</a></li>
		<li class="current"><a href="#none">일반배송</a></li>
	</ul>
<div id="contents">

	<div class="titWrap">
		<h2 class="pTit">주문서작성/결제</h2>
		<div class="flR">
			<ul class="cartStep">
				<li>
					<div class="step"><span>01</span><strong>장바구니</strong></div>
				</li>
				<li class="on">
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
	
	<div class="titWrap type03">
		<h3 class="tit02">주문자 정보</h3>
		<p class="flR mgT5"><i class="icon required" aria-required="true">필수</i> 항목은 필수입력 값입니다.</p>
	</div>
	
	<table border="0" width="1000" align="center" cellspacing="0">
		<tr height="2">
			<td colspan="2" bgcolor="#BDBDBD"></td>
		</tr>
		
		<tr height="50">
			<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<span class="icon required"></span>
				<font size="2"><b>이름&nbsp;</b></font>
			</td>
			<td colspan="2" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				&nbsp;&nbsp;<input type="text" name="buyerName" value="${dtoUserInfo.name }" style="width: 200px;height: 20px;">
			</td>
		</tr>
		
		<tr height="50">
			<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<span class="icon required"></span>
				<font size="2"><b>휴대번호&nbsp;</b></font>
			</td>
			<td colspan="2" valign="middle" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				&nbsp;&nbsp;<select name="buyerTel1" style="width: 100px;height: 28px;border-color: #BDBDBD;border-width: 1px;">
					<option value="">선택</option>
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
					<option value="0503">0503</option>
					<option value="0504">0504</option>
					<option value="0502">0502</option>
					<option value="0507">0507</option>
					<option value="050">050</option>
					<option value="0503">0503</option>
					<option value="0508">0508</option>
					<option value="070">070</option>
					<option value="${buyerTel1 }" selected>${buyerTel1 }</option>
				</select>&nbsp;-
				<input type="text" name="buyerTel2" value="${buyerTel2 }" style="width: 100px;height: 20px;">&nbsp;-
				<input type="text" name="buyerTel3" value="${buyerTel3 }" style="width: 100px;height: 20px;">
			</td>
		</tr>
		
		<tr height="50">
			<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<span class="icon required"></span>
				<font size="2"><b>이메일&nbsp;</b></font>
			</td>
			<td colspan="2" valign="middle" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				&nbsp;&nbsp;<input type="text" name="buyerEmail1" value="${buyerEmail1 }" style="width: 150px;height: 20px;">&nbsp;@
				<input type="text" name="buyerEmail2" id="email2" readonly="readonly" value="${buyerEmail2 }" style="width: 150px;height: 22px;border: none;border: solid;border-color: #5D5D5D;border-width: 1px;background-color: #EAEAEA;">&nbsp;
				<select name="buyerEmailSel" onchange="emailCheck();" style="width: 150px;height: 28px;border-color: #BDBDBD;border-width: 1px;">
					<option value="${buyerEmail2 }" selected>${buyerEmail2 }</option>
					<option value="naver.com">naver.com</option>
					<option value="hanamil.net">hanmail.net</option>
					<option value="nate.com">nate.com</option>
					<option value="">직접입력</option>
				</select>
			</td>
		</tr>
	</table>
	
	<div class="titWrap type03">
		<h3 class="tit02">배송지 정보 입력</h3>
			<input type="checkbox" name="sameInfo" 
			style="float:right;" onclick="sameInfoCheck();">
			<label for="copy_orderer_info" style="float:right;">주문자 정보와 동일&nbsp;&nbsp;</label>
	</div>
	
	<table border="0" width="1000" align="center" cellspacing="0">
		<tr height="2">
			<td colspan="5" bgcolor="#BDBDBD"></td>
		</tr>
		
		<tr height="50">
			<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<span class="icon required"></span>
				<font size="2"><b>받는사람&nbsp;</b></font>
			</td>
			<td colspan="4" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				&nbsp;&nbsp;<input type="text" name="getterName" style="width: 200px;height: 20px;">
			</td>
		</tr>
		
		<tr height="50">
			<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<span class="icon required"></span>
				<font size="2"><b>휴대번호&nbsp;</b></font>
			</td>
			<td colspan="2" valign="middle" width="36%" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				&nbsp;&nbsp;<select name="getterTel1" style="width: 90px;height: 28px;border-color: #BDBDBD;border-width: 1px;">
					<option value="">선택</option>
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
					<option value="0503">0503</option>
					<option value="0504">0504</option>
					<option value="0502">0502</option>
					<option value="0507">0507</option>
					<option value="050">050</option>
					<option value="0503">0503</option>
					<option value="0508">0508</option>
					<option value="070">070</option>
				</select>&nbsp;-
				<input type="text" name="getterTel2" style="width: 90px;height: 20px;">&nbsp;-
				<input type="text" name="getterTel3" style="width: 90px;height: 20px;">
			</td>
			<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<font size="2"><b>전화번호&nbsp;</b></font>
			</td>
			<td colspan="2" valign="middle" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				&nbsp;&nbsp;<select name="getterTel4" style="width: 90px;height: 28px;border-color: #BDBDBD;border-width: 1px;">
					<option value="">선택</option>
					<option value="010">010</option>
					<option value="02">02</option>
					<option value="031">031</option>
					<option value="032">032</option>
					<option value="033">033</option>
					<option value="041">041</option>
					<option value="042">042</option>
					<option value="051">051</option>
					<option value="052">052</option>
					<option value="053">053</option>
					<option value="054">054</option>
					<option value="055">055</option>
					<option value="061">061</option>
					<option value="062">062</option>
				</select>&nbsp;-
				<input type="text" name="getterTel5" style="width: 90px;height: 20px;">&nbsp;-
				<input type="text" name="getterTel6" style="width: 90px;height: 20px;">
			</td>
		</tr>
		
		<tr height="150">
			<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<span class="icon required"></span>
				<font size="2"><b>주소&nbsp;</b></font>
			</td>
			<td colspan="5" valign="middle" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				&nbsp;&nbsp;<input type="text" name="getterZip" id="sample6_postcode" placeholder="우편번호" onfocus="this.blur();" style="margin-bottom: 5px;height: 20px;border: none;border: solid;border-color: #BDBDBD;border-width: 1px;background-color: #EAEAEA;" readonly="readonly">
				&nbsp;&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기"><br/>
				&nbsp;&nbsp;<input type="text" name="getterAddr1" id="sample6_address" placeholder="주소" onfocus="this.blur();" style="width: 500px;margin-bottom: 5px;height: 20px;border: none;border: solid;border-color: #BDBDBD;border-width: 1px;background-color: #EAEAEA;" readonly="readonly"><br/>
				&nbsp;&nbsp;<input type="text" name="getterAddr2" id="sample6_extraAddress" placeholder="(도로명주소란)" onfocus="this.blur();" style="width: 500px;margin-bottom: 5px;height: 20px;border: none;border: solid;border-color: #BDBDBD;border-width: 1px;background-color: #EAEAEA;" readonly="readonly"><br/>
				&nbsp;&nbsp;<input type="text" name="getterAddr3" id="sample6_detailAddress" placeholder="상세주소" style="width: 500px;margin-bottom: 5px;height: 20px;">
			</td>
		</tr>
		
		<tr height="50">
			<td width="15%" align="right" bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<font size="2"><b>배송메세지&nbsp;</b></font>
			</td>
			<td colspan="4" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				&nbsp;&nbsp;<input type="text" name="getterMsg" placeholder="배송메시지를 입력해주세요." style="width: 600px;height: 20px;">
			</td>
		</tr>
	</table>
	<br/><br/>
		
	<div class="titWrap type02">
		<h3 class="tit02">주문상품정보		</h3>
	</div>		
			
	<div class="cartTbl">
		<table>
			<caption>주문상품정보</caption>
				<colgroup>
					<col width="*">
					<col width="140px">
				</colgroup>
			
			<thead>
				<tr>
					<th scope="col">상품</th>
					<th scope="col">상품금액</th>
				</tr>
			</thead>
		</table>
		
	
	<table border="0" width="1000" align="center" cellspacing="0">
		<c:forEach var="dtoCart" items="${listsCartDto }">
		<tr height="50">
			<td rowspan="2" width="15%" align="center" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<img alt="no found" src="${dtoCart.pic1 }" style="height: 100px;width: 100px;">
			</td>
			<td width="70%" align="left" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;">
				<b><font size="3">&nbsp;&nbsp;${dtoCart.productName }</font></b>
			</td>
			<td rowspan="2"  width="15%" align="center" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;border-left: solid;border-left-color: #BDBDBD;border-left-width: 1px;">
				<font size="2"><b><fmt:formatNumber value="${dtoCart.price }" pattern=" #,### " /></b>원</font>
			</td>
		</tr>
				<tr height="50">
			<td width="70%" align="left" style="border-bottom: solid;border-bottom-color: #BDBDBD; border-bottom-width: 1px;">
				<font size="2">&nbsp;&nbsp;1개 가격 :&nbsp;&nbsp;&nbsp;
				<fmt:formatNumber value="${dtoCart.price/dtoCart.qty }" pattern=" #,### " />원&nbsp;&nbsp;&nbsp;/
				&nbsp;&nbsp;&nbsp;수량 : &nbsp;&nbsp;&nbsp;${dtoCart.qty }개&nbsp;&nbsp;&nbsp;</font>
			</td>
		</tr>
		</c:forEach>

	</table>
	
	<div class="cp_pay">
		<div class="titWrap type03 mgT20">
			<h3 class="tit02">결제수단선택</h3>
		</div>	
				
		<div class="titW">
		<table border="0" width="500" align="left" cellspacing="0">
		<tr height="50">
			<td colspan="2" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 2px;"/>
		</tr>
		
		<tr height="50">
			<td bgcolor="#EAEAEA" style="border-top: solid;border-top-color: #BDBDBD;border-top-width: 1px;padding-left: 10px;">
				<input type="radio" name="payWay" value="신용카드" onclick="alertPayWay();"> 신용카드&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="payWay" value="실시간 계좌이체" onclick="alertPayWay();"> 실시간 계좌이체&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="payWay" value="무통장입금" onclick="showOrHideTable();"> 무통장입금&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="payWay" value="휴대폰 결제" onclick="alertPayWay();"> 휴대폰 결제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="payWay" value="카카오페이" onclick="alertPayWay();">
					<img alt="no found" align="top" src="https://www.goobnemall.com/static-root/resources/pc/img/common/pay_kakao.png">
			</td>
		</tr>
		
		<tr height="50">
			<td bgcolor="#EAEAEA" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;padding-left: 10px;">
				<input type="radio" name="payWay" value="페이코" onclick="alertPayWay();">
					<img alt="no found" align="top" src="https://www.goobnemall.com/static-root/resources/pc/img/common/pay_payco.png" style="height: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="payWay" value="삼성페이" onclick="alertPayWay();">
					<img alt="no found" align="top" src="https://www.goobnemall.com/static-root/resources/pc/img/common/pay_samsung.png">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="payWay" value="엘페이" onclick="alertPayWay();">
					<img alt="no found" align="top" src="https://www.goobnemall.com/static-root/resources/pc/img/common/pay_l.png">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="payWay" value="스마일페이" onclick="alertPayWay();">
					<img alt="no found" align="top" src="https://www.goobnemall.com/static-root/resources/pc/img/common/pay_smile.png">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	
	<table border="0" id="withoutBankbook" width="700" align="left" cellspacing="0" style="margin-left: 16.6%;display: none;">
		<tr height="50">
			<td colspan="2" style="border-bottom: solid;border-bottom-color: #BDBDBD;border-bottom-width: 1px;padding-left: 15px;">
				<font color="#5D5D5D">- 5영업일 이내 미입금시 주문이 자동취소 될 수 있습니다.</font><br/>
				<font color="#5D5D5D">- 기재한 입금자명과 다르게 입금 시, 결제확인이 되지 않으니 주의 바랍니다.</font>
			</td>
		</tr>
		
		<tr height="40">
			<td width="20%" align="left">
				<font size="2"><b>&nbsp;입금자명</b></font>
			</td>
			<td colspan="2">
				&nbsp;&nbsp;
			<input type="text" name="payerName" style="width: 200px;height: 20px;border: none;border: solid;border-color: #BDBDBD;border-width: 2px;">
			</td>
		</tr>
		
		<tr height="40">
			<td width="20%" align="left">
				<font size="2"><b>&nbsp;입금은행</b></font>
			</td>
			<td colspan="2">
				&nbsp;&nbsp;<select name="bankName" style="width: 400px;height: 28px;border-color: #BDBDBD;border-width: 2px;">
					<option value="">선택</option>
					<option value="국민은행 233002-041952-145878(예금주 : 저스틴비버)">국민은행 233002-041952-145878(예금주 : 저스틴비버)</option>
					<option value="신한은행 192099-339-944-199434(예금주 : 투팍)">신한은행 192099-339-944-199434(예금주 : 투팍)</option>
				</select>
			</td>
		</tr>
	</table>
	</div>		
	</div>
	
	<div class="priceEnd">
		<div class="titWrap type02">
			<h3 class="tit02">최종 결제정보</h3>
		</div>
		
	<div class="priceArea" style="height:680px;">
		<dl><dt>총상품금액</dt>
		<dd>
			<span class="price"><strong class="ord_amt_text" id="ord_amt_text">
				<fmt:formatNumber value="${totPrice+deliveryFee }" pattern=" #,###" /></strong>원</span>
		</dd></dl>
		
		<dl>
			<dt>배송비
				<div class="tooltipWrap dlvry_fee_add_tooltipWrap" style="display:none">
				<span class="icon tooltipBtn"><span>안내보기</span></span>
					<div class="tooltipLyr">
					<div class="tooltipTit">배송비</div>
					</div>
				</div>
			</dt>
		
		<dd>
			<span class="price"><strong class="dlvry_fee_total_text">
			<fmt:formatNumber value="${deliveryFee }" pattern=" #,###" /></strong>원</span>
		</dd>
		</dl>
		
		<dl class="total">
			<dt><span class="fb" style="color:#272222;">최종 결제금액</span></dt>
			<dd><span class="price red"><strong class="pay_amt_text" id="last_pay_amt">
				<fmt:formatNumber value="${totPrice+deliveryFee }" pattern=" #,###" /></strong>원</span></dd>
		</dl>
	
		<dl class="line">
			<dt class="fs11">적립 예정금액
			<div class="tooltipWrap">
				<span class="icon tooltipBtn"><span>안내보기</span></span>
					<div class="tooltipLyr sizeM">
						<div class="tooltipTit">적립 예정금액 안내</div>
							<div class="tooltipCont"> 구매 확정 시 상품금액의 등급별 적립율<br> 
							(패밀리 2%, 실버 4%, 골드 5%, VIP 10%) 적립<br>
							구매 후 시식 후기 작성 시 포토 <strong class="fc01">500원</strong>, 
							일반 <strong class="fc01">200원</strong>
							</div>
						</div>
			</div>
			</dt>
			<dd>
			<span class="price fs11">
				<strong class="fs14">0</strong> 원
			</span>
			</dd>
		</dl>
	</div>
		
	<div class="btnWrap cart" style="width:100%;margin:20px auto 0 !important;">
		<a href="javascript:sendIt();" id="doPay" class="btnM" style="min-width:130px !important;">결제하기</a>
		<a href="<%=cp %>/goobnemall/product/listdetail.do?productNum=${dtoProduct.productNum }" class="btnM sub2" style="min-width:100px !important;">취소</a>
	</div></div>
	</div>
	</div>
</div>
	<input type="hidden" value="${totPrice+deliveryFee }" name="totalCost"/>
</form>

<br/><br/>

<%@ include file="//goobne/data/footer.jsp" %>

