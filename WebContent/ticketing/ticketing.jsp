<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.movie.*, theater.screen.*, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 페이지</title>
<style>
#container { width: 1000px; margin: 0px auto; margin: 0px auto; }
#selectTable { height: 60px; width: 100%; overflow: auto; border: 2px solid gray; border-radius: 10px; }
td { border: 1px solid black; }
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
int mov_id = request.getParameter("mov_id")==null ? -1 : Integer.parseInt(request.getParameter("mov_id"));
MovieDAO movPro = MovieDAO.getInstance();
ScreenDAO scnPro = ScreenDAO.getInstance();
List<MovieDTO> movies = movPro.getMovList();

%>
<input type="hidden" id="mov_id" value="<%=mov_id %>">
<table id="selectTable">
	<tr>
		<th width="30%">영화 선택</th>
		<th width="15%">상영관 선택</th>
		<th width="25%">날짜 선택</th>
		<th width="30%">시간 선택</th>
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