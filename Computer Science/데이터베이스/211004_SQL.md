# Structured Query Language (SQL)

> DB의 데이터 관리를 위해 사용하는 언어

## SQL 실행

#### SQL shell 생성 및 실행

```bash
$ sqlite3 tutorial.sqlite3
sqlite> .database
```

#### csv 파일 import

```sqlite
sqlite> .mode csv
sqlite> .import name.csv tablename
sqlite> .tables
tablename
```



## SQL 설정

```sql
CREATE TABLE tablename (
	id INTEGER PRIMARY KEY AUTOINCREMENT, -- PK 재사용 방지 (장고 기본값)
    ...
);
```



## SQL 분류

### DDL - 데이터 정의 언어

- CREATE TABLE

  ```sql
  CREATE TABLE classmates (
  	id INTEGER PRIMARY KEY, -- 이게 있으면 rowid 못쓰고 넣어줘야함
  	name TEXT NOT NULL -- NOT NULL은 필수값
  );
  ```

- DROP TABLE (삭제)

  ```sql
  DROP TABLE tablename;
  ```

- ALTER TABLE (변경)

  ```sql
  ALTER TABLE tablename RENAME TO tablename2; -- 이름변경
  ALTER TABLE tablename ADD COLUMN col3 INT; -- 컬럼추가 (NOT NULL 불가)
  -- ADD COLUMN col4 INT NOT NULL DEFAULT 3; 이렇게 추가 가능
  ```

  

### DML - 데이터 조작 언어

- INSERT INTO

  ```sql
  -- 일부 열의 데이터만 넣는경우
  INSERT INTO tablename (col1, col2)
  VALUES (data1, data2);
  
  -- 전체 열의 데이터를 넣는경우
  INSERT INTO tablename
  VALUES (data1, data2, data3);
  ```

- SELECT

  ```sql
  SELECT rowid, col1, col2 -- 또는 전체(*)
  FROM tablename;
  ```

  - LIMIT 숫자: 숫자 만큼만 조회. `OFFSET (숫자개수 넘김)`과 함께 쓰기도함
  - WHERE: 특정 검색 조건 지정
  - SELECT DISTINCT 컬럼: 중복 행 제거 조회, SELECT 바로 뒤에 써야함

- UPDATE

  ```sql
  UPDATE tablename
  SET cal1=val1, cal2=val2
  WHERE id=5;
  ```

- DELETE

  ```sql
  DELETE 
  FROM tablename
  WHERE id=5;
  ```

  

### DCL - 데이터 제어 언어

- GRANT
- REVOKE
- COMMIT
- ROLLBACK



## Aggregate functions 

- COUNT: 그룹의 항목 수

  ```sql
  SELECT COUNT(*) FROM tablename;
  ```

- AVG/SUM: 평균/합 계산

  ```sql
  SELECT AVG(col1) FROM tablename;
  ```

- MAX/MIN: 최대값/최소값

  ```sql
  SELECT MAX(col1) FROM tablename;
  ```

## Clause

- LIKE: 패턴 일치 조회. `WHERE 인자 LIKE '패턴'`
  - %: 있을수도 없을수도
  - _: 자리수

- ORDER BY: `ORDER BY 컬럼 ASC`

  - ASC: Ascending. 기본값 생략 가능
  - DESC: Descending

- GROUP BY: 요약 행 만듬. WHERE 뒤에 작성. 

  ```sql
  SELECT last_name, COUNT(*) AS num FROM users GROUP BY last_name;
  --      조건        결과      변경 
  ```

  

## Sqlite Shell 명령어

```sqlite
sqlite> .tables -- 모든 테이블 조회
sqlite> .schema tablename -- 스키마 조회
sqlite> .headers on -- 헤더 표시
sqlite> .mode column -- 열 맞춤
```

