<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.ticket.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓 취소 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
TicketDAO ticketPro = TicketDAO.getInstance();
%>
<jsp:useBean id="ticket" class="theater.ticket.TicketDTO"/>
<jsp:setProperty property="*" name="ticket"/>
<%
ticketPro.deleteTicket(ticket);
response.sendRedirect("../visitor/visitorTicket.jsp");
%>
</body>
</html>