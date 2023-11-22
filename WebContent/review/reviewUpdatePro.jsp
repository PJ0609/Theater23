<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.review.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
ReviewDAO reviewPro = ReviewDAO.getInstance();
%>
<jsp:useBean id="modReview" class="theater.review.ReviewDTO"/>
<jsp:setProperty name="modReview" property="*"/>
<%
reviewPro.updateReview(modReview);
response.sendRedirect("../theater/movieInfo.jsp?mov_id=" + modReview.getMov_id() + "#review");
%>
</body>
</html>