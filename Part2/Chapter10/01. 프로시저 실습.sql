-- 스토어드 프로시저 실습
USE sqldb;
DROP PROCEDURE IF EXISTS userProc1;
DELIMITER $$
CREATE PROCEDURE userProc1 (IN userName VARCHAR(10))
BEGIN
	SELECT * FROM userTbl WHERE name = userName;
END $$
DELIMITER ;

CALL userProc1('조관우'); -- 11행에서 '조관우'를 입력 매개 변수로 넘기면 4행에서 userName 매게 변수에 대입되고, 6행에서 '조관우'에 대한 조회가 수행된다.

DROP PROCEDURE IF EXISTS userProc2;
DELIMITER $$
CREATE PROCEDURE userProc2(
	IN userBirth INT,
    IN userHeight INT
)
BEGIN
	SELECT * FROM userTbl
		WHERE birthYear > userBirth AND height > userHeight;
END $$
DELIMITER ;
CALL userProc2(1970, 178); -- 1970보다 늦게, 178보다 키가 큰 사람들을 usertbl에서 불러온다.

DROP PROCEDURE IF EXISTS userProc3;
DELIMITER $$
CREATE PROCEDURE userProc3 (
	IN txtValue CHAR(10), 
    OUT outValue INT
)
BEGIN
	INSERT INTO testTbl VALUES(NULL,txtValue);
    SELECT MAX(id) INTO outValue FROM testTBL;
END $$
DELIMITER ; 
-- testTBL이란 테이블이 존재하지 않았지만 오류없이 생성되었다. 즉 실제 테이블이 없어도 스토어드 프로시저는 만들어진다는 의미이다. 단 프로시저를 불러올때는 해당 테이블이 있어야한다.

CREATE TABLE IF NOT EXISTS testTBL(
	id INT AUTO_INCREMENT PRIMARY KEY,
	txt CHAR(10) 
);

CALL userProc3('테스트값', @myValue);
SELECT CONCAT('현재 입력된 ID 값 ==>', @myValue);

-- IF ELSE사용
DROP PROCEDURE IF EXISTS ifelseProc;
DELIMITER $$
CREATE PROCEDURE ifelseProc(
	IN userName VARCHAR(10)
)
BEGIN
	DECLARE bYear INT; -- 변수 선언
    SELECT birthYear into bYear FROM userTbl
		WHERE name = userName;
	IF (bYear >= 1980 ) THEN
		SELECT '아직 젊군요';
	ELSE
		SELECT '나이가 지긋하시네요';
	END IF;
END $$
DELIMITER ;

CALL ifelseProc ('조용필');

-- CASE문 사용
DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc(
	IN userName VARCHAR(10)
)
BEGIN
	DECLARE bYear INT;
    DECLARE tti CHAR(3);-- 띠
    SELECT birthYear INTO bYear FROM usertbl
		WHERE name = userName;
	CASE
		WHEN (bYear%12 = 0) THEN SET tti = '원숭이';
        WHEN (bYear%12 = 1) THEN SET tti = '닭';
        WHEN (bYear%12 = 2) THEN SET tti = '개';
        WHEN (bYear%12 = 3) THEN SET tti = '돼지';
        WHEN (bYear%12 = 4) THEN SET tti = '쥐';
        WHEN (bYear%12 = 5) THEN SET tti = '소';
        WHEN (bYear%12 = 6) THEN SET tti = '호랑이';
        WHEN (bYear%12 = 7) THEN SET tti = '토끼';
        WHEN (bYear%12 = 8) THEN SET tti = '용';
        WHEN (bYear%12 = 9) THEN SET tti = '뱀';
        WHEN (bYear%12 = 10) THEN SET tti = '말';
        ELSE SET tti = '양';
        END CASE;
        SELECT CONCAT(userName, '의 띠 ==>', tti);
END $$
DELIMITER ;

CALL caseProc('김범수'); -- 호출한 사람의 띠를 알려주는 스토어드 프로시저
        
        
