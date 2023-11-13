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
.mov_list { text-align: center; }
.mov_box { display: inline-block; width: 200px; padding: 10px; border: 2px solid #f2f0f0; border-radius: 8px; text-align: left; margin: 5px; }
.movImg { width: 190px; height: 270px; display: block; margin: 5px auto 10px auto; }
.rating { width: 20px; float: left; margin-right: 3px; }
.mov_name { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; word-break:break-all; width: 176px; height: 23px; font-weight: bold;  }
.rel_date { font-size: 0.8em; }
.infoBtn { display: inline-block; width: 84px; font-size: 14px; padding: 3px; background-color: lightgray; text-align: center; border-radius: 5px; font-weight: bold; margin: 5px 3px 3px 2px; }
.tktBtn { display: inline-block; width: 84px; font-size: 14px; padding: 3px; background-color: #224070; color: white; text-align: center; border-radius: 5px; font-weight: bold; margin: 5px 3px 3px 2px; }
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
<h2><img src="../icons/right.png" width="20px"> 상영중인 영화</h2>
<div class="mov_list">
	<%for(MovieDTO movie : movies) {%>
			<div class="mov_box">
				<a href="../theater/movieInfo.jsp?mov_id=<%=movie.getMov_id()%>">
					<img src="../images/<%=movie.getMov_img()%>" class="movImg">
				</a>
				<img src="../icons/<%=movie.getRating()%>.png" class="rating">
				<div class="mov_name"><%=movie.getMov_name()%></div>
				<div class="rel_date">개봉일: <%=sdf.format(movie.getRel_date()) %> </div>
				<a href="../theater/movieInfo.jsp?mov_id=<%=movie.getMov_id()%>">
					<div class="infoBtn" >상세정보</div>
				</a>
				<a href="../ticketing/ticketing.jsp?mov_id=<%=movie.getMov_id()%>">
					<div class="tktBtn">예매하기</div>
				</a>
			</div>
	<%}%>
</div>
</div>
</body>
</html>