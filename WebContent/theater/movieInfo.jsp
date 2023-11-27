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
.stars .rateLbl:hover{ text-shadow: 0 0 0 #fadf11; }
.stars .rateLbl:hover ~ label{ text-shadow: 0 0 0 #fadf11; /* 마우스 호버 뒤에오는 이모지들 */}
.stars input[type=radio]:checked ~ .rateLbl{text-shadow: 0 0 0 #fadf11; }
/* 리뷰 영역 */
.reviewBox { clear: both; margin: 5px auto; padding: 10px 10px 5px 15px; width: 100% ; background-color: #f2fcff; border-radius: 10px; 
			 border: 1px solid lightgray; }
.clearfix::after { content:""; clear: both; display: block; }
.new_rev_title { margin: 5px; }
.stars { float:left; }
.usr_rating_score { font-weight: bold; font-size: 1.2em;}

.spoilerLabel { font-weight: bold; color: black; }
.rev_content { float: right; width: 790px; margin-left: 14px; height: 60px; border-radius: 6px; resize: none; font-family: Malgun-Gothic; padding: 3px; }
.submitOption { float: right; }
.rev_btns { width: 90px; height: 25px; line-height: 25px; background-color: #0250cc; color: white; border-radius: 10px; 
			  font-weight: bold; border:none;  margin: 4px; cursor: pointer; }
/* 평가 읽기 */
.rev_change { float: right; }
#star_view { border: none; float: left; }
.view_content { background-color: transparent; width: 743px; height:70px; display:inline-block; vertical-align: middle; font-family: Malgun-Gothic; }
.rev_info { float:left; position: relative; height: 25px; width: 229px; line-heignt: 30px; margin-top: 5px; left: 2px; padding-top: 3px; text-align: center; background-color: #transparent; border: 1px solid lightgray; border-radius: 6px;  }
.mod_chkBox { display: none; }
.review_modBox { display: none; }
div:has(.mod_chkBox:checked)+.review_modBox { display: block; }
.blurEffect { text-shadow: 0px 0px 10px black; color: transparent; position: absolute; }
.blurTextarea { float: right; margin-left: 15px; border: none; border-radius: 6px; resize: none; padding: 3px; font-weight: bold; position: relative; z-index: 100000;
 				background-color: transparent; opacity:1; width: 743px; height:70px; display:inline-block; vertical-align: middle; font-family: Malgun-Gothic; }
/* 페이징 처리 */
.paging { clear: both; margin: 15px; text-align: center;}
.pageBox { display: inline-block; width: 30px; height: 30px; line-height: 30px; vertical-align: middle; font-weight: bold; border-radius: 4px; }
.pageBox:hover { background-color: lightblue; }
.currentPagebox { background-color: lightblue; }
.pageArrow { display: inline-block; width: 20px; height: 20px; line-height: 30px; vertical-align: middle; font-weight: bold; border-radius: 4px;  }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	// 스포일러 여부 값 처리
	let spoilerChks = document.querySelectorAll(".spoilerChk");
	for(let i = 0; i < spoilerChks.length; i++) {
		spoilerChks[i].addEventListener("change", function(){
			if(spoilerChks[i].checked == true) {
				spoilerChks[i].value = 1;
				console.log(spoilerChks[i].value);
			} else {
				spoilerChks[i].value = 0;
				console.log(spoilerChks[i].value);
			}
		});
	}
	
	// 스포일러 컨텐트 블러 처리
	let blurEffects = document.querySelectorAll(".blurEffect");
	let blurTextareas = document.querySelectorAll(".blurTextarea");
	for(let i = 0; i < blurTextareas.length; i++){
		blurTextareas[i].addEventListener("mouseover", function() {
			blurTextareas[i].style.visibility = "hidden";
			blurEffects[i].style.textShadow = "none";
			blurEffects[i].style.color = "black";
		});
		blurEffects[i].addEventListener("mouseout", function() {
			blurTextareas[i].style.visibility = "visible";
			blurEffects[i].style.textShadow = "0px 0px 10px black";
			blurEffects[i].style.color = "transparent";
		});
	}
	
	// 리뷰 작성 공란 검사
	function chkNullSubmit(reviewForm) {
		let isChecked = false;
		for(let i in reviewForm.usr_rating){
			if(reviewForm.usr_rating[i].checked) {
				isChecked = true;
			}
		}
		if(!isChecked) {
			alert("별점을 체크해 주세요."); return;
		} else if(!reviewForm.content.value) {
			alert("내용을 작성해 주세요."); return;
		} else {
			reviewForm.submit();
		}
	}
	let reviewForm = document.querySelector(".reviewForm");
	let submitBtn = document.querySelector(".submitBtn");
	submitBtn.addEventListener("click", function() {
		chkNullSubmit(reviewForm);
	});
	let reviewModForms = document.querySelectorAll(".reviewModForm");
	let submitModBtns = document.querySelectorAll(".submitModBtn");
	for(let i=0; i<reviewModForms.length; i++) {
		submitModBtns[i].addEventListener("click", function() {
			chkNullSubmit(reviewModForms[i]);
		});
	}
	// 삭제 버튼
	let btnReviewDelete = document.querySelectorAll(".btnReviewDelete");
	let reviewDeleteForms = document.querySelectorAll(".reviewDeleteForm");
	for(let i=0; i<btnReviewDelete.length; i++) {
		btnReviewDelete[i].addEventListener("click", function() {
			if(confirm("관람평을 삭제하시겠습니까?")) {
				reviewDeleteForms[i].submit();
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
// 영화 가져오기
MovieDTO movie = moviePro.getMovie(mov_id);

//현재 페이지 가져오기
int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
int showCount = 5;
int start = (currentPage - 1) * showCount;
//리뷰 가져오기
List<ReviewDTO> reviews = reviewPro.getRvwList(mov_id, start, showCount);

//전체 페이지 수 설정
int reviewCnt = reviewPro.getReviewCnt(mov_id);
int totalPageCount = reviewCnt / showCount + (reviewCnt%showCount == 0 ? 0 : 1);
//페이지 블럭 시작과 끝
int showPageblockCnt = 5;
int startPageblock = ((currentPage - 1) / showPageblockCnt) * showPageblockCnt + 1;
int endPageblock = (startPageblock + showPageblockCnt - 1) > totalPageCount ? totalPageCount : (startPageblock + showPageblockCnt - 1);


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
		<input type="radio" name="sw" value="sw_review" id="sw_review" class="sw" checked>
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
			<!-- 리뷰 작성 영역 -->
			<div class="new_rev_title"><%=id%>님의 감상평을 작성해보세요.</div>
			<div class="reviewBox clearfix">
			<form action="../review/reviewInsertPro.jsp" method="post" name="reviewForm" id="reviewForm" class="reviewForm">
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
					<input type="button" class="rev_btns submitBtn" value="감상평 작성">
				</div>
			</form>
			</div>
		<%}
		for(ReviewDTO review : reviews) { 
		int rev_id = review.getReview_id(); %>
		<!-- 리뷰 보기 영역 -->
		<div class="reviewBox clearfix">
			<%if(review.getId().equals(id)) {%><form action="../review/reviewDeletePro.jsp" method="post" class="reviewDeleteForm"><%}%>
				<input type="hidden" name="mov_id" value="<%=mov_id%>">
				<input type="hidden" name="review_id" value="<%=rev_id%>">
				<div class="stars" id="star_view">
				    <fieldset>
						<%int usr_rating = review.getUsr_rating();%>
				        <input type="radio" name="usr_rating_<%=rev_id%>" value="5" id="rate6<%=rev_id%>" <%if(usr_rating == 5) {%>checked<%}%>><label for="rate6<%=rev_id%>" class="rateLbl" onclick="return(false);">⭐</label>
				        <input type="radio" name="usr_rating_<%=rev_id%>" value="4" id="rate7<%=rev_id%>" <%if(usr_rating == 4) {%>checked<%}%>><label for="rate7<%=rev_id%>" class="rateLbl" onclick="return(false);">⭐</label>
				        <input type="radio" name="usr_rating_<%=rev_id%>" value="3" id="rate8<%=rev_id%>" <%if(usr_rating == 3) {%>checked<%}%>><label for="rate8<%=rev_id%>" class="rateLbl" onclick="return(false);">⭐</label>
				        <input type="radio" name="usr_rating_<%=rev_id%>" value="2" id="rate9<%=rev_id%>" <%if(usr_rating == 2) {%>checked<%}%>><label for="rate9<%=rev_id%>" class="rateLbl" onclick="return(false);">⭐</label>
				        <input type="radio" name="usr_rating_<%=rev_id%>" value="1" id="rate10<%=rev_id%>" <%if(usr_rating == 1) {%>checked<%}%>><label for="rate10<%=rev_id%>" class="rateLbl" onclick="return(false);">⭐</label>
				    	<span class="usr_rating_score">5 / <%=usr_rating %></span>
				    </fieldset>
			    </div>
				<textarea name="content" class="rev_content view_content <%if(review.getSpoiler() == 1) {%>blurEffect<%}%>" readonly><%=review.getContent() %></textarea>
				<%if(review.getSpoiler() == 1) {%><textarea class="blurTextarea">스포일러가 포함된 관람평입니다. ▼</textarea><%}%>
				<div class="rev_info">
					<span><%=review.getId() %></span> | 
					<span><%=sdf2.format(review.getPost_time()) %></span>
				</div>
				<%if(review.getId().equals(id)) {%>
					<div class="rev_change">
						<label for="mod_toggle_<%=rev_id%>">
						<div class="rev_btns" class="btnReviewUpdate" style="font-size: 0.8em; display: inline-block; text-align: center;">관람평 수정</div></label>
						<input type="button" class="rev_btns btnReviewDelete" value="관람평 삭제" >
						<input type="hidden" value="<%=rev_id %>" class="rev_id">
					</div>
					<input type="checkbox" id="mod_toggle_<%=rev_id%>" class="mod_chkBox">
				<%} %>
			</form>
		</div>
		<!-- 리뷰 수정 영역 -->
		<div class="reviewBox clearfix review_modBox">
		<form action="../review/reviewUpdatePro.jsp" method="post" name="reviewModForm" class="reviewModForm">
		<input type="hidden" name="review_id" value="<%=rev_id%>">
		<input type="hidden" name="id" value="<%=id%>">
		<input type="hidden" name="mov_id" value="<%=movie.getMov_id()%>">
		<input type="hidden" name="mov_name" value="<%=movie.getMov_name()%>">
			<div class="stars">
				<fieldset>
			        <input type="radio" name="usr_rating" value="5" id="rate11<%=rev_id%>" <%if(usr_rating == 5) {%>checked<%}%>><label for="rate11<%=rev_id%>" class="rateLbl">⭐</label>
			        <input type="radio" name="usr_rating" value="4" id="rate12<%=rev_id%>" <%if(usr_rating == 4) {%>checked<%}%>><label for="rate12<%=rev_id%>" class="rateLbl">⭐</label>
			        <input type="radio" name="usr_rating" value="3" id="rate13<%=rev_id%>" <%if(usr_rating == 3) {%>checked<%}%>><label for="rate13<%=rev_id%>" class="rateLbl">⭐</label>
			        <input type="radio" name="usr_rating" value="2" id="rate14<%=rev_id%>" <%if(usr_rating == 2) {%>checked<%}%>><label for="rate14<%=rev_id%>" class="rateLbl">⭐</label>
			        <input type="radio" name="usr_rating" value="1" id="rate15<%=rev_id%>" <%if(usr_rating == 1) {%>checked<%}%>><label for="rate15<%=rev_id%>" class="rateLbl">⭐</label>
			    </fieldset>
		    </div>
			<textarea name="content" class="rev_content" placeholder="관람평을 입력해주세요."><%=review.getContent() %></textarea>
			<div class="submitOption">
			    <input type="checkbox" name="spoiler" value="<%=review.getSpoiler() %>" class="spoilerChk" id="spoiler_<%=rev_id%>" <%if(review.getSpoiler() == 1) {%>checked<%}%>>
			    <label for="spoiler_<%=rev_id%>" id="spoilerLabel">스포일러 포함</label>
				<input type="button" class="rev_btns submitModBtn" value="글 수정">
			</div>
		</form>
		</div>
		<%} 
		if (reviewCnt != 0) {%>
		<div class="paging">
			<%if(currentPage != 1) {%>
				<a href="movieInfo.jsp?mov_id=<%=mov_id%>&page=1#review"><img src="../icons/double-left-arrow.png" class="pageArrow"></a>
			<%}
			if(startPageblock != 1) { %>
				<a href="movieInfo.jsp?mov_id=<%=mov_id%>&page=<%=startPageblock - 1 %>#review"><img src="../icons/left-arrow.png" class="pageArrow"></a>
			<%} 
			for(int i=startPageblock; i <= endPageblock; i++ )  {
				if (currentPage == i) {%>
				<div class="pageBox currentPagebox"><%=i%></div>
				<%} else {%>
				<a href="movieInfo.jsp?mov_id=<%=mov_id%>&page=<%=i%>"><div class="pageBox"><%=i%></div></a>
				<%}
			}
			if(endPageblock != totalPageCount) { %>
				<a href="movieInfo.jsp?mov_id=<%=mov_id%>&page=<%=endPageblock + 1%>"><img src="../icons/right-arrow.png" class="pageArrow"></a>
			<%}
			if (currentPage != totalPageCount) {%>
				<a href="movieInfo.jsp?mov_id=<%=mov_id%>&page=<%=totalPageCount %>#review"><img src="../icons/double-right-arrow.png" class="pageArrow"></a>
			<%}%>
		</div>
		<%} else {%>
		 등록된 관람평이 없습니다.
		<%}%>
	</div>
	</div>
</div>
</body>
</html>