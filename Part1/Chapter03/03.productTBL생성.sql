/*테이블 생성 예시2*/
CREATE TABLE `shopdb`.`producttbl` (
  `productName` CHAR(8) NOT NULL,
  `cost` INT NOT NULL,
  `makeDate` DATE NULL,
  `company` CHAR(5) NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`productName`));