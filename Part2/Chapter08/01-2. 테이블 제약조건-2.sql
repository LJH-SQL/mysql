/*
UNIQUE제약 조건
'중복되지 않는 유일한 값'을 입력해야 하는 조건으로 PRIMARY KEY와 비슷하나 UNIQUE는 NULL값을 허용한다. 회원 테이블의 예로 든다면 주로 Email주소를 Unique로 설정하는 경우 많다.
*/
USE tableDB;
DROP TABLE IF EXISTS buyTBL, userTBL;
CREATE TABLE userTBL
(	userID CHAR(8) NOT NULL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    email CHAR(30) NULL UNIQUE
);
DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL
(	userID CHAR(8) NOT NULL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    email CHAR(30) NULL ,
    CONSTRAINT AK_email UNIQUE (email)
);
-- 위의 두 경우는 동일한 결과를 나타내며 2번째는 정의가 끝난 상태에서 Unique 제약 조건을 추가한 것이다.

/* 
CHECK 제약 조건
입력되는 데이터를 점검하는 기능 - 키에 마이너스 값이 들어올 수 없게 한다던지 출생년도가 1900년 이후 현재 시점 이전이어야 한다는 등의 조건을 지정한다
*/
DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL
(	userID CHAR(8) PRIMARY KEY,
	name VARCHAR(10) ,
    birthYear INT CHECK (birthYear >= 1900 AND birthYear <= 2023), -- 출생년도의 제약
    mobile1 CHAR(3) NULL,
    CONSTRAINT CK_name CHECK (name IS NOT NULL) -- 마지막 제약 추가하는 문으로 NULL값 못들어 오도록 하였다
);
ALTER TABLE userTBL
	ADD CONSTRAINT CK_mobile1
    CHECK (mobile1 IN ('010','011','016','017','018','019')); -- 필요시 ALTER TABLE문으로 제약 조건 추가 가능
    
/*
DEFAULT 정의 
DEFAULT는 값을 입력하지 않았을 때, 자동으로 입력되는 기본 값을 정의하는 방법이다.
*/
DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL
(	userID CHAR(8) PRIMARY KEY,
	name VARCHAR(10) ,
    birthYear INT NOT NULL DEFAULT -1,
    addr CHAR(2) NOT NULL DEFAULT '서울',
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL DEFAULT 170,
    mDate DATE NULL
);
ALTER TABLE userTBL ALTER COLUMN addr SET DEFAULT '인천'; -- DEFAULT값 변경
INSERT INTO usertbl VALUES ('LHL','이혜리',DEFAULT,DEFAULT,'011','1234567',DEFAULT,'2023.12.12');
SELECT * FROM userTBL; -- 출력문 : LHL	이혜리	-1	인천	011	1234567	170	2023-12-12 
							