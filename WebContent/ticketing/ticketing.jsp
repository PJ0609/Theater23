<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.movie.*, theater.screen.*, java.util.Set, java.util.HashSet, java.util.List, java.util.Arrays, 
				 java.util.HashMap, java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 페이지</title>
<style>
#container { width: 1000px; margin: 0px auto; margin: 0px auto; }
#selectTable { height: 60px; width: 100%; overflow: auto; border: 2px solid gray; border-radius: 10px; background-color: #f0f7ff; }
td { border: 1px solid black; border-radius: 10px; background-color: white; border: 3px solid gray; vertical-align: top; }
td:last-child { background-color: #f0f7ff; border: none; }
.movieSelector { height: 300px; overflow: auto; }
.movie { overflow: hidden; text-overflow: ellipsis; width: 230px; white-space: nowrap; font-weight: bold;
		 border-radius: 3px; height: 30px; line-height: 30px;}
.movChk:checked+.movie { background-color: #224070; color: white; }
.movChk { display: none; }
.movie:hover { background-color: #f0f7ff; }
.rating { width: 20px; position: relative; top: 3px; left: 4px; }


.theaterSelector { height: 300px; overflow: auto; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {	
	let movChks = document.querySelectorAll(".movChk");
	let chkTs = document.querySelectorAll(".chkT");
	
	// request에서 받아오기
	let mov_id = document.querySelector("#mov_id");
	let mov_ids = mov_id.value == "" || mov_id.value == "null" ? new Array() : mov_id.value.split(",") ;
	let theater = document.querySelector("#theater");
	let theaters = theater.value == "" || theater.value == "null" ? new Array() : theater.value.split(",") ;
	let date = document.querySelector("#date");
	let dates = date.value == "" || date.value == "null" ? new Array() : date.value.split(",") ;
	
	// 받아온 값에 따라 체크 표시
	for(movChk of movChks) {
		if (mov_ids.indexOf(movChk.value) != -1 ) {
			movChk.checked = true;
		}
	}
	// 날짜 기준일 선택
	let refDay = document.getElementById("refDay");
	refDay.addEventListener("change", function() {
		location = "ticketing.jsp?refDay=" + refDay.value;
	});
	
	// 쿼리값에 따라 요소 기능 설정
	for(chkT of chkTs){
		chkT.addEventListener("click", function(e) {
			console.log("호출");
			if(e.currentTarget.checked) {
				if(mov_ids.length >= 3 ) { //추가필요
					alert("한 항목은 최대 3개까지 선택 가능합니다.");
					return;
				}
				console.log(e.currentTarget.classList[0]);
				switch(e.currentTarget.classList[0]) {
					case "movChk":
						mov_ids.push(e.currentTarget.value);
						console.log(mov_ids);
						break;
					case "thChk":
						break;
				}
				//location = "ticketing.jsp?mov_id=" + mov_ids.join(",");
				//mov_id뿐 아니라 상영관, 날짜값 모두 가져가야 함.
			} else {
				switch(e.currentTarget.classList[0]) {
					case "movChk":
						mov_ids.splice(mov_ids.indexOf(e.currentTarget.value), 1 );
						console.log(mov_ids);
						break;
				}
				//location = "ticketing.jsp?mov_id=" + mov_ids.join(","); 
			}
		});
	}
	
});
</script>
</head>
<body>
<div id="container">
<%
request.setCharacterEncoding("utf-8");
String mov_id = request.getParameter("mov_id");
String theater = request.getParameter("theater");
String date = request.getParameter("scnday");
// String List로 선택된 요소들 가져오기
List<String> s_mov_ids = mov_id == null || mov_id == "" ? null : Arrays.asList(mov_id.split(","));
List<String> s_theaters = theater == null || theater == "" ? null : Arrays.asList(theater.split(","));
List<String> s_dates = date == null || date == "" ? null : Arrays.asList(date.split(","));
System.out.println("s_mov_ids = " + s_mov_ids);
System.out.println("s_theaters = " + s_theaters);
System.out.println("s_dates = " + s_dates);

// DAO 연결
MovieDAO movPro = MovieDAO.getInstance();
ScreenDAO scnPro = ScreenDAO.getInstance();

// 영화선택란
// 영화 목록 가져오기
List<MovieDTO> movies = movPro.getMovList();
// 나머지 2개 중 하나라도 선택된 것이 있는 경우 -> av_mov_ids에 요소 추가하고 검사
// if movie id complementary info exists
Boolean mov_id_c = theater != null || date != null;
List<Integer> av_mov_ids = scnPro.getMovQry(s_theaters, s_dates);	//available movie ids

// 상영관 선택란
List<Integer> theaters = scnPro.getTheaterQry(null, null);
Boolean theater_c = mov_id != null || date != null;
List<Integer> av_theaters = scnPro.getTheaterQry(s_mov_ids, s_dates);

// 날짜 선택란
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
HashMap<Integer, String> weekdayMap = new HashMap<Integer, String>();
weekdayMap.put(1,"월");
weekdayMap.put(2,"화");
weekdayMap.put(3,"수");
weekdayMap.put(4,"목");
weekdayMap.put(5,"금");
weekdayMap.put(6,"토");
weekdayMap.put(7,"일");
//조회기준일 가져오기
String sRefDay = (String)request.getParameter("refDay");
LocalDate refDay = sRefDay==null ? LocalDate.now() : LocalDate.parse(sRefDay);
// 선택필터 날짜 리스트
Boolean date_c = mov_id != null || theater != null;
List<LocalDate> av_dates = scnPro.getDateQry(s_mov_ids, s_theaters);
%>
<input type="hidden" id="mov_id" value="<%=mov_id %>">
<input type="hidden" id="theater" value="<%=theater %>">
<input type="hidden" id="date" value="<%=date %>">
<table id="selectTable">
	<tr>
		<th width="30%">영화 선택</th>
		<th width="15%">상영관 선택</th>
		<th width="20%">날짜 선택</th>
		<th width="35%">시간 선택</th>
	</tr>
	<tr>
		<td class="movieSelector">
			<%for(MovieDTO movie : movies) {%>
				<label for="mov_<%=movie.getMov_id()%>">
				<input type="checkbox" name="movChk" class="movChk <%if(!av_mov_ids.contains(movie.getMov_id()) && mov_id_c) {%>chkF<%} else {%>chkT<%}%>" id="mov_<%=movie.getMov_id()%>" value="<%=movie.getMov_id()%>">
				<div class="movie">
					<img src="../icons/<%=movie.getRating()%>.png" class="rating"> <%=movie.getMov_name()%>
				</div>
				</label>
			<%}%>
		</td>
		<td>
			<div class="theaterSelector">
			<%for(int thtr : theaters) {%>
				<label for="th_<%=thtr%>">
				<input type="checkbox" name="movChk" class="thChk <%if(!av_theaters.contains(thtr) && theater_c) {%>chkF<%} else {%>chkT<%}%>" id="th_<%=thtr%>" value="<%=thtr%>">
				<div class="theater">
					<%=thtr%> 상영관
				</div>
				</label>
			<%}%>
			</div>
		</td>
		<td>
			<div class="dateSelector">
			<div class="dateSelect">기준일: <input type="date" id="refDay" value="<%=refDay%>"></div>
			<%for(int i=0; i<20; i++) { 
				String sDay = refDay.plusDays(i).format(formatter);
				if(refDay.plusDays(i).getDayOfMonth() == 1 || i == 0) {%>
				<div class="yrmonth"><%=refDay.plusDays(i).getYear()%>. <%=refDay.plusDays(i).getMonthValue()%></div>
				<%} %>
				<label for="day_<%=sDay%>">
				<input type="checkbox" name="dateChk" class="dateChk <%if(!av_dates.contains(sDay) && date_c) {%>chkF<%} else {%>chkT<%}%>" id="day_<%=sDay%>" value="<%=sDay%>">
					<div class="dayBlock <%if(i==0) {%>selected<%}%>">
						<span class="day"><%=refDay.plusDays(i).getDayOfMonth()%></span>
						<span class="weekday <%if(refDay.plusDays(i).getDayOfWeek().getValue()==6) {%>blue<%} else if(refDay.plusDays(i).getDayOfWeek().getValue()==7){%>red<%}%>"><%=weekdayMap.get(refDay.plusDays(i).getDayOfWeek().getValue())%></span>
					</div>
				</label>
			<%} %>
		</td>
		<td>
			<div class="timeSelector">
			
			</div>
		</td>
	</tr>
</table>
</div>
</body>
</html>