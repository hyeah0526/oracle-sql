-- 반정규화
-- sal*12연봉과 같은 계산이 복잡한 계산이라면 select 속도가 느려짐
select ename, sal, sal*12 연봉
from emp;

-- 아에 테이블에 연봉을 추가(year_sal)하면 연봉을 구하기 위한 계산식이 필요없음 --> SELECT 연산이 빨라졌다 
    --> 계산된 중복 데이터 -> 반정규화
-- 단점 : 반정규화로 select속도는 빨라졌지만 insert시 sal과 comm을 계산한 결과값이 입력되어야해서 inser속도가 느려졌음
update emp 
set year_sal = (sal*12)+nvl(comm,0)*12;
/*
    컬럼 반정규화 1) 이력테이블 2)계산속성
*/

-- total을 조회하고 싶을때,
select total from history ;
-- 반정규화를 하지 않았다면 --> 집계연산을 하면 속도가 느려짐
select sum(money) from card_history;

-- total을 넣게되면 조회속도는 빨라지지만 insert는 느려짐
CREATE TABLE card_history{
    card_date date
    , money number
    , total number -- 이력 + 계산 --> 반정규화 --> 이상현상 : 어제 금액수정 후 total컬럼을 수정하지 않으면 
};

-- 합집합, 교집합, 차집합
-- 집합연산시 쿼리의 결과셋의 컬럼수와 데이터타입은 일치해야함
-- union all 중복출력 / union 중복제외 
select * from 친구
union all
select * from 직장동료; 

-- 차집합 minus
select * from 친구
minus
select * from 직장동료; 

-- 교집합 intersect 공통으로 가지고 있는 것
select * from 친구
intersect
select * from 직장동료; 


-- 서브쿼리 (자식 SELECT문)
-- 1) 스칼라 : SELECT문의 SELECT절(컬럼값자리)에 사용된 SELECT문 --> 단일값(스칼라)
select * from emp;
select AVG(sal) from emp;
-- 위 쿼리의 결과물을 같이 조회  - cross join

SELECT *
from emp cross join(select round(avg(sal)) from emp) t;
-- 스칼라 서브쿼리를 이용
select emp.*, (select round(avg(sal)) from emp) 평균 from emp;

-- error
select emp.*, (select deptno from dept) from emp; -- 스카라 결과값은 항상 단일값이여야 함

-- 2) 인라인뷰 : SELECT문의 FROM절
select * 
from (SELECT * FROM emp WHERE gender = 'M') t -- 1. 남자인사람중에
WHERE t.deptno = 20; -- 2. deptno이 20인사람

select * from emp
where gender = 'M' and deptno = 20;

-- 예시> 쇼핑몰 emp 테이블, customer테이블 -> 사용자ID는 두테이블에서 중복되어서는 안됨
-- 'test'라는 아이디가 사용가능한지 
select * from emp where emp_id = 'test';
select * from customer where customer_id = 'test';
-- 두 쿼리의 결과가 모두 null일때만 'test'아이디를 사용가능 == 즉 DAO 2개를 만들어야함

-- 이렇게 두개의 쿼리를 하나의 쿼리로 변경
select ec.id 
from 
    (select emp_id from emp 
    union all -- 집합연산자
    select customer_id from customer) ec -- 인라인뷰라는 서브쿼리
where ec.id = 'test';

-- 3) 서브쿼리 : where절, having절, ...

-- a) 단일행 단일컬럼
-- 전체평균보다 높은 사원
select * from emp where sal > (select avg(sal) from emp);

-- 전체평균보다 부서평균이 낮은 부서
select deptno, avg(sal) 
from emp 
group by deptno 
having avg(sal) < (select avg(sal) from emp);

-- b) 단중행 단일컬럼
-- sal = (select sal from emp where deptno = 10)이 아니라 IN을 사용 
-- 왜? sal = (2450, 5000, 1300)으로 하나를 가지고 여러개를 비교해야하니까 =은사용이 안됨
-- IN이 아니라면 >ANY (select sal from emp where deptno = 10)
-- 혹은 >ALL (select sal from emp where deptno = 10)
select * from emp where sal IN (select sal from emp where deptno = 10);

-- c) 다중컬럼 (결과물이 여러개)
-- scott와 같은 부서에 일하면서 성별이 같은 사람을 뽑아줌
select * 
from emp 
where (deptno, gender) = (select deptno, gender from emp where ename = 'SCOTT');

-- 다중행 다중컬럼 IN
select * 
from emp 
where (deptno, gender) IN (select deptno, gender from emp where ename = 'SCOTT' or ename = 'JAMES');

-- 크다 같다 작다는 숫자와비교하는 것이므로 >ANY >ALL과 같은 함수는 사용이 불가능
select * 
from emp 
where (deptno, gender) >ANY (select deptno, gender from emp where ename = 'SCOTT' or ename = 'JAMES');