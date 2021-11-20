-- 제어흐름 함수
-- IF(수식, 참, 거짓) // 수식이 참 또는 거짓인지 결과에 따라 2중 분기
SELECT IF (100>200, '참이다', '거짓이다'); -- 출력문 : 거짓이다

-- IFNULL(수식1,수식2) // 수식1이 NULL이 아니면 수식1반환, NULL이면 수식2반환 
SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요'); -- 출력문 : '널이군요' 100 

-- NULLIF(수식1,수식2) // 수식1과 수식2가 같으면 NULL반환, 다르면 수식1 반환
SELECT NULLIF(100,100), NULLIF(200,100); -- 출력문 : NULL 200

-- CASE ~ WHEN ~ ELSE ~ END // CASE는 내장 함수는 아니며 연산자로 분류된다. 
SELECT CASE 10
			WHEN 1 THEN '일'
            WHEN 5 THEN '오'
            WHEN 10 THEN '십'
            ELSE '모름'
	END AS 'CASE연습'; -- 출력문 : 십


-- 문자열 함수
-- ASCII(아스키코드), CHAR(숫자) //아스키 코드값을 돌려주거나 숫자의 아스키 코드값에 해당하는 문자를 돌려준다.    
SELECT ASCII('A'), CHAR(65); -- 출력문 : 65, A

-- BIT_LENGTH(문자열), CHAR_LENGTH(문자열),LENGTH(문자열) //할당된 Bit 크기 또는 문자 크기를 반환한다. CHAR_LENGTH()는 문자의 개수를 반환 , LENGTH()는 BYTE수를 반환
SELECT BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc'); -- 출력문 : 24,3,3
SELECT BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다'); -- 출력문 : 72,3,3

-- CONCAT(문자열1,문자열2,...), CONCAT_WS(구분자,문자열1,문자열2,...) // 문자열을 이어준다. CONCAT_WS()는 구분자와 함께 문자열을 이어준다.
SELECT CONCAT_WS('/','2025','01','01'); -- 구분자'/'를 추가해서 '2025/01/01'이 반환된다.

/* ELT(위치,문자열1, 문자열2, ...) 위치 번째에 해당하는 문자열 반환
FIELD(찾을 문자열, 문자열1, 문자열2, ...)	찾을 문자열의 위치를 찾아서 반환, 매치되는 문자열이 없으면 0 반환
FIND_IN_SET(찾을 문자열, 문자열 리스트)	찾을 문자열을 문자열 리스트에서 찾아서 위치 반환
INSTR(기준 문자열, 부분 문자열)	기준 문자열에서 부분 문자열 찾아서 그 시작 위치를 반환
LOCATE(부분 문자열, 기준 문자열)	INSTR()와 동일하지만 파라미터의 순서가 반대
*/
SELECT ELT(2,'하나','둘','셋'), FIELD('둘','하나','둘','셋'), FIND_IN_SET('둘','하나,둘,셋'), 
INSTR('하나둘셋','둘'), LOCATE('둘','하나둘셋'); -- 출력문 : '둘',2,2,3,3


-- FORMAT(숫자, 소수점 자릿수) 숫자를 소수점 아래 자릿수까지 표현한다. 또한 1000 단위마다 콤다(,)를 표시해준다.
SELECT FORMAT(123456.123456,4);

-- BIN(숫자),HEX(숫자),OCT(숫자) // 2진수, 16진수, 8진수
SELECT BIN(31), HEX(31), OCT(31); -- 출력문 : 11111, 1F, 37

-- INSERT(기준문자열,위치,길이,삽입할 문자열) // 기준문자열의 위치부터 길이만큼 지우고 삽입할 문자열 끼워 넣는다.
SELECT INSERT('abcdefghi',3,4,'@@@@'), INSERT('abcdefghi',3,2,'@@@@');

-- LEFT(문자열,길이),RIGHTR(문자열,길이) // 왼쪽 또는 오른쪽에서 문자열의 길이만큼 반환한다.
SELECT LEFT('abcdefghi',3), RIGHT('abcdefghi',3); -- 출력문 : abc, ghi

-- UPPER(문자열),LOWER(문자열) // 소문자를 대문자로, 대문자를 소문자로 변경한다.
SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH'); -- 출력문 : abcdefgh, ABCDEFGH

-- LPAD(문자열, 길이, 채울 문자열), RPAD(문자열,길이,채울 문자열) //문자열을 길이만큼 늘린 후에, 빈 곳을 채울 문자열로 채운다.
SELECT LPAD('이것이',5,'##'), RPAD('이것이',5,'##'); -- 출력문 : ##이것이, 이것이##

-- LTRIM(문자열),RTRIM(문자열)		// 문자열의 왼쪽/오른쪽 공백을 제거
SELECT LTRIM('    이것이'), RTRIM('이것이    '); -- 출력문 : 이것이, 이것이

-- TRIM(문자열) // TRIM(문자열)은 문자열의 앞 뒤 공백을 모두 없앤다. 
-- TRIM(방향 자를_문자열 FROM 문자열) // TRIM(방향 자를_문자열 FROM 문자열)에서 방향은 LEADING(앞),BOTH(양쪽),TRAILING(뒤)가 나올 수 있따
SELECT TRIM('    이것이    '), TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋ재밌어요.ㅋㅋㅋㅋ'); -- 출력문 : 이것이, 재밌어요.

-- REPEAT(문자열,횟수); // 문자열을 횟수만큼 반복
SELECT REPEAT('반복',4); -- 출력문 : 반복반복반복반복

-- REPLACE(문자열, 원래 문자열, 바꿀 문자열) // 문자열에서 원래문자열을 찾아서 바꿀 문자열로 바꿔준다.
SELECT REPLACE('이것이  MYSQL이다', '이것이', 'This is'); -- 출력문 : This is MYQL이다
-- SELECT REPLACE((SELECT name from membertbl),'바비킴', '비비큐'); // 출력문 : ERROR CODE:1242. Subquery returns more than 1 row

-- REVERSE(문자열) // 문자열의 순서를 거꾸로 만든다.
SELECT REVERSE ('MYSQL'); -- 출력문 : LQSYM

-- SPACE(길이) // 길이만큼 공백을 반환한다.
SELECT CONCAT('이것이',SPACE(10), 'MYSQL이다'); -- 출력문 : 이것이          MYSQL이다.

-- SUBSTRING(문자열, 시작위치, 길이) 또는 SUBSTRING(문자열 FROM 시작위치 FOR 길이) // 시작 위치부터 길이만큼 문자를 반환한다.
SELECT SUBSTRING('대한민국 만세',3,2); -- 출력문 : 민국

-- SUBSTRING_INDEX(문자열, 구분자, 횟수) // 문자열에서 구분자가 왼쪽부터 횟수 번째 나오면 그 이후의 오른쪽은 버린다. 음수면 오른쪽부터 시작해서 횟수번째 이후 버림
SELECT SUBSTRING_INDEX('cafe.naver.com','.',2), SUBSTRING_INDEX('cafe.naver.com','.',-2); -- 출력문 : cafe.naver , naver.com

