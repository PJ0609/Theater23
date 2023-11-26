<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상단부</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Oswald:wght@500&display=swap');
body { margin: 0; }
.wing { background: linear-gradient(to bottom, #7fa6b3,#97c1cf); width: 100%; margin:0; box-shadow: 0px 0px 15px 0px gray; blur-radius: 3px;  }
.container { width: 1000px; margin: 0px auto; text-align: center;}
a { text-decoration: none; color: black; }
#loginBtn { background-color: #224070; color: white; font-weignt: bold;  border-radius: 4px; }
#logoutBtn { background-color: #224070; color: white; font-weignt: bold; border-radius: 4px; }
#visitorID { font-weight: 800; color: #192f52; }
.headTitle { background-color: black; color: #86c8f7; border-radius: 10px; font-size: 35px; font-weight: bold; font-family: Oswald;
			 padding: 0px 8px; margin: 0px 10px 0px 10px; display: inline-block; }
.usrInfo { float: right; margin-top: 10px;  }
/* 메뉴 */
.menus { clear: both; }
.mainmenu { text-align: center; background-color: #c5e5f0; display: inline-block; font-weight: bold; cursor: pointer; 
			width: 100px; border-radius:10px; padding: 3px; margin: 10px; transition:all 0.3s; }
.mainmenu:hover { background-color: black;  color: #86c8f7; }
/* 검색 */
.search { float: left; position: relative; top: 16px; }
.search_drop { position: absolute; opacity: 0; visibility: hidden; transition:all 0.5s; left: 40px; top: -5px; text-align: center;
			   vertical-align: center; width: 240px; height: 30px; background-color:lightblue; border-radius: 10px; padding: 0px 3px; }
#searchshowchk { display: none; }
.closeImg { display: none; width: 18px; cursor: pointer; }
.searchImg { display: inline-block; width: 20px; cursor: pointer; }
label:has(#searchshowchk:checked) +.search_drop { opacity: 1; visibility: visible; }
#searchshowchk:checked ~.closeImg { display: block; }
#searchshowchk:checked ~.searchImg { display: none; }
.search_drop .searchImg { position: relative; top: 5px; width: 15px;}
.searchBox { width: 190px; line-height:15px; font-size: 15px; background-color: transparent; font-weight: bold;
			 position: relative; top:3px; outline: none; border: none; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	// 예매내역 페이지 로그인 여부 검사
	let m6 = document.querySelector(".m6");
	let id = document.querySelector("#id");
	m6.addEventListener("click", function() {
		if(id.value == "null"){
			alert("로그인이 필요한 메뉴입니다.");
			location.href = "../visitor/login.jsp";
		} else {
			location.href = "../visitor/visitorTicket.jsp";
		}
	});
	
	// 검색버튼 구현
	let keyword = document.querySelector("#searchword");
	let searchBtn = document.querySelector("#searchBtn");
	function submitKeyword() {
		if(keyword.value == "") {
			alert("검색어를 입력해 주세요.");
		} else {
			location.href = "../theater/movieList.jsp?keyword=" + keyword.value;
		}
	}
	searchBtn.addEventListener("click", function() {
		submitKeyword();
	});
	// 엔터키로 검색
	keyword.addEventListener("keyup", function(e) {
		if(e.code === 'Enter') {
			submitKeyword();
		}
	});
	// 검색란으로 포커스 이동
	let searchToggle = document.querySelector("#searchshowchk");
	searchToggle.addEventListener("change", function() {
		if(searchToggle.checked == true) {
			// 애니메이션 시간을 기다린다.
			setTimeout(function() { keyword.focus(); }, 300);
		}
	});
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
%>
<input type="hidden" id="id" value="<%=id %>">
<div class="wing">
<div class="container">
	<div class="search">
		<label for="searchshowchk">
			<input type="checkbox" id="searchshowchk">
			<img class="closeImg" src="../icons/close.png">
			<img class="searchImg" src="../icons/search.png">
		</label>
		<div class="search_drop">
			<input class="searchBox" type="text" placeholder="이름, 감독, 장르별 영화검색" id="searchword">&nbsp;&nbsp;
			<img class="searchImg" src="../icons/search.png" id="searchBtn" >
		</div>
	</div>
	<div class="usrInfo">
		<%if(session.getAttribute("id") != null) {%>
		<span id="visitorID"><%=id %></span> 방문자님 환영합니다.
		<a href="../visitor/logoutPro.jsp"><input type="button" id="logoutBtn" value="로그아웃"></a>
		<img src="" id="usrPic">
		<%} else {%>
		<a href="../visitor/login.jsp"><input type="button" id="loginBtn" value="로그인"></a>
		<%}%>
	</div>
	<div class="menus">
		<a href="../theater/movieList.jsp"><div class="mainmenu m1">영화</div></a>
		<a href="../ticketing/ticketing.jsp"><div class="mainmenu m2">예매</div></a>
		<a href="../ticketing/schedule.jsp"><div class="mainmenu m3">상영시간표</div></a>
		<a href="../theater/frontPage.jsp"><div class="headTitle">MOVIPLAY</div></a>
		<a href=""><div class="mainmenu m4">영화관 소개</div></a>
		<a href=""><div class="mainmenu m5">공지사항</div></a>
		<div class="mainmenu m6">예매내역</div>
	</div>
</div>
</div>
</body>
</html>