/*트리거
트리거는 스토어드 프로시저와 거의 비슷한 문법으로 그 내용을 작성 할 수 있따. 그리고, 트리거가 부착된 테이블에 이벤트(입력,수정,삭제)가 발생하면 자동으로 부착된 트리거가 실행된다.
트리거는 슺토어드 프로시저와 작동이 비슷하지만 직접 실행시킬 수는 없고 오직 해당 테이블에 이벤트가 발생하는 경우에만 실행된다.
또한 프로시저와 달리 IN,OUT 매개변수를 사용할 수 없다.
*/
-- 예시
CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
CREATE TABLE IF NOT EXISTS testTbl (id INT, txt VARCHAR(10));
INSERT INTO testTbl VALUES(1,'레드벨벳');
INSERT INTO testTbl VALUES(2,'잇지');
INSERT INTO testTbl VALUES(3,'블랙핑크');

DROP TRIGGER IF EXISTS testTrg;
DELIMITER //
CREATE TRIGGER testTrg
	AFTER DELETE
    ON testTbl
    FOR EACH ROW -- 각 행마다 적용
BEGIN
	SET @msg = '가수 그룹이 삭제된' ; -- 트리거 실행 시 작동되는 코드들
END //
DELIMITER ;

SET @msg = '';
INSERT INTO testTbl VALUES(4,'마마무');
SELECT @msg;
UPDATE TestTbl SET txt = '블핑' WHERE id = 3;
SELECT @msg;
DELETE FROM testTbl WHERE id = 4;
SELECT @msg;
-- INSERT, UPDATE가 수행되어도 @msg는 바뀌지 않지만 DELETE가 실행되었을 때 @msg 값이 바뀌는것을 볼 수 있다.