<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.visitor.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Check</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

VisitorDAO visitorPro = VisitorDAO.getInstance();

if(visitorPro.loginChk(id, pwd) == 1){
	session.setAttribute("id", id);
	response.sendRedirect("../theater/frontPage.jsp");
} else {
	out.println("<script>alert('아이디와 비밀번호를 다시 확인하세요'); history.back();</script>");
}
%>
</body>
</html>