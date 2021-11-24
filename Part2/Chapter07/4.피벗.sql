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

SELECT uName,
	SUM(IF(season='봄', amount, 0)) AS '봄',
    SUM(IF(season='여름', amount, 0)) AS '여름',
    SUM(IF(season='가을', amount, 0)) AS '가을',
    SUM(IF(season='겨울', amount, 0)) AS '겨울',
    SUM(amount) AS '합계' FROM pivotTest GROUP BY uName;
