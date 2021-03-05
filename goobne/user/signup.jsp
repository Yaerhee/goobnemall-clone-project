<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<% /* post방식일때 한글깨짐 방지 */
	request.setCharacterEncoding("UTF-8");  
	
	//http://127.0.0.1:8080/study/까지의 주소를 가지고있음
	
%>

<%@ include file="//goobne/data/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm3;
		
		if (!f.id.value) {
			alert("아이디를 입력해주세요!");
			f.id.focus();
			return;
		}
		
		var check = /^[a-zA-Z0-9]{4,12}$/;
        
        if(!check.test(f.id.value)) {
               alert("형식에 맞춰 아이디를 입력하세요");
               f.id.value = "";
               f.id.focus();
               return;
           }
		
		if (!f.pwd.value) {
			alert("비밀번호를 입력해주세요!");
			f.pwd.focus();
			return;
		}
		
		if(!check.test(f.pwd.value)) {
            alert("형식에 맞춰 비밀번호를 입력하세요");
            f.pwd.value = "";
            f.pwd.focus();
            return;
        }
		
		if (!f.pwd_ch.value) {
			alert("비밀번호 확인을 입력해주세요!");
			f.pwd_ch.focus();
			return;
		}
		
		if (f.pwd.value != f.pwd_ch.value) {
			alert("비밀번호가 같지 않습니다!")
			f.pwd_ch.focus();
			return;
		}
		
		if (!f.name.value) {
			alert("이름을 입력해주세요!");
			f.name.focus();
			return;
		}

		if (!f.email1.value) {
			alert("이메일을 입력해주세요!");
			f.email1.focus();
			return;
		}
		
		if (!f.email2.value) {
			alert("이메일을 입력해주세요!");
			f.email2.focus();
			return;
		}
		
		
		if (!f.birthy.value) {
			alert("생일을 입력해주세요!");
			f.birthy.focus();
			return;
		}
		
		if (!f.birthm.value) {
			alert("생일을 입력해주세요!");
			f.birthm.focus();
			return;
		}
		
		if (!f.birthd.value) {
			alert("생일을 입력해주세요!");
			f.birthd.focus();
			return;
		}
		
		if (!f.tel1.value) {
			alert("전화번호를 입력해주세요!");
			f.tel1.focus();
			return;
		}
		
		if (!f.tel2.value) {
			alert("전화번호를 입력해주세요!");
			f.tel2.focus();
			return;
		}
		
		if (!f.tel3.value) {
			alert("전화번호를 입력해주세요!");
			f.tel3.focus();
			return;
		}

		if (!f.addr1.value) {
			alert("주소를 입력해주세요!");
			f.addr1.focus();
			return;
		}
		

		
		f.action = "<%=cp %>/goobnemall/user/signup_ok.do";
		f.submit();
		
	}
	
	
	
 	function SetEmailTail(emailValue) {
		
		  var email = document.all("email")    // 사용자 입력
		  var emailTail = document.all("email2") // Select box
		  
		  if ( emailValue == "etc" ) {
			  
		   emailTail.readOnly = false;
		   emailTail.value = "";
		   emailTail.focus();
		   
		  } else {
			  
		   emailTail.readOnly = true;
		   emailTail.value = emailValue;
		   
		   return;
		   
		  }
		  
		  
	 }
 	
 	function idch() {
 		
 		var f = document.myForm3;
 		f.action = "<%=cp %>/goobnemall/user/signChk.do";
 		f.submit();
 		
 		
 		
 	}
 



</script>

</head>
<body>

<form name="myForm3" method="post">

<div id="container">

		<!-- path -->
		<ul class="path">
			<li><a href="#none">홈</a></li>
			<li class="current"><a href="#none">회원가입</a></li>
		</ul>
		<!-- //path -->

		<!-- contents -->
		<div id="contents">
			<div id="personInpt01">
				<div class="titWrap">
					<h2 class="pTit">회원가입</h2>
				</div>


				<!-- 일반회원 상단문구 -->
				<div id="personView">
					<div class="joinCopy">
						굽네몰에 오신 것을 환영합니다. <br>
						<strong>지금 회원 가입하신 후 <span class="fc01">굽네몰의 다양한 서비스</span>를 만나보세요.</strong>
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
							<p class="tit">모든 회원<!-- (사업자회원제외) --></p>
							<p class="cmnt">생일시 3,000원 굽머니 지급</p>
							<img src="http://www.goobnemall.com/static-root/resources/pc/img/2017/img_memberbn04.png" alt="">
						</div>
						
					</div>
				</div>
				
				<!--// 일반회원 상단문구 -->


				<div class="mgT30" id="def-info">
					<strong class="dpIB flL fs17 fc33">기본정보입력</strong>
					<span class="dpIB flR"><i class="icon required">필수</i> 항목은 필수입력 값입니다.</span>
				</div>
			</div>
			</div>
			<div id="personInpt02">
				<div class="infoTbl clB">
					<table>
						<caption>회원가입 기본정보</caption>
						<colgroup>
							<col width="150px">
							<col width="*">
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i> 아이디</th>
							<td>
								<input type="text" id="lgn_id" name="id" style="width:235px;" title="아이디" value="${idVal }"/>
								<a href="#"  onclick="idch();" class="btnB w95" id="checkDuplicateId">중복확인</a><span class="cmnt"><c:if test="${chk==0 }">
									<font color="red">이미 사용중인 아이디입니다.</font>
									</c:if>
									<c:if test="${chk==1 }">
									<font color="blue">사용 가능한 아이디입니다.</font>
									</c:if>4~20자의 영, 숫자 혼용하여 사용 가능합니다.</span>
							</td>
						</tr>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i> 비밀번호</th>
							<td>
								<input type="password" id="lgn_pwd" name="pwd" style="width:235px;" title="비밀번호""><span class="cmnt">영문, 숫자 조합으로 6~15자리 사용 가능합니다.</span>
							</td>
						</tr>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i> 비밀번호 확인</th>
							<td><input type="password" id="lgn_pwd_cnfm" name="pwd_ch" style="width:235px;" title="비밀번호 확인"></td>
						</tr>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i> 이름</th>
							<td><input type="text" id="cst_nm" name="name" style="width:235px;" title="이름"></td>
						</tr>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i> 성별</th>
							<td>
								<input type="radio"  name="gender" value="M" checked><label for="user_male" class="mgR30"> 남성</label>
								<input type="radio"  name="gender" value="W"><label for="user_female">여성</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i> 생년월일</th>
							<td>
								<input type="text"  name="birthy" title="연도" maxlength="4" style="width:85px;"> 년&nbsp;
								<input type="text"  name="birthm" title="월" maxlength="2" style="width:50px;"> 월&nbsp;
								<input type="text"  name="birthd" title="일" maxlength="2" style="width:50px;"> 일
								<span class="cmnt">예) 1988.02.08</span>
							</td>
						</tr>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i> 이메일</th>
							<td>
								<div class="emailW dpIB">
									<input type="text" id="email_id" name="email1" title="email 아이디"/> @
									<input type="text" id="email_domain" name="email2" title="email 포탈주소 자동입력">
									<span class="selBox">
										<select name="emailCheck" 
											onchange="SetEmailTail(emailCheck.options[this.selectedIndex].value)"
												style="width:160px" title="email 주소" ">
											<option value="">직접입력</option>
												<option value="naver.com">naver.com</option>
												<option value="paran.com">paran.com</option>
												<option value="empal.com">empal.com</option>
												<option value="nate.com">nate.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="dreamwiz.com">dreamwiz.com</option>
												<option value="freechal.com">freechal.com</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="hanafos.com">hanafos.com</option>
												<option value="korea.com">korea.com</option>
												<option value="chollian.net">chollian.net</option>
										</select>
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i>휴대번호</th>
							<td>
								<div class="phoneW dpIB">
									<input type="text" id="mble1" name="tel1" title="휴대번호 첫째자리" ">
									-
									<input type="text" id="mble2" name="tel2" title="휴대번호 둘째자리" maxlength="4" ">
									-
									<input type="text" id="mble3" name="tel3" title="휴대번호 셋째자리" maxlength="4" ">
								</div>
								<span class="cmnt fc01">정확한 연락처가 아닐경우 주문,결제,배송 안내를 받지 못할 수 있습니다.</span>
							</td>
						</tr>
						<tr>
							<th scope="row"><i class="icon required" aria-required="true">필수</i>주소</th>
							<td><input type="text" id="sample4_postcode" placeholder="우편번호" name="addr1">
						    <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						    <input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="addr2">
						    <input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="addr3">
						    <span id="guide" style="color:#999;display:none"></span>
						    <input type="text" id="sample4_detailAddress" placeholder="상세주소" name="addr4">
						    <input type="text" id="sample4_extraAddress" placeholder="참고항목" name="addr5">
						    </td>
						</tr>
						</table>
						</tbody>
						</div>
						<div id="btnViewP" class="btnWrap cart">
						<button class="btnBuy" type="button" width="200"
						onclick="sendIt();">회원가입</button>
						</div><br/><br/><br/><br/>			
</form>						
						
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function sample4_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 참고 항목 변수

                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample4_postcode').value = data.zonecode;
                    document.getElementById("sample4_roadAddress").value = roadAddr;
                    document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                    // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                    if (roadAddr !== '') {
                        document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                    } else {
                        document.getElementById("sample4_extraAddress").value = '';
                    }

                    var guideTextBox = document.getElementById("guide");
                    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                    if (data.autoRoadAddress) {
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                        guideTextBox.style.display = 'block';

                    } else if (data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else {
                        guideTextBox.innerHTML = '';
                        guideTextBox.style.display = 'none';
                    }
                }
            }).open();
        }
    </script>
				
	
				





</body>
</html>
<%@ include file="//goobne/data/footer.jsp" %>
