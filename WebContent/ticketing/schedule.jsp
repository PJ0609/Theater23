<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.LocalDate, java.time.format.DateTimeFormatter, theater.screening.*, theater.movie.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 시간표 페이지</title>
<style>
#container { width: 1000px; margin: 0px auto; }
a { text-decoration: none; color: black; }
/* 날짜 선택부 */
.dateSelect { background-color: #f0f7ff; border: 1px solid gray; border-radius: 10px; padding: 8px 10px 10px 10px; }
.weekArr { position: relative; top: 10px; }
.days { display: inline-block; margin: 0px 8px; }
.dayBlock { box-sizing: border-box; width: 70px; height: 50px;  border: 1px solid gray; border-radius: 10px; text-align: center; }
.dayBlock:hover { background-color: #e6e8e8; }
.bold { font-weight: bold; }
.blue { color: blue; }
.red { color: red; }
.selected { background-color: #e6e8e8; border: 2.5px solid black; }
.yrmonth { box-sizing: border-box; font-size: 0.7em; width: 70px; border: 1px solid gray; border-radius: 6px; text-align: center; }
.day { font-size: 2em; }
.weekday {}
.dateSelector { display: inline-block; border: 1px solid gray; border-radius: 10px; padding: 5px; }
/* 상영 스케줄 뷰 */
.rating { width: 32px; position: relative; top: 3px; }
.mov_title { font-size: 2em; font-weight: bold; }
hr { color: #ff1100; }
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

// 조회기준일 설정
String sRefDay = (String)request.getParameter("refDay");
LocalDate refDay = sRefDay==null ? LocalDate.now() : LocalDate.parse(sRefDay);

%>
<div id="container">
<h1>상영시간표</h1>
<!-- 날짜 선택부 -->
<div class="dateSelect">
	<div class="days weekArr"><a href="schedule.jsp?refDay=<%=refDay.plusDays(-1)%>"><img src="../icons/square-left.png" width="35px" ></a></div>
	<%
	HashMap<Integer, String> weekdayMap = new HashMap<Integer, String>();
	weekdayMap.put(1,"월");
	weekdayMap.put(2,"화");
	weekdayMap.put(3,"수");
	weekdayMap.put(4,"목");
	weekdayMap.put(5,"금");
	weekdayMap.put(6,"토");
	weekdayMap.put(7,"일");
	int weekDiff = refDay.getDayOfWeek().getValue()-1;
	for(int i=-weekDiff; i<7-weekDiff; i++) { %>
	<div class="days">
		<%if(refDay.plusDays(i).getDayOfMonth() == 1 || i==-weekDiff) {%>
		<div class="yrmonth"><%=refDay.plusDays(i).getYear()%>. <%=refDay.plusDays(i).getMonthValue()%></div><%} %>
		<a href="schedule.jsp?refDay=<%=refDay.plusDays(i)%>">
		<div class="dayBlock <%if(i==0) {%>selected<%}%>">
			<span class="day"><%=refDay.plusDays(i).getDayOfMonth()%></span>
			<span class="weekday <%if(refDay.plusDays(i).getDayOfWeek().getValue()==6) {%>blue<%} else if(refDay.plusDays(i).getDayOfWeek().getValue()==7){%>red<%}%>"><%=weekdayMap.get(refDay.plusDays(i).getDayOfWeek().getValue())%></span>
		</div>
		</a>
	</div>
	<%} %>
	<div class="days weekArr"><a href="schedule.jsp?refDay=<%=refDay.plusDays(1)%>"><img src="../icons/square-right.png" width="35px"></a></div>
	<div class="dateSelector">날짜 선택 <input type="date" id="refDay" value="<%=refDay%>"></div>
</div>
<!-- 상영 스케줄 뷰 -->
<div class="schedules">
<%
//조회기준일로 영화 id목록 가져오기
ScreenDAO scnPro = ScreenDAO.getInstance();
List<Integer> mov_ids = scnPro.getMovByDate(refDay);
System.out.println("지정일 조회된 영화: " + mov_ids);

// 목록에 있는 영화 id마다 상영 조회
MovieDAO MovPro = MovieDAO.getInstance();
DateTimeFormatter dtf =  DateTimeFormatter.ofPattern("yyyy년 M월 dd일");
for(int mov_id : mov_ids) {
	ScreenDTO scndto = new ScreenDTO();
	List<ScreenDTO> scnList = scnPro.getScnList(mov_id, refDay);
	MovieDTO movie = MovPro.getMovie(mov_id);
%>
	<hr>
	<div class="movie">
		<div class="movieInfo">
			<img src="../icons/<%=movie.getRating()%>.png" class="rating">
			<span class="mov_title"><%=movie.getMov_name()%> </span>
			<span class="mov_length"><%=movie.getLength() %>분 / </span>
			<span class="mov_Rel_date"><%=movie.getRel_date().toLocalDate().format(dtf) %> 개봉 /</span>
			<span class="mov_genre"><%=movie.getGenre()%></span>
		</div>
		<img src="/imageFile/<%=movie.getMov_img()%>">
		<div class="movieTime">
		<%
		int scn_id = 0; String scn_type = "";
		for(ScreenDTO screen : scnList) {
			// 상영관이나 상영타입이 달라질 경우에만 줄바꿈, 재표시 수행 
			if(scn_id != screen.getScn_id() || scn_type != screen.getScn_type()){
				scn_id = screen.getScn_id();
				scn_type = screen.getScn_type();
			%>
			<div class="new_scntype">
				<span class="scn_id">상영관: <%=scn_id%></span>
				<span class="scn_type">상영 타입: <%=scn_type%></span>
			</div>
			<%} %>
			<div class="screenblock">
				<span class="scn_time">상영시간: <%=screen.getScn_time()%></span>
				<span class="remaining_seats">잔여석: <%=screen.getRemaining_seats()%></span>
			</div>
		<%} %>
		</div>
	</div>
	<hr>
<%}%>
</div>
</body>
</html>