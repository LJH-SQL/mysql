-- While문 활용하여 구구단 만들기
DROP PROCEDURE IF EXISTS whileProc;
CREATE TABLE guguTBL (txt VARCHAR(100)); -- 구구단 저장용 테이블

DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE str VARCHAR(100); -- 각 단을 문자열로 저장
    DECLARE i INT;	-- 구구단 앞자리
    DECLARE k INT;	-- 구구단 뒷자리
    SET i = 2;
    
    WHILE (i<10) DO -- 바깥 반복문 , 2~9단까지
    SET str = ''; -- 각 단의 결과 저장할 문자열 초기화
    SET k = 1; -- 구구단 뒷자리는 항상 1부터 9까지
		WHILE (k < 10) DO
			SET str = CONCAT(str, ' ', i, 'x', k ,'=', i*k );
			SET k = k+1;
		END WHILE;
    SET i= i+1 ;
    INSERT INTO guguTBL VALUES (str);
    END WHILE;
END $$
DELIMITER ;

CALL whileProc();
SELECT * FROM guguTBL; -- 구구단이 실행된다.

-- DECLARE ~~ HANDLER를 이용해서 무한루프 오버플로 오류 처리를 해보자
DROP PROCEDURE IF EXISTS errorProc;

DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE i INT ;
    DECLARE hap INT ;
    DECLARE saveHap INT ;

    DECLARE EXIT HANDLER FOR 1264 -- INT형 오버플로가 발생하면 이 부분을 수행
    BEGIN
		SELECT CONCAT('INT 오버플로 직전의 합계 --> ', saveHap);
        SELECT CONCAT('1+2+3+4+...+',i,'=오버플로');
	END ;
    SET i = 1 ;
    SET hap = 0 ;    
    WHILE (TRUE) DO
		SET saveHap = hap;
		SET hap = hap + i;
        SET i = i+1;
	END WHILE;
END $$
DELIMITER ;

CALL errorProc(); -- 출력문 : INT 오버플로 직전의 합계 --> 2147450880, 1+2+3+4+...+65536=오버플로

-- 현재 저장된 프로시저의 이름 및 내용을 확인하기
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_schema = 'sqldb' AND routine_type = 'PROCEDURE'; -- 프로시저 정보
SELECT parameter_mode, parameter_name, dtd_identifier
	FROM INFORMATION_SCHEMA.PARAMETERS WHERE specific_name = 'userProc3'; -- 프로시저의 파라미터를 확인
SHOW CREATE PROCEDURE sqldb.userProc3; -- CREATE PROCEDURE의 값에 우클릭 후 Open Value in Viewer로 쿼리문 확인 가능


-- 직접 입력 파라미터로 테이블 이름 전달
USE sqldb;
DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
	IN tblName VARCHAR(20)
)
BEGIN
	SELECT * FROM tblName;
END $$
DELIMITER ;
CALL nameProc ('userTBL'); -- sqldb.tblname이라는 테이블을 알 수 없다는 오류 발생. 즉 MySQL에서는 직접 테이블 이름을 파라미터로 사용할 수 없다.

-- 동적 SQL 활용하기
DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
	IN tblName VARCHAR(20)
)
BEGIN
	SET @sqlQuery = CONCAT('SELECT * FROM ', tblName); -- 'SELECT * FROM tblName' 이런식으로 적으면 위와 같은 오류 발생
    PREPARE myQuery FROM @sqlQuery; -- 실행할 명령문 준비
    EXECUTE myQuery;				-- 준비된 명령문 실행
    DEALLOCATE PREPARE myQuery;		-- 이전에 준비된 SQL 문의 할당 취소에 사용
END $$
DELIMITER ;
CALL nameProc ('userTBL');