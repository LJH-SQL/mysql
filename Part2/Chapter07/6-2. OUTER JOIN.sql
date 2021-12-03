/* 
OUTER JOIN
INNER JOIN과 달리 조인의 조건에 만족되지 않는 행까지 포함

형식
SELECT <열 목록>
FROM<첫 번째 테이블 (LEFT 테이블)>
	<LEFT | RIGHT | FULL> OUTER JOIN <두 번째 테이블 (RIGHT 테이블)>
		ON<조인될 조건>
[WHERE 검색조건];
*/

-- 전체회원 구매기록을 보자. 단, 구매 기록이 없는 회워도 출력되어야 한다.
USE sqldb;
SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(mobile1,mobile2) AS '전호번호'
	FROM usertbl U 
		LEFT OUTER JOIN buytbl B -- LEFT OUTER JOIN문의 의미를 왼쪽 테이블(usertbl)의 것은 모두 출력 되어야 한다. 로 기억하자
			ON U.userID = B.userID
	ORDER BY U.userID;

-- INNER JOIN은 우수 회원만 뽑았으나 OUTER JOIN 에서는 유령회원을 뽑아보자
SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(mobile1,mobile2) AS '전호번호'
	FROM usertbl U 
		LEFT OUTER JOIN buytbl B 
			ON U.userID = B.userID
		WHERE B.prodName IS NULL
	ORDER BY U.userID;
    
-- FULL JOIN은 한쪽 기준으로 조건과 일치하지 않는것을 출력하는 것이 아니라, 양쪽 모두에 조건이 일치하지 않은 것을 모두 출력하는 개념이다.
Use sqldb;
CREATE TABLE stdTbl
(	stdName VARCHAR(10) NOT NULL PRIMARY KEY,
	addr	CHAR(4) NOT NULL
);
CREATE TABLE clubTbl
(	clubName VARCHAR(10) NOT NULL PRIMARY KEY,
	roomNo	CHAR(4) NOT NULL
);
CREATE TABLE stdclubTbl
(	num int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	stdName VARCHAR(10) NOT NULL,
    clubName VARCHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdtbl(stdname),
    FOREIGN KEY (clubName) REFERENCES clubtbl(clubName)
);
INSERT INTO stdtbl VALUES ('김범수','경남'), ('성시경','서울'), ('조용필','경기'), ('은지원','경북'), ('바비킴','서울');
--	SELECT DISTINCT name, addr FROM membertbl LIMIT 5;
INSERT INTO clubtbl VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호');
INSERt INTO stdclubtbl VALUES (NULL, '김범수','바둑'), (NULL, '김범수','축구'), (NULL, '조용필','축구'), (NULL, '은지원','축구'), (NULL, '은지원','봉사'), (NULL, '바비킴','봉사');

-- 동아리에 가입하지 않은 학생도 출력되도록 OUTER JOIN 사용
USE sqldb;
SELECT S.stdname, S.addr, C.clubName, C.roomNo
	FROM stdtbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdname = SC.stdName
		LEFT OUTER JOIN clubtbl C
			ON SC.clubname = C.clubName
	ORDER BY S.stdname;

USE sqldb;
SELECT C.clubName, C.roomNo, S.stdName, S.addr
	FROM stdtbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdname = SC.stdname
		RIGHT OUTER JOIN clubtbl C
			ON SC.clubname = C.clubname
	ORDER BY C.clubName;

-- 동아리에서 가입하지 않은 학생도 출력되고 학생이 한 명도 없는 동아리도 출력되게 하자.
SELECT S.stdname, S.addr, C.clubName, C.roomNo
	FROM stdtbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdname = SC.stdName
		LEFT OUTER JOIN clubtbl C
			ON SC.clubname = C.clubName
UNION
SELECT C.clubName, C.roomNo, S.stdName, S.addr
	FROM stdtbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdname = SC.stdname
		RIGHT OUTER JOIN clubtbl C
			ON SC.clubname = C.clubname
