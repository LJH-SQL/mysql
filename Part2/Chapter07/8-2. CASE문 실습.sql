/* case문 활용하는 SQL 프로그래밍
문제 :
sqldb의 구매테이블에 구매액이 1500 이상인 고객은 '최우수 고객', 1000원 이상인 고객은 '우수고객', 1원 이상인 고객은 '일반고객'으로 출력하자. 
또, 전혀 구매 실적이 없는 고객은 '유령고객'이라고 출력하자.
*/

USE sqlDB;
DROP PROCEDURE IF EXISTS caseProc2;
DELIMITER $$
CREATE PROCEDURE caseProc2()
	BEGIN
		SELECT U.userID AS '아이디', U.name AS '이름', SUM(price*amount) AS '구매액',
        CASE
			WHEN SUM(price*amount) >= 1500 THEN '최우수 등급'
            WHEN SUM(price*amount) >= 1000 THEN '우수 등급'
            WHEN SUM(price*amount) >= 1 THEN '일반 등급'
            ELSE '유령 회원'
		END AS '고객등급'
        FROM buytbl B 
		RIGHT OUTER JOIN usertbl U ON U.userID = B.userID GROUP BY U.userID, U.name ORDER BY SUM(price*amount) DESC;
	END $$
DELIMITER ;
CALL caseProc2();