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
.cntSelector { box-sizing: border-box; width: 100%; height: 70px; border: 2px solid gray; border-radius: 15px; text-align: center; }
.seatSelector { float: left; width: 69%; height: 500px; border: 2px solid gray; border-radius: 15px; margin: 10px 2.5px 5px 0; text-align: center; }
.infoViewer { float: right; width: 29%; height: 500px; border: 2px solid gray; border-radius: 15px; margin: 10px 0 5px 2.5px;}
.selectCntBox { width: 100%; }
#cntConfirm { display: inline-block; width: 80px; height: 35px; border: 2px solid gray; background-color: #f0f7ff; text-align: center; 
			 line-height: 35px; margin: 10px; }
#cntReset { display: inline-block; width: 80px; height: 35px; border: 2px solid gray; background-color: #f0f7ff; text-align: center;  
			 line-height: 35px; margin: 10px; }

/* 좌석 선택 */
.seat { box-sizing: border-box; display: inline-block; width: 23px; height: 23px; font-size:10px; line-height:23px; text-align: center; border: 1px solid gray; border-radius: 3px;  }
.seat:hover { border: 2px solid black; }
.seatChkBx:checked+.seat { background-color: pink; }
.booked { background-color: gray; }
.empty { box-sizing: border-box; display: inline-block; width: 23px; height: 23px; border: none; }
.seatChkBx { display: none; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {	
	// 잔여좌석 개수
	let remaining_seats = document.getElementById("remaining_seats");
	// 인원수 핸들
	let adultMinus = document.getElementById("adultMinus");
	let adultPlus = document.getElementById("adultPlus");
	let teenMinus = document.getElementById("teenMinus");
	let teenPlus = document.getElementById("teenPlus");
	let adultCnt = document.getElementById("adultCnt");
	let teenCnt = document.getElementById("teenCnt");
	
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
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int scn_id = request.getParameter("scn_id")==null ? 1 : Integer.parseInt(request.getParameter("scn_id"));
int adultCnt = request.getParameter("adultCnt")==null ? 0 : Integer.parseInt(request.getParameter("adultCnt"));
int teenCnt = request.getParameter("teenCnt")==null ? 0 : Integer.parseInt(request.getParameter("teenCnt"));

ScreenDAO ScnPro = ScreenDAO.getInstance();
ScreenDTO screen = ScnPro.getScreen(scn_id);

ArrayList<String> resv_seat = null;
// 찬 좌석 리스트로 가져오기
if(screen.getResv_seat() != null) {
	resv_seat = new ArrayList<String>(Arrays.asList(screen.getResv_seat().split(", ")));
	// 찬 좌석 좌표값 리스트 저장
	ArrayList<SeatLoc> seats = new ArrayList<SeatLoc>();
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
}
// 좌석 행렬 수
// B12 = 2행 12열 좌석
int rows = 12;
int cols = 20;

%>
<div id="container">
	<h1>좌석 선택</h1>
	<div class="cntSelector">
		<input type="hidden" id="remaining_seats" value="<%=screen.getRemaining_seats() %>">
			성인: <button id="adultMinus" >-</button><input type="text" id="adultCnt" value="<%=adultCnt%>" ><button id="adultPlus">+</button>
			청소년: <button id="teenMinus" >-</button><input type="text" id="teenCnt"  value="<%=teenCnt %>" ><button id="teenPlus">+</button>
		<div id="cntConfirm">인원 결정</div>
		<div id="cntReset">초기화</div>
	</div>
	<div class="seatSelector">
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
					<input type="checkbox" class="seatChkBx" id="<%=seatCode%>" value="<%=seatCode%>">
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
	</div>
</div>
</body>
</html>