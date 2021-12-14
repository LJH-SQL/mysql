-- 테이블에 존재하는 많은 행의 데이터를 구분할 수 있는 식별자를 '기본 키'라고 부른다.
CREATE DATABASE tableDB;
USE tableDB;
DROP TABLE IF EXISTS buytbl, usertbl;
CREATE TABLE userTBL
( 	userID CHAR(8) NOT NULL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL
);
DESCRIBE usertbl; -- 테이블 정보 보기

DROP TABLE IF EXISTS usertbl;
CREATE TABLE userTBL
(	userID CHAR(8) NOT NULL,
	name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    CONSTRAINT PRIMARY KEY PK_userTBL_userID (userID)
);

-- 제약 조건을 수정하는 방법 ALTER TABLE 
ALTER TABLE usertbl -- usertbl을 변경
	ADD CONSTRAINT PK_userTBL_userID -- 제약 조건 추가, 추가할 제약 조건 이름은 'PK_usertbl_userID'이다.
		PRIMARY KEY (userID); -- 추가학 제약 조건은 기본 키 제약 조건이다. 그리고 제약 조건을 설정할 열은 userID이다.
        
DROP TABLE IF EXISTS prodTbl;
CREATE TABLE prodTbl
(	prodCode CHAR(3) NOT NULL,
	prodID CHAR(4) NOT NULL,
    prodDate DATETIME NOT NULL,
    prodCur CHAR(10) NULL
);

ALTER TABLE prodTbl
	ADD CONSTRAINT PK_prodTbl_prodCode_prodID
		PRIMARY KEY (prodCode, prodID); -- 제품코드+제품일련번호가 기본키
SHOW INDEX FROM prodTbl;

-- 외래키 제약조건
DROP TABLE IF EXISTS buyTBL, userTBL;
CREATE TABLE userTBL
(	userID CHAR(8) NOT NULL PRIMARY KEY,
	name VARCHAR(19) NOT NULL,
	birthYear INT NOT NULL
);
CREATE TABLE buyTBL
(	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	userID CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL,
    FOREIGN KEY(userID) REFERENCES userTBL(userID)
); -- 만약, 기준 테이블이 PRIMARY KEY 또는 UNIQUE가 아니라면 외래 키 관계는 설정되지 않는다.

DROP TABLE IF EXISTS buyTBL;
CREATE TABLE buyTBL
(	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY	,
	userID	CHAR(8)	NOT NULL,
    prodName CHAR(6) NOT NULL,
    CONSTRAINT FK_uerTBL_buyTBL FOREIGN KEY(userID) REFERENCES userTBL(userID)
); -- 외래키 직접 설정

/*
외래키 옵션 중 ON DELETE CASCADE 또는 ON UPDATE CASCADE가 있는데 이는 기준 테이블의 데이터가 변경되었을 때 외래 키 테이블도 자동으로 적용되도록 설정
별도로 지정하지 않으면 ON UPDATE NO ACITION 및 ON DELETE NO ACTION과 동일한데 회원 테이블의 회원 아이디가 변경되어도 아무런 일이 일어나지 않는다는 의미이다.
*/
-- ex)
ALTER TABLE buytbl
	DROP FOREIGN KEY FK_usertbl_buytbl; -- 외래 키 제거
ALTER TABLE buytbl
	ADD CONSTRAINT FK_usertbl_buytbl
    FOREIGN KEY (userID)
    REFERENCES usertbl (userID)
    ON UPDATE CASCADE; -- 예로 회원 테이블의 김범수의 ID인 KBS가 KIM으로 변경될 경우에, 구매 테이블의 KBS도 KIM으로 자동 변경된다.
    
