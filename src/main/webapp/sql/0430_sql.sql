-- 2024.04.30 SQL

-- 같은 null값을 가졌음에도 불구하고 전체null인지 null부서가 1개있는건지 구분이 불가
select null x, count(*) c
from emp
group by ()
union all
select deptno x, count(*) c
from emp
group by deptno;


-- GROUPING SETS를 사용
select deptno, count(*), grouping(deptno)
from emp
group by grouping sets((),deptno);

-- 이렇게 grouping을 사용하면 전체와 구분해서 출력이 가능함 
select case when deptno is null and grouping(deptno) = 0 then '부서없음'
            when deptno is null and grouping(deptno) = 1 then '전체'
            else to_char(deptno) end dept
        , count(*), grouping(deptno)
from emp
group by grouping sets((), deptno);



-- GROUPING SETS 함수는 GROUP BY 절에서 그룹 조건을 여러 개 지정할 수 있는 함수.
-- 결과는 각 그룹 조건에 대해 별도로 GROUP BY한 결과를 UNION ALL한 결과와 동일함
-- 
SELECT gender, COUNT(*) 
FROM emp
GROUP BY GROUPING SETS((),gender); -- () + gender라는 뜻 

-- rollup
-- 1. gender+deptno+job
-- 2. gender+deptno
-- 3. gender
-- 4. 전체
SELECT gender, job, COUNT(*)
FROM emp
GROUP BY ROLLUP(gender, deptno, job);

-- 모든 경우의 수 cube
-- 1. gender + deptno + job
-- 2. deptno + job
-- 3. gender+deptno
-- 4. gender+job
-- 5. job
-- 6. deptno
-- 7. gender
-- 8. 전체
SELECT gender, job,COUNT(*)
FROM emp
GROUP BY CUBE(gender, deptno, job);

-- group by 확장
-- 1) grouping sets > rollup/cube
-- 2) grouping()함수




select * from emp;


-- 계층쿼리
-- 정방향

-- where절이 있다면 계층 조건 다음으로 실행
SELECT * -- 4)
FROM emp -- 1)
WHERE ename != 'BLAKE' -- 3)
START WITH mgr IS NULL CONNECT BY PRIOR empno = mgr; -- 2)joing순서
-- 역방향
-- 이전의 mgr
SELECT *
FROM emp
START WITH ename = 'SMITH'
CONNECT BY PRIOR mgr = empno;

-- 계층쿼리에서 사용가능한 함수와 의사컬럼
SELECT rownum, t.*
FROM (SELECT rowid, ename from emp order by ename) t;

SELECT LPAD(' ',3*(LEVEL-1))||ename, empno, mgr, level
from emp
start with mgr is null
connect by prior empno = mgr;




-- error : 개별행을 조회할 결과셋이 존재하지 않음
SELECT ename, sal, sum(sal)
FROM emp
group by(); 


SELECT SUM(sal) FROM emp;

SELECT ename, sal, (SELECT SUM(sal) FROM emp) 합계
from emp;

select ename, sal, gender, sum(sal) over(partition by gender) e
from emp;

select ename, sal, gender
        , sum(sal) over() sum -- 1)를 복제한 계산셋을 만들어 전체를 하나의 집합으로 사용
        , avg(sal) over() avg
        , min(sal) over() min
        , max(sal) over() max
        , count(*) over(partition by gender) cnt -- 1)를 복제 후 두개의(gender) 집합계산셋을 만듬
from emp; -- 1) 집계 분석함수


-- 순위분석함수 RANK() / ROW_NUMBER()
SELECT ename, sal
        , RANK() OVER(ORDER BY sal DESC) rank -- 1)를 복제후 정렬
from emp; -- 1)

SELECT ename, sal
        , ROW_NUMBER() OVER(ORDER BY sal DESC) rank -- 1)를 복제후 정렬
from emp -- 1)
ORDER BY rank;



SELECT ename, sal, gender
        , ROW_NUMBER() OVER(ORDER BY sal DESC) rank1 -- 1)를 복제후 정렬
        , RANK() OVER(ORDER BY sal DESC) rank2 -- 1)를 복제후 정렬
        , DENSE_RANK() OVER(ORDER BY sal DESC) rank3
        , RANK() OVER(PARTITION BY gender ORDER BY sal DESC) 남여rank4 -- 1)을 두개의 집합으로 나누고 각각 정렬 후 
from emp; -- 1)



SELECT ename, sal, ntile(3) OVER(ORDER BY sal DESC)
from emp;
