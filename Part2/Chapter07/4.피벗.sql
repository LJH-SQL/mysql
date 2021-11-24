/*
피벗 : 한 열에 포함된 여러 값을 출력하고, 이를 여러 열로 변환하여 테이블 반환 식을 회전하고 필요하면 집계까지 수행하는 것을 말한다.
*/
USE sqldb;
CREATE TABLE pivotTest
	( uName CHAR(3),
	season CHAR(2),
    amount INT );

INSERT INTO pivotTest VALUES ('김범수','겨울',10), ('윤종신','여름',15), ('김범수','가을',25),('김범수','봄',3),('김범수','봄',37),('윤종신','겨울',40),('김범수','여름',14),
('김범수','겨울',22), ('윤종신','여름',64);
SELECT * FROM pivotTest;
/*출력문
	uName	season	amount
	김범수	겨울		10
	윤종신	여름		15
	김범수	가을		25
	김범수	봄		3
	김범수	봄		37
	윤종신	겨울		40
	김범수	여름		14
	김범수	겨울		22
	윤종신	여름		64
*/

SELECT uName,
	SUM(IF(season='봄', amount, 0)) AS '봄',
    SUM(IF(season='여름', amount, 0)) AS '여름',
    SUM(IF(season='가을', amount, 0)) AS '가을',
    SUM(IF(season='겨울', amount, 0)) AS '겨울',
    SUM(amount) AS '합계' FROM pivotTest GROUP BY uName; 
/*출력문
uName	봄	여름	가을	겨울	합계
김범수	40	14	25	32	111
윤종신	0	79	0	40	119
*/


/*퀴즈
	season	김범수	윤종신	합계
	가을		25		0		25
	봄		40		0		40
	겨울		32		40		72
	여름		14		79		93
    위 출력문을 뽑아보시오
*/
SELECT season,
	SUM(IF(uname='김범수',amount,0)) AS '김범수',
    SUM(IF(uname='윤종신',amount,0)) AS '윤종신',
    SUM(amount) AS '합계'  FROM pivotTest GROUP BY season ORDER BY 합계 ASC;