<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="theater.screening.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택 페이지</title>
<style>
#container { width: 1000px; margin: 0px auto; margin: 0px auto;}
.cntSelector { box-sizing: border-box; width: 100%; height: 70px; border: 2px solid gray; border-radius: 15px; text-align: center; background-color: #f0f7ff; }
.seatSelector { position: relative; float: left; width: 69%; height: 500px; border: 2px solid gray; border-radius: 15px; 
			   margin: 10px 2.5px 5px 0; text-align: center; }
.infoViewer { float: right; width: 29%; height: 500px; border: 2px solid gray; border-radius: 15px; margin: 10px 0 5px 2.5px;}
.selectCntBox { width: 100%; }
.cntConfirm { display: inline-block; width: 80px; height: 35px; border: 2px solid gray; border-radius: 10px; background-color: #86c8f7; text-align: center; 
			 line-height: 33px; margin: 15px 10px 10px 30px; position: relative; top:2px;  }
.selected { background-color: #86c8f7; }
.cntReset { display: inline-block; width: 80px; height: 35px; border: 2px solid gray; border-radius: 10px; background-color: #ebebeb; text-align: center;  
			 line-height: 33px; margin: 15px;  position: relative; top:2px;  }
.cntBtn { display: inline-block; width: 45px; height: 31px; border: 1px solid black; background-color: white; 
		 border-radius: 10px; }
.cntBtn:hover { background-color: #96c4ff; }
input[type="text"] { height: 25px; width: 50px; line-height: 25px; font-size: 1.3em; text-weight: bold; text-align: center; border: none; position: relative; top: 3px; background-color: #f0f7ff; }

/* 좌석 선택 */
.cntAlert { position: absolute; top: 20px; left: 140px; width: 400px; height: 50px; line-height: 50px; font-size: 1.2em; 
		   background-color: white; border: 4px solid black; border-radius: 10px; z-index:1000;}
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
#resultChk { width: 200px; }
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
	
	// 예매수 초과 확인
	function plusChk(obj) {
		let cnt = +adultCnt.value + +teenCnt.value;
		if(cnt >= 10){
			alert("총 10명 초과하여 예매할 수 없습니다.");
		} else if (cnt>= +remaining_seats.value) {
			alert("잔여 좌석 수를 초과하여 예매할 수 없습니다.");
		} else {
			obj.value = +obj.value + 1;
		}
	}
	
	let cnt = +adultCnt.value + +teenCnt.value;
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
		seatSelector.style.backgroundColor = "#ebebeb";
		// 좌석선택 방지
		for( seat of seats ) {
			seat.disabled = true;
		}
		
	}
	
	// 인원수 결정 버튼
	cntConfirm.addEventListener("click", function(){
		location = "seats.jsp?scn_id=" + scn_id.value + "&adultCnt=" + adultCnt.value + "&teenCnt=" + teenCnt.value;
	});
	
	// 초기화 버튼
	let cntReset = document.querySelector(".cntReset");
	cntReset.addEventListener("click", function(){
		location = "seats.jsp?scn_id=" + scn_id.value;
	});
	
	// 좌석 선택
	let resultChk = document.getElementById("resultChk");
	bookList = new Array();
	for(let i in seats) {
		seats[i].addEventListener("change", function(){
			if (seats[i].checked) {
				console.log(seats[i].value);
				bookList.push(seats[i].value);
				resultChk.value = bookList.sort().join(',');// 제대로 sort가 안됨!!(2자리수와 3자리수 계산 다른 특수성)
				console.log(bookList);
				if(bookList.length >= cnt) {
					for(seat of seats) {
						seat.disabled = true;
						seatSelector.style.backgroundColor = "#ebebeb";
					}
				}
			} else {
				bookList.delete(seats[i].value);
				resultChk.value = Array.from(bookList).join(',');
			}
		});
	}
	
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int scn_id = request.getParameter("scn_id")==null ? 1 : Integer.parseInt(request.getParameter("scn_id"));
int adultCnt = request.getParameter("adultCnt")==null ? 0 : Integer.parseInt(request.getParameter("adultCnt"));
int teenCnt = request.getParameter("teenCnt")==null ? 0 : Integer.parseInt(request.getParameter("teenCnt"));

// 인원수 선택 전 확인
boolean befCntSelect = adultCnt + teenCnt == 0;

ScreenDAO ScnPro = ScreenDAO.getInstance();
ScreenDTO screen = ScnPro.getScreen(scn_id);

ArrayList<String> resv_seat = null;
// 찬 좌석 리스트로 가져오기
if(screen.getResv_seat() != null) {
	resv_seat = new ArrayList<String>(Arrays.asList(screen.getResv_seat().split(", ")));
	// 찬 좌석 좌표값 리스트 저장
	ArrayList<SeatLoc> seats = new ArrayList<SeatLoc>();
	/*
	for(String s : resv_seat) {
		//s = s.replaceAll("[^\\w]", "");
		System.out.println(s);
		int x = (int)s.charAt(0)-64;
		int y = Integer.parseInt(s.replaceAll("[^0-9]", ""));
		seats.add(new SeatLoc(x, y));
	}
	//검증
	for(SeatLoc seat: seats) {
		System.out.println("x= " + seat.getX() + " y= " + seat.getY());
	}
	*/
}
// 좌석 행렬 수
// B12 = 2행 12열 좌석
int rows = 12;
int cols = 20;

%>
<div id="container">
	<h1>좌석 선택</h1>
	<div class="cntSelector">
		<input type="hidden" id="scn_id" value="<%=scn_id %>">
		<input type="hidden" id="remaining_seats" value="<%=screen.getRemaining_seats()%>">
			성인: &nbsp;<input type="button" id="adultMinus" class="cntBtn" value="-"><input type="text" id="adultCnt" value="<%=adultCnt%>"  readonly><input type="button" id="adultPlus" class="cntBtn" value="+">
			&nbsp;&nbsp;&nbsp;
			청소년: &nbsp;<input type="button"id="teenMinus" class="cntBtn" value="-"><input type="text" id="teenCnt"  value="<%=teenCnt%>" readonly><input type="button" id="teenPlus" class="cntBtn" value="+">
		<input type="button" class="cntConfirm" value="인원 결정">
		<input type="button" class="cntReset" value="초기화">
	</div>
	<div class="seatSelector <%if(befCntSelect) {%>greyed<%}%>">
		<!-- 좌석선택 먼저 하라고 요청하는 창 -->
		<%if(befCntSelect) {%>
			<div class="cntAlert">인원을 먼저 선택해 주세요.</div>
		<%} %>
		<div class="screen"> SCREEN </div>
		<!-- 좌석 생성 -->
		<%for(int i=1; i<rows+1; i++) {
			for(int j=1; j<cols+1; j++) {
				String seatCode = String.valueOf((char)(i+64)).concat(String.valueOf(j));
				boolean bookChk = resv_seat.contains(seatCode);
				%>
				<label for="<%=seatCode%>">
					<%if(bookChk) {%>
						<input type="checkbox" class="seatChkBx" id="<%=seatCode%>" disabled>
						<div class="seat booked" ><%=seatCode%></div>
					<%} else {%>
						<input type="checkbox" class="seatChkBx" id="<%=seatCode%>" value="<%=seatCode%>" >
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
		<input type="text" id="resultChk">
	</div>
</div>
</body>
</html>