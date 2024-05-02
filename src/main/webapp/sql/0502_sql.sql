-- 집계함수 (null값은 제외함)
SELECT COUNT(*)
FROM emp;

select count(empno), gender, max(sal) sal -- 3번 그걸 카운트함 
-- ,gender는 되는데 ,ename은 안됨 왜? gender는 group by에서 대표값으로 사용되었지만 ename 계산식이 아니므로
-- 반대로 max(sal)은 됨 왜? 이건 계산식이니까
from emp -- 1번
group by gender; --2번 'F'와 'M' 두가지가 계산식이 나오게 되고

/*
	개수count(), 합sum(), 평균값avg(), 최대값max(), 최소값min(), 집계열
	null+숫자 --> null집계함수를 사용할 수 없으므로 오라클의 집계함수는 null값을 제외 후 계산함
	
	HAVING 사용 
	아래 and는 사용이 불가능하다 왜? 순서는 맞지않기때문에 그렇기 때문에 HAVING을 사용함

*/
select deptno, count(*)
from emp
where deptno is not null 
//and count(*) >= 5 는 사용이 불가함 왜? 순서가 안맞음 where절이 먼저 실행되기 때문에 count(*)가 존재하지 않기때문
group by deptno
order by deptno asc nulls first;


select deptno, count(*)
from emp
where deptno is not null 
group by deptno
having count(*) >= 5
order by deptno asc nulls first;

select deptno, count(*)                     -- 5번
from emp                                    -- 1번 결과셋 : SELECT * FROM emp
where job != 'MANAGER'                      -- 2번 결과셋 : SELECT * FROM emp where job != 'MANAGER'
group by deptno                             -- 3번 총4개의 집합이 생성됨: SELECT * FROM emp where job != 'MANAGER' group by deptno = ?
having deptno is not null and count(*) >= 4 -- 4번
order by deptno asc nulls first;            -- 6번 정렬해달라

-- 1번 : 총 15개의 행
SELECT * FROM emp;

-- 2번 : 매니저를 제외한 총 12개
SELECT * FROM emp where job != 'MANAGER';

-- 3번 : 집합4개가 생김
SELECT * FROM emp where job != 'MANAGER' and deptno = 10; 
SELECT * FROM emp where job != 'MANAGER' and deptno = 20;
SELECT * FROM emp where job != 'MANAGER' and deptno = 30;
SELECT * FROM emp where job != 'MANAGER' and deptno is null;

-- 4번 : 
--집합 4개중 deptno에 null이 있는 4번째집합이 사라지게됨
--또 집합 4개중 count(*) >= 4이므로 2번째 집합도 사라지게됨
-- 결국 남아있는건 2개의 집합
SELECT * FROM emp where job != 'MANAGER' and deptno = 20;
SELECT * FROM emp where job != 'MANAGER' and deptno = 30;

-- 5번 : 남아있는 것 중에 deptno, count(*)를 보여주고 

-- 6번 : order by deptno asc nulls first; 로 나열


-- 문자열이 A인사람 ename == 'A'
select *
from emp
where ename like 'A'; 

--문자열이 A로 시작하는 사람
select *
from emp
where ename like 'A%';

-- 만약 대소문자 구분없이 검색을 원한다면 치환 후 검색
select *
from emp
where LOWER(ename) like '%a%'; 

--문자열이 AL로 시작하는 사람
select *
from emp
where ename like 'AL%';

--문자열 중에 A가 들어가는 사람
select *
from emp
where ename like '%A%'; 

-- _는 하나의 문자를 가리킴. 즉 A로 시작하는 두자짜리
select *
from emp
where ename like 'A_'; 

-- A로 시작하는 총 5자짜리
select *
from emp
where ename like 'A____'; 
​

/*
 ORDER BY 

정렬 (기본값이자 오름차순asc / 내림차순desc)

null값이 있으면 무조건 제일 큰값으로 오게되어 있음(오름차순시 맨 마지막 / 내림차순시 맨 위)

ASC NULLS LAST / DESC NULLS FIRST가 기본으로 붙어있는 것으로 직접 바꿔도 가능함

SELECT문 순서

5) SELECT 절

1) FROM 절

2) WHERE 절

3) GROUP BY 절 (계산셋을 만듬)

4) HAVING 절

6) ORDER BY 절
*/

ASC 
-- name값의 오름차순이고 생략시 asc가 기본값이 됨
-- 뒤에 기본으로 nulls last가 붙어 있음. nulls first로 변경가능함
select *
from emp
order by ename asc; -- A부터정렬

select *
from emp
order by empno asc; -- 1부터 정렬

select *
from emp
order by ename asc nulls first; -- null값이 제일 위로 올라옴



DESC
-- name의 내림차순
-- 뒤에 기본으로 nulls first가 붙어 있음. nulls last로 변경가능함
select *
from emp
order by ename desc; -- W부터정렬

select *
from emp
order by empno asc; -- 제일 뒷자리부터 정렬

select *
from emp
order by ename desc nulls last; -- W부터정렬