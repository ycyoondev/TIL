# Spring MSA - Redis

## Redis

Redis(레디스)는 key-value 형태의 비정형 데이터 저장소이다. 파이썬의 dictionary나 자바의 hashmap과 유사하다. 데이터 저장을 내부 파일로 저장하는 방식인 In-Memory 기반으로 저장하여 속도가 빠르다는 장점을 가진다.

결국 Redis는 Cache 저장소로 생각하면 되겠다. 캐시 저장 뿐만 아니라 인증 토큰, Ranking board 저장 등으로 사용한다.

## Redis 데이터 구조

Redis를 공부하면 항상 데이터 구조를 먼저 설명한다. 사용 가능한 데이터 구조가 어떤지 알아보자. DB의 필드라고 생각해도 되겠다.

- String: 단순 문자열로, key-value형태로 문자를 조회한다.
- List: ArrayList 형태의 자료형이다. 데이터를 양 끝에 넣는데 빠른 속도를 제공하지만, 중간에 데이터를 삽입하는 일은 효율적이지 않다.
- Set: 순서가 없는 String 집합이다. 중복을 하나로 만든다.
- Sorted Set: 순서를 부여하는 score를 설정한다.
- Hash: key-value에서 value에 object를 담당한다. 트리 형태로 Redis 데이터 구조를 가져갈 수 있다.

## Redis 관리하기

레디스의 가장 큰 특징은 싱글 스레드라는 점이다. 한번에 하나의 명령만 처리한다. Redis 자체가 초당 10만개 정도의 명령어를 처리하는 빠른 저장 장치다 보니 관리가 필요한 멀티 스레드 보다는 이러한 싱글 스레드로 충분한 성능을 뽑아낸다고 생각한다. 다만, 싱글 스레드다 보니 큐 형식으로 프로세스가 처리되며 긴 명령어가 들어오면 전체적인 성능 저하가 발생할 수 있다.

Redis를 설정하기 위해 maxmemory-policy를 설정해야 한다.

### maxmemory-policy

데이터를 어떻게 관리할지 용량 개념에서 생각한다. 페이지 교체 알고리즘과 유사하다.

- noeviction: 기존 데이터를 삭제하지 않는다. 메모리가 꽉 차면 Out Of Memory (OOM) 오류를 발생시키고 데이터를 받지 않는다.
- allkeys-lru: Least Recently Used(LRU) 페이지 교체 알고리즘을 통해 가장 오래된 데이터를 삭제하여 공간을 확보한다.
- allkeys-lfu: Least Frequently Used(LFU) 페이지 교체알고리즘을 통해 사용회수가 가장 적은 데이터를 삭제하여 공간을 확보한다.

## Redis 쓰기 방식

Redis는 Copy On Write (COW) 방식을 사용한다. COW는 작성시 이전 내용을 복사한다는 의미이다. 백업에 대한 개념이기 보다는 실제 컴퓨터상에 한정된 Resource를 서로 다른 두개의 프로세스가 공유할 때 유용하다.

### Copy On Write (COW)

Process 1에서 fork가 발생하여 Process 2가 생성된다고 하자. 그리고 Process 1의 데이터를 변경하려면 전체를 변경할 필요가 없이, 필요한 부분만 복제하여 변경하고, 포인터를 바꾸면 된다. 아래 그림과 같다.

![img](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F7338277f-403a-4160-b0e0-5a4fd6d27c1a%2FUntitled.png?table=block&id=06465705-46b0-48e8-ab9c-e1e9c0cdca96&spaceId=d63fd706-3d84-46de-bed5-a315277ec10a&width=1920&userId=878ba2cc-ea9d-4360-af76-79b5c3031b62&cache=v2)

이러한 방식은 phisical memory의 변수에 한개의 process만 참고하고 있다면 상관없다. 하지만 여러개 프로세스가 참여한다면 공통된것은 공유하고, 변경이 필요한 부분만 cow하는것이 유리하다.

다시 Redis로 돌아와 쓰기 요청을 살펴보자.

1. 쓰기 요청이 왔을때 fork 가 발생하여 자식 프로세스를 만든다. 위 그림과 같이 물리 메모리 블록은 공유한다.
2. CPU를 점유하여 쓰기 작업을 시작하며 수정할 메모리 영역을 복사 & 포인터 변경 한다.
3. 복사한 메모리에 쓰기작업을 완료한다.

## Redis Replication

DB와 유사하게 Redis는 Replication을 지원한다. 읽기 분산과 데이터 이중화를 위한 Master / Slave 분리이다. Master는 읽기/쓰기 모두를 지원하며, Slave는 읽기만 지원한다. Slave는 지속적으로 Master에서 발생한 쓰기 기록을 반영시킨다.

앞서 Redis에서 쓰기 작업을 위해서는 fork가 발생한다고 했다. 즉, Master가 쓰기 작업을 하기 위해서는 자신이 쓰고있는 메모리만큼 추가적인 메모리가 필요하다. 이때 OOM이 발생할 위험이 있다. 이는 위에서 확인한 용량 관리에서 설정이 필요하다.

## Redis Cluster

DB에서 에러가 발생했을 때 정상적인 동작을 위해서 Cluster를 구성한다. 다른 서버가 죽더라도 다른 서버가 대신 요청을 처리하게 하는 방식이다.

Replication이 여러개 묶음으로 구성되어 여러개의 master가 로드 밸런서에 연결된 형태로 구성한다.
