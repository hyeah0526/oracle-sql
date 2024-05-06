/*
	[ 날짜함수 - sysdate / next_day() / last_day() ]
	sysdate 날짜함수
*/
select sysdate
from dual;
next_day()

last_day()

select next_day(sysdate, '토') "오늘이후 첫번째 토요일"
from dual;

select last_day(sysdate) "이달의 마지막 날짜"
from dual;
​
/*
	[ null 함수 -  nvl() / nvl2() / nullif() / coalesce() ]
	nvl() null값이 있으면 0으로 치환
	nvl2() comm이 null이 아니면 comm이되는거고 null이면 0이되는거고
*/
select ename, sal, comm, sal+nvl(comm,0), sal+nvl2(comm, comm, 0)
from emp;
 nullif() 매개값이 동일하면 null로 변경, 다르면 앞에 값으로 가져옴

select nullif(2, 2), nullif(2, 3)
from dual;
-- coalesce() 매개변수값 중에 첫번째로 null이 아닌 값을 가져옴
-- 전부 null만 들어있으면 null을 반환함 

select coalesce(null, null, 1, null, 2, 3), coalesce(null, null, null)
from dual;
​

​
/*
	[ decode() & CASE ]
	decode() -> CASE표현식으로 반환이 가능
	deptno이 10이면 빨강 / 20이면 주황 / 나머지는 노랑
	decode보다는 표준SQL인 CASE표현식을 사용하자!
	-- decode()
*/
select ename, deptno, decode(deptno, 10, '빨강', 20, '주황', '노랑') 색상
from emp;

-- CASE
select ename, deptno
        , CASE WHEN deptno = 10 then '빨강'
            WHEN deptno = 20 then '주황'
            ELSE '노랑' end 색상
from emp;
​

​
/*
	[ 비교연산자 - all() / any()]
	 >, <, =, <=, >=, 다르다(!=, ^=, <>)
*/
select ename, sal
from emp
where sal <all (3000,5000) ; -- sal < 5000 둘다 만족해야하고

select ename, sal
from emp
where sal > any (2000,3000) ; -- sal > 2000 -- 하나만 만족하면됨
​
/*
[ 논리연산자 ]
논리연산자
*/
and
  T and T => T
 T and F => F
 F and T => F
 F and F => 
or
T or T => T
T or F => T
F or T => T
F or F => F

select ename, sal, deptno
from emp
where sal > 2000 
and deptno = 20; -- 둘다 참이여야함

select ename, sal, deptno
from emp
where sal > 2000 
or deptno = 20; -- 둘중 하나만 참이면 됨
-- 같은 표현 :: deptno이 10이거나 30인 사람들이 나옴
select ename, deptno
from emp
where deptno = 10 or deptno=30;

select ename, deptno
from emp
where deptno =any (10, 30);

--------------------------------------------------------------------

-- 같은 표현 :: 1000과 2000사이의 사람들이 나옴
select ename, sal
from emp
where sal >= 1000 and sal <=2000;

select ename, sal
from emp
where sal between 1000 and 2000;

--------------------------------------------------------------------

-- 같은 표현 :: 입사년도가 2002 ~ 2005인 사람들
select ename, extract(year from hiredate)
from emp
where extract(year from hiredate) >= 2002 
and extract(year from hiredate) <= 2005;

select ename, extract(year from hiredate)
from emp
where extract(year from hiredate) between 2002 and 2005;

--------------------------------------------------------------------

-- 같은 표현 :: 이름의 첫글자가 대문자 S이거나 A인사람
select ename
from emp
where substr(ename, 1, 1) = 'S' 
or substr(ename, 1, 1) = 'A';

select ename
from emp
where substr(ename, 1, 1) in ('S', 'A');
​

​
/*
	[ is null / is not null ]
*/
is null - null인걸 가져오기

is not null - null이 아닌걸 가져오기

select ename, comm
from emp
where comm is null;

select ename, comm
from emp
where comm is not null;