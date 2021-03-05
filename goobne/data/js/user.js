
function sendIt() {

	var f = document.myForm;

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

	f.action = "study/goobnemall/user/signup_ok.do";
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

	var f = document.myForm;

}

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
