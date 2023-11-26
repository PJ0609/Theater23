<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.ticket.*, theater.screen.*, theater.movie.*, java.util.List, java.util.ArrayList, 
				 java.text.SimpleDateFormat, java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매내역</title>
<style>
#container { width: 1000px; margin: 0px auto; margin: 0px auto; }
.tkt { border: 2px solid lightgray; border-radius: 8px; text-align: center; vertical-align: top; margin: 20px; padding: 12px; }
.tkt:after {content : "";display : block;clear : both;}
.movImg { width: 150px;  margin-left: 10px; float: left;  }
.ticketForm { width: 700px; display: inline-block; }
.tktInfo { display: inline-block; margin: 20px; width: 700px; float: left; font-weight: bold; }
.tktInfo th { width: 100px; font-weight: bold; text-align: right; }
.tktInfo td { text-align: left; padding-left: 20px; }
#resv_id { font-weight: bold; color: #224070; }
.Btn { margin: 3px 12px 0px 12px; float: right; background-color: lightgray; width: 100px; height: 35px; border-radius: 8px; 
 text-align: center; line-height: 35px; font-weight: bold; cursor: pointer; }
.movieInfo { background-color: lightblue; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	// 예매일 조회월 선택
	let monthSelect = document.querySelector(".monthSelect");
	monthSelect.addEventListener("change", function() {
		let year = monthSelect.value.substring(0,4);
		let month = monthSelect.value.substring(6,8);
		location = "visitorTicket.jsp?tktMonth=" + year + "-" + month;
	});
	
	// 예매 취소버튼
	let cancelTktBtns = document.querySelectorAll(".cancelTkt");
	let ticketForms = document.querySelectorAll(".ticketForm");
	for(let i in cancelTktBtns) {
		cancelTktBtns[i].addEventListener("click", function() {
			if(confirm(ticketForms[i].time.value + " 의 <" + ticketForms[i].mov_name.value + "> 예매내역을 취소하시겠습니까?")) {
				ticketForms[i].submit();
			} else {
				return;
			}
		});
	}
})
</script>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
SimpleDateFormat sdf1 = new SimpleDateFormat("YYYY. MM. dd (E) kk:mm");
SimpleDateFormat sdf2 = new SimpleDateFormat("MM. dd kk:mm");
LocalDate now = LocalDate.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYY년 MM월");
DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("YYYY-MM");
// 요청된 월 가져오기
String tktMonth = request.getParameter("tktMonth") == null ? now.format(formatter2) : request.getParameter("tktMonth");

// DAO 불러오기
TicketDAO ticketPro = TicketDAO.getInstance();
ScreenDAO screenPro = ScreenDAO.getInstance();
MovieDAO moviePro = MovieDAO.getInstance();

List<TicketDTO> tickets = ticketPro.getTktList(id, tktMonth);


%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
	<h2><img src="../icons/right.png" width="20px"> 예매내역 확인</h2>
	<div class="selector">조회범위 선택
	<select class="monthSelect">
		<option <%if(tktMonth.equals(now.plusMonths(3).format(formatter2))){%>selected<%}%>><%=now.plusMonths(3).format(formatter) %></option>
		<option <%if(tktMonth.equals(now.plusMonths(2).format(formatter2))){%>selected<%}%>><%=now.plusMonths(2).format(formatter) %></option>
		<option <%if(tktMonth.equals(now.plusMonths(1).format(formatter2))){%>selected<%}%>><%=now.plusMonths(1).format(formatter) %></option>
		<option <%if(tktMonth.equals(now.format(formatter2))){%>selected<%}%>><%=now.format(formatter) %></option>
		<option <%if(tktMonth.equals(now.plusMonths(-1).format(formatter2))){%>selected<%}%>><%=now.plusMonths(-1).format(formatter) %></option>
		<option <%if(tktMonth.equals(now.plusMonths(-2).format(formatter2))){%>selected<%}%>><%=now.plusMonths(-2).format(formatter) %></option>
		<option <%if(tktMonth.equals(now.plusMonths(-3).format(formatter2))){%>selected<%}%>><%=now.plusMonths(-3).format(formatter) %></option>
		<option <%if(tktMonth.equals(now.plusMonths(-4).format(formatter2))){%>selected<%}%>><%=now.plusMonths(-4).format(formatter) %></option>
	</select>
	</div>
	<div class="ticketViewer">
		<%for(TicketDTO ticket : tickets) {
			MovieDTO movie = moviePro.getMovie(ticket.getMov_id());
			String[] resv_type = ticket.getResv_type().split(",");
			for(int i = 0; i<resv_type.length; i++) {
				resv_type[i] = resv_type[i].trim();
			}
			%>
			<div class="tkt">
				<img src="../images/<%=movie.getMov_img() %>" class="movImg">
				<form action="../ticketing/ticketDeletePro.jsp" method="post" class="ticketForm">
				<input type="hidden" name="resv_id" value="<%=ticket.getResv_id() %>">
				<input type="hidden" name="seat" value="<%=ticket.getSeat() %>">
				<input type="hidden" name="scn_id" value="<%=ticket.getScn_id() %>">
				<input type="hidden" name="time" value="<%=sdf1.format(ticket.getScn_time()) %>">
				<input type="hidden" name="mov_name" value="<%=movie.getMov_name() %>">
				<table class="tktInfo">
					<tr>
						<th>영화명:</th>
						<td id="info_mov_name" colspan="3"><%=movie.getMov_name() %></td> 
					</tr>
					<tr class="info_resv_id">
						<th>예매번호:</th>
						<td colspan="3" id="resv_id"><%=ticket.getResv_id() %></td>
					</tr>
					<tr class="info_theater">
						<th width="20%">상영관: </th>
						<td width="30%"><%=ticket.getTheater() %></td>
						<th width="15%">관람인원:</th>
						<td width="35%">성인 <%=resv_type[0] %>명, 청소년 <%=resv_type[1] %>명</td>
					</tr>
					<tr class="info_time">
						<th>관람일시:</th>
						<td colspan="3"><%=sdf1.format(ticket.getScn_time()) %> ~ <%=sdf2.format(ticket.getEnd_time()) %></td>
					</tr>
					<tr class="info_seat">
						<th>관람좌석:</th>
						<td  colspan="3"><%=ticket.getSeat() %></td>
					</tr>
				</table>
				<hr>
				<div class="cancelTkt Btn">예매 취소</div>
				<a href="../theater/movieInfo.jsp?mov_id=<%=ticket.getMov_id()%>"><div class="movieInfo Btn">영화 정보</div></a>
			</form>
			</div>
		<%} %>
	</div>
</div>
</body>
</html>