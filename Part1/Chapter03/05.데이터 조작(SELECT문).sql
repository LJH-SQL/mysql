/*데이터 활용*/
SELECT * from productTBL;
/*출력문
productName	cost	makeDate	company	amount
냉장고		5		2023-02-01	대우		22
세탁기		20		2022-09-01	LG		3
컴퓨터		10		2021-01-01	삼성		17
*/
SELECT memberName, memberAddress From memberTBL;
/*
memberName	memberAddress
당탕이		경기 부천시 중동
한주연		연천 남구 주안동
지운이		서울 은평구 중산동
상길이		경기 성남시 분당구
*/
select * from memberTBL WHERE memberName = '지운이';
/*
memberID	memberName	memberAddress
Jee			지운이		서울 은평구 중산동		

MYSQL에서 한 쿼리창에 여러개의 SQL문을 쓰면 모든 SQL문을 실행하기 때문에 데이터를 변경하는 SQL을 사용하거나 코드가 길어진다면
데이터의 문제를 발생시킬 수 있으므로 주의해야 한다.*/