# HashMap 해시충돌

## Hash collision

Map (Dictionary) 구조는 효율적으로 key에 해당하는 value를 관리해 주어야 한다. 여기서 관리란 빠르게 CRUD하는것을 포함해서 메모리를 적게 사용해야 한다.

이를 위해 key에 따른 value 저장소를 Hash 함수를 이용해서 맵핑하는 방식을 사용한다. 이때, 아무리 좋은 hash함수를 사용하더라도 key 개수보다 value 저장소 (버킷이라고 부른다)의 크기가 작기때문에 결국 다른 key가 같은 저장소를 가르키는 충돌이 발생할 수 밖에 없다. key의 개수만큼 value공간을 사용하면 문제가 해결되어 보일 수 있지만, key는 무한할 수 있기때문에 불가능하고 자원 효율적이지도 않다.

![https://miro.medium.com/max/1400/1*i5JV9RiF17ftnGDvuqVFSA.png](https://miro.medium.com/max/1400/1*i5JV9RiF17ftnGDvuqVFSA.png)

## 대응책

### 충돌 처리

충돌은 필연적이기 때문에 충돌 발생 대응 전략이 필요하다.

- Separate Chaining (Open Hashing)
  - 충돌이 발생하면, 버킷에 연결된 새로운 버킷을 할당한다.
  - linked list 형태로 쭉쭉 이어지는 모양이다.
  - 충돌 발생시 linked list 끝에 저장하기 보다는, 전체 순환 O(N) 시간을 아끼기 위해서 head에 저장한다.
  - 요약하면, key & value가 들어오고 key에 해당하는 저장소에 value가 없으면 (key, value)를 저장하고 종료한다. 만약 value가 있다면 (key, value, 다음주소)를 저장하고 다음 주소에 (key, value)를 저장한다. 이런식으로 쭉 연결된 리스트 형태로 저장된다.
- Open Addressing (Closed Hashing)
  - 주어진 value 저장소 공간에서 잘 사용하겠다는 전략이다.
  - 충돌이 발생하면, 같은 규칙을 가지고 다른 버킷의 값으로 이동한다.
  - 이동하는 규칙은 선형, 제곱, 해싱 등 다양한 방법이 있다. 선형은 클러스터를 형성하고, 제곱은 클러스터에서 탈출이 쉽다 등 서로 다른 장단점을 가진다.
  - Open Addressing 방식은 Delete의 경우에 바로 처리가 번거롭다.
  - 요약하면, key & value가 들어오고 key에 해당하는 저장소에 value가 없으면 (key, value)를 저장하고 종료한다. 만약 value가 있으면 규칙에 따라 다음 버킷으로 이동해서 (key, value)를 저장한다.

### Array size

저장소를 직접 만들어 사용하지 않는다면 array size를 계산할 필요가 없다. 하지만 직접 array를 만들어서, 해쉬함수 및 모듈러 함수(array capacity에 들어가게 함)를 만든다면 array size를 정해야 한다.

보통은 작게 만들고, 상황에 따라 키운다고 한다. 하지만 함수 전략에 따라서 array를 키울때 모든 key, value를 재배치 해야할 수도 있다. 정확한 규칙이 있는것은 아니지만 70% 공간이 사용되었을때 확장한다는 글도 있었다. 이는 open addressing에 대한 대응이고, separate chaining 전략을 사용한다면 리스트 깊이까지 판단해야 한다.

## Java의 전략

JDK 8 이전에는 Separate Chaining 방식을 이용해서 충돌을 회피하였다.

JDK 8부터는 Separate Chaining의 방식에 linked list가 아닌 레드블랙트리를 이용하여 탐색에서 효율을 높였다. linked list가 O(n)이라면 레드블랙트리는 O(log n) 탐색속도를 가진다.

정확하게는 5개 까지 충돌은 linked list를 사용하다가 6개가 되면 트리형태로 변환한다. 이는 찾은 트리 교체를 방지하는 장점이있다.

## Python의 전략

Python의 dictionary는 Hash table과 유사하다. 충돌 회피 전략으로 Open Addressing을 사용한다.
