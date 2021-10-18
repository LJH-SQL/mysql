/*
형식 :
SELECT select_expr
	[FROM table_references]
    [WHERE where_condtion]
    [Group BY {col_name | expr | position}]
    [HAVING where_condition]
    [ORDER BY {col_name | expr | position}]
    
집계함수 : SUM()-더하기, AVG()-평균, MIN()-최소값, MAX()-최대값, COUNT()-행의 갯수, COUNT(DISTINCT)-행의개수(단 중복은 1개만 인정), STDEV()-표준편차, VAR_SAMP()-분산
*/
SELECT userID, SUM(amount) FROM buytbl GROUP BY userID; -- userID별로 그룹으로 묶는다.
SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수' FROM buytbl GROUP BY userID; -- ALIAS를 사용하여 결과를 보기 편하게 만든다.
SELECT userID AS '사용자 아이디', SUM(price*amount) AS '총 구매액' FROM buytbl GROUP BY userID; -- 사칙연산도 가능

USE sqldb;
SELECT AVG(amount) AS '평균 구매 개수' FROM buytbl; -- 평균 구매 개수 결과는 2.9167개
SELECT userID, AVG(amount) AS '평균 구매 개수' FROM buytbl GROUP BY userID; -- 사용자 별 평균 구매개수

-- Q. 가장 큰 키와 가장 작은 키의 회원 이름과 키를 출력하는 쿼리문
SELECT name, height FROM usertbl where height = (SELECT MAX(HEIGHT) from userTBL) OR height = (SELECT MIN(HEIGHT) FROM userTBL);
-- WHERE height =ANY (SELECT MAX(HEIGHT), MIN(HEIGHT) FROM usertbl); 내가 쓴 오답 출력문 : error Code: 1241. Operand should contain 1 column(s)

-- COUNT 사용
SELECT COUNT(*) FROM usertbl; -- 사용자의 수 카운트
SELECT COUNT(mobile1) AS '휴대폰 소지 사용자' FROM usertbl; -- 휴대폰이 있는 사용자 카운트(NULL값 제외)

-- HAVING절 - GROUP BY 뒤에 오는 조건절
USE sqldb;
SELECT userID, SUM(amount*price) AS '총 구매액' FROM buytbl GROUP BY userID HAVING SUM(price*amount) > 1000 ORDER BY SUM(amount*price);-- 총 구매액이 1000이상인 사용자에게만 사은품을 주고 싶을 떄 사용

-- ROLLUP - 총합 또는 중간 합계가 필요하다면 GROUP BY절과 함께 WITH ROLLUP문 사용
SELECT * FROM buytbl;
UPDATE buytbl SET num = num -3;
SELECT num, groupName, SUM(price*amount) AS '비용' FROM buytbl GROUP BY groupName, num WITH ROLLUP;
SELECT groupName, SUM(price*amount) AS '비용' FROM buytbl GROUP BY groupName WITH ROLLUP; -- 소합계 및 총합계만 필요하다면 num만 뺀다.

/*
SELECT문의 최종적인 틀
SELECT select_expr
	[FROM table_references]
    [WHERE where_condition]
    [GROUP BY {col_name | expr | position}]
    [HAVING where_condition]
    [ORDER BY {col_name | expr | position}]
기억해두자
*/