-- session sql

select *
from emp e inner join pw_history ph
on e.empno = ph.empno
where e.empno = 7369 and ph.pw ='0000';

insert into pw_history(empno, pw, createdate) values(7369, '0000', sysdate);

-- 여러개중에 하나만 담길 것이니까 group by사용
select * from pw_history 
where empno = 7369 
group by max(createdate);


select e.empno, e.ename, ph.pw, ph.createdate
from emp e inner join pw_history ph
on e.empno = ph.empno
where e.empno = 7369 
order by createdate desc
OFFSET 0 rows fetch next 1 rows only; -- 마리아DB의 LIMIT(0,1)와 같은걸로 생각(0부터 다음 rows1번만 가져오기)


select t.empno, t.ename -- 로그인정보를 세션으로 넘길 것
FROM(select e.empno empno, e.ename ename, ph.pw pw, ph.createdate createdate
from emp e inner join pw_history ph
on e.empno = ph.empno
where e.empno = 7369 
order by createdate desc
OFFSET 0 rows fetch next 1 rows only) t
where t.pw = '0000';
