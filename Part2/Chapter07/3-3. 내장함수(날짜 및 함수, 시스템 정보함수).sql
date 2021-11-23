-- 날짜 및 시간 함수
-- ADDDATE(날짜, 차이), SUBDATE(날짜,차이) // 날짜를 기준으로 차이를 더하거나 뺀 날짜를 구한다.
SELECT ADDDATE('2025-01-01', INTERVAL 31 DAY), ADDDATE('2025-01-01', INTERVAL 1 MONTH); -- 출력문 : 2025-02-01, 2025-02-01
SELECT SUBDATE('2025-01-01', INTERVAL 31 DAY), SUBDATE('2025-01-01', INTERVAL 1 MONTH); -- 출력문 : 2024-12-01, 2024-12-01
-- DATE_ADD()와 ADDDATE()는 같은함수, SUBDATE()와 DATE_SUB()는 같은함수이다.

-- ADDTIME(날짜/시간,시간), SUBTIME(날짜/시간,시간) // 날짜/시간을 기준으로 시간을 더하거나 뺀 결과를 구한다.
SELECT ADDTIME('2025-01-01 23:59:59', '1:1:1'), ADDTIME('15:00:00', '2:10:10'); -- 출력문 : 2025-01-02 01:01:00 , 17:10:10
SELECT SUBTIME('2025-01-01 23:59:59', '1:1:1'), SUBTIME('15:00:00', '2:10:10'); -- 출력문 : 2025-01-01 22:58:58 , 12:49:50

-- CURDATE(), CURTIME(), NOW(), SYSDATE() // 각각 현재 연-월-일, 현재 시:분:초, NOW()와 SYSDATE()는 현재'연-월-일 시:분:초'를 구한다

-- YEAR(날짜), MONTH(날짜), DAY(날짜), HOUR(시간), MINUTE(시간), SECOND(시간), MICROSECOND(시간) // 각각 날짜 또는 시간에서 연,월,일,시,분,초, 밀리초를 구한다.
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE()); -- 출력문 : 2021,11,22 단, DAYOFMONTH()와 DAY()는 같은함수
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME()), MICROSECOND(CURTIME()); -- 출력문 :21,35,44,0

-- DATE(),TIME() // DATETIME 형식에서 연-월-일 및 시:분:초만 추출한다.
SELECT DATE(NOW()), TIME(NOW()); -- 출력문 : 2021-11-22, 21:37:03
 
-- DATEDIFF(날짜1,날짜2), TIMEDIFF(날짜1 또는 시간1, 날짜11 또는 시간2) // 날짜1-날짜2의 일수를 결과로 구한다. 즉 날짜2에서 날짜1까지 몇 일 남았는지 구한다.
SELECT DATEDIFF('2025-01-01', NOW()), TIMEDIFF('23:23:59', '12:11:10'); -- 출력문 : 1136, 11:12:49

-- DAYOFWEEK(날짜), MONTHNAME(), DAYOFYEAR(날짜) // 요일(1:월, 2:월 ~7:토) 및 1년 중 몇 번째 날짜인지를 구한다.
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE()); -- 출력문 : 2,NOVEMVER,326

-- LAST_DAY(날짜) // 주어진 날짜의 마지막 날짜를 구한다. 주로 그 달이 몇 일 까지 있는지 확인할 때 사용
SELECT LAST_DAY('2025-02-01'); -- 출력문 : 2025-02-28

-- MAKEDATE(연도, 정수) // 연도에서 정수만큼 지난 날짜를 구한다.
SELECT MAKEDATE(2025, 32); -- 출력문 : 2025-02-01 // 2025년의 32일이 지난 날짜

-- MAKETIME(시,분,초) // 시,분,초를 이용해서 '시:분:초'의 time형식을 만든다.
SELECT MAKETIME(12,11,10); -- 출력문 : 12:11:10

-- PERIOD_ADD(연월,개월수), PERIOD_DIFF(연월, 연월2) // PERIOD_ADD()는 연월에서 개월만큼 지난 연월을 구하고 연월은 YYYY 또는 YYYYMM형식 사용, PERIOD_DIFF()는 연월1-연월2 개월수
SELECT PERIOD_ADD(202501, 11), PERIOD_DIFF(202501, 202312); -- 출력문 : 202512, 13

-- QUARTER(날짜) // 날짜가 4분기 중에서 몇 분기인지를 구한다.
SELECT QUARTER('2025-07-07');

-- TIME_TO_SEC(시간) // 시간을 초 단위로 구한다.
SELECT TIME_TO_SEC('12:11:10'); -- 출력문 : 43870
 
 -- 시스템 정보 함수
 --  USER(),DATABASE() // 현재 사용자 및 현재 선택된 데이터베이스를 구한다.
 SELECT CURRENT_USER(), DATABASE(); -- 출력문 : root@localhost , sqldb
 
 -- FOUND_ROWS() // 바로앞의 SELECT문에서 조회된 행의 개수를 구한다.
 USE sqldb;
 SELECT * FROM usertbl;
 SELECT FOUND_ROWS(); -- 출력문 : 10
 
-- ROW_COUNT() // 바로 앞의 INSERT, UPDATE, DELETE문에서 입력, 수정, 삭제된 행의 개수를 구한다. CREATE, DROP문은 0 반환, SELECT문은 -1반환 한다.
USE sqldb;
UPDATE buytbl SET price=price*2;
SELECT ROW_COUNT(); -- 출력문 : 12

-- VERSION() // 현재 MYSQL의 버전을 구한다.

-- SLEEP(초) // 쿼리의 실행을 잠깐 멈춘다.
SELECT SLEEP(5);
SELECT '5초 후에 이게 보여요'; -- 5초 후에 결과가 보인다.
