/* 
INSERT문의 기본
INSERT [INTO] 테이블[(열1,열2,...)] VALUES (값1, 값2,...)
*/
USE sqldb;
CREATE TABLE testTbl1 (id int, userName char(3), age int);
INSERT INTO testTbl1 VALUES (1, '홍길동', 25);
INSERT INTO testTbl1 (id, userName) VALUES (2,'설현'); -- id,이름만 넣고싶다면 age를 입력하지 않으면 되고 age는 NULL값이 들어간다.
INSERT INTO testTbl1 (userName, age, id) VALUES ('하니',26,3); -- 열의 순서를 바꿔 입력하고 싶으면 순서를 바꾸면 되나 뒤에도 입력할 순서를 맞춰야한다.

-- 자동으로 증가하는 AUTO_INCREMENT 
USE sqldb;
CREATE TABLE testTbl2
	(id int AUTO_INCREMENT PRIMARY KEY, userName char(3), age int ); -- AUTO_INCREMENT로 지정할 때는 꼭 PRIMARY KEY 또는 UNIQUE로 지정해 줘야 하며 INSERT할 때는 NULL로 값을 넣으면 된다.
INSERT INTO testTbl2 VALUES (NULL, '지민', 25);
INSERT INTO testTbl2 VALUES (NULL, '유나', 22);
INSERT INTO testTbl2 VALUES (NULL, '유정', 21);
SELECT * FROM testtbl2;
SELECT LAST_INSERT_ID(); -- 해당 쿼리문은 마지막에 입력된 값을 보여준다.

ALTER TABLE testTbl2 AUTO_INCREMENT=100; -- 해당 쿼리문은 자동증가 하는 시작부분을 100으로 조정한다.
INSERT INTO testTbl2 VALUES (NULL,'찬미',23);
SELECT * FROM testTbl2;

CREATE TABLE testTbl3
	(id int AUTO_INCREMENT PRIMARY KEY, userName char(3), age int );
ALTER TABLE testTbl3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3; -- 증가값 변경하려면 서버 변수인 @@auto_increment_increment 변수를 변경시켜야 한다.
INSERT INTO testTbl3 VALUES (NULL, '나연', 20), (NULL,'정연',18),(NULL,'모모',19);
SELECT * FROM testTbl3;

/* 
대량의 샘플 데이터 생성
형식 :
INSERT INTO 테이블이름 (열 이름1, 열 이름2, ...)
	SELECT문	;
이 때 SELECT문의 결과 열의 개수는 INSERT를 할 테이블의 열 개수와 일치해야 한다.
*/

USE sqldb;
CREATE TABLE testTbl4 (id int, Fname varchar(50), Lname varchar(50));
INSERT INTO testTbl4
	SELECT emp_no, first_name, last_name
		FROM employees.employees;
-- 결과 메세지 : 300024 row(s) affected Records:~~ => // 기존의 대량의이 데이터를 샘플 데이터로 사용할 때 INSERT NTO...SELECT문은 아주 유용하다.
CREATE TABLE testTbl5
	(SELECT emp_no, first_name, last_name FROM employees.employees);
-- 결과 메세지 : 300024 row(s) affected Records:~~ => // INSERT문을 따로 넣지않고 테이블을 만들 때도 이런식으로 넣을 수 있다.