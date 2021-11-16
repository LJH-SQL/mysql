/*WITH절과 CTE (Common Table Expression)
WITH절은 CTE를 표현하기 위한 구문으로 MySQL 8.0 이후부터 사용할 수 있다.
CTE는 기존의 뷰, 파생 테이블, 임시 테이블 등으로 사용되던것을 대신할 수 있다. 
CTE는 비재귀젹CTE와 재귀적CTE가 있다.
비재귀적 CTE
비재귀적 CTE는 복잡한 쿼리문장을 단수화 시키는데에 적합

양식
WITH CTE_테이블이름(열 이름)
AS
(
	<쿼리문>
)
SELECT 열 이름 FROM CTE_테이블이름 ;
*/

USE sqlDB;
SELECT userid AS '사용자', SUM(price*amount) AS '총구매액' FROM buyTBL GROUP BY userid order by '총구매액' DESC; -- 이 결과를 총 구매액이 많은 순으로 정렬

WITH abc(userid, total)
AS
(SELECT userid, SUM(price*amount) FROM buytbl GROUP BY userid)
SELECT * FROM abc ORDER BY total DESC; -- 여기서 abc는 실존하지 않는 테이블이 아니라 WITH구문으로 만든 SELECT의 결과이다.

-- 회원 테이블에서 각 지역별로 가장 큰 키를 1명씩 뽑은 후에, 그 사람들 키의 평균 내기
SELECT addr, MAX(height) FROM usertbl GROUP BY addr; -- 각 지역별로 가장 큰 키 뽑는 쿼리
WITH cte_userTBL(addr, maxHegiht) AS (SELECT addr, MAX(height) FROM usertbl GROUP by addr)
	SELECT AVG(maxHegiht*1.0 /*실수변환*/) AS '각 지역별 최고키의 평균' FROM CTE_userTBL;

/*
WITH
AAA (컬럼들)
AS ( AAA의 쿼리문),
	BBB (컬럼들)
		AS ( BBB의 쿼리문),
	CCC (컬럼들)
		AS ( CCC의 쿼리문)
SELECT * FROM [AAA 또는 BBB 또는 CCC]
CTE는 위와같이 중복 CTE가 가능하다
하지만 주의할 점은 CCC의 쿼리문에서는 AAA나 BBB를 참조할 수 있찌만, AAA의 쿼리문이나 BBB쿼리문에서 CCC를 참조할 수 없다.
*/