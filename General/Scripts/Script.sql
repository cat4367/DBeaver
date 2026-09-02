-- 데이터베이스 삭제(존재 한다면~) : drop database 데이터베이스명
drop database if exists test;
-- 데이터베이스 추가(존재 하지않는다면~) : create databese 데이터베이스명
create database if not exists test;
-- 사용할 데이터베이스 선택 : use 데이터베이스명
use test;

-- 테이블 추가 : create table 테이블명 (컬럼 리스트)
create table 학생(
	-- not null : 빈칸 안됨
	학번 char(4) not null,
	이름 varchar(20) not null,
	-- default : 초기값, 기본값
	주소 varchar(50) null default '미정',
	-- int : 정수형 숫자
	학년 int not null,
	나이 int null,
	성별 char(1) not null,
	휴대폰번호 char(14) null,
	소속학과 varchar(20) null,
	-- 기본키 : 중복되지않은 / 각각의 튜플을 구별할 수 있는 컬럼
	primary key (학번)
);

create table 과목(
	과목번호 char(4) not null primary key,
	이름 varchar(20) not null,
	강의실 char(3) not null,
	개설학과 varchar(20) not null,
	시수 int not null
);

create table 수강(
	학번 char(6) not null,
	과목번호 char(4) not null,
	신청날짜 date not null,
	중간성적 int null default 0,
	기말성적 int null default 0,
	평가학점 char(1) null,
	primary key(학번, 과목번호)
);

INSERT INTO 학생
VALUES ('s001', '김연아', '서울 서초', 4, 23, '여','010-1111-2222', '컴퓨터');
INSERT INTO 학생
VALUES ('s002', '홍길동', DEFAULT, 1, 26, '남', NULL , '통계') ;
INSERT INTO 학생
VALUES ('s003', '이승엽', null, 3, 30, '남', null, '정보통신');
INSERT INTO 학생
VALUES ('s004', '이영애', '경기 분당', 2, NULL, '여', '010-4444-5555', '정보통신') ;
INSERT INTO 학생
VALUES ('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터') ;
INSERT INTO 학생
VALUES ('s006', '홍길동', '서울 종로', 2, 26, '남', '010-8888-9999', '컴퓨터') ;
INSERT INTO 학생
VALUES ('s007', '이은진', '경기 과천', 1, 23, '여', '010-2222-3333', '경영') ;

INSERT INTO 과목
VALUES ('c001', '데이터베이스', '126', '컴퓨터', 3) ;
INSERT INTO 과목
VALUES ('c002', '정보보호', '137', '정보통신', 3) ;
INSERT INTO 과목
VALUES ('c003', '모바일웹', '128', '컴퓨터', 3) ;
INSERT INTO 과목
VALUES ('c004', '철학개론', '117', '철학', 2) ;
INSERT INTO 과목
VALUES ('c005', '전공글쓰기', '120', '교양학부', 1) ;

INSERT INTO 수강
VALUES ('s001', 'c002', '2019-09-03', 93, 98, 'A') ;
INSERT INTO 수강
VALUES ('s004', 'c005', '2019-03-03', 72, 78, 'C') ;
INSERT INTO 수강
VALUES ('s003', 'c002', '2017-09-06', 85, 82, 'B') ;
INSERT INTO 수강
VALUES ('s002', 'c001', '2018-03-10', 31, 50, 'F') ;
INSERT INTO 수강
VALUES ('s001', 'c004', '2019-03-05', 82, 89, 'B') ;
INSERT INTO 수강
VALUES ('s004', 'c003', '2020-09-03', 91, 94, 'A') ;
INSERT INTO 수강
VALUES ('s001', 'c005', '2020-09-03', 74, 79, 'C') ;
INSERT INTO 수강
VALUES ('s003', 'c001', '2019-03-03', 81, 82, 'B') ;
INSERT INTO 수강
VALUES ('s004', 'c002', '2018-03-05', 92, 95, 'A') ;

insert into 학생
values ('s008', '정형민', '광주 서구', 1, 20, '남', '010-0000-2222', '자바반');


-- UPDATE
-- update 테이블명 set 컬럼명 = 바꿀값, ... where 조건식;
update 학생 set 주소 = '광주 동구' where 이름 = '정형민';
-- 데이터 수정 -> 주소를 '광주 동구' -> 이름이 '정형민'인 데이터 만!
update 학생 set 주소 = '광주 북구', 나이 = 23, 성별 = '여' where 이름 = '정형민';
-- update 학생 set 학년 = 2 where 학년 = 1;
-- where을 생략하면 전체가 바뀌므로 주의해서 사용할 것

update 학생 set 주소 = '경기 광주' where 주소 = '경기 분당';
-- update 학생 set 학번 = 's001' where 학번 = 's009';


-- DELETE
-- delete from 테이블명;  : 전체삭제!
-- delete from 테이블명 where 조건; : 조건에 맞는것들만 삭제
delete from 학생 where 학번 = 's008';

insert into 학생(학번, 이름, 주소, 학년, 나이, 성별, 휴대폰번호, 소속학과)
values ('s009', '홍길동', '광주 북구', 3, 24, '남', '010-1234-5678', '컴퓨터');

update 학생 set 주소 = '광주 광산구' where 이름 = '홍길동' and 주소 = '광주 북구';

delete from 학생 where 소속학과 = '통계' and 이름 = '홍길동';

delete from 학생;

-- select : 조회

-- select 컬럼명 from 테이블명;
select * from 학생;

select 이름, 나이, 성별 from 학생;
select * from 학생 where 성별 = '남';
select 이름 from 학생 where 성별 = '남';
select 이름, 나이 from 학생 where 나이 >= 22;
select 
	이름,
	나이, 
	성별
from 학생 
where 
	나이 >= 25 or 성별 = '여';

select 이름, 학년, 소속학과 from 학생 where 학년 >= 2 and 소속학과 = '컴퓨터';

select
	이름, 학년, 소속학과
from 학생
where 학년 >= 2 and 소속학과 != '컴퓨터';		-- not(소속학과 = '컴퓨터'), <> , != 전부 아닌것을 표현
-- 학년이 1학년이면서 3학년인 남학생
select
	*
from 학생
where 학년 in (1,3) and 성별 = '남';
-- 소속학과가 정보통신 이거나 4학년인 학생
select
	*
from 학생
where 소속학과 = '정보통신' or 학년 = 4;
-- 2학년에서 4학년 사이의 학생
select
	*
from 학생
where (학년 between 2 and 4); 
-- 중복 제거 distinct '조회정보' (조회 시킨 모든 정보가 같을경우만 제거 됨)
select distinct 학년
from 학생
order by 학년 desc;
-- 정렬 order by '조회정보' 기본은 내림차순(ASC) 오름차순(DESC)

select *
from 학생
where 학년 between 2 and 4
order by 학년, 이름; -- 적힌 순서대로 정렬 실행 ex) 학년 정렬후 이름 정렬

select *
from 학생
where 소속학과 != '컴퓨터' or 학년 = 3
order by 이름 desc
limit 2;		-- 처음부터 2개의 행만 

select count(*)	-- 갯수를 세는거 
from 학생
where 소속학과 = '컴퓨터';

select SUM(나이) -- 나이 합
from 학생
where 성별 = '남'

select avg(나이) as 평균나이 -- 나이 평균 및 컬럼명 변경
from 학생
where 성별 = '남'

select 
	이름 학생명,
	나이,
	성별
from 학생;

select avg(나이) as 평균나이
from 학생
where 나이 >= 25;

-- group by : 집계함수의 그룹화
select 성별, avg(나이)
from 학생
group by 성별;

select 학년, sum(나이) as 나이합, count(학년) as 학생수
from 학생
group by 학년
order by 학년;

-- SELECT문 순서 SELECT(필수) -> FROM(필수) -> WHERE -> GROUP BY -> HAVING -> ORDER BY

select 학년, count(*) as 학생수
from 학생
group by 학년
having count(*) >= 2		-- where 에서 실행시 count(*)이 시행된게 아니라 사용할수 없음
order by 학년 asc;

use test;

select 개설학과 학과, sum(시수)
from 과목
group by 개설학과;

select 학년, 성별, avg(나이)
from 학생
where 소속학과 = '컴퓨터'
group by 학년, 성별
having avg(나이) >= 25
order by 학년, 성별;

-- like 연산자 : 문자열의 일부분을 검색 (where에서 사용)
-- 와일드카드 문자 : % , _ (어떤글자든 올 수가 있다)
-- % : 글자수 상관 x		%정 (~정 [까지]) , 정% ([부터] 정~ )  * %정% ('정'이 포함되어있는것) 
-- _ : _갯수 만큼 글자수 지정		ex) 정 _ _ 뒤에 두글자 자리도 고정
select *
from 학생
where 이름 like '이%';

select 이름, 주소, 학년
from 학생
where 주소 like '%서울%'
order by 학년 desc;

-- null값 검색시 'is'를 사용하여 조건, 아닌건 is not null
select *
from 학생
where 나이 is null or 휴대폰번호 is null;

-- 집합연산자 UNION(합집합)*중복제거   UNION ALL *중복가능
select 학번
from 학생
where 학년 = 4
union all
select 학번
from 수강
where 평가학점 = 'a';

select *
from 학생
where 소속학과 in ('컴퓨터','통계');

select *
from 학생
where 학번 in (select 학번 from 수강 where 평가학점 = 'a');

select 이름
from 학생
where exists (select* from 수강 where 수강.학번 = 학생.학번 and 과목번호 = 'c002');		-- 테이블.조회 .(기능)
-- 이름을 구하는데 수강T 학생T 동시에 포함된 학번을 이용하고, 수강T의 해당 과목번호를 이용해서 구하는 방법

-- JOIN 사용 (대체적으로 프라이머리 키 값 사용)
select *
from 학생, 수강, 과목
where 학생.학번 = 수강.학번 and 수강.과목번호 = 과목.과목번호;

-- 조인 1번 방법
-- 장점 : 간단하고 사용하기 쉽다.
-- 단점 : inner/outer인지 조절이 어렵다
select *
from 학생, 수강
where 학생.학번 = 수강.학번;

-- 조인 2번 방법
-- 장점 : 나가 하고싶은 조인을 조절할 수 있다. 가독성이 좋다.
-- 단점 : 복잡하다
select *
from 학생 inner join 수강
on 학생.학번 = 수강.학번;


select 학생.이름, 과목.이름, 평가학점
from 학생
	join 수강
	join 과목 
	on 학생.학번 = 수강.학번 
	and 수강.과목번호 = 과목.과목번호;

-- 해당 select문 안에서만 유용하며, 변경된후 변경전 이름은 사용할 수 없다
select stu.이름, sub.이름, 평가학점
from 학생 as stu
	join 수강 as cls
	join 과목 as sub
	on stu.학번 = cls.학번 
	and cls.과목번호 = sub.과목번호;


select *
from 학생 left outer join 수강			-- 기준(학생)데이터는 모두 보이되, on조건에 부합한걸 먼저 표시후 null값들을 표시
on 학생.학번 = 수강.학번;


use titanic;
create table gender_submission(
	Passenger_Id int,
	survived int
);

create table test(
	PassengerId int,
	Pclass int,
	Name varchar(50),
	Sex varchar(10),
	Age float,
	SibSp int,
	Parch int,
	Ticket varchar(50),
	Fare float,
	Cabin varchar(50),
	Embarked char(1)
);

create table train(
	PassengerId int,
	Survived int,
	Pclass int,
	Name varchar(50),
	Sex varchar(10),
	Age float,
	SibSp int,
	Parch int,
	Ticket varchar(50),
	Fare float,
	Cabin varchar(50),
	Embarked char(1)
)

select name, age, sex
from test
	join gender_submission as ge
	on test.passengerid = ge.passengerid and ge.survived = 1;

select sex, count(sex)
from test
	join gender_submission as ge
	on test.passengerid = ge.passengerid and ge.survived = 1
group by sex;


select pclass, count(pclass)
from test
group by pclass
order by pclass;

-- 어떤 항구에서 어떤 좌석 클래스에 가족 몇명(1~2/3~4/5~6)과 온 고객의 생존률이 높았는지 

	

select 과목이름 , min(점수) 최소점수, max(점수) 최대점수
from 성적
group by 과목이름
having avg(점수) >= 90;


select 학과, count(학과) '학생 수'
from 학생
group by 학과

select *
from 학생;

select 학번, 이름, 나이
from 학생
where 성별 = '남' and 나이 in ( select min(나이) from 학생 where 성별 = '남');


use test;
create table student_list(
	student_id char(101) not null,
	name varchar(50) not null default '미상',
	age int,
	primary key (student_id, name),
	unique (student_id)
);
 
use test;
select 학번, 학생.이름, 과목번호, 과목.이름
from 학생, 과목;
	
-- 121 페이지 (137강의실에서 강의되는 모든 과목을 수강하는 학생의 이름)
select 이름
from
(select 학번, 과목번호
from 수강
where 과목번호 = (
	select 과목번호
	from 과목
	where 강의실=137)
) R1 join 학생 on R1.학번 = 학생.학번;

-- 121 페이지 맨아래쪽 회색박스의 3번째 줄)
select 과목번호, 평가학점
from (
	select 과목번호, 평가학점, 학생.이름
	from 학생,수강
	where 학생.학번 = 수강.학번
) R1
where R1.이름='김연아';





use test;

create table 비상연락망 (
	이름 varchar(50),
	성별 char(1),
	연락처 varchar(20) not null default '추후입력',
	학교 varchar(50),
	학년 int,
	반 int,
	번호 int,
	주민등록번호 varchar(14),
	primary key(주민등록번호),	-- 중복 x  null x
	unique(학교,학년,반,번호),	-- 중복 x  null o
	unique(이름,연락처)
);

desc 수강;					-- 테이블 내용 확인 desc

insert into 비상연락망 (이름, 성별) value ('홍길동','남');
insert into 비상연락망 (이름, 성별, 연락처) value ('홍길동','남', '010-1111-2222');

use



create database if not exists shop;
use shop;

create table member (
	member_id int primary key,
	username varchar(20) not null,
	email varchar(50) unique ,
	created_at datetime default CURRENT_TIMESTAMP()
);

create table products (
	product_id int primary key,
	product_name varchar(30) not null,
	price int check (price >= 0),
	stock int
);

create table orders (
	order_id int primary key,
	member_id int,
	order_date datetime ,
	foreign key(member_id) references member(member_id)
);

alter table orders modify column order_date datetime default CURRENT_TIMESTAMP();

insert into member (member_id, username, email) values
(1, '김철수', 'chulsoo@gmail.com'),
(2, '이영희', 'younghee@naver.com'),
(3, '박민수', 'minsu@daum.net'),
(4, '정서연', 'seoyeon@gmail.com'),
(5, '강도윤', 'doyun@kakao.com'),
(6, '조지우', 'jiwoo@naver.com'),
(7, '윤하준', 'hajun@gmail.com'),
(8, '한서윤', 'seoyun@daum.net');

insert into products (product_id, product_name, price, stock) values 
(1, '무선 키보드', 35000, 120),
(2, '게이밍 마우스', 25000, 80),
(3, '27인치 모니터', 250000, 30),
(4, 'USB-C 허브', 15000, 200),
(5, '책상 장패드', 12000, 150),
(6, '노트북 거치대', 22000, 90),
(7, '블루투스 스피커', 45000, 50),
(8, 'HD 웹캠', 60000, 40);

insert into orders (order_id,member_id, order_date) values
(1, 1, '2026-06-01 10:30:00'),
(2, 2, '2026-06-01 14:15:00'),
(3, 3, '2026-06-02 09:00:00'),
(4, 1, '2026-06-03 11:20:00'),
(5, 4, '2026-06-04 16:45:00'),
(6, 5, '2026-06-05 13:10:00'),
(7, 6, '2026-06-06 17:50:00'),
(8, 7, '2026-06-07 08:30:00');

create table 게시판(
	게시물번호 int not null auto_increment primary key,		-- auto_increment 입력할때마다 숫자++ 자동입력
	제목 varchar(50),
	내용 text,
	작성일 date,
	작성자 varchar(20)
);

insert into 게시판(제목, 내용) values
('안녕하세요 제목임','안녕하세요 나는내용임');

delete from 게시판 where 게시물번호 in(5,6,7,10,11);			-- 해당 행이 사라져도 번호가 재정렬되는건 아님

select *
from products;

select product_name 상품명, price 가격
from products
where price <= 30000;

select *
from orders
where member_id in(1);

select order_id 주문번호, username 회원명, order_date 주문일자
from orders join member on orders.member_id = member.member_id;

select username 회원명, count(*) 주문횟수
from member join orders on member.member_id = orders.member_id
group by username;

select username 회원명, count(*) 주문횟수
from member join orders on member.member_id = orders.member_id
group by username
order by 주문횟수 desc,회원명;

use test;
create table 게시판(
	게시물번호 int not null auto_increment primary key,
	제목 varchar(50),
	내용 text,
	작성일 date,
	작성자 varchar(20)
);

alter table 게시판 add 작성일 time ;
alter table 게시판 modify 작성일 date not null;	-- 자료형 변경 'modify' 
alter table 게시판 change 작성일 작성일자 date;	-- 컬럼명 변경 'change'
alter table 게시판 rename to 게시물;			-- 테이블명 변경 'rename to'
alter table 게시판 modify 작성자 varchar(20) default '관리자';
alter table 게시판 drop column 작성일;			-- 컬럼 삭제 'drop column'

drop table 게시물;							-- 테이블 삭제 'drop table 테블명'






























