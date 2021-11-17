/*변수의 사용
SET @변수이름 = 변수의 값 ;		-- 변수의 선언 및 값 대입
SELECT @변수이름 ; 			-- 변수의 값 출력	
*/
USE sqldb;
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수 이름 ==>' ;

SELECT @myVar1 ;
SELECT @myVar2 + @myVar3 ;
SELECT @myVar4 , Name FROM usertbl WHERE height > 180 ;

-- LIMIT에는 원칙적으로 변수를 사용할 수 없으나 PREPARE와 EXECUTE문을 활용해서 변수의 활용도 가능
SET @myVar1 = 3 ;
PREPARE myQuery FROM 'SELECT Name, height FROM usertbl ORDER BY height LIMIT ?'; 
EXECUTE myQuery USING @myVar1 ;  -- 위의 ? 부분에 'MyVar1'이 적용되어 LIMIT 3 이 된다.
-- PREPARE 쿼리이름 FROM '쿼리문' 는 나중에 EXECUTE USING @변수 를 이용
