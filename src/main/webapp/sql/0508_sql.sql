/*
	GROUPING STES와 ROLLUP의 결과가 같음
*/

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