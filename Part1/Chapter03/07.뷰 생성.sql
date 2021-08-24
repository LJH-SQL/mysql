CREATE VIEW uv_memberTBL
AS
	SELECT memberName, memberAddress From memberTBL;

SELECT * from uv_memberTBL;
/*뷰는 가상의 테이블로 접근권한을 주기위해서 만든다.
뷰는 진짜 테이블에 링크된 개념이라고 생각하면 된다*/