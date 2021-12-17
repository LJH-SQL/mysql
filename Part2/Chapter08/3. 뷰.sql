-- 뷰의 실체는 SELECT문이 되는 것

USE tabledb;
CREATE VIEW v_usertbl
AS
	SELECT userid, name, birthYear FROM usertbl; -- 뷰를 생성하는 방식
SELECT * FROM v_usertbl;	-- 뷰를 접근하는 방식
/*
뷰의 장점
- 보안에 도움 : v_usertbl에는 이름 생일만 있을뿐 사용자의 중요한 개인정보, 연락처, 키 가입일 등의 정보는 들어있지 않다
- 봇잡한 쿼리 단순화 : 복잡한 쿼리문을 자주 사용하게 된다면 뷰를 만들어 앞으로 뷰테이블만 불러오면 된다.
*/

USE sqldb;
CREATE VIEW v_userbuytbl
AS
	SELECT U.userid AS 'USER ID', U.name AS 'USER NAME', B.prodName AS 'PRODUCT NAME', U.addr, CONCAT(U.mobile1, U.mobile2) AS 'MOBILE PHONE'
		FROM usertbl U
        INNER JOIN buytbl B
			ON U.userID = B.userID;
            
SELECT `USER ID`,`USER NAME` FROM v_userbuytbl; -- 주의 : 백틱 사용

-- 뷰의 수정
ALTER VIEW v_userbuytbl
AS
	SELECT U.userID AS '사용자 아이디', U.name AS '이름', B.prodName As '제품 이름', U.addr, CONCAT(u.mobile1, U.mobile2) AS '전화 번호'
		FROM usertbl U
			INNER JOIN buytbl B
				ON U.userid = B.userID ;
SELECT `이름`,`전화 번호` FROM v_userbuytbl;
-- 뷰의 삭제
DROP VIEW v_userbuytbl;

USE sqldb;
CREATE OR REPLACE VIEW v_usertbl -- CREATE VIEW는 기존에 뷰가 있으면 오류가 발생하지만, CREATE OR REPLACE VIEW는 기존에 뷰가 있어도 덮어쓰는 효과를 내기 때문에 오류각 발생하지 않는다.
AS
	SELECT userid, name, addr FROM usertbl;
    DESCRIBE v_usertbl;
    
-- 뷰를 통해 데이터 변경
UPDATE v_usertbl SET addr = '부산' WHERE userid='JKW';
-- 데이터 삽입
INSERT INTO v_usertbl (userid,name,addr) VALUEs('KBM','김병만','충북');    -- 오류 : 테이블 usertbl중에서 birthYear가 NOT NULL이라 인덱스에서 값을 넣으면 오류가 뜬다. birthYear을 수정해야함
select * from v_usertbl;


-- 그룹함수 포함하는 뷰
CREATE VIEW v_sum
AS
	SELECT userid AS 'userid', SUM(price*amount) AS 'total'
		FROM buytbl GROUP BY userid;
SELECT * FROM v_sum;

SELECT * FROM INFORMATION_SCHEMA.VIEWS
	WHERE TABLE_SCHEMA = 'sqldb' AND TABLE_NAME = 'v_sum'; -- IS_UPDATEBLE이 NO이므로 수정할 수 없다 INFORMATION_SCHEMA의 VIEWS 테이블에서 전체 시스템에 저장된 뷰에 대한 다양한 정보를 가지고있다

-- 키가 177이상인 뷰를 생성하고 뷰에 입력값이 177미만이 들어가지않도록 수정하기
CREATE VIEW v_height177
AS SELECT * FROM usertbl WHERE height >=177;
ALTER VIEW v_height177
AS SELECT * FROM usertbl WHERE height >= 177 WITH CHECK OPTION;

-- 뷰가 참조하는 테이블을 삭제한다면 뷰도 같이 조회할 수 없다.