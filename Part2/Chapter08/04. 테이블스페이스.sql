/*
테이블스페이스
데이터베이스가 테이블이 저장되는 논리적 공간이라면, 테이블스페이스는 테이블이 실제로 저장되는 물리적인 공간
대용량 테이블을 동시에 여러개 사용하는 상황이라면 테이블마다 별도의 테이블스페이스엥 저장하는 것이 성능에 효과적이다.
시스템 테이블스페이스에 대한 정보는 시스템 변수 innoddb_data_file_pathㅇ[ 관련 내용이 저장되어있다
*/
SHOW VARIABLES LIKE 'innodb_data_file_path'; -- VALUE : ibdata1:12M:autoextend 라 나오는데 기본적으로 파일은ibdata1, 파일크기는 12MB, 최대 파일크기는 허용하는 최대값까지 자동 증가를 뜻함

-- 실습
SHOW VARIABLES LIKE 'innodb_file_per_table'; -- 각 테이블이 별도의 테이블스페이스에 저정되도록 시스템변수가 ON으로 설정되어 있어야 한다. // 출력값  : value : ON

CREATE TABLESPACE ts_a ADD DATAFILE 'ts_a ibd';
CREATE TABLESPACE ts_b ADD DATAFILE 'ts_b.ibd';
CREATE TABLESPACE ts_c ADD DATAFILE 'ts_c.ibd'; -- 테이블 스페이스 생성 ts_c.ibd는 파일이름

USE sqldb;
CREATE TABLE table_a (id INT) TABLESPACE ts_a; -- 저장하고자 하는 테이블스페이스 이름을 끝에 적으면 된다.

CREATE TABLE table_b (id INT);
ALTER TABLE table_b TABLESPACE ts_b; -- ALTER문으로 테이블스페이스 변경 가능

CREATE TABLE table_c (SELECT * FROM employees.salaries); -- 280만건 데이터
ALTER TABLE table_c TABLESPACE ts_c; -- Error Code: 2013. Lost connection to MySQL server during query // 응답시간이 너무 짧게 설정되어 있어서 그렇다. 설정에서 늘리자ALTER 

