use db03;
drop table movie;
create table movie(
mov_id bigint primary key auto_increment,
mov_name varchar(50) default '제목없음',
director varchar(50) not null,
mov_img varchar(50) default 'nothing.jpg',
genre varchar(30) not null, 
rating varchar(5),
synopsis text,
length int, 
rel_date date not null, 
trailer_link varchar(200),
avgusr_rating float
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('라따뚜이','브래드 버드','Ratatouille.jpg','어린이, 코미디','all', 
'쉿! 요건 비밀인데... 저 요리해요!
절대미각, 빠른 손놀림, 끓어 넘치는 열정의 소유자 ‘레미’. 프랑스 최고의 요리사를 꿈꾸는 그에게 단 한가지 약점이 있었으니, 바로 주방 퇴치대상 1호인 ‘생쥐’라는 것!
그러던 어느 날, 하수구에서 길을 잃은 레미는 운명처럼 파리의 별 다섯개짜리
최고급 레스토랑에 떨어진다. 그러나 생쥐의 신분으로 주방이란 그저 그림의 떡.
보글거리는 수프, 뚝닥뚝닥 도마소리, 향긋한 허브 내음에 식욕이 아닌 ‘요리욕’이 북받친
레미의 작은 심장은 콩닥콩닥 뛰고 마는데!
쥐면 쥐답게 쓰레기나 먹고 살라는 가족들의 핀잔에도 굴하지 않고 끝내 주방으로 들어가는 레미. 깜깜한 어둠 속에서 요리에 열중하다 재능 없는 견습생 ‘링귀니’에게 ‘딱’ 걸리고 만다. 하지만 해고위기에 처해있던 링귀니는 레미의 재능을 한눈에 알아보고 의기투합을 제안하는데. 과연 궁지에 몰린 둘은 환상적인 요리 실력을 발휘할 수 있을 것인가? 레미와 링귀니의 좌충우돌 공생공사 프로젝트가 아름다운 파리를 배경으로 이제 곧 펼쳐진다!',
110,'2007-07-25',
'https://youtu.be/NgsQ8mVkN8w?si=dRnD-g3f6arpjTNE'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('살인의 추억','봉준호','memoriesofmurder.jpg','범죄, 미스터리','15', 
'1986년 경기도. 젊은 여인이 무참히 강간, 살해당한 시체로 발견된다. 2개월 후, 비슷한 수법의 강간살인사건이 연이어 발생하면서 사건은 세간의 주목을 받기 시작하고, 일대는 연쇄살인이라는 생소한 범죄의 공포에 휩싸인다. 사건 발생지역에 특별수사본부가 설치되고, 수사본부는 구희봉 반장(변희봉 분)을 필두로 지역토박이 형사 박두만(송강호 분)과 조용구(김뢰하 분), 그리고 서울 시경에서 자원해 온 서태윤(김상경 분)이 배치된다. 육감으로 대표되는 박두만은 동네 양아치들을 족치며 자백을 강요하고, 서태윤은 사건 서류를 꼼꼼히 검토하며 사건의 실마리를 찾아가지만, 스타일이 다른 두 사람은 처음부터 팽팽한 신경전을 벌인다.', 
132,'2003-04-25',
'https://youtu.be/0n_HQwQU8ls?si=sYgSfmt1OYaVeVpC'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('서울의 봄','김성수','서울의봄_메인포스터_이마노출버전.jpg','드라마','12', 
'그날, 대한민국의 운명이 바뀌었다

대한민국을 뒤흔든 10월 26일 이후, 서울에 새로운 바람이 불어온 것도 잠시
12월 12일, 보안사령관 전두광이 반란을 일으키고
군 내 사조직을 총동원하여 최전선의 전방부대까지 서울로 불러들인다.

권력에 눈이 먼 전두광의 반란군과 이에 맞선 수도경비사령관 이태신을 비롯한
진압군 사이, 일촉즉발의 9시간이 흘러가는데…

목숨을 건 두 세력의 팽팽한 대립
오늘 밤, 대한민국 수도에서 가장 치열한 전쟁이 펼쳐진다!', 
141,'2023-11-22',
'https://youtu.be/-AZ7cnwn2YI?si=VGPmMgToEo9j4mId'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('더 마블스','니아 다코스타','더 마블스_메인 포스터_절찬상영중.jpg','SF, 액션','12', 
'강력한 힘으로 은하계를 수호하는 최강 히어로 캡틴 마블 ‘캐럴 댄버스’
캡틴 마블의 오랜 친구의 딸이자, 빛의 파장을 조작하는 히어로 ‘모니카 램보’
최애 히어로 캡틴 마블의 열렬한 팬인 미즈 마블 ‘카말라 칸’

캡틴 마블에 대한 복수를 꿈꾸는 냉혹한 크리족 리더 ‘다르-벤’의 영향으로
세 명의 히어로는 능력을 사용할 때마다 서로의 위치가 뒤바뀌게 된다.

뜻하지 않게 우주와 지구를 넘나들게 되는 예측 불가하고 통제 불가한 상황 속,
‘다르-벤’은 지구를 포함해 캡틴 마블이 고향이라고 부르는
수많은 행성을 모두 파멸시키려 하고,
이를 저지하기 위해 모인 팀 ‘마블스’는 하나로 힘을 모으는데…

함께, 더 높이! 더 멀리! 더 빨리!
역대급 파장을 일으킬 마블의 NEW 팀업이 시작된다!', 
105,'2023-11-08',
'https://youtu.be/xC-ITzh98Vo?si=hw2EEEoPeCUJUlsS'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('여귀교- 저주를 부르는 게임','해악륭','(메인) 여귀교_메인포스터_최종.jpg',' 공포(호러)','15', 
'※경고※
저주를 부르는 게임, 플레이 하시겠습니까?


1. 나홀로 숨바꼭질
2. 구석놀이
3. 엘리베이터 의식

퀘스트가 계속될수록,
현실과 게임의 경계가 무너지고 예상치 못한 기묘한 일들이 벌어지는데...!', 
102,'2023-11-15',
'https://youtu.be/t8dTzfVjgU0?si=5jTBPh-29bGQdQl_'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('다크 나이트','크리스토퍼 놀란','6월1일대개봉다크나이트재개봉포스터Os.jpg','슈퍼히어로, 범죄','15', 
'범죄와 부정부패를 제거하여 고담시를 지키려는 배트맨(크리스찬 베일). 그는 짐 고든 형사(게리 올드만)와 패기 넘치는 고담시 지방 검사 하비 덴트(아론 에크하트)와 함께 도시를 범죄 조직으로부터 영원히 구원하고자 한다.

배트맨을 죽여라! 세 명의 의기투합으로 위기에 처한 악당들이 모인 자리에 보라색 양복을 입고 얼굴에 짙게 화장을 한 괴이한 존재가 나타나 ‘배트맨을 죽이자’는 사상 초유의 제안을 한다. 그는 바로 어떠한 룰도, 목적도 없는 사상 최악의 악당 미치광이 살인광대 ‘조커’(히스 레저).

마침내 최강의 적을 만나다! 배트맨을 죽이고 고담시를 끝장내버리기 위한 조커의 광기 어린 행각에 도시는 혼란에 빠진다. 조커는 배트맨이 가면을 벗고 정체를 밝히지 않으면 멈추지 않겠다며 점점 배트맨을 조여온다. 한편, 배트맨은 낮엔 기업의 회장으로, 밤에는 가면을 쓴 배트맨으로 밤과 낮의 정체가 다른 자신과 달리 법을 통해 도시를 구원하는 하비 덴트야말로 진정한 영웅이 아닐까 생각하게 된다.

밤의 기사, 그 전설의 서막이 열린다! 조커를 막기 위해 직접 나서 영원히 존재를 감춘 밤의 기사가 될 것인가. 하비 덴트에게 모든 걸 맡기고 이제 가면을 벗고 이중 생활의 막을 내릴 것인가. 갈림길에 선 그는 행동에 나서야만 하는데… 사상 최강, 운명을 건 대결은 이제부터 시작이다!', 
132,'2023-11-15',
'https://youtu.be/0n_HQwQU8ls?si=sYgSfmt1OYaVeVpC'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('헝거게임: 노래하는 새와 뱀의 발라드','프란시스 로렌스','헝거게임_메인포스터(개봉일).jpg','SF, 스릴러, 액션, 어드벤처','15', 
'반란의 불씨를 잠재우기 위해 시작된
잔인한 서바이벌 헝거게임.

헝거게임 10회를 맞아 ‘멘토제’가 도입되고
‘스노우’는 12구역의 소녀 ‘루시 그레이’의 멘토가 된다.

그는 몰락한 가문의 영광을 되찾기 위해
‘루시 그레이’를 헝거게임에서 우승 시키려 수단과 방법을 가리지 않는데…

2023년 11월, 게임을 지배하라!', 
157 ,'2023-11-15',
'https://youtu.be/fxKTLR-L8o4?si=duhe-YaKSyuorsh_'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('그대들은 어떻게 살 것인가','미야자키 하야오','그어살_메인 포스터_절찬상영중.jpg','애니메이션','all', 
'화재로 어머니를 잃은 11살 소년 ‘마히토’는 아버지와 함께 어머니의 고향으로 간다.
어머니에 대한 그리움과 새로운 보금자리에 적응하느라 힘들어하던 ‘마히토’ 앞에
정체를 알 수 없는 왜가리 한 마리가 나타나고, 저택에서 일하는 일곱 할멈으로부터 왜가리가 살고 있는 탑에 대한 신비로운 이야기를 듣게 된다.
그러던 어느 날, ‘마히토’는 사라져버린 새엄마 ‘나츠코’를 찾기 위해 탑으로 들어가고,
왜가리가 안내하는 대로 이세계(異世界)의 문을 통과하는데…!', 
123,'2023-10-25',
'https://youtu.be/RURusloLi-s?si=J4K0aQv_HtPbozZa'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('뉴 노멀','정범식','뉴 노멀_1차 포스터(화이트ver).jpg','스릴러','15', 
'새로운 시대가 열렸다. 오늘, 당신의 공포는 일상이 된다.', 
112,'2023-11-08',
'https://youtu.be/OiKLv-NnJ1A?si=4gZR2IzWZRSQ1UPE'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('싱글 인 서울','박범수','싱글 인 서울 메인포스터-개봉일.jpg','코미디','12', 
'“나한테 딱 맞는 사람은 나밖에 없어, 싱글이 답이다!”
혼자 걷기, 혼자 쉬기, 혼자 먹기, 혼자 살기…
혼자가 좋은 파워 인플루언서 ‘영호‘(이동욱)

“사실 혼자인 사람은 없잖아요”
혼자 썸타기, 나 홀로 그린 라이트…
유능한 출판사 편집장이지만 혼자는 싫은 ‘현진’(임수정)

싱글 라이프를 담은 에세이 <싱글 인 더 시티> 시리즈의 작가와 편집자로 만난 ‘영호’와 ‘현진’.
생활 방식도 가치관도 서로 다른 두 사람은
책을 두고 사사건건 대립하면서도, 함께 보내는 시간이 나쁘지만은 않은데…?

서울, 혼자가 좋지만 연애는 하고 싶은
두 남녀의 싱글 라이프가 시작된다!', 
102,'2023-11-29',
'https://youtu.be/OquYKZLUJmY?si=TgI7bu8VWZR2Wt1s'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('톡 투 미','대니 필리푸, 마이클 필리푸','TTM_Sposter.jpg','공포','15', 
'실시간트렌드 #90초빙의챌린지 #넘사벽스릴 #주작아님

STEP 1. 촛불을 켜고 저승의 문을 연다.
STEP 2. 몸을 묶고 ‘죽은 자의 손’을 잡는다.
STEP 3. “내게 말해”라고 속삭인다.
STEP 4. 나타난 귀신에게 “널 들여보낸다”라고 말하면 빙의 완료.

※ 경고 ※
단, 90초 안에 깨울 것.
반드시 촛불을 꺼 문을 닫을 것.

SNS에서 핫한 빙의 챌린지에 중독된 \'미아\'와 친구들.
위험한 게임을 이어가던 중 친구 \'라일리\'가 \'미아\'의 죽은 엄마에게 빙의되자
\'미아\'는 이성을 잃고 마의 90초를 넘기고 마는데!

죽음보다 끔찍하게, 당신을 무자비하게 뒤흔들 공포가 시작된다!', 
95,'2023-11-01',
'https://youtu.be/gk9urSdhbzg?si=WDceRwJaKtLMjz0s'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('소년들','정지영','소년들 3차 포스터 절찬상영중.jpg','드라마, 범죄','15', 
'이것이 무슨 수사여? 똥이제!

1999년 전북 삼례의 작은 슈퍼마켓에서 강도 살인 사건이 발생한다.
경찰의 수사망은 단번에 동네에 사는 소년들 3인으로 좁혀지고,
하루아침에 살인자로 내몰린 이들은 영문도 모른 채 감옥에 수감된다.

이듬해 새롭게 반장으로 부임 온 베테랑 형사 \'황준철\'(설경구)에게
진범에 대한 제보가 들어오고, 그는 소년들의 누명을 벗겨주기 위해 재수사에 나선다.
하지만 당시 사건의 책임 형사였던 \'최우성\'(유준상)의 방해로
모든 것이 수포로 돌아가고, \'황반장\'은 좌천된다.

그로부터 16년 후,
\'황반장\' 앞에 사건의 유일한 목격자였던 \'윤미숙\'(진경)과 소년들이 다시 찾아오는데…', 
123,'2023-11-01',
'https://youtu.be/cR8WLXejdmE?si=jILNBtPkhEAZqAAo'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('30일','남대중','30일_메인 포스터.jpg','코미디','12', 
'“완벽한 저에게 신은 저 여자를 던지셨죠”
지성과 외모 그리고 찌질함까지 타고난, \'정열\'(강하늘).

“모기 같은 존재죠. 존재의 이유를 모르겠는?”
능력과 커리어 그리고 똘기까지 타고난, \'나라\'(정소민).

영화처럼 만나 영화같은 사랑을 했지만
서로의 찌질함과 똘기를 견디다 못해 마침내 완벽한 남남이 되기로 한다.

그러나!
완벽한 이별을 딱 D-30 앞둔 이들에게 찾아온 것은... 동반기억상실?

올 추석,
기억도 로맨스도 날리고 웃음만 남긴 이들의
제대로 터지는 코미디가 온다!
', 
119,'2023-10-03',
'https://youtu.be/6WFEc44dxfY?si=O9VISx2ZbUIUI3xk'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('탑건-매버릭','조셉 코신스키','Topgun.jpg','액션','12', 
'한순간의 실수도 용납되지 않는 하늘 위, 
가장 압도적인 비행이 시작된다!

최고의 파일럿이자 전설적인 인물 매버릭(톰 크루즈)은 자신이 졸업한 훈련학교 교관으로 발탁된다. 
그의 명성을 모르던 팀원들은 매버릭의 지시를 무시하지만 실전을 방불케 하는 상공 훈련에서 눈으로 봐도 믿기 힘든 전설적인 조종 실력에 모두가 압도된다. 

매버릭의 지휘아래 견고한 팀워크를 쌓아가던 팀원들에게 국경을 뛰어넘는 위험한 임무가 주어지자
매버릭은 자신이 가르친 동료들과 함께 마지막이 될 지 모를 하늘 위 비행에 나서는데… ', 
130,'2023-11-15',
'https://youtu.be/Mrj9XACVJ8U?si=OxKMyYCUmMZt2dU7'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('블루 자이언트','타치카와 유즈루','블루 자이언트_메인 포스터.jpg','애니메이션','12', 
'“세계 최고가 될 거야, 반드시”

언제나 강가에서 홀로 색소폰을 불던 고등학생 ‘다이’는

세계 최고의 재즈 플레이어에 도전하기 위해 도쿄로 향한다.



“실력이 안 되면 같이 안 할 거니까”

우연히 재즈 클럽에서 엄청난 연주 실력을 뽐내는

천재 피아니스트 ‘유키노리’를 만나 밴드 결성을 제안하고,



“나도 드럼을 칠 수 있을까?”

‘다이’의 고등학교 동창이자 평범한 대학생이던 ‘슌지’가

열정 가득한 초보 드러머로 합류하면서 밴드 ‘JASS 재스’가 탄생한다.



“전력을 다해 연주하자! 분명 전해질 거야”

목표는 최고의 재즈 클럽 ‘쏘 블루’! 10대의 마지막 챕터를 바친

JASS 재스의 격렬하고 치열한 연주가 지금, 바로, 여기서 시작된다!', 
120 ,'2023-10-18',
'https://youtu.be/JXD2v-GeZuc?si=XqHR5Xy0BoB1fkzQ'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('오펜하이머','크리스토퍼 놀란','오펜하이머.jpg','드라마, 스릴러','15', 
'“나는 이제 죽음이요, 세상의 파괴자가 되었다.”

세상을 구하기 위해 세상을 파괴할 지도 모르는 선택을 해야 하는 천재 과학자의 핵개발 프로젝트.', 
180,'2023-08-15',
'https://youtu.be/qAWEb0h43lU?si=7e2JNeMfguTDMI4C'
);

insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('바빌론',' 데이미언 셔젤','바빌.jpg','드라마','18', 
'"모든 순간이 영화가 되는 곳ㅡ\'바빌론\'"

황홀하면서도 위태로운 고대 도시, \'바빌론\'에 비유되던 할리우드.
\'꿈\' 하나만을 위해 모인 사람들이 이를 쟁취하기 위해 벌이는 강렬하면서도 매혹적인 이야기', 
188,'2023-02-01',
'https://youtu.be/kYkNIkymny8?si=ohxuxcfZCezeM6_J'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('조커',' 토드 필립스','조커_포스터.jpg','드라마, 스릴러, 액션','15', 
'“내 인생이 비극인줄 알았는데, 코미디였어”
고담시의 광대 아서 플렉은 코미디언을 꿈꾸는 남자.
하지만 모두가 미쳐가는 코미디 같은 세상에서
맨 정신으로는 그가 설 자리가 없음을 깨닫게 되는데…
이제껏 본 적 없는 진짜 ‘조커’를 만나라!', 
123,'2019-10-02',
'https://youtu.be/c8_EJWCK76Q?si=rYRJ8Yni_flk0jBU'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('엘리멘탈',' 피터 손','엘리멘탈_메인 포스터.jpg',' 애니메이션','all', 
'디즈니·픽사의 놀라운 상상력!

올여름, 세상이 살아 숨 쉰다
불, 물, 공기, 흙 4개의 원소들이 살고 있는 ‘엘리멘트 시티’', 
109,'2023-06-14',
'https://youtu.be/BOqFRHCrN-k?si=KhYEt71-3V0AV5-K'
);
insert into movie(mov_name, director, mov_img, genre, rating, synopsis, length, rel_date, trailer_link)
values('플라워 킬링 문','마틴 스코세이지','플라워 킬링 문_국내 포스터(Hero Scene).jpg','드라마, 범죄','18', 
'‘플라워 킬링 문’은 진정한 사랑과 말할 수 없는 배신이 교차하는 서부 범죄극으로
‘어니스트 버크하트’(레오나르도 디카프리오)와 ‘몰리 카일리’(릴리 글래드스톤)의
이루어질 수 없는 로맨스를 중심으로 오세이지족에게 벌어진 끔찍한 비극 실화를 그려낸다.
데이비드 그랜 작가의 베스트셀러 소설을 원작으로
아카데미를 수상한 거장 마틴 스코세이지 감독이 연출과 각본을 맡았으며,
에릭 로스가 각본에 함께 참여했다.', 
206,'2023-10-19',
'https://youtu.be/0FQmdSSYPiI?si=u05KARLMR4bstSy3'
);
select * from movie;