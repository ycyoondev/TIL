# DB성능 향상 기법

### Sargable (Search Argument able) Query

- where, order by, group by 등에는 가능한 index가 걸린 컬럼 사용
- where 절에 함수, 연산자, like(% 시작)문은 Sargable하지 않음
  - 이런게 있으면 index를 타지 않음 (full scan)
- between, like 부등호는 범위가 크면 Sargable하지 않음
- or 연산자는 필터링의 반대 개념 (row 증가)이므로 Sargable하지 않음
- offset이 길어지면 Sargable하지 않음
- 범위 보다는 in 절을 사용하는게 좋고, in보다는 exits가 더 좋음
- 꼭 필요한 경우가 아니라면 서브 쿼리 보다는 Join이 좋음



### Clustering

DB 분산기법 중 하나로 DB 서버가 죽는것을 대비하여 병렬적으로 구성한 DB 묶음이다.

- 활성 방식
  - Active Clustering
    - 여러개 서버를 active 상태로 두고 분산처리함
    - 운용 비용이 큼
  - Standby Clustering
    - 서버를 하나만 운용하고 나머지는 대기 상태로 둠. 하나 다운시 전환함
    - 전환 과정에서 시간이 소요됨



### Replication

DB 손상을 대비하여 복제해두는 기법

- 단순백업
  - Master DB에 CRUD가 수행될때마다 Slave DB에 바이너리 로그를 전달해 동기화하는 방식
  - Master DB가 손상되었을때 Slave를 Master로 승격함
- 부하 분산
  - 기존 단순 백업에서 Select작업을 Slave DB에서 수행하게 시켜 Master DB 부하 분산



### Partition

컬럼을 나눠 조회 속도를 향상 시킴



### Sharding

수평 파티셔닝이라고도 함
