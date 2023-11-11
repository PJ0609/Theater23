-- create database db03;
use db03;
/*
*** 영화관 홈페이지 제작 ***

< 회원 정보 >
ㄴ 아이디와 패스워드
ㄴ 성별, 연령대, 거주지
ㄴ 관람한 영화 정보
id, username, pwd, gender, birthday, address1, address2, seen_mov

< 예매 정보 >
ㄴ resv_id: 예매번호(랜덤생성)
ㄴ id: 예매한 회원 id
ㄴ resv_type: 예매 유형(성인석, 청소년석 순서로, '4,2'는 청소년 4명, 성인2명을 뜻한다)
ㄴ theater: 예매한 상영관
ㄴ scr_time: 상영 시간
ㄴ seat: 예매한 좌석 좌표(e.g. "A4 B3 B4"는 1행 4열, 2행3열, 2행4열 좌석이 찬 것을 의미)
resv_id, id, resv_type, theater, scr_time, seat

< 영화 정보 >
ㄴ mov_id: 영화 고유 id
ㄴ 기본정보: 제목, 이미지, 장르, 등급, 상영시간, 개봉일
ㄴ synopsis: 상세 설명
ㄴ 영화별 댓글 게시판
ㄴ 영화별 평점 매기기 정보
ㄴ 트레일러 링크
mov_id, mov_name, director, mov_img, genre, rating, length, rel_date, avgusr_rating, trailer_link

< 영화후기 글 정보 >
ㄴ id: 작성자 id
ㄴ mov_name: 관련 영화
ㄴ post_date: 글 작성 시간
ㄴ usr_rating: 관람객 평점
ㄴ content: 리뷰 내용
id, mov_name, reg_date, usr_rating, content

< 상영 정보 >
ㄴ mov_id: 상영되는 영화
ㄴ scn_id: 영화관 상영관 번호
ㄴ scn_type: 상영 타입(2d, 3d, imax...)
ㄴ scn_time, end_time: 영화관 상영시간 정보
ㄴ remaining_seats: 상영시간별 잔여좌석수
ㄴ resv_seat: 예약된 좌석 (e.g. "A4,B3,B4"는 1행 4열, 2행3열, 2행4열 좌석이 찬 것을 의미)
mov_id, mov_name, scn_id, scn_time, scn_type, end_time, remaining_seats, resv_seat

# 관리자 기능
- 상영 변경/추가

### 특이사항 ###
- 시간대별 상영관별 좌석 상태 저장하고 표시하기
 ㄴ 예매시 상영정보 테이블의 resv_seat 에 예약된 좌석의 좌표값을 모두 저장하기-> List, split/toString 사용
 ㄴ resv_seat의 예약된 좌석은 음영 처리하여 선택되지 않도록 설정하기
 
### 여유가 되면 추가해볼 것 ###
- 2개 이상의 상영관 운영, 회원 거주지에서 가장 가까운 상영관 추천
- 회원이 가장 많이 본 장르 영화 추천
- 관람객 성별, 연령대별 데이터 수집하여 그래프 출력
 
*/
-- 회원 정보
create table visitor(
id varchar(30) primary key ,
pwd varchar(16) not null,
name varchar(50) not null,
gender char(1) not null, 
tel varchar(20) not null,
email varchar(50) not null,
birthday date not null, 
address1 varchar(100) not null,
address2 varchar(100) not null,
seen_mov text,
reg_date datetime default now()
);
insert into visitor(id, pwd, name, gender, tel, email, birthday, address1, address2, seen_mov) values('aaaa','1234', '길길동', 'm', '010-1234-2345','asdf@email.com', '2000-01-01','주소1','주소2','살인의 추억,라따뚜이');

-- 예매 정보
create table ticketing(
resv_id varchar(20) primary key,
id varchar(30) not null, 
resv_type varchar(10) not null,
theater int not null, 
scr_time datetime not null,
end_time datetime not null,
seat text not null
);
insert into ticketing(resv_id, id, resv_type, theater, scr_time, end_time, seat) values('jr3r41243l','aaaa', '2,1', '1', '2023-10-21 12:00', '2023-10-21 13:20', 'B3,B4,C3');

-- 영화 정보
create table movie(
mov_id bigint primary key auto_increment,
mov_name varchar(50) default '제목없음',
director varchar(50) not null,
mov_img varchar(30) default 'nothing.jpg',
genre varchar(30) not null, 
rating varchar(5),
synopsis text,
length int, 
rel_date date not null, 
trailer_link varchar(200),
avgusr_rating float
);
-- 영화후기 글 정보
create table review(
mov_id bigint not null,
mov_name varchar(100) not null,
id varchar(30) not null,
usr_rating int not null,
content text not null,
post_date datetime default now()
);
insert into review(mov_id, mov_name, id, usr_rating, content) values(1, '라따뚜이', 'aaaa', '5', '집에 레미 한마리 키우고 싶어요');

-- 상영 정보
create table screening(
mov_id bigint not null,
mov_name varchar(50) default '제목없음',
scn_id bigint primary key auto_increment, 
theater int not null,
scn_type varchar(20) not null,
scn_time datetime not null, 
end_time datetime not null,
adult_price int default 13000,
teen_price int default 10000,
remaining_seats int,
resv_seat text
);
select * from screening;
insert into screening(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(1,'라따뚜이', 1, '2D(자막)', '2023-10-21 12:00', '2023-10-21 13:10', 81, 'F3, A2, H12, D15');
insert into screening(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats) values(2, '살인의 추억', 1, '2D', '2023-10-21 14:00', '2023-10-21 15:50', 70);
insert into screening(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats) values(1,'라따뚜이', 1, '2D(자막)', '2023-10-21 14:00', '2023-10-23 13:10', 81);
insert into screening(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats) values(1,'라따뚜이', 2, '3D(자막)', '2023-10-21 16:00', '2023-10-21 17:10', 70);
insert into screening(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats) values(1,'라따뚜이', 2, '2D(자막)', '2023-10-21 14:00', '2023-10-21 15:10', 87);
insert into screening(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats) values(1,'라따뚜이', 2, '2D(자막)', '2023-10-21 18:00', '2023-10-21 19:10', 87);
insert into screening(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats) values(2, '살인의 추억', 1, '2D', '2023-10-22 14:00', '2023-10-22 15:50', 70);

select * from screening;
select date_format(scn_time, '%Y-%m-%d') as fdate from screening group by fdate ;

select date(scn_time) as fdate from screening where date(scn_time) between '2023-10-20' and '2023-11-10' and mov_id in (1) group by fdate ;
