-- SELECT 필드이름 FROM 테이블이름 WHERE 조건식;

USE sqldb;
SELECT * FROM usertbl;

SELECT * FROM usertbl WHERE name = '김경호';

-- 관계연산자 이용
SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 AND height >= 182; -- 이승기, 성시경 출력
SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 OR height >= 182; -- 바비킴,은지원,김범수,김경호,임재범,이승기,성시경 출력

-- BETWEEN ... AND
SELECT name, height FROM usertbl WHERE height >= 180 AND height <=183; -- 출력문 임재범,이승기
SELECT name, height FROM usertbl WHERE height BETWEEN 180 AND 183; -- 위와 같은 결과가 나온다.
-- IN() 
SELECT name, addr FROM usertbl WHERE addr = '경남' OR addr='전남' OR addr='경북';
SELECT name, addr FROM usertbl WHERE addr IN ('경남','전남','경북'); -- 위와 출력문이 동일하다.
-- LIKE
SELECT name, height FROM usertbl WHERE name LIKE '김%'; -- 맨 앞 글자가 '김' 인 것들을 추출한다.
SELECT name, height FROM usertbl WHERE name LIKE '_종신'; -- 맨 앞 글자가 한 글자이고, 그 다음이 '종신'인 사람을 추출한다.
SELECT name, height FROM usertbl WHERE name LIKE '_용%'; -- 앞에 아무 한 글자가 오고, 두번째는 '용', 세번째 이후로는 몇글자든 아무거나 오는 값을 추출한다.

-- ANY/ALL/SOME 그리고 서브쿼리
-- 서브쿼리란 간단히 쿼리문 안에 또 쿼리문이 있는 것을 얘기한다.
SELECT name, height FROM usertbl WHERE height > 177;
SELECT name, height FROM usertbl
	WHERE height > (SELECT height FROM usertbl WHERE Name = '김경호'); -- 해당 서브쿼리는 177을 반환하므로 WHERE > 177 과 같다

SELECT name, height FROM usertbl
	WHERE height >= (SELECT height FROM usertbl WHERE addr = '경남');
-- 위 쿼리는 Error Code: 1242. Subquery returns more than 1 row 라는 오류가 발생한다. 그래서 ANY 구문이 필요하다.

SELECT name, height FROM usertbl
	WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남'); -- 서브쿼리 출력문은 결과로 173, 170이 나오고 해당 쿼리는 키가 173보다 크거나 같은 살마 또는 키가 170보다 크거나 같은 사람 모두 철력 한다.
SELECT name, height FROM usertbl
	WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남'); -- ANY 를 ALL 로 바꾼다면 키가 170 보다 크거나 같아야 할 뿐만 아니라 173보다 크거나 같아야 한다.
SELECT name, height FROM usertbl
	WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남'); -- '>=ANY'가 아니고 '=ANY'를 넣는다면 173, 170에 해당하는 사람만 출력된다.
SELECT name, height FROM usertbl
	WHERE height IN (SELECT height FROM usertbl WHERE addr = '경남'); -- '=ANY'구문과 동일하다.

SELECT name, mDate FROM usertbl ORDER BY mDate; -- 가입한 순서로 회원들 출력
SELECT name, mDate FROM usertbl ORDER BY mDate DESC; -- DESC는 내림차순, ASC는 오름차순
SELECT name, mDate FROM usertbl ORDER BY height DESC, name ASC; -- 키가 큰 순서로 정렬하되 만약 키가 같을 경우 이름 순으로 정렬

SELECT DISTINCT addr FROM usertbl; -- DISTINCT는 중복된 값을 1개씩만 보여준다.

use employees;
SELECT emp_no, hire_date FROM employees Order By hire_date ASC;	-- 입사일 순서로 출력
SELECT emp_no, hire_date FROM employees Order By hire_date ASC LIMIT 5; -- 입사일 순서 출력문 중 제일 앞 5개만 출력

/*
테이블 복사 구문 CREATE TABLE ... SELECT
형식 :
CREATE TABLE 새로운테이블 (SELECT 복사할 열 FROM 기존테이블)
다만 복사한 테이블은 PK나 FK등의 제약조건은 복사되지 않는다.
*/
USE sqldb;
CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * FROM buytbl2;
CREATE TABLE buytbl3 (SELECT userID, prodName FROM buytbl); -- 복사할 열 선택해서 만들기
SELECT * FROM buytbl3;



