/*
인덱스 생성/변경/삭제

인덱스 생성
형식 :
CREATE [UNIQUE | FULLTEXT | SPATIAL] INDEX index_name
	[index_type]
    ON tbl name (key_part,...)
    [index_option]
    [algorithm_option | lock_option]...
    
key_part:
	{col_name [(length)] | (expr)} [ASC | DESC]
    
index_option:
	KEY_BLOCK_SIZE [=] value
    | index_type
    | WITH PARSER parser_name
    | COMMENT 'string'
    | {VISIBLE | INVISIBLE}
    
index_type:
	USING {BTREE | HASH}
    
algorithm_option:
	ALGORITHM [=] {DEFAULT | INPLACE | COPY}

lock_option :
	LOCK [=] {DEFAULT | NONE | SHARED | EXCLUSIVE}

UNIQUE 옵션은 고유한 인덱스를 만들것인지 결정 즉, UNIQUE로 지정된 인덱스는 동일한 데이터 값이 될 수 없다
index_type을 생략하면 기본 값을 B-TREE형식을 사용한다.

인덱스 제거
형식 :
DROP INDEX index_name ON tbl_name
	[algorithm_option | lock_option]...
algorithm_option:
	ALGORITHM [=] {DEFAULT|INPLACE|COPY}
lock_option:
	LOCK [=] {DEFAULT|NONE|SHARED|EXCLUSIVE}
    
실습해보자
*/
Use sqldb;
SELECT * FROM usertbl;
SHOW INDEX FROM usertbl;
SHOW TABLE STATUS LIKE 'usertbl';	-- Data_length는 클러스터형 인덱스의 크기를 byte로 표현, Index_length는 보조 인덱스의 크기인데 usertbl은 보조인덱스가 없어 0이다.
CREATE INDEX idx_usertbl_addr
	ON usertbl (addr);
SHOW INDEX FROM usertbl;	-- Non_unique부분이 1로 설정되어 있으므로 Unique 인덱스가 아니다.
SHOW TABLE STATUS LIKE 'usertbl';	-- 보조인덱스 크기가 여전히 0으로 나온다. 생성한 인덱스를 실제 적용시키려면 ANALYZE TABLE문으로 먼저 테이블을 분석/처리해줘야 한다.
ANALYZE TABLE usertbl;
SHOW TABLE STATUS LIKE 'usertbl';

CREATE UNIQUE INDEX idx_usertbl_birthYear ON usertbl (birthYear); -- Error Code: 1062 Duplicate entry '1979' for key 'idx_usertbl_birthYear' 키값이 중복이여서 오류
CREATE UNIQUE INDEX idx_usertbl_name ON usertbl (name);
SHOW INDEX FROM usertbl;
INSERT INTO usertbl VALUES('GPS', '김범수', 1983, '미국',NULL, NULL, 162, NULL); -- Error Code: 1062 Duplicate entry '김범수' for key 'idx_usertbl_name' 인덱스의 UNIQUE로 인해 중복된 값을 넣을 수 없다.

CREATE INDEX idx_usertbl_name_birthYear ON usertbl (name,birthYear);
DROP INDEX idx_usertbl_name ON usertbl;
SHOW INDEX FROM usertbl; -- seq_in_index열이 1과2로 설정되어 있는 것을 확인할 수 있다. 두 열이 조합된 조건문의 쿼리에도 해당 인덱스가 사용되며 이러한 쿼리가 거의 사용되지 않는다면 이 인덱스는 오히려 MYSQL의 성능에 나쁜 영향을 줄 수 있다.