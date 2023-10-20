<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상단부</title>
<style>
.container { width: 1000px; margin: 0px auto; }

.headTitle { float: left; font-size: 35px; font-weight: bold; }
.usrInfo { float: right; }
/* 메뉴 */
.menus { clear: both; }
.mainmenu { color: white; background-color: lightblue; display: inline-block; }
/* 검색 */
.search { float: right; position: relative; }
.search_drop { position: absolute; opacity: 0; visibility: hidden; transition:all 0.5s; left:-50px;}
#searchshowchk { display: none; }
#searchshowchk:checked ~.search_drop { opacity: 1; visibility: visible; }
</style>
</head>
<body>
<div class="container">
	<div class="headTitle">
		sol영화관
	</div>
	<div class="usrInfo">
		<a href=""><input type="button" value="로그인"></a>
		<img src="" id="usrPic">
	</div>
	<div class="menus">
		<div class="mainmenu m1"><a href="">영화</a></div>
		<div class="mainmenu m2"><a href="">예매</a></div>
		<div class="mainmenu m3"><a href="">상영시간표</a></div>
		<div class="mainmenu m4"><a href="">영화관 소개</a></div>
		<div class="mainmenu m5"><a href="">공지사항</a></div>
		<div class="mainmenu m6"><a href="">예매내역</a></div>
		<div class="search">
			<input type="checkbox" id="searchshowchk">
			<label for="searchshowchk">
			<img src="">검색버튼이미지
			</label>
			<div class="search_drop">
				<input type="text" placeholder="검색어 입력">
				<img src="">검색하기이미지
			</div>
		</div>
	</div>
	<hr>
</div>
</body>
</html>