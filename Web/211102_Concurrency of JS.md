# 211102 TIL

> JS를 공부하며 처음으로 비동기적 개념을 만났다. JS는 왜 이런 기술을 채택했으며, 비동기적 개념과 이와 비교되는 유사 개념(여기선 Parallelism)을 정리한다.



### 비동기성 동기성

#### 코드는 어떻게 수행되는가?

C, Java, Python과 같은 코드를 이용해 알고리즘을 풀거나 간단한 프로그램을 만들면서 느끼는 논리는 위에서 아래로 적용된다. 순차적으로 실행되어야 하며, 한 단계에서 시간이 걸리면 다음 단계는 앞 단계가 끝날때까지 기다린다는 특징을 가진다.

하지만 꼭 이러한 방식이 유용하지 않는 경우가 있다. 위에 내용과 관계없이 아래 내용이 실행되어도 괜찮은데, 위 코드를 기다리느라 아래 내용이 수행되지 않는것은 손해이며 사용자에게 답답함을 느끼게 한다. 

위에 예시로 들은 C, Java, Python도 비동기를 지원하는 다양한 툴이 있으나, 여기선 무시하고 그럼 비동기 언어의 대표적인 예시인 JavaScript를 가지고 이해해 보겠다.



### JS의 비동기적 성질 (Concurrency)

JS 비동기는 `Call Stack`, `Web API`, `Task Queue(Callback Queue)`, `Event Loop`가 복합적으로 동작하면서 수행된다. JS는 단일 스레드 시스템으로 1개의 스레드에서 비동기를 구현하다 보니 이러한 복잡한 방식이 필요하다. 아래 블로그를 보면 좀더 편한 이해가 가능할것이다. 

Ref. https://im-developer.tistory.com/113



### Concurrency vs. Parallelism

Concurrency는 Parallelism과 비교된다.

- 가장 큰 차이점은 Concurrency는 프로그램의 성질이고 Parallelism은 기계의 성질이다.
- JS와 같이 코드 진행 순서에 관계없이 수행이 가능하다면 concurrent하다고 말할 수 있다. 이는 하드웨어가 병렬 연산을 지원하는지와 관계없이 단일 스레드(싱글 코어)에서 진행하는 경우에도 시분할 형태로 작동 되지만 사용자가 보기에는 concurrent하게 만들 수 있다.
- 반면  Parallelism은 코드 실행에서 동시성이기 보다는 하드웨어 관점에서 병렬적으로 수행된다는 의미이다. 하드웨어 지원이 가능한 환경(Multi Core)에서 실제로 동시에 작업이 처리된다. 하지만, 꼭 작동이 비동기적으로 발생하지는 않는다.

Ref.

[https://ko.wikipedia.org/wiki/%EB%B3%91%ED%96%89%EC%84%B1](https://ko.wikipedia.org/wiki/병행성)

https://12bme.tistory.com/184

[https://vallista.kr/2019/12/28/%EB%8F%99%EC%8B%9C%EC%84%B1%EA%B3%BC-%EB%B3%91%EB%A0%AC%EC%84%B1-Concurrency-Parallelism](https://vallista.kr/2019/12/28/동시성과-병렬성-Concurrency-Parallelism)

https://nesoy.github.io/articles/2018-09/OS-Concurrency-Parallelism



