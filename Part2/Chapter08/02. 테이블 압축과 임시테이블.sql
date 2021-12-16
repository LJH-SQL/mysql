/*
테이블 압축
테이블 압축 기능은 대용량 테이블의 공간을 절약하는 효과를 갖는다. MYSQL5.0부터 제공했으며 8.0에서는 내부적인 기능이 더욱 강화되어 MYSQL이 허용하는 최대 용량의 데이터도 오류없이 압축이 잘 작동 한다.
*/
-- 2개의 테이블을 만들어 하나는 압축을 하여 입력속도와 데이터 길이등을 비교해볼 것이다.
CREATE DATABASE IF NOT EXISTS compressDB;
USE compressDB;
CREATE TABLE normalTBL( emp_no int, first_name VARCHAR(14));
CREATE TABLE compressTBL( emp_no int, first_name VARCHAR(14)) 
	ROW_FORMAT=COMPRESSED; -- 압축되도록 설정구문
INSERT INTO normalTbl
	SELECT emp_no, first_name FROM employees.employees; -- 3만건의 입력 속도 1.312초
INSERT INTO compressTbl
	SELECT emp_no, first_name FROM employees.employees; -- 3만건의 입력 속도 3.078초로 압축하며 데이터가 들어가 더 오래걸린다.
SHOW TABLE STATUS FROM compressDB;
/*
	Name		Engine	Version	Row_format	Rows	Avg_row_length	Data_length	Max_data_length	Index_length	Data_free	Auto_increment	Create_time			Update_time			Check_time	Collation			Checksum	Create_options			Comment
	normaltbl	InnoDB	10		Dynamic		299606	40				12075008	0				0				4194304						2021-12-15 10:09:26	2021-12-15 10:11:23				utf8mb4_0900_ai_ci			
	compresstbl	InnoDB	10		Compressed	299140	25				7626752		0				0				2097152						2021-12-15 10:09:27	2021-12-15 10:11:28				utf8mb4_0900_ai_ci				row_format=COMPRESSED	
ROW_FORMAY이 Compressed와 Dynamic으로 다르고 데이터의 길이 또한 차이가 많이 나는 것으로 알 수 있다.
디스크 공간의 여유가 별로 없으며 대용량의 데이터를 저장하는 테이블이라면 압축을 고려하는 것도 좋은 방법이다.
*/
DROP DATABASE IF EXISTS compressDB;

/*
임시 테이블
임시 테이블을 생성하는 형식
CREATE TEMPORARY TABLE [IF NOT EXISTS] 테이블이름 (열 정의...)
임시 테이블은 세션내에서만 존재하며, 세션이 닫히면 자동으로 삭제된다. 또한 임시 테이블은 생성한 클라이언트에서만 접근 가능하다
임시테이블은 데이터베이스 내의 다른 테이블과 이름은 동일하게 만들 수 있으며 그러면 임시 테이블이 있는 동안에 기존 테이블은 접근 불가하고 무조건 임시 테이블로 접근할 수 있다.
임시 테이블이 삭제되는 시점은 다음과 같다.
- 사용자가 DROP TABLE로 직접 삭제
- Workbench를 종료하거나 mysql 클라이언트를 종료하면 삭제됨
MYSQL 서비스가 재시작되면 삭제됨
*/

-- 테이블 수정
-- 열의 추가
USE tabledb;
ALTER TABLE usertbl
	ADD homepage VARCHAR(30)
		DEFAULT 'http://www.hanbit.co.kr'
        NULL;	-- NULL허용

-- 열 삭제
ALTER TABLE usertbl
	DROP COLUMN mobile1;

-- 열의 이름 및 데이터 형식 변경
ALTER TABLE usertbl
	CHANGE name uName VARCHAR(20) NULL;	-- name은 기존이름 Uname은 새이름

-- 열의 제약 조건 추가 및 삭제 
ALTER TABLE usertbl
	DROP PRIMARY KEY;
ALTER TABLE buytbl
	DROP FOREIGN KEY buytbl_ibfk_1; -- 외래키 이름