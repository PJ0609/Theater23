-- 상영 정보
drop table screen;
create table screen(
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
select * from screen;
-- 2023-12-11
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(1,'라따뚜이', 1, '2D(자막)', '2023-12-11 12:00', '2023-12-11 13:10', 236, 'F3, A2, H12, D15');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(1,'라따뚜이', 1, '2D(자막)', '2023-12-11 10:00', '2023-12-11 11:10', 236, 'F3, A2, H12, D15');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(2, '살인의 추억', 1, '2D', '2023-12-11 14:00', '2023-10-11 15:50', 235, 'D11, A11, H11, F13, F14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(2, '살인의 추억', 1, '2D', '2023-10-22 14:00', '2023-10-22 15:50', 236, 'F3, A2, H12, D15');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(1,'라따뚜이', 2, '3D(자막)', '2023-12-11 16:00', '2023-12-11 17:10', 235, 'D11, A11, H11, F13, F14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(1,'라따뚜이', 2, '2D(자막)', '2023-12-11 14:00', '2023-12-11 15:10', 236, 'F3, A2, H12, D15');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(1,'라따뚜이', 2, '2D(자막)', '2023-12-11 18:00', '2023-12-11 19:10', 235, 'D11, A11, H11, F13, F14');
-- 2023-12-12
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(3, '서울의 봄', 1, '2D', '2023-12-12 09:00', '2023-12-12 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(4, '더 마블스', 1, '2D', '2023-12-12 11:00', '2023-12-12 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(5, '여귀교-저주를 부르는 게임', 1, '2D', '2023-12-12 13:00', '2023-12-12 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(7, '헝거게임: 노래하는 새와 뱀의 발라드', 1, '2D', '2023-12-12 15:00', '2023-12-12 18:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(8, '그대들은 어떻게 살 것인가', 1, '2D', '2023-12-12 18:00', '2023-12-12 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(6, '다크 나이트', 2, '2D', '2023-12-11 09:00', '2023-12-12 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(4, '더 마블스', 2, 'IMAX', '2023-12-11 11:00', '2023-12-12 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(5, '여귀교-저주를 부르는 게임', 2, '2D', '2023-12-12 13:00', '2023-12-12 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(9, '뉴 노멀', 2, 'IMAX', '2023-12-12 15:00', '2023-12-12 18:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(8, '그대들은 어떻게 살 것인가', 2, '2D', '2023-12-12 18:00', '2023-12-12 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
-- 2023-12-13
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(12, '소년들', 1, '2D', '2023-12-13 09:00', '2023-12-13 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(13, '30일', 1, '2D', '2023-12-13 11:00', '2023-12-13 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(14, '탑건-매버릭', 1, 'IMAX', '2023-12-13 13:00', '2023-12-13 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(15, '블루 자이언트', 1, '2D', '2023-12-13 15:00', '2023-12-13 18:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(16, '오펜하이머', 1, '2D', '2023-12-13 18:00', '2023-12-13 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(17, '바빌론', 2, '2D', '2023-12-13 09:00', '2023-12-13 11:00', 232, 'I12, I13, I14, G8, G9, F11, F12, D10');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(18, '조커', 2, '2D', '2023-12-13 11:00', '2023-12-13 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(19, '엘리멘탈', 2, 'IMAX', '2023-12-13 13:00', '2023-12-13 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(1, '라따뚜이', 2, '2D', '2023-12-13 15:00', '2023-12-13 18:00', 235, 'B12, D14, I13, G12, G17');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(20, '플라워 킬링 문', 2, '2D', '2023-12-13 18:00', '2023-12-13 20:00', 232, 'I12, I13, I14, G8, G9, F11, F12, D10');
-- 2023-12-14
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(6, '다크 나이트', 1, '2D', '2023-12-14 09:00', '2023-12-12 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(4, '더 마블스', 1, 'IMAX', '2023-12-14 11:00', '2023-12-12 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(5, '여귀교-저주를 부르는 게임', 1, '2D', '2023-12-12 13:00', '2023-12-12 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(9, '뉴 노멀', 1, 'IMAX', '2023-12-14 15:00', '2023-12-12 18:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(8, '그대들은 어떻게 살 것인가', 1, '2D', '2023-12-12 18:00', '2023-12-12 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(1, '라따뚜이', 2, '2D', '2023-12-14 09:00', '2023-12-12 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(20, '플라워 킬링 문', 2, 'IMAX', '2023-12-14 11:00', '2023-12-12 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(2, '살인의 추억', 2, '2D', '2023-12-14 13:00', '2023-12-14 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(19, '엘리멘탈', 2, 'IMAX', '2023-12-14 15:00', '2023-12-14 17:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(3, '서울의 봄', 2, '2D', '2023-12-14 18:00', '2023-12-14 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
-- 2023-12-15
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(12, '소년들', 1, '2D', '2023-12-15 09:00', '2023-12-15 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(13, '30일', 1, '2D', '2023-12-15 11:00', '2023-12-15 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(14, '탑건-매버릭', 1, 'IMAX', '2023-12-15 13:00', '2023-12-15 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(10, '싱글 인 서울', 1, '2D', '2023-12-15 15:00', '2023-12-15 18:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(11, '톡 투 미', 1, '2D', '2023-12-15 18:00', '2023-12-15 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(2, '살인의 추억', 2, '2D', '2023-12-14 09:00', '2023-12-12 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(9, '뉴 노멀', 2, 'IMAX', '2023-12-11 11:00', '2023-12-12 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(8, '그대들은 어떻게 살 것인가', 2, '2D', '2023-12-12 13:00', '2023-12-12 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(10, '싱글 인 서울', 2, '2D', '2023-12-11 15:00', '2023-12-12 17:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(14, '더 마블스', 2, 'IMAX', '2023-12-12 18:00', '2023-12-12 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
-- 2023-12-16
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(13, '30일', 1, '2D', '2023-12-16 09:00', '2023-12-16 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(7, '헝거게임: 노래하는 새와 뱀의 발라드', 1, '2D', '2023-12-16 11:00', '2023-12-16 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(14, '탑건-매버릭', 1, 'IMAX', '2023-12-16 13:00', '2023-12-16 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(17, '바빌론', 1, '2D', '2023-12-16 15:00', '2023-12-16 18:00', 232, 'F8, G7, G8, D12, H13, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(18, '조커', 1, '2D', '2023-12-16 18:00', '2023-12-16 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(13, '30일', 2, '2D', '2023-12-16 09:00', '2023-12-16 11:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(8, '그대들은 어떻게 살 것인가', 2, '2D', '2023-12-16 11:00', '2023-12-16 13:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(11, '톡 투 미', 2, '2D', '2023-12-16 13:00', '2023-12-16 15:00', 235, 'B12, D14, I13, G12, G14');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(4, '더 마블스', 2, '2D', '2023-12-16 15:00', '2023-12-16 17:00', 232, 'F8, G7, G8, D12, H13, E10, E11, G8');
insert into screen(mov_id, mov_name, theater, scn_type, scn_time, end_time, remaining_seats, resv_seat) values(18, '조커', 2, '2D', '2023-12-16 18:00', '2023-12-16 20:00', 232, 'F8, G12, G13, D12, H10, E10, E11, G8');
select * from screen;