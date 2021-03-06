# DB설계 기법

> DB 설계는 매우 넓은 분야의 지식이다. DB 설계를 어떤식으로 생각하고, 필수적인 개념 정도로 공부하고 넘어간다. 



## Work flow

전반적인 개발 과정 속에서 DB설계가 어느 위치인지 보자. 아래 9단계가 순차적인 폭포수 방식으로 진행할 수 있고, 계속 반복하는 애자일 방법으로 진행할 수 있다.

1. 계획/기획 (interview) 개발하고자 하는 프로그램이 뭔지 요구사항을 확인
2. 분석 및 Ideation 프로그램도, Use diagram 등 작성, 기획자 중심
3. UX/UI 설계
4. **DB설계 (모델링)** ERD를 그린다. 최근에는 EERD 등 프로그램을 이용
5. SW 및 인프라 설계 클라우드 방식, 서버 규모 등을 확정
6. 구현
7. 테스트 및 통합 TDD방식이라면 구현 전에 테스트 케이스를 만듬
8. 오픈
9. 유지보수 (운영)

## Database Modeling

### 개념적 모델링

- Entity 도출
  - 비즈니스 로직에 따른 도메인

### 논리적 모델링

- Data 구조 및 속성 정의
  - 컬럼의 데이터 타입
- 무결성 정의 및 정규화
  - 외래키 지정 (무결성 확보)
  - 정규화를 통해 중복 데이터 제거

### 물리적 모델링

- Schema, table, index 생성

## 정규화 (Normal Form, NF)

> 정규화는 중복 데이터를 제거하여 관계를 단순화한다. 목표는 데이터 무결성 확보와 저장 용량 감소이다. 아래 정규화 순서가 있으나, 실무에서는 정규화 목표만 생각하고, 프로그램 상황에 맞게 개발하면 된다.

- 제1정규화
  - 원자성 확보
  - 모슨 속성 (컬럼)은 하나의 값을 가져야 한다.
- 제2정규화
  - 완전 함수적 종속 (부분 종속 제거)
  - 모든 속성은 기본키에 종속되어야 한다.
- 제3정규화
  - 이행 종속 제거
  - 기본키가 아닌 모든 속성 간에는 서로 종속될 수 없다.
- BCNF
  - Boyce and Codd Normal Form
  - 모든 결정자는 후보키에 속해야 한다.

정규화는 데이터 무결성을 증가시키지만 효율(속도)에 문제가 있다.

빅데이터를 다루는 상황에서 속도 저하를 방지하기 위해 반정규화를 선택하기도 한다.

이때는 반정규화된 데이터의 무결성을 유지하기위한 데이터 정책을 잘 만들어둬야한다.

## 모델링 기법

1. PK(기본키)를 잘 지정하자
   - PK는 null이 아닌 유일한 값을 가져야 한다
   - 변경이 없어야 한다. 변경이 있다면 FK 모두 영향을 준다
   - 가능한 1개 컬럼으로 하며, 정수형을 선하는게 좋다. 복합키로 잡는 경우 FK를 잡기 번거롭다. 또한 조회에서 더 귀찮다.
2. 적절한 정규화를 사용하자
   - 원자성을 준수하고 최대한 중복이 없도록 하자
   - 계산 결과 컬럼을 최대한 자제하자.
   - Nullable 할 필요가 없다면 Not Null을 쓰자.
3. 참조 무결성을 위해 FK를 정의하자
4. 서로 다른 성격의 컬럼은 테이블을 분리하자
   - 사용 시 view나 join table을 만들자.
   - 컬럼보다 row가 더 저렴하다. 따라서 row를 늘리는 방향으로 가야한다. 적절한 정규화와 반정규화를 해야한다.
