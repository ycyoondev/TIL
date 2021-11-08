# 211108 TIL

> JavaScript는 비동기적 특징을 가진다. 하지만 부분적으로 동기적인 방법을 제공한다. 이러한 JS의 비동기와 동기적 방식을 정리한다.



### AJAX (Asychoronous JavaScript And XML)

- 비동기적 특징은 코드가 순차적으로 실행되는것이 아니라는 의미이고, 일부 페이지만 업데이트가 가능하게 한다.
- 비동기식 JS로 서버와 통신하기위해 XMLHttpRequest 객체를 사용한다.
- JSON, XML, HTML, TXT 등 다양한 포맷 주고받을 수 있다.



### Asynchronous JavaScript

- 싱글 스레드에서 비동기적 방식을 수행한다.
- 즉시 처리 못하면 Web API에 보내고, 여기서 처리되면 Task queue에 이동된 다음, Event Loop를 통해서 다시 Call stack으로 보내진다.



### Zero delays

- Callback함수는 실행되는데 시간이 필요하기 때문에 `setTimeout`을 사용하더라도 추가되는 시간이 존재한다.



### JS에서 순차적인 비동기 처리하기

- Async callbacks
  - 백그라운드에서 실행을 시작할 함수를 호출할 때 인자로 지정된 함수
  - 예를들면, `addEventListener()`의 두번째 인자
- promise style
  - Modern Web APIs에서의 새로운 코드 스타일
  - XHR 객체를 이용하는 구조보다 더 현대적인 버전
