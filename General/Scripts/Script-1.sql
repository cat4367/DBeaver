create database practice;
use practice;
create table 회원(
	아이디 varchar(30) not null primary key,
	비밀번호 varchar(20) not null,
	이름	varchar(20) not null,
	나이	int,
	성별 char(1),
	생년월일 varchar(10) not null,
	연락처 varchar(15) not null,
	주소 varchar(30),
	가입일자 DATE DEFAULT (CURRENT_DATE),
	활동여부 char(1) not null,
	탈퇴날짜 date
);
create table 상품(
	상품번호 char(7) not null primary key,
	상품명 varchar(30) not null,
	가격 int,
	재고 int,
	판매자 varchar(20) not null,
	판매자연락처 varchar(15),
	노출여부 char(1)
);
create table 구매내역(
	구매번호 char(7) not null,
	상품번호 char(7),
	구매자아이디 varchar(30),
	구매일자 date,
	primary key(구매번호, 상품번호, 구매자아이디),
	foreign key(상품번호) references 상품(상품번호),
	foreign key(구매자아이디) references 회원(아이디)
);

insert into 회원(아이디,비밀번호,이름,나이,성별,생년월일,연락처,주소,가입일자,활동여부,탈퇴날짜) values
('user01', 'pass123!@', '김민준', 28, 'm', '1998-05-14', '010-1234-5678', '서울시 강남구 테헤란로123', '2024-01-15', 'y', null);
insert into 회원(아이디,비밀번호,이름,나이,성별,생년월일,연락처,주소,가입일자,활동여부,탈퇴날짜) values
('user02','p@ssword99','이서연',34,'f','1992-11-03','010-9876-5432','경기도 성남시 분당구 불정로6','2023-08-20','y',null);
insert into 회원(아이디,비밀번호,이름,나이,성별,생년월일,연락처,주소,가입일자,활동여부,탈퇴날짜) values
('user03','secure_p3','박도현',22,'m','2004-02-28','010-5555-1234','부산시 해운대고 해운대로45','2025-03-10','n','2025-11-01');
-- update 테이블명 set 컬럼명 = 바꿀값, ... where 조건식
update 회원 set 활동여부 = 'y', 탈퇴날짜 = null where 이름 = '박도현'; 
insert into 회원(아이디,비밀번호,이름,나이,성별,생년월일,연락처,주소,가입일자,활동여부,탈퇴날짜) values
('user04','qwer1234!','최유진',41,'f','1985-09-19','010-3333-7777','대전시 유성구 대학로99','2022-12-01','y',null);
insert into 회원(아이디,비밀번호,이름,나이,성별,생년월일,연락처,주소,가입일자,활동여부,탈퇴날짜) values
('user05','testpass1','정현우',19,'m','2007-07-07','010-8888-0000','광주시 동구 필문대로12','2026-01-05','y',null);

insert into 상품(	상품번호,상품명,가격,재고,판매자,판매자연락처,노출여부) values
('T000001','무선 게이밍 마우스',59000,120,'테크몰','02-123-4567','y');
insert into 상품(	상품번호,상품명,가격,재고,판매자,판매자연락처,노출여부) values
('T000002','기계식 키보드',129000,45,'키보드월드','02-987-6543','y');
insert into 상품(	상품번호,상품명,가격,재고,판매자,판매자연락처,노출여부) values
('T000003','C타입 초고속 충전기',18500,0,'테크몰','02-123-4567','n');

insert into 구매내역(구매번호,상품번호,구매자아이디,구매일자) values
('S000001','T000001','user01','2025-05-10');
insert into 구매내역(구매번호,상품번호,구매자아이디,구매일자) values
('S000002','T000002','user01','2025-06-01');
insert into 구매내역(구매번호,상품번호,구매자아이디,구매일자) values
('S000003','T000001','user02','2025-07-12');
insert into 구매내역(구매번호,상품번호,구매자아이디,구매일자) values
('S000004','T000003','user03','2025-09-02');
insert into 구매내역(구매번호,상품번호,구매자아이디,구매일자) values
('S000005','T000002','user04','2026-01-20');
insert into 구매내역(구매번호,상품번호,구매자아이디,구매일자) values
('S000006','T000001','user05','2026-02-14');
insert into 구매내역(구매번호,상품번호,구매자아이디,구매일자) values
('S000007','T000002','user05','2026-03-01');
-- 1) 전체 회원의 이름, 나이, 성별
select 이름,나이,성별
from 회원;

-- 2) 각 회원이 주문한 주문 횟수 (이름,주문횟수)
select 이름, count(*) as 주문횟수
from 회원
	join 구매내역 on 회원.아이디 = 구매내역.구매자아이디
group by 이름;

-- 3) 성별 별 주문횟수 통계 (성별,주문횟수)
select 성별, count(*) as 주문횟수
from 회원
	join 구매내역 on 회원.아이디 = 구매내역.구매자아이디
group by 성별;

-- 4) 3번째로 입력한 회원이 주문한 상품목록
select 상품명
from 구매내역
	join 회원 on 구매내역.구매자아이디 = 회원.아이디 and 구매내역.구매자아이디 = 'user03'
	join 상품 on 구매내역.상품번호 = 상품.상품번호;

-- 5) 5번째로 입력한 회원의 회원탈퇴 상태(활동여부가 n이 되면서, 날짜가 입력)
update 회원 set 활동여부 = 'n', 탈퇴날짜 = '2026-09-02' where 아이디 = 'user05';

-- 6) 상품 테이블의 재고가 품절인 상태 (재고가 0이 되면서, 노출 여부가 n으로 변경)
update 상품 set 재고 = 0, 노출여부 = 'n';

-- 7) 주문 취소한 상황 => 5번째로 입력한 주문이 취소됨
delete from 구매내역 where 구매번호 = 'S000005'; 

-- 8) 회원정보 삭제 요청 상황 => 4번째로 입력했던 회원의 정보 삭제
delete from 회원 where 아이디 = 'user04';


-- 나잇대별 분류 방법
select concat(floor(나이/10) *10,'대') 나이대, count(*) 회원수
from 회원
group by 나이대
order by 나이대;

-- 회원 수가 2명 이상인 나이대
select concat(floor(나이/10) *10,'대') 나이대, count(*) 회원수
from 회원
group by 나이대
having count(*) >= 2;

-- 구매 건수가 2회 이상 발생한 상품의 상품번호와 구매건수를 조회
select 상품번호, count(*) 구매건수
from 구매내역
group by 상품번호
having count(*) >= 2;

-- 활동중인 회원만 대상으로 나이대별 인원수를 집계하고, 그 중 활동회원이 1명 이상인 나이대만 조회
select concat(floor(나이/10) * 10,'대') 나이대, count(*) 활동인원
from 회원
where 활동여부 = 'y'
group by 나이대
having count(*) >= 1;


