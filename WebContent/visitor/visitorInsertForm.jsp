<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
#container { width: 1000px; margin: 20px auto;}

/* 본문 */
.main { width: 1000px; margin: 0 auto; }
h2 { text-align: center; }
table { width: 70%; border: 1px solid black; border-collapse: collapse; margin: 0px auto; }
tr { height: 50px; }
th, td { border: 1px solid black;}
th { background: #f8f9fa;}
td { padding-left: 25px; }
input[type="text"] { width: 300px; }
.first_row #btnCheck { width: 110px; height: 27px; background: #9942f; border: none; border-radius: 5px; font-weight: bold; margin-left: 10px;
font-size: 0.8em;}
.first_row span {font-size: 0.8em;}
.blue { color: blue; }
.red { color: red; }
.end_row { height: 100px; }
.end_row>td {margin: 4px 0; }
.end_row #btnAddress { width: 80px; height: 27px; background: #1e94be; color: #fff; font-weight: bold; 
border: #1e94be; border-radius:5px;}
.btns { text-align: center; }
.btns>input { width: 100px; height: 35px; margin: 20px; background:#000; color: white; font-size: 16px; font-weight: bold;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let form = document.insertForm;
	
	let btnCheck = document.getElementById("btnCheck");
	btnCheck.addEventListener("click", function(){
		if(!form.id.value) {
			alert("ID 중복체크 하기 위한 아이디를 입력하시오.");
			form.id.focus();
			return;
		}
		location = "idChkPro.jsp?id=" + form.id.value;
	});

	let btnAddress = document.getElementById("btnAddress");
	btnAddress.addEventListener("click", function(){
		new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.insertForm.address1.value = data.address; // 주소 넣기
                document.insertForm.address2.focus(); //상세입력 포커싱
            }
        }).open();
	});
	
	
	let btnInsert = document.getElementById("btnInsert");
	btnInsert.addEventListener("click", function() {
		if(!form.id.value) {
			alert("아이디를 입력하세요.");
			form.id.focus();
			return;
		}
		if(form.check.value != "0") {
			alert("아이디 중복체크를 해 주세요");
			form.id.focus();
			return;
		}
		if(!form.pwd.value) {
			alert("비밀번호를 입력하세요.");
			form.pwd.focus();
			return;
		}
		if(form.pwd2.value != form.pwd.value) {
			alert("비밀번호 재확인을 올바르게 입력하세요.");
			form.pwd2.focus();
			return;
		}
		if(!form.name.value) {
			alert("이름을 입력하세요.");
			form.name.focus();
			return;
		}
		if(!form.birthday.value) {
			alert("생년월일을 입력하세요.");
			form.birthday.focus();
			return;
		}
		if(!form.email.value) {
			alert("이메일을 입력하세요.");
			form.email.focus();
			return;
		}
		if(!form.gender.value) {
			alert("성별을 선택하세요.");
			return;
		}
		if(!form.tel.value) {
			alert("전화번호를 입력하세요.");
			form.tel.focus();
			return;
		}
		if(!form.address1.value) {
			alert("기본주소를 입력하세요.");
			form.address1.focus();
			return;
		}
		if(!form.address2.value) {
			alert("상세주소를 입력하세요.");
			form.address2.focus();
			return;
		}
		form.submit();
	});

	let btnCancel = document.getElementById("btnCancel");
	btnCancel.addEventListener("click", function() {
		location = "../theater/frontPage.jsp";
	});
})
</script>
</head>
<body>
<%
String check = request.getParameter("idChk");
String id = request.getParameter("id");
if (check==null) check = "-1";
if (id==null) id = "";
%>

<div id="container">
	<!-- 상단 -->
	<div class="header">
		<jsp:include page="../common/top.jsp"/>
	</div>
	<!-- 본문 -->
	<div class="main">
	
	<h2>회원 가입</h2>
	<form action="visitorInsertPro.jsp" method="post" name="insertForm">
	<input type="hidden" name="check" value="<%=check %>">
		<table>
			<tr class="first_row">
				<th width="20%" height="75px">아이디</th>
				<td width="80%">
					<input type="text" name="id" placeholder="아이디 중복 체크를 누르세요." value=<%=id %>>
					<input type="button" id="btnCheck" value="아이디 중복체크"><br>
					<%if (check.equals("-1")) {%>
						<span>중복 아이디를 체크하세요.</span>
					<%} else if (check.equals("0")) {%>
						<span class="blue">사용 가능한 아이디입니다.</span>
					<%} else if (check.equals("1")) {%>
						<span class="red">사용중인 아이디입니다. 다른 아이디를 입력하세요.</span>
					<%} %>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="pwd2"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="date" name="birthday"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="email" name="email"></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" id="gen_m" value="m"><label for="gen_m">남성</label>
					<input type="radio" name="gender" id="gen_f" value="f"><label for="gen_f">여성</label>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel"></td>
			</tr>
			<tr class="end_row">
				<th>주소</th>
				<td>
					<input type="button" value="주소 찾기" id="btnAddress"><br>
					<input type="text" name="address1" placeholder="기본주소 입력"><br>
					<input type="text" name="address2" placeholder="상세주소 입력"><br>
				</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" id="btnInsert" value="회원가입">
			<input type="button" id="btnCancel" value="취소">
			
		</div>
	</form>
	</div>
	<!-- 하단 -->
	<div class="footer">
		<jsp:include page="../common/bottom.jsp"/>
	</div>
</div>
</body>
</html>