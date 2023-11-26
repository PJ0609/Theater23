<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.screen.*, theater.movie.*, java.util.*, java.text.SimpleDateFormat, java.text.DecimalFormat, java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택 페이지</title>
<style>
#container { width: 1000px; margin: 0px auto; margin: 0px auto; }
.cntSelector { width: 100%; height: 70px; border: 2px solid gray; border-radius: 15px; text-align: center; background-color: #f0f7ff; }
.seatSelector { position: relative; float: left; width: 69%; height: 500px; border: 2px solid gray; border-radius: 15px; 
			   margin: 10px 2.5px 5px 0; text-align: center; transition: all 0.4s; }
.infoViewer { position: relative; float: right; width: 29%; height: 500px; border: 2px solid gray; border-radius: 15px; margin: 10px 0 5px 2.5px;
			  background-color: #f0f7ff; transition: all 0.4s; }
.selectCntBox { width: 100%; }
.cntConfirm { display: inline-block; width: 90px; height: 35px; border: 2px solid gray; border-radius: 10px; background-color: #86c8f7; text-align: center; 
			 line-height: 33px; margin: 15px 10px 10px 30px; position: relative; top: 2.5px; cursor: pointer; }
.cntReset { display: inline-block; width: 90px; height: 35px; border: 2px solid gray; border-radius: 10px; background-color: #ebebeb; text-align: center;  
			 line-height: 33px; margin: 15px;  position: relative; top: 2.5px;  cursor: pointer; }
.cntBtn { display: inline-block; width: 45px; height: 31px; border: 1px solid black; background-color: white; 
		 border-radius: 10px;  cursor: pointer; font-weight: bold; }
.cntBtn:hover { background-color: #96c4ff; }
.outText { height: 25px; width: 50px; line-height: 25px; font-size: 1.3em; text-weight: bold; text-align: center; border: none; position: relative; top: 3px; background-color: #f0f7ff; }
.outText:focus { outline: none; }

/* 좌석 선택 */
.cntAlert { display: block; position: absolute; top: 20px; left: 140px; width: 400px; height: 50px; line-height: 50px; font-size: 1.2em; 
		   background-color: white; border: 4px solid black; border-radius: 10px; z-index:1000; }
.screen { clip-path: polygon(0 0, 100% 0, 95% 100%, 5% 100%); display: block; margin: 20px auto 40px auto; 
		 width: 600px; height: 40px; background-color: #d9d9d9 ; text-align: center; line-height: 40px; font-weight: bold; }
.seat { box-sizing: border-box; display: inline-block; width: 21px; height: 21px; font-size:10px; line-height:21px; text-align: center; 
		border: 1px solid gray; border-radius: 3px; }
.seat:hover { border: 2px solid black; }
.seatChkBx:checked+.seat { background-color: #86c8f7; }
.booked { background-color: gray; }
.empty { box-sizing: border-box; display: inline-block; width: 10px; height: 21px; border: none; }
.seatChkBx { display: none; }

/* 정보 확인 */
.barcodeImg { width: 100px; height: 30px; position: absolute; top: -4px; right: 25px; }
.scnInfo { width: 97%; height: 280px; border: none; margin: 30px auto 0px auto; border-radius: 10px; padding: 5px; background-color:#05275e; }
.rating { margin: 0 0 0 20px; width: 25px; position: relative; top:-28px; }
.poster { width: 70px; height: 95px; float: right; position: relative; top: 7px; right: 18px;}
.mov_name { display: inline-block; width: 200px; height: 42px;  background-color: transparent; font-family:'Malgun Gothic'; resize: none;
		    overflow: hidden; border: none; margin: 10px; color: white; font-weight: bold; font-size: 16px; margin-top: 25px ; }
.mov_name:focus { outline: none; }
.Info { margin: 10px 10px 10px 20px; color: #cccccc; font-size: 0.7em; }
.scn_time { margin: 10px 10px 10px 20px; color: white; font-size: 0.7em;  }
.horizontal { width: 100%;  height: 2px; background-color: #213d6b; margin: 0; }
#seatResult { width: 230px; display: inline-block; height: 30px;  background-color: transparent; font-family:'Malgun Gothic'; font-weight: bold;
		      resize: none; overflow: hidden; color: #cccccc; border: none;}
#seatResult:focus { outline: none; }
.result { margin: 10px 20px; font-size: 0.7em;  }
.cntResult { float: left; margin: 5px; line-height: 20px; }
.calculate { float: right; margin: 5px; line-height: 20px; text-align: right; }
hr { clear: both; }
.priceLabel { float: left; margin: 5px; font-weight: bold; font-size: 1.2em; position: relative; top: 3px; }
#price { width: 100px; float: right; color: #b53c4c; font-weight: bold; font-size: 1.5em; text-align: right; }
.btn { position: absolute; width: 80px; height: 35px; border: 2px solid gray; border-radius: 10px; background-color: #ebebeb; text-align: center;  
	   line-height: 30px; margin: 15px;  cursor: pointer; font-weight: bold; }
.prev { bottom: 20px; left: 30px; }
.next { bottom: 20px; right: 30px; }
.next:hover { background-color: #86c8f7; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {	
	// 값 가져오기
	let remaining_seats = document.getElementById("remaining_seats");
	let scn_id = document.getElementById("scn_id");
	let adultCnt = document.getElementById("adultCnt");
	let teenCnt = document.getElementById("teenCnt");
	// 인원수 핸들
	let adultMinus = document.getElementById("adultMinus");
	let adultPlus = document.getElementById("adultPlus");
	let teenMinus = document.getElementById("teenMinus");
	let teenPlus = document.getElementById("teenPlus");
	//출력 폼
	let resultForm = document.resultForm;
	
	// 다음 버튼
	let nextBtn = document.querySelector(".next");
	nextBtn.style.backgroundColor = "gray";
	
	// 이전 버튼
	let prevBtn = document.querySelector(".prev");
	prevBtn.addEventListener("click", function() {
		location = "../ticketing/ticketing.jsp?mov_id=" + resultForm.mov_id.value + "&theater=" + resultForm.theater.value + "&date=" + resultForm.scn_time.value.substring(0,10) + "&refDay=" + resultForm.scn_time_minus.value.substring(0,10);
	});
	// 예매수 초과 확인
	function plusChk(obj) {
		let cnt = +adultCnt.value + +teenCnt.value;
		if(cnt >= 8){
			alert("총 8명 초과하여 예매할 수 없습니다.");
		} else if (cnt>= +remaining_seats.value) {
			alert("잔여 좌석 수를 초과하여 예매할 수 없습니다.");
		} else {
			obj.value = +obj.value + 1;
		}
	}
	
	let cnt = +adultCnt.value + +teenCnt.value;
	let cntAlert = document.querySelector(".cntAlert");
	let cntSelector = document.querySelector(".cntSelector");
	let cntConfirm = document.querySelector(".cntConfirm");
	let seatSelector = document.querySelector(".seatSelector");
	let seats = document.querySelectorAll(".seatChkBx");
	// request 결과 0인 경우에만 인원변경 가능하게 설정, 좌석선택 블럭, 암전
	if (cnt == 0) {
		adultPlus.addEventListener("click", function(){
			plusChk(adultCnt);
		});
		
		teenPlus.addEventListener("click", function(){
			plusChk(teenCnt);
		});
		
		adultMinus.addEventListener("click", function(){
			adultCnt.value -= adultCnt.value == "0" ? 0 : 1;
		});
		
		teenMinus.addEventListener("click", function(){
			teenCnt.value -= teenCnt.value == "0" ? 0 : 1;
		});
		// 암전
		cntConfirm.style.backgroundColor = "#ebebeb";
		cntSelector.style.border = "4px solid black";
		seatSelector.style.backgroundColor = "#ebebeb";
		nextBtn.style.backgroundColor = "gray";
		// 좌석선택 방지
		for(seat of seats) {
			seat.disabled = true;
		}
	} else {
		// 인원선택 먼저 요청 안내창 숨김
		cntAlert.style.display = "none";
		seatSelector.style.border = "5px solid black";
		// 좌석 재선택 버튼으로 이름 변경
		cntConfirm.value = "좌석 재선택";
	}
	
	// 인원수 결정 버튼
	cntConfirm.addEventListener("click", function(){
		location = "seats.jsp?scn_id=" + scn_id.value + "&adultCnt=" + adultCnt.value + "&teenCnt=" + teenCnt.value;
	});
	
	// 인원변경 버튼
	let cntReset = document.querySelector(".cntReset");
	cntReset.addEventListener("click", function(){
		location = "seats.jsp?scn_id=" + scn_id.value;
	});
	
	// 좌석 선택
	let seatResult = document.getElementById("seatResult");
	let infoViewer = document.querySelector(".infoViewer");
	locArr = new Array();	// sort를 사용하기 위해 seatCode가 아닌 i 값을 저장
	for(let i=0; i < seats.length; i++) {
		seats[i].addEventListener("change", function(){
			if (seats[i].checked) {
				locArr.push(i);
				locArr.sort((a,b)=>a-b);	//숫자형 정렬로 변경(기본 문자열 정렬)
				seatResult.value = locArr.map((e) => seats[e].value).join(', ');
				resultForm.seat.value = seatResult.value;
				if(locArr.length >= cnt) {
					for(seat of seats) {
						seat.disabled = true;
						seatSelector.style.backgroundColor = "#ebebeb";
						seatSelector.style.border = "2px solid gray";
						nextBtn.style.backgroundColor= "#86c8f7";
						nextBtn.style.border = "3px solid black";
						infoViewer.style.border = "5px solid black";
						nextBtn.addEventListener("click", function(){
							resultForm.submit();
						});
					}
				}
			} else {
				// 찾아서 제거
				locArr.splice(locArr.indexOf(i), 1);
				seatResult.value = locArr.map((e) => seats[e].value).join(', ');
				resultForm.seat.value = seatResult.value;
			}
		});
	}
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
// null일 때 테스트용 상영(1) 입력 
int scn_id = request.getParameter("scn_id")==null ? 1 : Integer.parseInt(request.getParameter("scn_id"));
int adultCnt = request.getParameter("adultCnt")==null ? 0 : Integer.parseInt(request.getParameter("adultCnt"));
int teenCnt = request.getParameter("teenCnt")==null ? 0 : Integer.parseInt(request.getParameter("teenCnt"));

// 인원수 선택 전 확인
boolean befCntSelect = adultCnt + teenCnt == 0;
// 상영 정보 가져오기
ScreenDAO ScnPro = ScreenDAO.getInstance();
ScreenDTO screen = ScnPro.getScreen(scn_id);
// 영화 정보 가져오기
MovieDAO MovPro = MovieDAO.getInstance();
MovieDTO movie = MovPro.getMovie(screen.getMov_id());
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy년 M월 dd일");
SimpleDateFormat sdf2 = new SimpleDateFormat("kk:mm");
SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

ArrayList<String> resv_seat = new ArrayList<String>();
// 찬 좌석 리스트로 가져오기
if(screen.getResv_seat() != null) {
	ArrayList<String> resv_seat_raw = new ArrayList<String>();
	resv_seat_raw = new ArrayList<String>(Arrays.asList(screen.getResv_seat().split(",")));
	// 공백 제거하기
	resv_seat_raw.forEach(e -> resv_seat.add(e.trim()));
}
// 좌석 행렬 수
// B12 = 2행 12열 좌석
int rows = 12;
int cols = 20;

// 영화표 가격
int adultPrice = screen.getAdult_price();
int teenPrice = screen.getTeen_price();
int totalPrice = adultPrice * adultCnt + teenPrice * teenCnt;
DecimalFormat df = new DecimalFormat("#,###");

%>
<!-- 상단 -->
<div class="header">
	<jsp:include page="../common/top.jsp"/>
</div>
<div id="container">
	<h2><img src="../icons/right.png" width="20px"> 좌석 선택</h2>
	<div class="cntSelector">
		<input type="hidden" id="scn_id" value="<%=scn_id %>">
		<input type="hidden" id="remaining_seats" value="<%=screen.getRemaining_seats()%>">
			성인: &nbsp;<input type="button" id="adultMinus" class="cntBtn" value="-"><input type="text"  class="outText" id="adultCnt" value="<%=adultCnt%>"  readonly><input type="button" id="adultPlus" class="cntBtn" value="+">
			&nbsp;&nbsp;&nbsp;
			청소년: &nbsp;<input type="button"id="teenMinus" class="cntBtn" value="-"><input type="text" class="outText" id="teenCnt"  value="<%=teenCnt%>" readonly><input type="button" id="teenPlus" class="cntBtn" value="+">
		<input type="button" class="cntConfirm" value="인원 결정">
		<input type="button" class="cntReset" value="인원 재선택">
	</div>
	<div class="seatSelector">
		<!-- 좌석선택 먼저 하라고 요청하는 창 -->
		<div class="cntAlert">인원을 먼저 선택해 주세요.</div>
		<div class="screen"> SCREEN </div>
		<!-- 좌석 생성 -->
		<%int k=1;
		for(int i=1; i<rows+1; i++) {
			for(int j=1; j<cols+1; j++) {
				String seatCode = String.valueOf((char)(i+64)).concat(String.valueOf(j));
				boolean bookChk = resv_seat.contains(seatCode);
				%>
				<label for="<%=k%>">
					<%if(bookChk) {%>
						<input type="checkbox" class="seatChkBx" id="<%=k++%>" disabled>
						<div class="seat booked" ><%=seatCode%></div>
					<%} else {%>
						<input type="checkbox" class="seatChkBx" id="<%=k++%>" value="<%=seatCode%>" >
						<div class="seat" ><%=seatCode%></div>
					<%} %>
				</label>
				<%if(j==4 || j==16) {%>
					<div class="empty"></div>
				<%}
			} %>
			<br>
		<%} %>
	</div>
	<div class="infoViewer">
			<img src="../icons/barcode.png" class="barcodeImg">
			<div class="scnInfo">
				<img src="../icons/<%=movie.getRating()%>.png" class="rating">
				<textarea class="mov_name" ><%=screen.getMov_name() %></textarea>
				<div class="horizontal"></div>
				<img src="../images/<%=movie.getMov_img()%>" class="poster">
				<div class="scn_type Info"><%=screen.getScn_type() %></div>
				<div class="theater Info"><%=screen.getTheater() %> 상영관</div>
				<div class="scn_date Info"><%=sdf1.format(screen.getScn_time()) %></div>
				<div class="scn_time"><%=sdf2.format(screen.getScn_time()) %> ~ <%=sdf2.format(screen.getEnd_time())%></div>
				<div class="horizontal"></div>
				<div class="Info">좌석번호: <textarea id="seatResult" readonly></textarea></div>
			</div>
			<div class="result">
				<form action="../ticketing/ticketingPro.jsp" method="get" name="resultForm">
				<input type="hidden" name="mov_id" value="<%=screen.getMov_id()%>">
				<input type="hidden" name="scn_id" value="<%=screen.getScn_id()%>">
				<input type="hidden" name="resv_type" value="<%=Integer.toString(adultCnt) + ", " + Integer.toString(teenCnt)%>">
				<input type="hidden" name="theater" value="<%=screen.getTheater() %>">
				<input type="hidden" name="scn_time" value="<%=sdf3.format(screen.getScn_time())%>">
				<input type="hidden" name="scn_time_minus" value="<%=screen.getScn_time().toLocalDateTime().toLocalDate().plusDays(-2).toString().substring(0,10)%>">
				<input type="hidden" name="end_time" value="<%=sdf3.format(screen.getEnd_time())%>">
				<input type="hidden" name="seat" value="">
				<div class="cntResult"><%=(adultCnt != 0) ? "성인: " + adultCnt + "명" : ""%><%if(adultCnt!=0 && teenCnt!=0){ %><br><%}%><%=(teenCnt != 0) ? "청소년: " + teenCnt + "명" : ""%></div>
				<div class="calculate"><%=(adultCnt != 0) ? df.format(adultPrice * adultCnt):""%><%if(adultCnt!=0 && teenCnt!=0){ %><br><%}%><%=(teenCnt != 0) ? df.format(teenPrice * teenCnt) : ""%></div>
				<hr>
				<div class="priceLabel">결제금액:</div><input type="text" class="outText" id="price" value="<%=df.format(totalPrice) %> 원" readonly>
				</form>
			</div>
			<input type="button" value="이전" class="btn prev">
			<input type="button" value="다음" class="btn next">
	</div>
</div>
</body>
</html>