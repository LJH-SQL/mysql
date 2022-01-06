/*
스토어드 함수
스토어드 함수는 스토어드 프로시저와 상당히 유사하지만 형태와 사용용도에는 약간의 차이가 있다.A
함수 정의는 간단하게 아래와 같다.
DELIMITER $$
CREATE FUNCTION 스토어드 함수이름( 파라미터 )
	RETURNS 반환형식
BEGIN

	잉 부분에 프로그래밍 코딩..
    RETURN 반환값;
    
END $$
DELIMITER ;
SELECT 스토어드_함수이름();

스토어드 프로시저와 비슷하지만 차이점이 여러가지 있다.
- 스토어드 프로시저 파라미터와 달리 IN, OUT등을 사용할 수 없다. 스토어드 함수의 파라미터는 모두 입력 파라미터로 사용된다.
- 스토어드 함수는 RETURNS문으로 반환할 갑싀 데이터 형식을 지정하고, 본문 안에서는 RETURN문으로 하나의 값을 반환해야 한다.
스토어드 프로시저는 별도의 반환하는 구문이 없으며, 꼭 필요하다면 여러 개의 OUT 파라미터를 사용해서 값을 반환할 수 있다.
- 스토어드 프로시저는 CALL로 호출하지만, 스토어드 함수는 SELECT 문장 안에서 호출된다.
- 스토어드 프로시저 안에는 SELECT문을 사용할 수 있지만, 스토어드 함수 안에서는 집합 결과를 반환하는 SELECT를 사용할 수 없다.
- 스토어드 프로시저는 여러 SQL문이나 숫자 계산 등의 다양한 용도로 사용되지만, 스토어드 함수는 어떤 계산을 통해서 하나의 값을 반호나하는 주로 사용된다.
*/
SET GLOBAL log_bin_trust_function_creators = 1; -- 스토어드 함수를 사용하기 위해서 먼저 스토어드 함수 생성 권한을 허용해줘야 한다.

-- 간단하게 2개의 숫자의 합계를 계산하는 스토어드 함수
USE sqlDB;
DROP FUNCTION IF EXISTS userFunc;
DELIMITER $$
CREATE FUNCTION userFunc(value1 INT, value2 INT)
	RETURNS INT
BEGIN
	RETURN value1 + value2;
END $$
DELIMITER ;
SELECT userFunc(100,200);

-- 출생년도를 입력하면 나이가 출력되는 함수 생성
USE sqlDB;
DROP FUNCTION If EXISTS getAgeFunc;
DELIMITER $$
CREATE FUNCTION getAgeFunc(bYear INT)
	RETURNS INT
BEGIN
	DECLARE age INT;
    SET age = YEAR(CURDATE()) - bYear;
    RETURN age;
END $$
DELIMITER ;
SELECT getAgeFunc(1995);
-- 필요하다면 함수의 반환값을 SELECT ... INTO 로 저장했다가 사용할 수 있다.
SELECT getAgeFunc (1979) INTO @age1979; -- @age1979 에 펑션 결과값 넣기
SELECT getAgeFunc(1997) INTO @age1989; -- -- @age1989 에 펑션 결과값 넣기
SELECT CONCAT('1997년과 1979년의 나이차 ==>', (@age1979-@age1989)); -- 넣어둔 결과값의 차이 출력

SELECT userID, name, getAgeFunc(birthYear) AS '만 나이' FROM userTbl; -- 함수는 이와같이 주로 테이블을 조회할 때 활용된다.
SHOW CREATE FUNCTION getAgeFunc; -- 현재 저장된 스토어드 함수의 이름 및 내용 확인
DROP FUNCTION getAgeFunc; -- 스토어드 함수 제거