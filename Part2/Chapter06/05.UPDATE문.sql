/*
기존에 입력되어 있는 값을 변경하기 위해서는 UPDATE문을 다음과 같은 형식으로 사용
UPDATE 테이블 이름
	SET 열1=값1, 열2=값2 ...
    WHERE 조건 ;
*/
UPDATE testTbl4
	SET Lname = '없음'
    WHERE Fname = 'Kyoichi';
-- 결과값 : 251rows affected Rows matched

USE sqldb;
UPDATE buytbl SET price = price * 1.5; -- 단가가 1.5배 인상하였다면 다음과 같이 사용 할 수 있다.

/*
DELETE FROM
DELETE문 형식 : DELETE FROM 테이블 이름 WHERE 조건 ;
만약 WHERE 문이 생략되면 전체 데이터를 삭제한다.
*/
USE sqldb;
DELETE FROM testTbl4 WHERE Fname = 'Aamer'; -- 'Aamer'라는 이름의 사용자를 삭제(해당테이블에 200명 넘게 있음)
DELETE FROM testTbl4 WHERE Fname = 'Aamer' LIMIT 5; -- 상위 5건만 삭제

-- 대용량의 테이블을 삭제
USE sqldb;
CREATE TABLE bigTbl1 (SELECT * FROM employees.employees); -- 테이블 복사
CREATE TABLE bigTbl2 (SELECT * FROM employees.employees);
CREATE TABLE bigTbl3 (SELECT * FROM employees.employees);
DELETE FROM bigTbl1; -- 트랜잭션 로그를 기록하는 작업 때문에 삭제가 오래 걸린다. 수백, 수천 만 건의 데이터를 삭제할 경우 한참걸릴 수 있다.
DROP TABLE bigTbl2; -- DDL은 트랜잭션 로그를 기록하지 ㅇ낳아서 속도가 매우 빠르다. 따라서 DROP,TRUNCATE는 매우 속도가 빠르고 DROP문은 테이블 자체를 삭제한다.
TRUNCATE TABLE bigTbl3; -- TRUNCATE는 DELETE와 동일하지만 트랜잭션 로그를 기록하지 않아 속도가 빠르고 테이블 구조를 남겨놓고 싶다면 TRUNCATE로 삭제하는게 효율적이다.

-- 조건부 데이터 입력, 변경
USE sqldb;
CREATE TABLE memberTBL (SELECT userID, name, addr FROM usertbl LIMIT 3); -- 3건만 가져옴
ALTER TABLE memberTBL
	ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID); -- PK를 지정함
SELECT * FROM memberTBL;

/*
INSERT INTO memberTBL VALUES('BBK','비비코','미국');
INSERT INTO memberTBL VALUES('SJH','서장훈','미국');
INSERT INTO memberTBL VALUES('HJY','현주엽','미국');
SELECT * FROM memberTBL;
BBK의 PK가 오류나서 아래가 실행되지 않는다.
*/

INSERT IGNORE INTO memberTBL VALUES('BBK','비비코','미국');
INSERT IGNORE INTO memberTBL VALUES('SJH','서장훈','미국');
INSERT IGNORE INTO memberTBL VALUES('HJY','현주엽','미국');
SELECT * FROM memberTBL;
-- 첫번째 데이터는 오류때문에 들어가지 않았지만 나머지 2개는 들어갔다. IGNORE는 PK 중복이더라도 어류를 발생시키지 않고 무시하고 넘어간다.

INSERT INTO memberTBL VALUES('BBK','비비코','미국') ON DUPLICATE KEY UPDATE name = '비비코', addr='미국';
INSERT INTO memberTBL VALUES('DJM','동짜몽','일본') ON DUPLICATE KEY UPDATE name = '동짜몽', addr='일본';
SELECT * FROM memberTBL;
-- 첫번째에서 BBK가 중복이므로 UPDATE문이 수행되었다

