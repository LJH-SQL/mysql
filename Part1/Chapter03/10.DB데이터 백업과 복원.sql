
#백업 방법은 Navigator에서 administration 탭 누르고 db export 로 백업을 할 수 있다.
#DELETE FROM productTBL;

#USE sys;
#복원은 위와 같은 탭을 누른 후 db import를 통해서 DB를 복원 할 수 있다. 
USE ShopDB;
SELECT * FROM productTBL;
#USE 'DB이름' -> 사용 DB를 설정하는 것