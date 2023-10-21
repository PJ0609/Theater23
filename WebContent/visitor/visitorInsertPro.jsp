<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.visitor.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="newVisitor" class="theater.visitor.VisitorDTO"/>
<jsp:setProperty property="*" name="newVisitor"/>
<%
VisitorDAO visitorPro = VisitorDAO.getInstance();
if(visitorPro.insertVisitor(newVisitor) == 1 ) {
	out.println("<script>alert('회원가입 완료');</script>");
	response.sendRedirect("../visitor/login.jsp");
} else {
	out.println("<script>alert('회원가입 오류'); history.back()</script>");
}
%>
</body>
</html>