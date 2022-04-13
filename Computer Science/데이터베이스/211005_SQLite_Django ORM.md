# Object-Relational Mapping (ORM)

> Django에서 SQL없이 DB를 객체처럼 다루게 하는 방식

## SQL 관계

ORM -> SQL 출력

```python
print(ORM.query)
```



## 초기 설정

1. Django 기본 세팅
2. migrate
3. sqlite 실행



## CRUD

### Read

```python
dbname.objects.all() # 전체 조회
dbname.objects.get(pk=102) # 특정 조회
```

### Create

```python
dbname.objects.create(
	first_name='길동',
    last_name='홍',
    age=100
)
```

### Update

```python
user = dbname.objects.get(pk=102)
user.last_name = '김'
user.save()
```

### Delete

```python
dbname.objects.get(pk=102).delete()
```



## 기능 함수

- count

  ```python
  dbname.objects.count() # 전체 데이터 수
  ```

- filter

  ```python
  dbname.objects.filter(age=30) # 조건 검색
  ```

- values

  ```python
  dbname.objects.filter(age=30).values('name') # 출력 값
  ```

#### 조건 키워드 (filter 사용)

- 크기 대소

  ```python
  # __gte, gt, --lte, __lt
  dbname.objects.filter(age__gte=30).count() # 나이 30 이상 수
  ```

- And

  ```python
  dbname.objects.filter(조건1, 조건2) # 콤마로 and 구분
  ```

  > WHERE 조건1 AND 조건2;

- Or

  ```python
  from django.db.models import Q
  dbname.objects.filter(Q(조건1) | Q(조건2))
  ```

  > WHERE 조건1 OR 조건2

- 패턴 검색

  ```python
  # 시작 값
  dbname.objects.filter(phone__startswith='02-').count() # 02시작 수
  ```

- 정렬 검색

  ```python
  dbname.objects.order_by('-age')[:10] # 나이 역순 10명
  ```

  

## Django Aggregation

- Avg, Max, Min, Sum

  ```python
  from django.db.models import Avg
  dbname.objects.aggregate(Avg('인자'))
  ```

- annotate: 주석을 달아줌 (원본 테이블 그대로)

