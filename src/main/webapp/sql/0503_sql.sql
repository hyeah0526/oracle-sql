/*
	 [ lower() / upper() / initcap() ]
	 lower()소문자변환
	 upper()대문자변환
	 initcap()맨첫글자만 대문자변환
*/

SELECT lower('ABC'), upper('def'), initcap('abc'), initcap('ABC')
FROM dual;

SELECT initcap(ename), lower(job)
FROM emp;

/*
	lpad() / rpad()
*/
select lpad('1234', 6, ' '), lpad('1234', 6), lpad('1234', 6, 'x')
from dual;

select rpad('1234', 6, ' '), rpad('1234', 6), rpad('1234', 6, 'x')
from dual;

-- 특정문자(ename)을 늘리고자하는 전체 길이만큼 나머지를 어떻게 처리할지
select lpad(ename, 6), lpad(ename, 2)
from emp;


/*
	[ trim() / ltrim() / rtrim() ]
	
	trim() 글자의 왼쪽오른쪽 공백을 제거
	ltrim()글자의 왼쪽 공백을 제거
	rtrim()글자의 오른쪽 공백을제거
*/
select trim('       abc       '), ltrim('       efg       '), rtrim('       hij       ')
from dual;


/*
	[ replace() ]
	글자 사이에 있는 공백은 trim()으로 불가능하므로 replace함수를 사용해야함
*/
-- 공백제거 불가능한 예시
select trim('a b c')
from dual;

-- 대신 replace를 사용 
select replace('a b c', ' ', '')
from dual;


/*
	[ substr() ]
	글자 잘라주는 함수 substr(문자, 어디부터, 어디까지 자를건지)
*/
SELECT SUBSTR('abcde', 1), substr('abcde', 2), substr('abcde', 2, 3)
FROM DUAL;
​

​
/*
	[ length() ]
	문자열 길이 확인하는 함수
*/
select length('abc')
from dual;
// 3
​
/*
	[ round() / ceil() / floor() / trunc() ]
	round()반올림함수 
	ceil()올림함수
	floor() 버림함수 
	trunc() 버림함수 (절삭의 개념으로 말그대로 소수점뒤를 그냥 잘라버림)
	 차이점 :: 음수일경우 달라짐
*/
select round(3.14567, 1), ceil(3.14567), floor(3.14567), trunc(3.14567),
        floor(-3.14567), trunc(-3.14567)
from dual;
​

​
/*
	[ mod() ]
	나머지 연산자
*/

-- oracle에서는 소수점까지 구함
select 3/2
from dual;

-- oracle에는 나머지 연산자가 없기때문에 mod()를 사용함
select mod(7, 4)
from dual;
​

/*
	[ 몫 구할때는 trunc() 사용 ]
*/
select trunc(10/3)
from dual;




