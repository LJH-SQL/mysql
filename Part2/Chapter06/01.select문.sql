USE employees; 
-- 두 쿼리는 같은 쿼리
SELECT * FROM employees.titles;
SELECT * FROM titles;
-- 사원의 이름만 불러오기
SELECT first_name From employees;
-- 여러개의 열 가져오기
SELECT first_name, last_name, gende FROM employees;

-- 데이터베이스 이름, 테이블 이름, 필드 이름이 정확히 기억나지 않거나 또는 각 이름의 철자가 확실하지 않을 때 찾아서 조회하는 방법
SHOW DATABASES; -- 데이터베이스 이름 조회
USE employees; -- 데이터베이스 지정
SHOW TABLE STATUS; -- 테이블의 정보를 조회
DESCRIBE employees; -- 출력문으로 열 이름을 조회할 수 있다.
SELECT 
    first_name, gender
FROM
    employees; -- 최종적으로 데이터 조회

/* 이후 사용할 DB 만들기
DROP DATABASE IF EXISTS sqldb;
CREATE DATABASE sqldb;
USE sqldb;
CREATE TABLE usertbl 
(	userId	CHAR(8) NOT NULL PRIMARY KEY,
	name	VARCHAR(10) NOT NULL,
	birthYear	INT NOT NULL,
    addr	CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height	SMALLINT,
    mDate	DATE
);
CREATE TABLE buytbl
(	num	INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	useRID	CHAR(8) NOT NULL,
    prodName	CHAR(6) NOT NULL,
    groupName	CHAR(4),
    price	INT NOT NULL,
    amount	SMALLINT NOT NULL,
    FOREIGN KEY (userID) REFERENCES usertbl(userID)
);
-- 값넣기
INSERT INTO usertbl VALUES('LSH','이승기',1987,'서울','011','1111111',182,'2008-8-8');
INSERT INTO usertbl VALUES('KBS','김범수',1979,'경남','011','2222222',173,'2012-4-4');
INSERT INTO usertbl VALUES('KKH','김경호',1971,'전남','019','3333333',177,'2007-7-7');
INSERT INTO usertbl VALUES('JYP','조용필',1950,'경기','011','4444444',166,'2009-4-4');
INSERT INTO usertbl VALUES('SSK','성시경',1979,'서울',NULL	,NULL,186,'2013-12-12');
INSERT INTO usertbl VALUES('LJB','임재범',1963,'서울','016','6666666',182,'2009-9-9');
INSERT INTO usertbl VALUES('YJS','윤종신',1969,'경남',NULL,NULL,170,'2005-5-5');
INSERT INTO usertbl VALUES('EJW','은지원',1972,'경북','011','8888888',174,'2014-3-3');
INSERT INTO usertbl VALUES('JKW','조관우',1965,'경기','018','9999999',172,'2010-10-10');
INSERT INTO usertbl VALUES('BBK','바비킴',1973,'서울','010','0000000',176,'2013-5-5');
INSERT INTO buytbl VALUES(NULL,'KBS','운동화',NULL,30,2);
INSERT INTO buytbl VALUES(NULL,'KBS','노트북','전자',1000,1);
INSERT INTO buytbl VALUES(NULL,'JYP','모니터','전자',200,1);
INSERT INTO buytbl VALUES(NULL,'BBK','모니터','전자',200,5);
INSERT INTO buytbl VALUES(NULL,'KBS','청바지','의류',50,3);
INSERT INTO buytbl VALUES(NULL,'BBK','메모리','전자',80,10);
INSERT INTO buytbl VALUES(NULL,'SSK','책','서적',15,5);
INSERT INTO buytbl VALUES(NULL,'EJW','책','서적',15,2);
INSERT INTO buytbl VALUES(NULL,'EJW','청바지','의류',50,1);
INSERT INTO buytbl VALUES(NULL,'BBK','운동화',NULL,30,2);
INSERT INTO buytbl VALUES(NULL,'EJW','책','서적',15,1);
INSERT INTO buytbl VALUES(NULL,'BBK','운동화',NULL,30,2);

SELECT * FROM usertbl;
SELECT * FROM buytbl;
*/
