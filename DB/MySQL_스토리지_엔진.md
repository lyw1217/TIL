# MySQL 스토리지 엔진

mysql(mariadb)에서 사용 가능한 'Plug In' 방식의 스토리지 엔진은 아래와 같은 명령어로 확인 가능하다.

    MariaDB > show engines;
    +--------------------+---------+----------------------------------------------------------------------------------+--------------+------+------------+
    | Engine             | Support | Comment                                                                          | Transactions | XA   | Savepoints |
    +--------------------+---------+----------------------------------------------------------------------------------+--------------+------+------------+
    | MRG_MyISAM         | YES     | Collection of identical MyISAM tables                                            | NO           | NO   | NO         |
    | CSV                | YES     | Stores tables as CSV files                                                       | NO           | NO   | NO         |
    | MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables                        | NO           | NO   | NO         |
    | MyISAM             | YES     | Non-transactional engine with good performance and small data footprint          | NO           | NO   | NO         |
    | Aria               | YES     | Crash-safe tables with MyISAM heritage                                           | NO           | NO   | NO         |
    | InnoDB             | DEFAULT | Supports transactions, row-level locking, foreign keys and encryption for tables | YES          | YES  | YES        |
    | PERFORMANCE_SCHEMA | YES     | Performance Schema                                                               | NO           | NO   | NO         |
    | SEQUENCE           | YES     | Generated tables filled with sequential values                                   | YES          | NO   | YES        |
    +--------------------+---------+----------------------------------------------------------------------------------+--------------+------+------------+

마크다운 표로 다시 정리하면 아래와 같다.

| Engine             | Support | Comment                                                                          | Transactions | XA   | Savepoints |
|--------------------|---------|----------------------------------------------------------------------------------|--------------|------|------------|
| MRG_MyISAM         | YES     | Collection of identical MyISAM tables                                            | NO           | NO   | NO         |
| CSV                | YES     | Stores tables as CSV files                                                       | NO           | NO   | NO         |
| MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables                        | NO           | NO   | NO         |
| MyISAM             | YES     | Non-transactional engine with good performance and small data footprint          | NO           | NO   | NO         |
| Aria               | YES     | Crash-safe tables with MyISAM heritage                                           | NO           | NO   | NO         |
| InnoDB             | DEFAULT | Supports transactions, row-level locking, foreign keys and encryption for tables | YES          | YES  | YES        |
| PERFORMANCE_SCHEMA | YES     | Performance Schema                                                               | NO           | NO   | NO         |
| SEQUENCE           | YES     | Generated tables filled with sequential values                                   | YES          | NO   | YES        |


### 참고 자료
- [Hong's Store House - [MySQL] 주요 스토리지 엔진(Storage Engine) 간단 비교](http://asuraiv.blogspot.com/2017/07/mysql-storage-engine.html)
- [Useful Guide - MySQL 스토리지 엔진 종류 및 특징](https://nomadlee.com/mysql-%EC%8A%A4%ED%86%A0%EB%A6%AC%EC%A7%80-%EC%97%94%EC%A7%84-%EC%A2%85%EB%A5%98-%EB%B0%8F-%ED%8A%B9%EC%A7%95/)
- [기억하기 프로젝트 - mysql 엔진 MyISAM과 InnoDB 차이](https://rebeccajo.tistory.com/14)
- [길은 가면, 뒤에 있다. - [MySQL] 적절한 스토리지엔진 선택](https://12bme.tistory.com/95)