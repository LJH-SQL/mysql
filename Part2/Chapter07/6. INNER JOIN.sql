/*
JOIN문
조인이란 두 개 이상의 테이블을 서로 묶어서 하나의 결과 집합으로 만드러 내는 것을 말한다.
1대다 관계는 많은 현실의 업무에서 발견할 수 있따. 회사원 테이블과 급영 테이블도 마찬가지이다.
*/

/*
INNER JOIN (=JOIN)
조인 중 가장 많이 사용되는 조인으로 일반저긍로 JOIN이라고 얘기하는 것이 INNER JOIN이다.

SELECT <열목록>
FROM <첫 번째 테이블>
		INNER JOIN<두 번째 테이블>
        ON <조인될 조건>
[WHERE 검색조건]
이 형식에서 INNER JOIN을 JOINㅣㅇ라고만 써도 된다.
*/


-- 구매 테이블 중에서 JYP라는 아이디를 가진 사람이 구매한 물건을 발송하기 위해서 조인해서 검색
USE sqldb;
SELECT *
	FROM buytbl
		INNER JOIN usertbl
			ON buytbl.userID = usertbl.userID
	WHERE buytbl.userID = 'JYP';
/* 
출력문 : 	num	useRID	prodName	groupName	price	amount	userId	name	birthYear	addr	mobile1	mobile2	height	mDate
		3	JYP		모니터		전자			600		1		JYP		조용필	1950		경기		011		4444444	166		2009-04-04
ON 구문과 WHERE 구문에는 '테이블이름.열 이름'의 형식으로 되어 있다. 이우는 두 개의 테이블에 동일한 열 이름이 모두 존재하기 때문
*/

SELECT userId, name, prodName, addr, CONCAT(mobile1, mobile2) AS '연락처' FROM buytbl
	INNER JOIN usertbl
		ON buytbl.userID = usertbl.userID
	ORDER BY num; -- 출력문 : Error Code : 1052. Column userID in field list i ambiguous -> SELECT 뒤에 오는 userID가 어느 테이블의 것인지 명확하지 않아 오류
    
SELECT buytbl.userId, name, prodName, addr, CONCAT(mobile1, mobile2) AS '연락처' 
	FROM buytbl
		INNER JOIN usertbl
			ON buytbl.userID = usertbl.userID
		ORDER BY num;
-- 해당코드는 너무 길어져 복잡해 보인다. 이를 간편하기 위해서 각 테이블에 별칭을 줄 수 있다.

SELECT B.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
	FROM buytbl B
		INNER JOIN usertbl U
			ON B.userID = U.userID
		WHERE B.userID = 'JYP'; -- 출력문 : JYP	조용필	모니터	경기	0114444444

-- 전체 회원들이 구매한 목록 모두 출력
SELECT B.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1,U.mobile2) AS '연락처'
	FROM usertbl U
		INNER JOIN buytbl B
			ON U.userID = B.userID
		ORDER BY U.userID;

-- 쇼핑몰에서 한번이라도 구매한 기록이 있는 우수회원 찾기
SELECT DISTINCT U.userID, U.name, U.addr
	FROM usertbl U
		INNER JOIN buytbl B
			ON U.userID = B.userID
		ORDER BY U.userID;

-- EXISTS문을 사용해서도 동일한 결과 낼 수 있다.
SELECT U.userID, U.name, U.addr
	FROM usertbl U
		WHERE EXISTS(
			SELECT * FROM buytbl B
            WHERE U.userID = B.userID
        )
        