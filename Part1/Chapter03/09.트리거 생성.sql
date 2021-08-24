/*트리거를 사용해보자
ex)
INSERT INTO memberTBL VALUES ('Figure', '연아', '경기도 군포시 당정동');
SELECT * FROM memberTBL;	-- 제대로 입력되었는지 확인
UPDATE memberTBL SET memberAddress = '서울 강남구 역삼동' WHERE memberName = '연아';
DELETE FROM memberTBL WHERE memberName = '연아';
SELECT * FROM memberTBL;	-- 잘 삭제되었는지 확인
이 상황에서 '연아'가 쇼핑몰의 회원이었다는 증명을 요구하면 증명할 방법이 없기 때문에 이것을 방지하기위해 트리거를 작성해야한다
*/
CREATE TABLE deletedMemberTBL (
memberID CHAR(8),
memberName CHAR(5),
MemberAddress Char(20),
deleteDate DATE
);

#회원테이블에 DELETE 작업이 일어나면 백업 테이블에 기록되는 트리거 생성
DELIMITER //
CREATE TRIGGER trg_deletedMemberTBL -- 트리거 이름
	AFTER DELETE -- 삭제 후에 작동하게 지정
	ON memberTBL -- 트리거를 부착할 테이블
	FOR EACH ROW -- 각 행마다 적용시킴 
BEGIN
	#	OLD 테이블의 내용을 백업 테이블에 삽입
    INSERT INTO deletedMemberTBL
		VALUES (OLD.memberID, OLD.memberName, OLD.memberAddress, CurDATE() );
END	//
DELIMITER ;

#트리거 작동 실험
SELECT * FROM memberTBL;
DELETE FROM memberTBL WHERE memberName = '당탕이';
SELECT * FROM memberTBL; -- 해당 테이블에서 데이터가 삭제되었는지 확인
SELECT * FROM deletedMemberTBL; -- 트리거가 작동되었는지 확인
