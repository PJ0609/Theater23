<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관 정문</title>
<style>
#container { width: 1000px; margin: 0px auto; }
</style>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
	<div class="main">
		<h1>정문입니다. 로그인된 아이디: <%=id %></h1>
		<h1> Branch1에서 추가된 부분입니다. </h1>
		<a href="../visitor/logoutPro.jsp">로그아웃</a>
	</div>
</div>
<!-- 하단 -->
<div class="footer">
	<jsp:include page="../common/bottom.jsp"/>
</div>
</body>
</html>