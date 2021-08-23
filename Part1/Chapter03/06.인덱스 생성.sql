CREATE TABLE indexTBL (first_name varchar(14), last_name varchar(16), hire_date date);

INSERT INTO indexTBL
	SELECT first_name, last_name, hire_date
	FROM employees.employees
    LIMIT 500;
/*indexTBL에 예제파일의 데이터를 500개 까지 넣는다*/

CREATE INDEX idx_indexTBL_firstname ON indexTBL(first_name);
/*
데이터베이스 튜닝이란
데이터베이스 성능을 향상시키거나 응답하는 시간을 단축시키는 것으로 그를 위해 인덱스를 사용하며 이를 적절히 사용하면
시스템 성능이 몇 십 배 이상 차이가 날 수 있다.
*/
SELECT * FROM indexTBL WHERE first_name = 'Mary';
/* 인덱스를 생성후에 검색을 하게 되면 인덱스를 사용해서 결과를 찾아내게 되며 이는
인덱스가 없을때는 책의 제일 뒤의 찾아보기가 없는 상태에서 단어를 검색하는 것이고,
인덱스를 생성 후에는 찾아보기가 있는 상태에서 trigger 단어를 찾아 본 후 그곳에 있는 페이지를 바로 펴서 검색한 것과 같은 것이다.*/