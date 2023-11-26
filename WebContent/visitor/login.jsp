<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
.main { width: 400px; margin: 0px auto; text-align: center; }
.title_row { height: 40px; font-family: "monoton"; font-size: 30px; }

table { width: 100%; border: none; border-collapse: collapse; text-align: center;}
.input_row { width: 340px; height: 100px; margin: 0 auto; border: 1px solid black; border-radius: 8px;}
th { border: 1px solid black; text-align: center; }
.material-symbols-outlined { display: inline-block; margin-top:11px;}
.logintxt { border: none; width: 250px; line-height: 30px; font-size: 15px; font-weight:bold; margin: 2px 6px; position: relative; top:-5px;}
.loginhr {height: 1px; margin: 0}

.end_row>td { text-align: center; }
.end_row input { width: 340px; height: 50px; background-color: #224070; color: white; cursor:pointer; border: none; border-radius:5px; margin: 10px 20px;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	let form = document.loginForm;
	form.id.focus();
	
	//로그인 버튼
	let btnLogin = document.getElementById("btnLogin");
	btnLogin.addEventListener("click", function() {
		if(!form.id.value) {
			alert("아이디를 입력하세요");
			form.id.focus();
			return;
		}
		if(!form.pwd.value) {
			alert("패스워드를 입력하세요");
			form.pwd.focus();
			return;
		}
		form.submit();
	});
	
	// 패스워드 엔터키
	form.pwd.addEventListener("keyup", function(e) {
		if(e.code === 'Enter') {
			e.preventDefault();
			form.submit();
		}
	})
	
	//쿠키 사용
	let id_save = document.getElementById("id_save");
	id_save.addEventListener("click", function() {
		let now = new Date();
		let name = "cookieId";
		let value = form.id.value; 
		console.log("cookie");
		
		if(form.id_save.checked == true) {
			now.setDate(now.getDate() + 7);//쿠키 유지시간 설정, 7일
			document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";";;
		} else {
			now.setDate(now.getDate() + 0);
			document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";";;
		}
	});
	
	if(document.cookie.length > 0) {
		let search = "cookieId=";
		let idx = document.cookie.indexOf(search);
		if(idx != -1) { //쿠키에 cookieId= 라는 문자열이 존재한다면
			idx += search.length; //cookieId 값의 시작점
			let end = document.cookie.indexOf(";", idx); //cookieId값의 끝
			if(end == -1) {//끝을 만나지 못하면
				end = document.cookie.length;
			}
			form.id.value = document.cookie.substring(idx, end);
			form.id_save.checked = true;
		}
	}
})
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String scn_id = request.getParameter("scn_id");
%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
	<!-- 본문 -->
	<div class="main">
		<form action="../visitor/loginChkPro.jsp" method="post" name="loginForm">
		<input type="hidden" name="scn_id" value="<%=scn_id%>">
		<table>
			<tr class="title_row">
				<td><a href="../theater/frontPage.jsp"></a></td>
			</tr>
			<tr>
				<td width="70%">
				<div class="input_row">
					<div class="material-symbols-outlined">person</div>
					<input type="text" name="id" class="logintxt">
					<hr class="loginhr">
					<div class="material-symbols-outlined">lock</div>
					<input type="password" name="pwd" class="logintxt">
				</div>
				</td>
			</tr>
			<tr class="end_row">
				<td>
					<input type="button" id="btnLogin" value="로그인">
				</td>
			</tr>
		</table>
		<div class="etc">
			<input type="checkbox" id="id_save"><label for="id_save">아이디 저장 &nbsp;&nbsp; </label>
			<a href="visitorInsertForm.jsp">회원가입</a>
		</div>
		</form>
	</div>
</div>
<!-- 하단 -->
<div class="footer">
	<jsp:include page="../common/bottom.jsp"/>
</div>
</body>
</html>