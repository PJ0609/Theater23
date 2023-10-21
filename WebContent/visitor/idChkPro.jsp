<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.visitor.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 아이디 체크</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");

VisitorDAO visitorPro = VisitorDAO.getInstance();
int chk = visitorPro.idChk(id);
response.sendRedirect("../visitor/visitorInsertForm.jsp?id=" + id + "&idChk=" + chk);
%>
</body>
</html>