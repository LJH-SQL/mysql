/*데이터 입력 및 삭제*/
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Dang', '당탕이', '경기 부천시 중동');
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Han', '한주연', '연천 남구 주안동');
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Jee', '지운이', '서울 은평구 중산동');
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Sang', '상길이', '경기 성남시 분당구');
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('NaoTa', '나오타', '주소불명');
INSERT INTO `shopdb`.`producttbl` (`productName`, `cost`, `makeDate`, `company`, `amount`) 
VALUES 
('냉장고', 5, '2023-02-01', '대우', 22),
('세탁기', 20, '2022-09-01', 'LG', 3),
('컴퓨터', 10, '2021-01-01', '삼성', 17);
/*값을 한번에 여러개 입력할 때는 아래와같이 입력하면 된다.
INSERT INTO 테이블명 (컬럼1, 컬럼2,,,,)
VALUES
('값1','값2'),
('값1','값2'),
('값1','값2');
*/

DELETE FROM `shopdb`.`membertbl` WHERE (`memberID` = 'NaoTa'); 
/*memberID 가 Naota 인 행을 삭제*/
