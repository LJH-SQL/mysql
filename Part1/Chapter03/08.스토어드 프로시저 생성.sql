/*
SELECT * FROM memberTBL WHERE memberName = '당탕이';
SELECT * FROM productTBL WHERE productName = '냉장고';
위와 같이 여러 테이블을 조회할때 매번 다 적으면 불편하고 틀릴 소지도 다분하기 때문에 스토어드 프로시저를 만든다
*/
DELIMITER // #DELIMITER는 '구분 문자'를 의미한다. 뒤에 //가 나오면 기존 세미콜론을 //로 대신한다는 의이다. 이는 CREATE PROCEDURE ~~END 까지 하나의 단락으로 묶어주는 효과이고 제일 마지막에 DELIMITER; 를 적어준다#
CREATE PROCEDURE myProc()
BEGIN
	SELECT * FROM memberTBL WHERE memberName = '당탕이';
	SELECT * FROM productTBL WHERE productName = '냉장고';
END //
DELIMITER ;

CALL myProc(); #프로시저를 불러올 때는 CALL 스토어드 프로시저_이름()으로 실행한다