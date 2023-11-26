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
/* 페이징 처리 */
.paging { clear: both; margin: 15px; text-align: center;}
.pageBox { display: inline-block; width: 30px; height: 30px; line-height: 30px; vertical-align: middle; font-weight: bold; border-radius: 4px; }
.pageBox:hover { background-color: lightblue; }
.currentPagebox { background-color: lightblue; }
.pageArrow { display: inline-block; width: 20px; height: 20px; line-height: 30px; vertical-align: middle; font-weight: bold; border-radius: 4px;  }
</style>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
MovieDAO moviePro = MovieDAO.getInstance();
// 검색어가 있는지 검사
boolean searched = request.getParameter("keyword") != null && request.getParameter("keyword") != "";
String keyword = "";
if (searched) {
	keyword = request.getParameter("keyword");
}

// 현재 페이지 가져오기
int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
int showCount = 8;
int start = (currentPage - 1) * showCount;
// 영화 가져오기
List<MovieDTO> movies = searched ? moviePro.getMovList(start, showCount, keyword) : moviePro.getMovList(start, showCount);

// 전체 페이지 수 설정
int movieCnt = searched ? moviePro.getMovieCnt(keyword) : moviePro.getMovieCnt();
int totalPageCount = movieCnt / showCount + (movieCnt%showCount == 0 ? 0 : 1);
// 페이지 블럭 시작과 끝
int showPageblockCnt = 10;
int startPageblock = ((currentPage - 1) / showPageblockCnt) * showPageblockCnt + 1;
int endPageblock = (startPageblock + showPageblockCnt - 1) > totalPageCount ? totalPageCount : (startPageblock + showPageblockCnt - 1);

SimpleDateFormat sdf = new SimpleDateFormat("YYYY.MM.dd");
%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
<%if(searched) {
	if(movieCnt == 0) {%>
		<h2><img src="../icons/right.png" width="20px"> '<%=keyword %>' 키워드로 검색된 영화가 없습니다.</h2>
	<%} else { %>
		<h2><img src="../icons/right.png" width="20px"> '<%=keyword %>' 키워드로 검색된 영화</h2>
	<%}
} else { %>
	<h2><img src="../icons/right.png" width="20px"> 상영중인 영화</h2>
<%}%>
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
	<div class="paging">
		<%if(currentPage != 1) {%>
			<a href="movieList.jsp?page=1&keyword=<%=keyword%>"><img src="../icons/double-left-arrow.png" class="pageArrow"></a>
		<%}
		if(startPageblock != 1) { %>
			<a href="movieList.jsp?page=<%=startPageblock - 1%>&keyword=<%=keyword%>"><img src="../icons/left-arrow.png" class="pageArrow"></a>
		<%} 
		for(int i=startPageblock ; i <= endPageblock; i++ )  {
			if (currentPage == i) {%>
			<div class="pageBox currentPagebox"><%=i%></div>
			<%} else {%>
			<a href="movieList.jsp?page=<%=i%>&keyword=<%=keyword%>"><div class="pageBox"><%=i%></div></a>
			<%}
		}
		if(endPageblock != totalPageCount) { %>
			<a href="movieList.jsp?page=<%=endPageblock + 1%>&keyword=<%=keyword%>"><img src="../icons/right-arrow.png" class="pageArrow"></a>
		<%} 
		if (currentPage != totalPageCount) {%>
			<a href="movieList.jsp?page=<%=totalPageCount%>&keyword=<%=keyword%>"><img src="../icons/double-right-arrow.png" class="pageArrow"></a>
		<%}%>
	</div>
</div>
</div>
</body>
</html>