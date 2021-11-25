/*
JASON 데이터
JASON 형태는 속성과 값으로 쌍을 이룬다.
{
	"아이디" : "BBK",
    "이름" : "바비킴",
    "생년" : "1973",
    "지역" : "서울",
    "국번" : "010",
    "전화번호" : "00000000",
    "키" : "178",
    "가입일" : "2013.5.5",
}
*/

-- 테이블을 JSON데이터로 변환하려면 JSON_OBJECT()나 JSON_ARRAY() 함수를 이용하면 된다.
USE sqldb;
SELECT JSON_OBJECT('name',name,'height', height) AS 'JSON값' FROM usertbl WHERE height >= 180; -- 출력문 : {"name": "임재범", "height": 182},{"name": "이승기", "height": 182},{"name": "성시경", "height": 186}

-- JSON 관련 함수 사용법 확인해보기
SET @json='{ "usertbl" :
	[
		{"name":"임재범","height":182},
        {"name":"이승기","height":182},
        {"name":"성시경","height":186}
	]
}';
SELECT JSON_VALID(@json) AS JSON_VALID; -- 문자열이 JSON 형식을 만족하면 1, 그렇지 않으면 0을 반환 // 출력문 : 1
SELECT JSON_SEARCH(@json, 'one', '성시경') AS JSON_SEARCH; -- 세 번째 파라미터에 주어진 문자열의 위치를 반환 두번째 파라미터는 'one'과 'all'중 하나가 올 수 있다. 'one'은 처음매치되는 하나만 반환, 'all'응ㄴ 매치되는 모든 것을 반환 // 출력문 : "$.userTBL[2].name"
SELECT JSON_EXTRACT(@json, '$.usertbl[2].name') AS JSON_EXTRACT; -- JOn_SEARCH()와 반대로 지정된 위치의 값을 추출한다.
SELECT JSON_INSERT(@json, '$.usertbl[0].mDate', '2009-09-09') AS JSON_INSERT; -- JSON_INSERT()는 새로운 값을 추가한다.
SELECT JSON_REPLACE(@json, '$.usertbl[0].name', '홍길동') AS JSON_REPLACE; -- JSON_REPLACE()는 값을 변경한다.
SELECT JSON_REMOVE(@json, '$.usertbl[0]') AS JSON_REMOVE; -- JSON_REMOVE()는 지정된 항목을 삭제