/* WHILE문은 다른 프로그래밍 언어의 WHILE과 동일한 개념
형식
WHILE <부울 식> DO
	SQL 명령문들 ...
END WHILE;
*/
-- 1~100까지 숫자의 합 구현
DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT;
    DECLARE hap INT;
    SET i = 0;
    SET hap = 0;
	WHILE  (i <=100) DO
		SET hap = hap + i;
        SET i = i+1;
	END WHILE;
    SELECT i, hap;
END $$
DELIMITER ;
call whileProc();

-- 1~100까지 합계에서 7의 배수를 제외시키기 또한 hap이 1000이 넘으면 멈추기
DROP PROCEDURE IF EXISTS whileProc2;
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN 
	DECLARE i INT;
    DECLARE hap INT;
    SET hap = 0;
    SET i = 0;
    myWhile: WHILE (1<=100) DO -- WHILE 문에 label을 지정
    IF (i%7 = 0) THEN 
		SET i = i + 1;
        ELSE
            SET hap = hap + i;
            SET i = i + 1;
        ITERATE myWhile; -- 지정한 label문으로 계속 가서 진행
    END IF;
		IF (hap>1000) THEN
			LEAVE myWhile; -- 지정한 label문을 떠남. 즉, while 종료
	END IF;
	END WHILE;
    SELECT hap;
END $$
DELIMITER ;
CALL whileProc2();

-- Q. 1~1000까지 숫자 중에서 3의 배수 또는 8의 배수만 더하는 스토어드 프로시저 만들어보자
DROP PROCEDURE IF EXISTS whileProc3;
DELIMITER $$
CREATE PROCEDURE whileProc3()
BEGIN
	DECLARE i INT;
    DECLARE hap INT;
    SET i = 1;
    SET hap = 0;
    WHILE (i<=1000) DO
		IF (i%3 = 0) THEN 
			SET hap = hap+i;
        ELSEIF (i%8 = 0) 
			THEN SET hap = hap+i;
		END IF;
        SET i= i+1;
	END WHILE;
    SELECT hap;
END $$
DELIMITER ;
CALL whileProc3();