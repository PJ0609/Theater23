<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 시간표 페이지</title>
<style>
.days { display: inline-block; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {	
	// refDay를 현재날짜로 설정
	let refDay = document.getElementById("refDay");
	refDay.addEventListener("change", function() {
		location = "schedule.jsp?refDay=" + refDay.value;
	})
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String sRefDay = (String)request.getParameter("refDay");
LocalDate refDay = sRefDay==null ? LocalDate.now() : LocalDate.parse(sRefDay);
%>
<h1>상영시간표</h1>
날짜를 선택하세요: <input type="date" id="refDay" value="<%=refDay%>">
<div class="dateSelector">
	<div class="days"><img src="../icons/square-left.png" width="35px" ></div>
	<%for(int i=0; i<7; i++) { %>
	<div class="days"></div>
	<%} %>
	<div class="days"><img src="../icons/square-right.png" width="35px"></div>
</div>
</body>
</html>