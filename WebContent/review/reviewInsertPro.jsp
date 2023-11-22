<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.review.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 삽입 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
ReviewDAO reviewPro = ReviewDAO.getInstance();
%>
<jsp:useBean id="newReview" class="theater.review.ReviewDTO"/>
<jsp:setProperty name="newReview" property="*"/>
<%
reviewPro.insertReview(newReview);
response.sendRedirect("../theater/movieInfo.jsp?mov_id=" + newReview.getMov_id() + "#review");
%>
</body>
</html>