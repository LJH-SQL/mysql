/*테이블 생성 예시*/
CREATE TABLE `shopdb`.`memberTBL` (
	`memberID` CHAR(8) NOT NULL,
	`memberName` CHAR(5) Not Null,
    `memberAddress` CHAR(20) NULL,
    PRIMARY KEY(`memberID`));