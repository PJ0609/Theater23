<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.review.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 삭제 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
ReviewDAO reviewPro = ReviewDAO.getInstance();
int review_id = Integer.parseInt(request.getParameter("review_id"));
String mov_id = request.getParameter("mov_id");
reviewPro.deleteReview(review_id);
response.sendRedirect("../theater/movieInfo.jsp?mov_id=" + mov_id + "#review");
%>

</body>
</html>