<%@page import="java.time.DayOfWeek"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 시간표 페이지</title>
<style>
#container { width: 1000px; margin: 0px auto; }
a { text-decoration: none; color: black; }
/* 날짜 선택부 */
.weekArr { position: relative; top: 10px; }
.days { display: inline-block; margin: 0px 10px; }
.dayBlock { width: 70px; height: 50px;  border: 1px solid gray; border-radius: 10px; text-align: center; }
.dayBlock:hover { background-color: #e6e8e8; }
.bold { font-weight: bold; }
.blue { color: blue; }
.red { color: red; }
.selected { background-color: #e6e8e8; }
.yrmonth { font-size: 0.7em; width: 70px; border: 1px solid gray; border-radius: 6px; text-align: center; }
.day { font-size: 2em; }
.weekday {}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {	
	// refDay를 현재날짜로 설정
	let refDay = document.getElementById("refDay");
	refDay.addEventListener("change", function() {
		location = "schedule.jsp?refDay=" + refDay.value;
	});
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String sRefDay = (String)request.getParameter("refDay");
LocalDate refDay = sRefDay==null ? LocalDate.now() : LocalDate.parse(sRefDay);
%>
<div id="container">
<h1>상영시간표</h1>
<!-- 날짜 선택부 -->
날짜를 선택하세요: <input type="date" id="refDay" value="<%=refDay%>">
<div class="dateSelector">
	<div class="days weekArr"><a href="schedule.jsp?refDay=<%=refDay.plusDays(-7)%>"><img src="../icons/square-left.png" width="35px" ></a></div>
	<%
	HashMap<Integer, String> weekdayMap = new HashMap<Integer, String>();
	weekdayMap.put(1,"월");
	weekdayMap.put(2,"화");
	weekdayMap.put(3,"수");
	weekdayMap.put(4,"목");
	weekdayMap.put(5,"금");
	weekdayMap.put(6,"토");
	weekdayMap.put(7,"일");
	for(int i=-1; i<6; i++) { %>
	<div class="days">
		<%if(refDay.plusDays(i).getDayOfMonth() == 1 || i == -1) {%>
		<div class="yrmonth"><%=refDay.plusDays(i).getYear()%>년 <%=refDay.plusDays(i).getMonthValue()%>월</div><%} %>
		<a href="schedule.jsp?refDay=<%=refDay.plusDays(i)%>">
		<div class="dayBlock <%if(i==0) {%>selected<%}%>">
			<span class="day"><%=refDay.plusDays(i).getDayOfMonth()%></span>
			<span class="weekday <%if(refDay.plusDays(i).getDayOfWeek().getValue()==6) {%>blue<%} else if(refDay.plusDays(i).getDayOfWeek().getValue()==7){%>red<%}%>"><%=weekdayMap.get(refDay.plusDays(i).getDayOfWeek().getValue())%></span>
		</div>
		</a>
	</div>
	<%} %>
	<div class="days weekArr"><a href="schedule.jsp?refDay=<%=refDay.plusDays(7)%>"><img src="../icons/square-right.png" width="35px"></a></div>
</div>
<!-- 상영 스케줄 뷰 -->

</body>
</html>