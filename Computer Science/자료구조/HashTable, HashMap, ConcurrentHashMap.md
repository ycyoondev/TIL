# HashTable, HashMap, ConcurrentHashMap

> Map (Dictionary) 자료형에 사용되는 구현체는 다양하다. 여기에 사용되는 개념에서 Hash에 집중할 수 도있고 메모리나 속도 등 리소스에 집중할 수 있다. 본 글에서는 Thread-safe 관점에서  비교하였다.



## HashTable (Python: Dictionary)

Java에서 HashMap과 HashTable은 Map 인터페이스를 상속받아 구현된다.

사용 방법은 유사하다.

- Key - value 형태의 자료형이다.
- 다중 스레드 환경에서 동기화를 지원한다. (HashMap과 차이)
  - 이는 순회를 위해 Enumeration을 반환하기 때문이다.
  - Enumeration는 remove 메소드를 사용할 수 없다.
  - 동기화(synchroized)를 위해 락을 거는데 이 과정에서 시간 소모가 크다.
- 동기화를 위해서라면 HashTable이 아닌 ConcurrentHashMap이 권장된다.
- key, value에 null을 사용할 수 없다.

## HashMap

- Key - value 형태의 자료형이다.
- HashTable에 비해 빠르다.
- 다중 스레드 환경에서 동기화를 지원하지 않는다.
  - 이는 순회를 위해 Iterator를 반환하기 때문이다.
  - Iterator은 key를 list데이터 구조로 다시 만들어 적용하는 구조이다. 따라서 속도가 Enumeration에 비해 느리다. 하지만 스레드 unblock을 기다리지 않기때문에 전체적인 속도는 HashMap이 HashTable보다 빠르다.
  - 속도는 느리지만 유지보수와 유연성이 더 좋다는 장점 때문에 Iterator가 사용되는 추세이다. Iterator은 다양한 부가기능을 제공한다.
  - Iterator는 Fail-Fast 반환으로 실행전에 오류를 파악하고 에러를 생성할 수 있다.
- key, value에 null이 들어갈 수 있다.

## ConcurrentHashMap

- Key - value 형태의 자료형이다.
- 다중 스레드 환경에서 동기화를 지원한다.
  - 동기화 처리를위해 힙 영역에서 Entry를 조작하는 경우 해당 Entry에 대한 락을 건다. (Map의 일부만 lock을 건다)
  - HashTable보다 데이터를 다루는 속도가 빠르다.
- key, value에 null이 들어갈 수 없다.



## 정리

| **ConcurrentHashMap                                          | **SynchronizedMap                                            | **HashTable**                                                |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| We will get thread safety without locking the total map object just with a bucket level lock. | We will get thread safety by locking the whole map object.   | We will get thread safety by locking the whole map object    |
| At a time multiple threads are allowed to operate on map objects safely. | At a time only one thread is allowed to perform any operation on a map object. | At a time one thread is allowed to operate on a map object.  |
| Read operation can be performed without lock but write operation can be performed with bucket level lock. | Every read and write operations required total map object    | Every read and write operations required total map object    |
| While one thread iterating map objects the other thread is allowed to modify the map and won’t get ConcurrentModificationException. | While one thread iterating map object the other threads are not allowed to modify the map otherwise we will get ConcurrentModificationException | While one thread iterating map object the other threads are not allowed to modify the map otherwise we will get ConcurrentModificationException |
| Iterator of ConcurrentHashMap is fail-safe and won’t raise ConcurrentModificationException | Iterator of SynchronizedMap is fail-fast and it will raise ConcurrentModificationException | Iterator of HashTable is fail-fast and it will raise ConcurrentModificationException |
| Null is not allowed for both keys and values.                | Null is allowed for both keys and values                     | Null is not allowed for both keys and values.                |
| Introduce in java 1.5version                                 | Introduce in java 1.2 version                                | Introduce in java 1.0version                                 |

