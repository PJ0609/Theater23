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
.tkt { border: 2px solid lightgray; border-radius: 8px; text-align: center; vertical-align: top; margin: 20px; border-collapse: collapse; }
.movImg { width: 100px;  margin: 10px; float: left; }
.tktInfo {  margin: 20px; width: 700px; }
.tktInfo th { width: 100px; font-weight: bold; text-align: right; }
.tktInfo td { text-align: left; padding-left: 20px;}
#resv_id { font-weight: bold; color: #224070; }
</style>
<script>

</script>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
SimpleDateFormat sdf1 = new SimpleDateFormat("YYYY. MM. dd (E) kk:mm");
SimpleDateFormat sdf2 = new SimpleDateFormat("MM. dd kk:mm");
// DAO 불러오기
TicketDAO ticketPro = TicketDAO.getInstance();
ScreenDAO screenPro = ScreenDAO.getInstance();
MovieDAO moviePro = MovieDAO.getInstance();

List<TicketDTO> tickets = ticketPro.getTktList(id);

LocalDate now = LocalDate.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYY년 MM월");
%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
	<h3>예매내역 확인</h3>
	<div class="selector">조회범위 선택
	<select>
		<option><%=now.plusMonths(3).format(formatter) %></option>
		<option><%=now.plusMonths(2).format(formatter) %></option>
		<option><%=now.plusMonths(1).format(formatter) %></option>
		<option selected><%=now.plusMonths(0).format(formatter) %></option>
		<option><%=now.plusMonths(-1).format(formatter) %></option>
		<option><%=now.plusMonths(-2).format(formatter) %></option>
		<option><%=now.plusMonths(-3).format(formatter) %></option>
		<option><%=now.plusMonths(-4).format(formatter) %></option>
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
				
			</div>
		<%} %>
	</div>
</div>
</body>
</html>