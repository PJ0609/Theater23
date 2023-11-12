<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.movie.*, java.util.List, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 목록</title>
<style>
#container { width: 1000px; margin: 0px auto; }
.mov_box { display: inline-block; width: 220px; padding: 10px; border: 2px solid lightgray; border-radius: 8px; }
.movImg { width: 200px; height: 287px; display: block; margin: 5px auto; }
.rating { width: 25px; float: left; }
.mov_name { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; word-break:break-all; width: 180px; height: 23px; font-size: 18px; font-weight: bold;  }
</style>
</head>
<body>
<%
MovieDAO moviePro = MovieDAO.getInstance();
List<MovieDTO> movies = moviePro.getMovList(0, 8);
SimpleDateFormat sdf = new SimpleDateFormat("YYYY.MM.dd");
%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
<h3>영화</h3>
<%for(MovieDTO movie : movies) {%>
<a href="../theater/movieInfo.jsp?mov_id=<%=movie.getMov_id()%>">
	<div class="mov_box">
		<img src="../images/<%=movie.getMov_img()%>" class="movImg">
		<img src="../icons/<%=movie.getRating()%>.png" class="rating">
		<div class="mov_name"><%=movie.getMov_name()%></div>
		<span>개봉일: <%=sdf.format(movie.getRel_date()) %> </span>
	</div>
</a>
<%}%>
</div>
</body>
</html>