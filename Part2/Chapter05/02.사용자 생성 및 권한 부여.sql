-- director를 만들고 모든 권한을 부여
CREATE USER director@'%' IDENTIFIED BY 'director';
GRANT ALL ON *.* TO director@'%' WITH GRANT OPTION;

-- CEO만들어 읽기 부여
CREATE USER ceo@'%' IDENTIFIED BY 'ceo';
GRANT SELECT ON *.* TO CEO@'%';

-- staff만들어 shopDB의 모든 테이블에 읽기,쓰기 권한 부여와 프로시저 생성 수정 부여, 추가로 employees 테이블에 대해서 읽기 권한 부여
CREATE USER staff@'%' IDENTIFIED BY 'staff';
GRANT SELECT,INSERT,DELETE,UPDATE ON shopdb.* TO staff@'%';
GRANT SELECT ON employees.* TO staff@'%';
