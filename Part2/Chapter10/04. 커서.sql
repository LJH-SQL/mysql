/*
파일 처리의 작동 개념
1. 파일 포인터는 파일의 제일 시작(BOF:Begin Of file)을 가리킨다.
2. 처음 데이터를 읽고 파일 포인터는 다음으로 이동한다.
3. 파일의 끝(EOFL End Of File)까지 반복한다.
	- 읽은 데이터 처리
	- 현재의 파일 포인터가 가리키는 데이터를 읽는다. 파일 포인터는 자동으로 다음으로 이동한다.

커서의 처리 순서 : 커서의 선언(DECLARE CURSOR) - 반복 조건 선언(DECLARE CONTINUE HANDLER) - 커서열기(OPEN) - 커서에서 데이터 가져오기(FETCH) - 데이터 러치 - 커서 닫기(CLOSE)

*/

-- 커서를 이용해 구매 테이블에서 고객이 구매한 총액에 따라 고객 등급 열을 나누는 프로시저를 작성해보자
ALTER TABLE userTbl ADD grade VARCHAR(5); -- 고객 등급 열 추가
DROP PROCEDURE IF EXISTS gradeProc;
DELIMITER $$
CREATE PROCEDURE gradeProc()
BEGIN
	DECLARE id VARCHAR(10); -- 사용자 아이디를 저장할 변수
    DECLARE hap BIGINT; -- 총 구매액을 저장할 변수
    DECLARE userGrade CHAR(5); -- 고객 등급
    
    DECLARE endOfRow BOOLEAN DEFAULT FALSE;
    
    DECLARE userCuror CURSOR FOR -- 커서 선언
    SELECT U.userid, sum(price*amount) FROM buytbl B RIGHT OUTER JOIN userTbl U ON B.userid = U.userid GROUP BY U.userid, U.name;
	
	DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET endOfRow = TRUE;
        
	OPEN userCuror; -- 커서 열기
    grade_loop: LOOP
		FETCH userCuror INTO id, hap; -- 첫 행 값을 대입
        IF endOfRow THEN
			LEAVE grade_loop;
		END IF;
        
        CASE
			WHEN (hap>= 1500) THEN SET userGrade = '최우수고객';
            WHEN (hap>=1000) THEN SET userGrade = '우수고객';
            WHEN (hap>=1) THEN SET userGrade = '일반고객';
			ELSE SET userGrade = '유령고객';
		END CASE;
        
		UPDATE userTbl SET grade = userGrade WHERE userID = id;
	END LOOP grade_loop;
    
    CLOSE userCuror; -- 커서 닫기
END $$
DELIMITER ;
CALL gradeProc();
SELECT * FROM userTBL;