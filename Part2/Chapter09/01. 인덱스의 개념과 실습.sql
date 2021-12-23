/*
지금까지 사용한 테이블은 인덱스를 별로 고려하지 않았다. 즉 예를들면 책에서 <찾아보기>가 없는것돠 마찬가지의 테이블을 사용해왔다.
그럼에도 문제가 되지 않는 이유는 데이터의 양이 적어서이기 때문이다. 하지만 데이터가 점점 늘어나고 대용량의 테이블이 될 경우에는ALTER데이터를 좀 더 빠르게 찾을 수 있도록 하는 인덱스를 필요로 한다.
인덱스의 단점은 필요 업슨 인덱스를 만드는 바람에 데이터베이스가 차지하는 공간만 늘어나고 데이터를 찾는것이 전체 테이블을 차즌ㄴ 것보다 느려질 수 있다.
장단점을 정리하자면
장점 :
- 검색은 속도가 무척 빨라질 수 있다.
- 그 결과 해당 쿼리의 부하가 줄어들어 결국 시스템 전체의 성능이 향상된다.
단점 :
- 인덱스가 데이터베이스 공간을 차지해서 추가적인 공간이 필요해지는데, 대략 데이터베이스 크기의 10% 정도의 추가 공간이 필요
- 처음 인덱스를 생성하는데 시간이 많이 소요될 수 있다.
- 데이터의 변경 작업이 자주 일어날 경우에는 오히려 성능이 많이 나빠질 수 있다.
이 이외에도 예외적인 상황이 있고 결국 잘 사용하면 검색속도가 월등히 빨라지고, 잘못 사용하면 사용하는것보다 못한 나쁜 결과를 초래할 수 있다.

인덱스의 종류
클러스터형 인덱스, 보조 인덱스로 나뉜다.
클러스터형 인덱스는 영어사전처럼 책의 내용 자체가 순서대로 정렬되어 있고
보조 인덱스는 <찾아보기>를 찾은 후 그 옆에 표시된 페이지로 가야 실제 찾는 내용이 있는것과 같다.

인덱스는 열당 기본적으로 하나의 인덱스를 생성 할 수 있다.
단 클러스터형 인덱스는 테이블당 한 개만 생성할 수 있다.
CREATE TABLE usertbl
(	userID CHAR(8) NOT NULL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    ...
    );
PRIMARY KEY 또는 UNIQUE를 사용하면 자동으로 인덱스가 생성된다
*/

-- 제약 조건으로 자동 생성되는 인덱스를 확인해 보자
USE sqldb;
CREATE TABLE tbl1
(	a INT PRIMARY KEY,
	b INT,
    c INT
);
SHOW INDEX FROM tbl1; -- a열에 유일한 인덱스가 생성되어 있는것을 확인 가능하고 Key_name이 PRIMARY로 된 것은 클러스터형 인덱스를 의미

CREATE TABLE tbl2
(	a INT PRIMARY KEY,
	b INT UNIQUE,
    c INT UNIQUE,
    d INT
);
SHOW INDEX FROM tbl2; -- UNIQUE 제약 조건으로 설정하면 보조 인덱스가 자동으로 생성되는 것을 확인 할 수 있다.

CREATE TABLE tbl3
(	a INT UNIQUE,
	b INT UNIQUE,
    c INT UNIQUE,
    d INT
);
SHOW INDEX FROM tbl3; -- UNIQUE 열이 모두 보조 인덱스로 지정 되었다.

CREATE TABLE tbl4
(	a INT UNIQUE NOT NULL,
	b INT UNIQUE,
    c INT UNIQUE,
    d INT
);
SHOW INDEX FROM tbl4; -- UNIQUE에 NOT NULL이 포함되면 클러스터형 인덱스로 지정된다.

CREATE TABLE tbl5
(	a INT UNIQUE NOT NULL,
	b INT UNIQUE,
    c INT UNIQUE,
    d INT PRIMARY KEY
);
SHOW INDEX FROM tbl5; -- d열에 클러스터형 인덱스가 생성되고 a열에는 보조 인덱스가 생성된다.

CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl
(	userID	CHAR(8) NOT NULL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr NCHAR(2) NOT NULL
);
INSERT INTO usertbl VALUES('LSG','이승기',1987,'서울');
INSERT INTO usertbl VALUES('KBS','김범수',1979,'경남');
INSERT INTO usertbl VALUES('KKH','김경호',1971,'전남');
INSERT INTO usertbl VALUES('JYP','조용필',1950,'경기');
INSERT INTO usertbl VALUES('SSK','성시경',1979,'서울');
SELECT * FROM usertbl;
/* 출력
JYP	조용필	1950	경기
KBS	김범수	1979	경남
KKH	김경호	1971	전남
LSG	이승기	1987	서울
SSK	성시경	1979	서울
*/

ALTER TABLE usertbl DROP PRIMARY KEY;
ALTER TABLE usertbl
	ADD CONSTRAINT pk_name PRIMARY KEY(name);
SELECT * FROM usertbl; -- 기본키를 바꾼 후 출력문
/*
KKH	김경호	1971	전남
KBS	김범수	1979	경남
SSK	성시경	1979	서울
LSG	이승기	1987	서울
JYP	조용필	1950	경기
출력문의 순서가 name 열 순으로 정렬되어있는것을 볼 수 있다.

위의 실습들을 통해서 결론을 내자면
- PRIMARY KEY로 지정한 열은 클러스터형 인덱스가 생성된다.
- UNIQUE NOT NULL로 지정핞 열은 클러스터형 인덱스가 생성된다.
- UNIQUE로 지정한 열은 보조 인덱스가 생서된다
- PRIMARY KEY와 UNIQUE NOT NULL이 있으면 PRIMARY KEY로 지정한 열에 우선 클러스터형 인덱스가 생성된다.
- PRIMARY KEY로 지정ㅎ안 열로 데이터가 오름차순 정렬된다.
*/

