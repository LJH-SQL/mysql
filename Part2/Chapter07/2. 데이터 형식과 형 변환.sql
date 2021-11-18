/* 데이터 형식과 형 변환
형식 :
CAST ( expression AS 데이터형식 [(길이)])
CONVERT ( expression, 데이터형식 [(길이)])
*/


USE sqldb;
SELECT AVG (amount) AS '평균 구매 개수' FROM buytbl;
-- 출력문 : 2.9167		해당 결과문을 정수로 바꾸려면 아래와 같다
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl; -- signed : 숫자의 양수, 음수 전부 표현 가능한 값
-- or SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매 개수 FROM buytbl;' // 출력문 : 3

SELECT CAST('2020$12$12' AS DATE);
SELECT CAST('2020/12/12' AS DATE);
SELECT CAST('2020%12%12' AS DATE);
SELECT CAST('2020@12@12' AS DATE);
-- 4개의 쿼리문은 다양한 구분자를 날짜 형식으로 변경하는 것이다. // 출력문 : 2020-12-12

SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS Char(4)), '=') AS '단가X수량',  -- CONCAT : 두 개의 문자열을 하나의 문자열로 만들엊주는 역할
price*amount AS '구매액' FROM buytbl;
-- 쿼리문의 결과를 보기 좋도록 처리할 때도 사용한다. // 출력문 : 1	45X2=	90

/*
형 변환 방식에는 명시적인 변환과 암시적인 변환, 두 가지가 있다. 명시적인 변환이란 CAST() or CONVERT() 함수를 이용해서 데이터 형식 변환하는 것이고,
암시적인 변환은 CAST(), CONVERT()함수를 사용하지 않고 형변환 하는것
아래가 그 예이다.
*/
SELECT '100' + '200' ; -- 문자와 문자를 더함 ( 정수로 변환되어서 연산됨) // 출력문 : 300
SELECT CONCAT('100','200'); -- 문자와 문자를 연결(문자로 처리) //출력문 : 100200
SELECT CONCAT(100, '200'); -- 정수와 문자를 연결( 정수가 문자로 변환되어 처리) 출력문 : 100200
SELECT 1 > '2mega'; -- 정수인 2로 변환되어서 비교 // 출력문 : 0
SELECT 3 > '2MEGA'; -- 정수인 2로 변환되어서 비교 // 출력문 : 1
SELECT 0 = 'mega2'; -- 문자는 0으로 변환 //출력문 : 1



