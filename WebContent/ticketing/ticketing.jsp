<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.movie.*, theater.screen.*, java.util.Set, java.util.HashSet, java.util.List, java.util.Arrays, java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 페이지</title>
<style>
#container { width: 1000px; margin: 0px auto; margin: 0px auto; }
#selectTable { height: 60px; width: 100%; overflow: auto; border: 2px solid gray; border-radius: 10px; background-color: #f0f7ff; }
td { border: 1px solid black; border-radius: 10px; background-color: white; border: 3px solid gray; }
td:last-child { background-color: #f0f7ff; border: none; }
.movieSelector { height: 300px; overflow: auto; }
.movie { overflow: hidden; text-overflow: ellipsis; width: 230px; white-space: nowrap; font-weight: bold;
		 border-radius: 3px; height: 30px; line-height: 30px;}
.movRadio:checked+.movie { background-color: #224070; color: white; }
.movRadio { display: none; }
.movie:hover { background-color: #f0f7ff; }
.rating { width: 20px; position: relative; top: 3px; left: 4px; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {	
	let movRadios = document.querySelectorAll(".movRadio");
	let mov_id = document.querySelector("#mov_id");
	for(movRadio of movRadios){
		if(movRadio.value == mov_id.value) {
			movRadio.checked = true;
		}
		movRadio.addEventListener("click", function(e) {
			if(e.currentTarget.checked) {
				location = "ticketing.jsp?mov_id=" + e.currentTarget.value; 
				//mov_id뿐 아니라 상영관, 날짜값 모두 가져가야 함.
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
String dates = request.getParameter("scnday");
// String List로 선택된 요소들 가져오기
List<String> s_mov_ids = mov_id == null ? null : Arrays.asList(mov_id.split(","));
List<String> s_theaters = theater == null ? null : Arrays.asList(theater.split(","));
List<String> s_dates = dates == null ? null : Arrays.asList(dates.split(","));

// DAO 연결
MovieDAO movPro = MovieDAO.getInstance();
ScreenDAO scnPro = ScreenDAO.getInstance();

// 영화선택란
// 영화 목록 가져오기
List<MovieDTO> movies = movPro.getMovList();
Set<Integer> av_mov_ids = new HashSet<Integer>();	//available movie ids
if(theater != null || dates != null) {
	av_mov_ids = scnPro.getMovQry(s_theaters, s_mov_ids);
}

// 상영관 선택란

// 날짜 선택란


%>
<input type="hidden" id="mov_id" value="<%=mov_id %>">
<table id="selectTable">
	<tr>
		<th width="30%">영화 선택</th>
		<th width="15%">상영관 선택</th>
		<th width="20%">날짜 선택</th>
		<th width="35%">시간 선택</th>
	</tr>
	<tr>
		<td>
			<div class="movieSelector">
			<%for(MovieDTO movie : movies) {%>
				<label for="mov_<%=movie.getMov_id()%>">
					<input type="radio" name="movRadio" class="movRadio" id="mov_<%=movie.getMov_id()%>" value="<%=movie.getMov_id()%>">
					<div class="movie">
						<img src="../icons/<%=movie.getRating()%>.png" class="rating"> <%=movie.getMov_name()%>
					</div>
				</label>
			<%}%>
			</div>
		</td>
		<td>
			<div class="theaterSelector">
				
			</div>
		</td>
		<td>
			<div class="dateSelector">
			
			</div>
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