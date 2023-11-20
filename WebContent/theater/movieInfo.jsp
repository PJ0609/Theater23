<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.movie.*, theater.review.*, java.util.List, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 상세정보</title>
<style>
#container { width: 1000px; margin: 0px auto; text-align: left; }
.movImgDiv { float: left; margin: 30px 30px 0px 30px; position: relative; top: -30px; }
.movImg { width: 260px; height: 370px; }
.ratingImg { width: 20px; }
.mov_name { margin: 35px 15px 15px 15px; }
.infoTable th { width: 80px; text-align: left; font-weight: 900; }
.infoTable td { width: 150px; text-align: left; font-weight: bold; }
.synopsis { display: inline-block; width: 650px; height: 150px;  background-color: transparent; font-family:'Malgun Gothic'; resize: none;
		    border: none; margin: 10px; font-weight: bold; font-size: 16px; margin-top: 20px ; }
.synopsis:focus { outline: none; }
.tktBtn { float: left; width: 100px; height: 40px; line-height: 40px; font-weight: bold; border-radius: 8px; background-color: #224070; color: white;
		  position: relative; left: 0px; cursor: pointer; text-align: center; border: 3px solid black; }
.clr { clear: both; margin: 0px; }
/* 메뉴 전환기 */
.switcher { text-align: center; clear: both; }
.swDiv { display: inline-block; width: 300px; height: 30px; line-height: 30px; border-bottom: 4px solid lightgray; margin: 0px 30px; cursor: pointer; }
.sw { display: none; }
.sw:checked+label>.swDiv { border-bottom:4px solid #0250cc; }
/* 플레이어 */
.trailer { display: none; text-align: center; margin: 20px; }
.switcher:has(#sw_trailer:checked)~.trailer { display: block; }
/* 리뷰 */
.review { display: none; }
.switcher:has(#sw_review:checked)~.review { display: block; }
/* 별점 애니메이션 처리*/
.stars fieldset{ direction: rtl; /* 이모지 순서 반전 */ border: 1px solid lightgray; border-radius: 6px; }
.stars fieldset legend{ text-align: left; }
.stars input[type=radio]{ display: none; }
.stars .rateLbl{ font-size: 1.2em; color: transparent; text-shadow: 0 0 0 #f0f0f0; }
.stars .rateLbl:hover{text-shadow: 0 0 0 #fadf11; }
.stars .rateLbl:hover ~ label{text-shadow: 0 0 0 #fadf11; /* 마우스 호버 뒤에오는 이모지들 */}
.stars input[type=radio]:checked ~ .rateLbl{text-shadow: 0 0 0 #fadf11; }
/* 리뷰 영역 */
.reviewBox { margin: 5px auto; padding: 15px 10px 5px 10px; width: 100% ; height: 105px;  background-color: #f2fcff; border-radius: 10px; border: 1px solid lightgray; }
.new_rev_title { margin: 5px; }
.stars { float:left; }
.usr_rating_score { font-weight: bold; font-size: 1.2em;}

.spoilerLabel { font-weight: bold; color: black; }
.rev_content { width: 790px; margin-left: 10px; height: 60px; border-radius: 6px; resize: none; font-family: Malgun-Gothic; }
.submitOption { float: right; }
.rev_submit { width: 90px; height: 25px;background-color: #0250cc; color: white; border-radius: 10px; 
			  font-weight: bold; border:none;  margin: 4px; }
/* 평가 읽기 */
.rev_change { float: right; }
#star_view { border: none; float: left; }
#view_content { background-color: transparent; width: 750px; height:70px; display:inline-block; vertical-align: middle; font-family: Malgun-Gothic; }
.rev_info { float:left; position: relative; height: 25px; width: 229px; line-heignt: 30px; top: -30px; left: 2px; padding-top: 3px; text-align: center; background-color: #transparent; border: 1px solid lightgray; border-radius: 6px;  }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	// 스포일러 여부 값 처리
	let spoilerChks = document.querySelectorAll(".spoilerChk");
	for(spoilerChk of spoilerChks) {
		spoilerChk.addEventListener("change", function(){
			if(spoilerChk.checked == true) {
				spoilerChk.value = 1;
			} else {
				spoilerChk.value = 0;
			}
		});
	}
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
int mov_id = Integer.parseInt(request.getParameter("mov_id"));
MovieDAO moviePro = MovieDAO.getInstance();
ReviewDAO reviewPro = ReviewDAO.getInstance();
// 영화, 리뷰정보 가져오기
MovieDTO movie = moviePro.getMovie(mov_id);
List<ReviewDTO> reviews = reviewPro.getRvwList(mov_id);

SimpleDateFormat sdf1 = new SimpleDateFormat("YYYY.MM.dd");
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy년 MM월 dd일"); // .format() : Date -> String

%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
	<div class="movImgDiv">
		<img src="../images/<%=movie.getMov_img()%>" class="movImg">
	</div>
	<div class="infoBox">
		<h1 class="mov_name"><%=movie.getMov_name() %></h1>
		<hr>
		<table class="infoTable">
			<tr>
				<th class="rel_date">개봉일: </th>
				<td><%=sdf1.format(movie.getRel_date()) %></td>
				<th class="genre">장르:</th>
				<td><%=movie.getGenre() %></td>
				<th class="director">감독:</th>
				<td><%=movie.getDirector() %></td>
			</tr>
			<tr>
				<th class="rating">상영등급:</th>
				<td><img src="../icons/<%=movie.getRating()%>.png" class="ratingImg"></td>
				<th class="length">상영시간: </th>
				<td><%=movie.getLength() %>분</td>
			</tr>
		</table>
		<div><textarea class="synopsis" readonly><%=movie.getSynopsis() %></textarea></div>
		<a href="../ticketing/ticketing.jsp?mov_id=<%=movie.getMov_id()%>">
			<div class="tktBtn">예매하기</div>
		</a>
	</div>
	<div class="switcher">
		<input type="radio" name="sw" value="sw_trailer" id="sw_trailer" class="sw">
		<label for="sw_trailer">
			<div class="swDiv">트레일러</div>
		</label>
		<input type="radio" name="sw" value="sw_review" id="sw_review" class="sw">
		<label for="sw_review">
			<div class="swDiv">영화 감상평</div>
		</label>
	</div>
	<hr class="clr">
	<div class="trailer">
		<iframe width="800" height="450" 
		src="<%=movie.getTrailer_link() %>" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
		</iframe>
	</div>
	<!-- 리뷰 영역 -->
	<div class="review" id="review">
		<%if(id != null) { %>
			<div class="new_rev_title"><%=id%>님의 감상평을 작성해보세요.</div>
			<div class="new_rev reviewBox">
			<form action="../theater/reviewInsertPro.jsp" method="post" name="reviewForm" id="reviewForm" class="reviewForm">
				<input type="hidden" name="id" value="<%=id%>" >
				<input type="hidden" name="mov_id" value="<%=movie.getMov_id()%>" >
				<input type="hidden" name="mov_name" value="<%=movie.getMov_name()%>" >
				<div class="stars">
				    <fieldset>
						<div>별점주기</div>
				        <input type="radio" name="usr_rating" value="5" id="rate1"><label for="rate1" class="rateLbl">⭐</label>
				        <input type="radio" name="usr_rating" value="4" id="rate2"><label for="rate2" class="rateLbl">⭐</label>
				        <input type="radio" name="usr_rating" value="3" id="rate3"><label for="rate3" class="rateLbl">⭐</label>
				        <input type="radio" name="usr_rating" value="2" id="rate4"><label for="rate4" class="rateLbl">⭐</label>
				        <input type="radio" name="usr_rating" value="1" id="rate5"><label for="rate5" class="rateLbl">⭐</label>
				    </fieldset>
			    </div>
				<textarea name="content" class="rev_content" placeholder="관람평을 입력해주세요."></textarea>
				<div class="submitOption">
				    <input type="checkbox" name="spoiler" value="0" class="spoilerChk" id="spoiler_new">
				    <label for="spoiler_new" class="spoilerLabel">스포일러 포함</label>
					<input type="submit" class="rev_submit" value="리뷰 작성">
				</div>
			</form>
			</div>
		<%} %>
		<%for(ReviewDTO review : reviews) { %>
		<div class="reviewBox">
			<div class="stars" id="star_view">
			    <fieldset>
					<%int usr_rating = review.getUsr_rating(); %>
			        <input type="radio" name="usr_rating" value="5" id="rate6" <%if(usr_rating == 5) {%>checked<%}%>><label for="rate6" class="rateLbl" onclick="return(false);">⭐</label>
			        <input type="radio" name="usr_rating" value="4" id="rate7" <%if(usr_rating == 4) {%>checked<%}%>><label for="rate7" class="rateLbl" onclick="return(false);">⭐</label>
			        <input type="radio" name="usr_rating" value="3" id="rate8" <%if(usr_rating == 3) {%>checked<%}%>><label for="rate8" class="rateLbl" onclick="return(false);">⭐</label>
			        <input type="radio" name="usr_rating" value="2" id="rate9" <%if(usr_rating == 2) {%>checked<%}%>><label for="rate9" class="rateLbl" onclick="return(false);">⭐</label>
			        <input type="radio" name="usr_rating" value="1" id="rate10" <%if(usr_rating == 1) {%>checked<%}%>><label for="rate10" class="rateLbl" onclick="return(false);">⭐</label>
			    	<span class="usr_rating_score"><%=usr_rating %> / 5</span>
			    </fieldset>
		    </div>
			<textarea name="content" class="rev_content" id="view_content" placeholder="관람평을 입력해주세요." readonly><%=review.getContent() %></textarea>
			<div class="rev_info">
				<span><%=review.getId() %></span> | 
				<span><%=sdf2.format(review.getPost_time()) %></span>
			</div>
			<%if(review.getId().equals(id)) {%>
				<div class="rev_change">
					<input type="button" value="관람평 수정" class="btnReviewUpdate">
					<input type="button" value="관람평 삭제" class="btnReviewDelete">
					<input type="hidden" value="<%=review.getReview_id() %>" class="rev_id">
				</div>
			<%} %>
			<div class="rev_options">
				<input type="checkbox" class="mod_show" id="mod_show<%=review.getReview_id()%>">
			</div>
			<div class="mod_rev reviewBox">
				<form action="../review/reviewUpdatePro.jsp" method="post" name="reviewForm" class="reviewForm">
				<input type="hidden" name="review_id" value="<%=review.getReview_id()%>">
				<input type="hidden" name="id" value="<%=id%>">
				<input type="hidden" name="mov_id" value="<%=movie.getMov_id()%>">
				<input type="hidden" name="mov_name" value="<%=movie.getMov_name()%>">
				<fieldset>
			        <input type="radio" name="usr_rating" value="5" id="rate6" <%if(usr_rating == 5) {%>checked<%}%>><label for="rate6" class="rateLbl">⭐</label>
			        <input type="radio" name="usr_rating" value="4" id="rate7" <%if(usr_rating == 4) {%>checked<%}%>><label for="rate7" class="rateLbl">⭐</label>
			        <input type="radio" name="usr_rating" value="3" id="rate8" <%if(usr_rating == 3) {%>checked<%}%>><label for="rate8" class="rateLbl">⭐</label>
			        <input type="radio" name="usr_rating" value="2" id="rate9" <%if(usr_rating == 2) {%>checked<%}%>><label for="rate9" class="rateLbl">⭐</label>
			        <input type="radio" name="usr_rating" value="1" id="rate10" <%if(usr_rating == 1) {%>checked<%}%>><label for="rate10" class="rateLbl">⭐</label>
			        <%=usr_rating %> / 5
			    </fieldset>
			    <input type="checkbox" name="spoiler" value="0" class="spoilerChk" id="spoiler_<%=review.getReview_id()%>">
			    <label for="spoiler_<%=review.getReview_id()%>" id="spoilerLabel">스포일러 포함</label>
				<input type="text" id="newrev_content" value="<%=review.getContent()%>" name="content">
				<input type="submit" id="rev_submit" value="글 수정">
			</form>
			</div>
		</div>
		<%} %>
	</div>
</div>
</body>
</html>