/*
프로시저 형식
DELIMITER $$
CREATE PROCEDURE 스토어드 프로시저이름()
BEGIN

	이 부분에 SQL 프로그래밍 코딩..
    
END $$
DELIMITER ;
CALL 스토어드 프로시저 이름();

DELIMITER $$ ~~ END $$ 스토어드 프로시저의 코딩할 부분을 묶어주는 부분
CREATE PROCEDURE 안에서도 세미콜론이 종료 문자이므로 어디까지가 스토어드 프로시저인지 구별이 어렵다. 그래서 END $$가 나올 때까지를 스토어드 프로시저로 인식하게 하는 것이다. 
그리고 다시 DELIMITER ; 로 종료 문자를 세미콜론(;)으로 변경해 놓아야 한다.
CALL 스토어드 프로시저이름();은 생성한 프로시저를 호출한다.
*/

/*
IF...ELSE 조건에 따라 분기한다.
한 문장 이상이 처리되어야 할 때는 BEGIN ... END 와 함께 묶어 줘야만 한다. 
형식 :
IF <부울 표현식> THEN
	SQL 문장들1..
ELSE
	SQL 문장들2..
END IF;
*/
DROP PROCEDURE IF EXISTS ifProc; -- 기존에 만든게 있다면 삭제
DELIMITER $$
CREATE PROCEDURE ifProc()
	BEGIN
	DECLARE var1 INT ; -- var1 변수 선언
    SET var1 = 100 ; -- 변수에 값 대입
    
    IF var1 = 100 THEN
		SELECT '100입니다.' ;
	ELSE
		SELECT '100이 아닙니다.' ;
        END IF;
END $$
DELIMITER ;
CALL ifProc();

DROP PROCEDURE IF EXISTS ifProc2;
USE employees;

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE hireDATE DATE;
    DECLARE curDATE DATE;
    DECLARE days INT;
    
    SELECT hire_date INTO hireDATE -- hire_date열의 결과를 hireDATE에 대입
		FROM employees.employees
        WHERE emp_no = 10001;
        
	SET curDATE = CURRENT_DATE();
    SET days = DATEIFF (curDATE, hireDATE); -- 날짜의 차이, 일 단위
    
    IF (days/365) >= 5 THEN -- 5년이 지났다면
			SELECT CONCAT('입사한지',days,'일이나 지났습니다. 축하합니다!');
	ELSE
			SELECT '입사한지' + days + '일밖에 안되었네요. 열심히 일하세요.';
	END IF;
END $$
DELIMITER ;
CALL ifProc2();

-- IF 다중분기
DROP PROCEDURE IF EXISTS ifProc3;
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77;
    IF point >= 90 THEN
		SET credit = 'A';
	ELSEIF point >= 80 THEN
		SET credit = 'B';
	ELSEIF point >= 70 THEN
		SET credit = 'C';
	ELSEIF point >= 60 THEN
		SET credit = 'D';
	ELSE 
		SET credit = 'F';
	END IF;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ; 

-- CASE문
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
	DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77;
    CASE
    WHEN point >= 90 THEN
		SET credit = 'A';
	WHEN point >= 80 THEN
		SET credit = 'B';
	WHEN point >= 70 THEN
		SET credit = 'C';
	WHEN point >= 60 THEN
		SET credit = 'D';
	ELSE 
		SET credit = 'F';
	END CASE;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ; 
-- CASE문의 활용은 SELECT에서 더 많이 사용된다.
