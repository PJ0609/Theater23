<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.LocalDateTime, java.sql.Timestamp, theater.ticket.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓 발급 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

// 티켓 고유 예약 ID 만들기
LocalDateTime now = LocalDateTime.now();
String str1 = String.valueOf(now.getYear()) + String.valueOf(now.getMonthValue()) + String.valueOf(now.getDayOfMonth());
UUID uuid = UUID.randomUUID();
String str2 = uuid.toString().replace("-","").substring(0,12);
String resv_id = str1 + str2;
System.out.println(resv_id);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
TicketDTO ticket = new TicketDTO();
ticket.setResv_id(resv_id);
ticket.setScn_id(Integer.parseInt(request.getParameter("scn_id")));
ticket.setMov_id(Integer.parseInt(request.getParameter("mov_id")));
ticket.setId((String)session.getAttribute("id"));
ticket.setResv_type(request.getParameter("resv_type"));
ticket.setTheater(Integer.parseInt(request.getParameter("theater")));
ticket.setScn_time(Timestamp.valueOf(request.getParameter("scn_time")));
ticket.setEnd_time(Timestamp.valueOf(request.getParameter("end_time")));
ticket.setSeat(request.getParameter("seat"));

TicketDAO ticketPro = TicketDAO.getInstance();
ticketPro.insertTicket(ticket);
out.println("<script>alert('예매가 완료되었습니다.');</script>");
response.sendRedirect("../visitor/visitorTicket.jsp");
%>
</body>
</html>