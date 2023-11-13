<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.movie.*, theater.screen.*, java.util.Set, java.util.HashSet, java.util.List, java.util.Arrays, 
				 java.util.HashMap, java.time.LocalDate, java.time.format.DateTimeFormatter, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 페이지</title>
<style>
#container { width: 1000px; margin: 0px auto; }
.subTitle { float: left; }
.reload { width: 100px; height: 28px; background-color: white; float: right; border: 2px solid black; border-radius: 7px; text-align: center;
		  position: relative; top: 28px; font-weight: bold; line-height: 28px; cursor: pointer; transition: all 0.3s;  }
.reload:hover { background-color: lightgray; }
.reloadImg { width: 18px; position: relative; top: 3px; margin-right: 5px; }
#selectTable { width: 100%; overflow: auto; border: 2px solid gray; border-radius: 10px; background-color: #f0f7ff; }
td { border: 1px solid black; border-radius: 10px; background-color: white; border: 3px solid gray; 
	 vertical-align: top; }
td>div { height: 350px; height: 380px; overflow: auto; }
/* 개별 선택 요소 설정 */
.chkT, .chkF { display: none; }
.chkT+div, .chkF+div { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-weight: bold;
		 			   border-radius: 3px; height: 30px; line-height: 30px; padding: 0px 5px; transition: all 0.15s; }
.chkT+div { background-color: #f0f7ff; }
.chkT+div:hover { background-color: #96c7ff; }
.chkT:checked+div { background-color: #224070; color: white; }
.chkF+div { color: #545454; background-color: #c9c9c9; }
.chkF+div:hover { background-color: lightgray; }
/* 영화 선택 */
.movie:hover { background-color: #f0f7ff; }
.rating { width: 20px; position: relative; top: 3px; left: 4px; }
/* 상영관 선택 */
/* 날짜 선택 */
.dateSelector { height: 380px; overflow: auto; }
.dateSelect { margin-bottom: 3px; }
.yrmonth { font-size: 1.1em; font-weight: bold; border: 1px solid gray; border-radius: 3px;  }
.chkT:checked+div .weekday { color: white; }
.blue { color: blue; }
.red { color: red; }
/* 시간 선택 */
.timeSelector { display: none; border-color: black; }
.scntype { font-size: 1.1em; font-weight: bold; border: 1px solid gray; border-radius: 3px; padding:0px 5px; margin-top: 5px; }
.screenblock { display: inline-block; width: 65px; height: 45px; text-align: center; border-radius: 3px; background-color: #f0f7ff;
			   border: 2px solid black; padding-top: 3px; font-weight: bold; margin: 3px; transition: all 0.2s; cursor: pointer; }
.screenblock:hover { background-color: #96c7ff; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {	
	let movChks = document.querySelectorAll(".movChk");
	let thChks = document.querySelectorAll(".thChk");
	let dateChks = document.querySelectorAll(".dateChk");
	let chkTs = document.querySelectorAll(".chkT");
	let chkFs = document.querySelectorAll(".chkF");
	let timeSelector = document.querySelector(".timeSelector");
	
	// request에서 받아오기
	let mov_id = document.querySelector("#mov_id");
	let mov_ids = mov_id.value == "" || mov_id.value == "null" ? new Array() : mov_id.value.split(",") ;
	let theater = document.querySelector("#theater");
	let theaters = theater.value == "" || theater.value == "null" ? new Array() : theater.value.split(",") ;
	let date = document.querySelector("#date");
	let dates = date.value == "null" ? "" : date.value ;
	
	// 초기화 버튼
	let reloadBtn = document.querySelector(".reload");
	reloadBtn.addEventListener("click", function() {
		location = "ticketing.jsp?refDay=" + refDay.value;
	})
	
	// 받아온 값에 따라 체크 표시
	// 만일 체크된 값 중에 클래스가 chkF로 변경되었다면 ->배열에서 제거
	for(movChk of movChks) {
		if (mov_ids.indexOf(movChk.value) != -1 ) {
			if(movChk.classList[1] =="chkF"){
				mov_ids.splice(mov_ids.indexOf(movChk.value),1);
				continue;
			}
			movChk.checked = true;
		}
	}
	for(thChk of thChks) {
		if (theaters.indexOf(thChk.value) != -1 ) {
			if(thChk.classList[1] =="chkF"){
				theaters.splice(theaters.indexOf(thChk.value),1);
				continue;
			}
			thChk.checked = true;
		}
	}
	for(dateChk of dateChks) {
		if (dates == dateChk.value ) {
			if(dateChk.classList[1] =="chkF"){
				dates = "";
				continue;
			}
			dateChk.checked = true;
		}
	}
	
	// 3개 모두 선택된 경우 시간선택란 표시
	if(mov_ids.length * theaters.length * dates.length != 0) {
		timeSelector.style.display = "block";
	}
	
	// 날짜 기준일 선택
	let refDay = document.getElementById("refDay");
	refDay.addEventListener("change", function() {
		location = "ticketing.jsp?refDay=" + refDay.value;
	});
	
	// 쿼리값에 따라 선택가능 요소 기능 설정
	for(chkT of chkTs){
		chkT.addEventListener("click", function(e) {
			if(e.currentTarget.checked) {
				// 클릭한 대상의 클래스명 중 첫번째 클래스명을 가져옴
				// 해당 클래스명에 맞는 배열에 클릭한 대상의 값을 추가
				switch(e.currentTarget.classList[0]) {
					case "movChk":
						if(mov_ids.length >= 3) {
							alert("영화는 최대 3개까지 선택 가능합니다.");
							e.currentTarget.checked = false;
							return;
						}
						mov_ids.push(e.currentTarget.value);
						break;
					case "thChk":
						if(theaters.length >=3) {
							alert("영화와 상영관은 최대 3개까지 선택 가능합니다.");
							e.currentTarget.checked = false;
							return;
						}
						theaters.push(e.currentTarget.value);
						break;
					case "dateChk":
						dates = e.currentTarget.value;
						break;
				}
			} else {
				switch(e.currentTarget.classList[0]) {
					case "movChk":
						mov_ids.splice(mov_ids.indexOf(e.currentTarget.value), 1 );
						break;
					case "thChk":
						theaters.splice(theaters.indexOf(e.currentTarget.value), 1 );
						break;
				}
			}
			location = "ticketing.jsp?mov_id=" + mov_ids.join(",") + "&theater=" + theaters.join(",") + "&date=" + dates + "&refDay=" + refDay.value;
		});
	}
	//쿼리값에 따라 선택 불가능 요소 기능 설정
	for(chkF of chkFs){
		chkF.addEventListener("click", function(e) {
			alert("해당 조건의 상영이 존재하지 않습니다. 다른 조건으로 변경해 주세요.");
			e.currentTarget.checked = false;
		});
	}
	
	// 좌석 선택 전 로그인 여부 확인
	let screenblock = document.querySelectorAll(".screenblock");
	let scn_id = document.querySelectorAll(".scn_id");
	let id = document.querySelector("#id");
	for(let i=0; i<screenblock.length; i++) {
		screenblock[i].addEventListener("click", function() {
			if ( id.value == "null" ) {
				alert("예매하기 위해서 로그인해 주세요.");
				location = "../visitor/login.jsp?scn_id=" + scn_id[i].value;
			} else {
				location = "../ticketing/seats.jsp?scn_id=" + scn_id[i].value;
			}
		})
	}
	
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
// 빈 문자열 null로처리
String mov_id = request.getParameter("mov_id") == "" ? null : request.getParameter("mov_id");
String theater = request.getParameter("theater") == "" ? null : request.getParameter("theater");
String date = request.getParameter("date")== "" ? null : request.getParameter("date");
// String List로 선택된 요소들 가져오기
List<String> s_mov_ids = mov_id == null ? null : Arrays.asList(mov_id.split(","));
List<String> s_theaters = theater == null ? null : Arrays.asList(theater.split(","));
List<String> s_dates = date == null ? null : Arrays.asList(date.split(","));
System.out.println("s_mov_ids = " + s_mov_ids);
System.out.println("s_theaters = " + s_theaters);
System.out.println("s_dates = " + s_dates);
//조회기준일 가져오기
String sRefDay = (String)request.getParameter("refDay");
LocalDate refDay = sRefDay==null ? LocalDate.of(2023,12,11) : LocalDate.parse(sRefDay); //원래 LocalDate.now()

// DAO 연결
MovieDAO movPro = MovieDAO.getInstance();
ScreenDAO scnPro = ScreenDAO.getInstance();

// < 영화선택란 >
// 기간내 영화 목록 가져오기
List<Integer> movieIds = scnPro.getMovQry(null, null, refDay);
List<MovieDTO> movies = movPro.getMovList(movieIds);
//movPro.get
// 나머지 2개 중 하나라도 선택된 것이 있는 경우 -> av_mov_ids에 요소 추가하고 검사
// 추가조건 선택되었는지 여부 검사
Boolean mov_id_c = theater != null || date != null;
// 선택가능 영화목록 가져오기 (available movie IDs)
List<Integer> av_mov_ids = scnPro.getMovQry(s_theaters, s_dates, refDay);

// < 상영관 선택란 >
// 기간내 전체 상영관 가져오기
List<Integer> theaters = scnPro.getTheaterQry(null, null, refDay);
// 추가조건 선택되었는지 여부 검사
Boolean theater_c = mov_id != null || date != null;
// 기간, 조건내 선택가능 상영관 조회
List<Integer> av_theaters = scnPro.getTheaterQry(s_mov_ids, s_dates, refDay);

// < 날짜 선택란 >
DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
HashMap<Integer, String> weekdayMap = new HashMap<Integer, String>();
weekdayMap.put(1,"월");
weekdayMap.put(2,"화");
weekdayMap.put(3,"수");
weekdayMap.put(4,"목");
weekdayMap.put(5,"금");
weekdayMap.put(6,"토");
weekdayMap.put(7,"일");
// 추가조건 선택되었는지 여부 검사
Boolean date_c = mov_id != null || theater != null;
// 선택가능 날짜 리스트
List<LocalDate> av_dates = scnPro.getDateQry(s_mov_ids, s_theaters, refDay);// refDay로부터 10일간의 선택가능여부 조회

// < 상영 선택란 >
// 3가지 조건 모두 선택되었는지 검사
boolean time_c = mov_id != null && theater != null && date != null;
System.out.println("mov_id=" + mov_id + " theater= " + theater + " date= " + date );
// 조건에 맞는 상영 가져오기
List<ScreenDTO> scnList = null;
if(time_c) {
	scnList = scnPro.getScreen(s_mov_ids, s_theaters, s_dates);
}
SimpleDateFormat sdf1 = new SimpleDateFormat("kk:mm");

%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
	<h2 class="subTitle"><img src="../icons/right.png" width="20px"> 예매하기</h2>
	<input type="hidden" id="mov_id" value="<%=mov_id %>">
	<input type="hidden" id="theater" value="<%=theater %>">
	<input type="hidden" id="date" value="<%=date %>">
	<input type="hidden" id="id" value="<%=id %>">
	<div class="reload">
		<img src="../icons/reload.png" class="reloadImg">
		<span>초기화</span>
	</div>
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
				<%if(movies != null) {
					for(MovieDTO movie : movies) {%>
						<label for="mov_<%=movie.getMov_id()%>">
						<input type="checkbox" name="movChk" class="movChk 
						<%if(mov_id_c) {//다른 조건이 걸려 있는 경우
							if(av_mov_ids.contains(movie.getMov_id()) ){%>chkT<%} else {%>chkF<%}%>
						<%} else {%>chkT<%}%>"
						 id="mov_<%=movie.getMov_id()%>" value="<%=movie.getMov_id()%>">
						<div class="movie">
							<img src="../icons/<%=movie.getRating()%>.png" class="rating">&nbsp;&nbsp;<%=movie.getMov_name()%>
						</div>
						</label>
					<%}
				}%>
				</div>
			</td>
			<td>
				<div class="theaterSelector">
				<%if(theaters != null) {
					for(int thtr : theaters) {%>
						<label for="th_<%=thtr%>">
						<input type="checkbox" name="thChk" class="thChk 
						<%if(theater_c) {
							if(av_theaters.contains(thtr) ) {%>chkT <%} else {%>chkF<%}%>
						<%} else {%>chkT<%}%>"
						 id="th_<%=thtr%>" value="<%=thtr%>">
						<div class="theater">
							<%=thtr%> 상영관
						</div>
						</label>
					<%} %>
				<%}%>
				</div>
			</td>
			<td>
				<div class="dateSelector">
				<div class="dateSelect">기준일: <input type="date" id="refDay" value="<%=refDay%>"></div>
				<%for(int i=0; i<10; i++) { 
					String sDay = refDay.plusDays(i).format(formatter1);
					if(refDay.plusDays(i).getDayOfMonth() == 1 || i == 0) {%>
					<div class="yrmonth"><%=refDay.plusDays(i).getYear()%>. <%=refDay.plusDays(i).getMonthValue()%></div>
					<%} %>
					<label for="day_<%=sDay%>">
					<!-- 체크박스를 라디오 버튼으로 바꿈(단일선택) -->
					<input type="radio" name="dateChk" class="dateChk 
					<%if(av_dates.contains(LocalDate.parse(sDay,formatter1))) {%>chkT<%} else { %>chkF<%} %>" 
					id="day_<%=sDay%>" value="<%=sDay%>">
						<div class="dayBlock">
							<span class="day"><%=refDay.plusDays(i).getDayOfMonth()%></span>
							<span class="weekday <%if(refDay.plusDays(i).getDayOfWeek().getValue()==6) {%>blue<%} else if(refDay.plusDays(i).getDayOfWeek().getValue()==7){%>red<%}%>"><%=weekdayMap.get(refDay.plusDays(i).getDayOfWeek().getValue())%></span>
							<%if(sDay.equals(LocalDate.now().format(formatter1))) {%><span class="today">(오늘)</span><%}%>
						</div>
					</label>
				<%} %>
				</div>
			</td>
			<td class="timeSelector">
				<div>
				<%
				if(time_c) {
				int th = -1; String scn_type = "";
				for(ScreenDTO screen : scnList) {
					// 영화, 상영관이나 상영타입이 달라질 경우에만 줄바꿈, 표시 
					if(th != screen.getTheater() || !scn_type.equals(screen.getScn_type()) ){
						th = screen.getTheater();
						scn_type = screen.getScn_type();%>
						<div class="scntype"><b>
							<span class="mov_name"><%=screen.getMov_name()%> / </span>
							<span class="theater"><%=th%>상영관 / </span>
							<span class="scn_type"> <%=scn_type%></span>
						</b></div>
					<%}%>
					<div class="screenblock">
						<input type="hidden" class="scn_id" value="<%=screen.getScn_id()%>">
						<span class="scn_time"><%=sdf1.format(screen.getScn_time())%></span><br>
						<span class="remaining_seats"><%=screen.getRemaining_seats()%>석</span>
					</div>
				<%}}%>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>