# DB 백업 / 복구

데이터베이스는 물리적인 메모리에 저장된다. 따라서 수명이 있으며, 백업을 수행하지 않는다면 여러 이유로 데이터가 손실 될 수 있다.

DB의 데이터를 파일로 담아두는 방법으로 파일을 복구하여 다시 데이터로 만들 수 있다. 백업 파일을 다시 압축툴을 이용해서 크기를 줄일 수 있다.

백업은 DB, Table 단위로 가능하다.

### MySQL DB 백업

```sql
-- 특정 DB
mysqldump -u [사용자 계정] -p [패스워드] [원본 데이터베이스명] > [생성할 백업 DB명].sql
-- 예를들면,
-- mysqldump -u test_user -p test_db > backup_test_db.sql

-- 모든 DB
mysqldump --all-databases -u [사용자 계정] -p --default-character-set=euckr < [백업된 DB].sql
-- 예를들면,
-- mysqldump --all-databases -uroot -p --default-character-set=euckr > all.sql
```

### MySQL DB 복구

```sql
-- 특정 DB
mysql -u [사용자 계정] -p [패스워드] [복원할 DB] < [백업된 DB].sql
-- 예를들면,
-- mysql -u test_user -p test_db < backup_test_db.sql

-- 모든 DB
mysql --all-databases -u [사용자 계정] -p < [백업된 DB].sql
-- 예를들면,
mysql -uroot -p < all.sql
```

### MySQL Table 백업

```sql
mysqldump -u [사용자 계정] -p [패스워드] [데이터베이스명] [원본 백업받을 테이블명] > [백업받을 테이블명].sql
-- 예를들면,
-- mysqldump -u test_user -p test_db test_table > backup_test_table.sql
```

### MySQL Table 복구

```sql
mysql -u [사용자 계정] -p [패스워드] [복원할 DB ] < [백업된 테이블].sql
-- 예를들면,
-- mysql -u test_user -p 123456 test_db < backup_test_table.sql
```



# 직접 이관

Database를 다른 System으로 변경하고 싶을때 사용한다. 위에 백업 방법으로 파일을 옮겨서 이관도 가능하다.

### MySQL 원격 백업 생성

```sql
mysqldump --column-statistics=0 [데이터베이스명] > [덤프파일명.sql] -h[서버주소] -u[아이디] -p[비밀번호]
```

