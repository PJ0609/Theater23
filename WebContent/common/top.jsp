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
.wing { background-color: #97c1cf; width: 100%; margin:0; }
.container { width: 1000px; margin: 0px auto; text-align: center;}
a { text-decoration: none; color: black; }
.headTitle { background-color: black; color: #86c8f7; border-radius: 10px; font-size: 35px; font-weight: bold; font-family: Oswald;
			 padding: 0px 5px; margin: 0px 10px 0px 10px; display: inline-block; }
.usrInfo { float: right; margin-top: 10px;  }
/* 메뉴 */
.menus { clear: both; }
.mainmenu { text-align: center; background-color: white; display: inline-block; font-weight: bold; border: 2px solid black;
			width: 100px; border-radius:10px; padding: 3px; margin: 10px; transition:all 0.3s; }
.mainmenu:hover { background-color: #86c8f7; }
/* 검색 */
.search { float: left; position: relative; top: 10px; }
.search_drop { position: absolute; opacity: 0; visibility: hidden; transition:all 0.5s; left:40px; top: -2px; text-align: center; vertical-align: center;
			   width: 300px; height: 35px; background-color:lightblue; border: 2px solid gray; border-radius: 10px; }
#searchshowchk { display: none; }
.closeImg { display: none; width: 25px; cursor: pointer; }
.searchImg { display: inline-block; width: 25px; cursor: pointer; }
label:has(#searchshowchk:checked) +.search_drop { opacity: 1; visibility: visible; }
#searchshowchk:checked ~.closeImg { display: block; }
#searchshowchk:checked ~.searchImg { display: none; }
.search_drop .searchImg { position: relative; top: 5px; }
.searchBox { width: 200px; line-height:18px; font-size: 18px; background-color: transparent; font-weight: bold;
			 position: relative; outline: none; border: none; }

</style>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
%>
<div class="wing">
<div class="container">
	<div class="search">
		<label for="searchshowchk">
			<input type="checkbox" id="searchshowchk">
			<img class="closeImg" src="../icons/close.png">
			<img class="searchImg" src="../icons/search.png">
		</label>
		<div class="search_drop">
			<input class="searchBox" type="text" placeholder="영화를 검색하세요">&nbsp;&nbsp;
			<img class="searchImg" src="../icons/search.png" >
		</div>
	</div>
	<div class="usrInfo">
		<%if(session.getAttribute("id") != null) {%>
		<span id="visitorID"><%=id %></span> 방문자님 환영합니다.
		<a href="../visitor/logoutPro.jsp"><input type="button" value="로그아웃"></a>
		<img src="" id="usrPic">
		<%} else {%>
		<a href="../visitor/login.jsp"><input type="button" value="로그인"></a>
		<%}%>
	</div>
	<div class="menus">
		<a href=""><div class="mainmenu m1">영화</div></a>
		<a href="../ticketing/ticketing.jsp"><div class="mainmenu m2">예매</div></a>
		<a href="../ticketing/schedule.jsp"><div class="mainmenu m3">상영시간표</div></a>
		<a href="../theater/frontPage.jsp"><div class="headTitle">MOVIPLAY</div></a>
		<a href=""><div class="mainmenu m4">영화관 소개</div></a>
		<a href=""><div class="mainmenu m5">공지사항</div></a>
		<a href=""><div class="mainmenu m6">예매내역</div></a>
	</div>
	<hr>
</div>
</div>
</body>
</html>