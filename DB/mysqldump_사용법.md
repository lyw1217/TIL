# mysqldump 사용법         

## mysqldump ?

    mysqldump - a database backup program

mysql(mariadb)를 백업하는 프로그램이다.

백업 뿐만 아니라 다른 SQL 서버로 전송하기 위해 데이터 베이스 또는 데이터베이스 컬렉션을 덤프하는데 사용 가능하다. (MariaDB일 필요는 없다.)

명령어를 통해 생성된 덤프에는 일반적으로 테이블을 만들거나 채우는 SQL문이 포함되어 있다.

CSV, other delimited text, XML 포멧으로도 생성 가능하다.

서버에서 백업을 하는 경우, 테이블이 모두 MyISAM 테이블인 경우, `mysqlhotcopy`를 사용하면 백업 속도 및 복원 속도가 빨라 질 수 있으므로 이 경우에는 `mysqlhotcopy`를 사용하는 것이 좋다.

## 명령어 실행 방법

    shell> mysqldump [options] db_name [tbl_name ...]
    shell> mysqldump [options] --databases db_name ...
    shell> mysqldump [options] --all-databases

`db_name` 뒤에 오는 `tbl_name`(table name)을 지정하지 않거나 `--databases` 또는 `-all-databases` 옵션을 사용할 경우 전체 데이터베이스가 덤프됩니다.


## 사용 예시

### 백업(덤프)

- 모든 databases를 덤프

    mysqldump -u root -p --all-databases > dump_name.sql

- 모든 databases의 DDL 정보만 덤프

    mysqldump -u root -p --all-databases --no-data > dump_name.sql

- 특정 database(db_name)를 덤프

    mysqldump -u root -p --databases db_name > dump_name.sql

### 복원

- 덤프를 복원한다. 복원할 db_name은 미리 생성되어 있어야 한다.

    mysql -u root -p db_name < dump_name.sql

### 참고 자료
- [mysqldump(1) - Linux man page](https://linux.die.net/man/1/mysqldump)
- [소금인형 - MySQL mysqldump로 full backup, DB table 백업, 복원](https://blog.edit.kr/entry/mysqldump%EB%A1%9C-full-backup-%EB%B3%B5%EC%9B%90)
- [코드공장 - mysqldump 사용법](https://code-factory.tistory.com/21)