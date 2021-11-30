/* UNION은 두 쿼리의 결과를 행으로 합치는 것으로 말한다.
SELECT 문장1
	UNION [ALL]
SELECT 문장2
대신 SELECT 문장1과 SELECT 문장2 결과 열의 개수가 같아야 한다.
*/
USE sqldb;
SELECT stdName, addr FROM stdtbl
	UNION ALL
SELECT clubName, roomNo FROM clubtbl;

-- NOTIN 첫 번째 쿼리 결과 중에서, 두 번째 쿼리에 해당ㅇ하는 것을 제외하기 위한 구문
SELECT name, CONCAT(mobile1, mobile2) AS '전화번호' FROM usertbl
	WHERE name NOT IN ( SELECT name FROM usertbl WHERE mobile1 IS NULL);
    
-- NOT IN과 반대로 첫 번째 쿼리의 결과 중에서, 두 번째 쿼리에 해당되는 것만 조회하기 위해서 IN을 사용
SELECT name, CONCAT(mobile1, mobile2) AS '전화번호' FROM usertbl
	WHERE name IN ( SELECT name FROM usertbl WHERE mobile1 IS NULL);