# Spring MSA - Fluentd

### 개요

Fluentd는 로그 수집기다. 다양한 로그들을 수집할 수 있으며 HTTP, TCP 같은 네트워크 수집도 가능하다. Fluentd로 전달된 데이터는 tag, time, JSON 으로 구성된다. 가공된 데이터를 Elasticsearch, S3 등 관리 프로그램에 보낼 수 있다.

### 아키텍처

#### 기본 구조

![img](https://t1.daumcdn.net/cfile/tistory/2672EE3C575EBE6507)

가장 기본적인 방법으로, Fluentd를 이용해 생성된 로그를 저장소에 저장한다.

#### 전처리 포함

![img](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F99cc8113-f278-4ccd-9dae-045184eeaa53%2FUntitled.png?table=block&id=715966d7-0587-4779-83ab-f37c87989b07&spaceId=d63fd706-3d84-46de-bed5-a315277ec10a&width=1920&userId=878ba2cc-ea9d-4360-af76-79b5c3031b62&cache=v2)

Fluentd를 한번 거쳐서 저장소에 저장되는 방식이다. 공통적으로 처리해야 하는 로직이 있다면 더 효율적인 구조이다.

#### 저장소 분산

![img](https://t1.daumcdn.net/cfile/tistory/22638D3C575EBE6816)

저장되는 로그의 트래픽을 조절해서 저장소의 용량에 맞게 보낼 수 있다. 또한 이후 알게될 tag를 통해서 알맞은 저장소에 라우팅할 수 있다.

### Fluentd 처리 데이터 특징

#### Event

Fluentd가 읽은 데이터는 tag, time, json으로 구성된 이벤트(event)로 처리된다.

- tag: 이벤트를 어디로 보낼지 결정하는 구분자
- time: 시간
- json: 기록 데이터 (다른 형식도 가능하다)

#### Tag

생성된 log에 tag를 붙여서 다루기 위해 필요하다. Tag를 통해서 output 플러그인으로 찾아서 이동한다.

```xml
# tag 사용 예시
<source>
  @type tail
  tag dev.sample
  path /var/log/sample.log
</source>

<match dev.sample>
  @type stdout
<match>
```

### Fluentd 사용 예시

- 어플리케이션 로그를 한곳으로 모으기 (예: [Python 로그](https://docs.fluentd.org/v1.0/articles/python), [PHP 로그](https://docs.fluentd.org/v1.0/articles/php))
- 서비스 로그 모니터링 (예: Elasticsearch와 Kibana)
- 데이터 분석을 위한 hdfs로 적재하기
- AWS S3로 데이터 저장
- Stream 데이터 처리

### Fluentd 흐름

원하는 기능을 설정 파일에 추가하는 방식으로 구성한다.

전체 동작은 Input -> Filter -> Buffer -> Output 이다.

이는 7개의 컴포넌트로 구성된다. (Input, Parser, Engine, Filter, Buffer, Ouput, Formatter)

![img](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FccoJ8N%2FbtrdqinfnM3%2F82BVY53yLqplNO5OMc8wCk%2Fimg.png)

### Fluentd 내부구조

![img](https://t1.daumcdn.net/cfile/tistory/2252EF3C575EBE5B24)Input

- - 로그를 수집하는 플러그인이다.
  - HTTP, tail, TCP 등 기본 플러그인 이외에도, 확장 플러그인을 통해서 다양한 서버나 애플리케이션으로 부터 다양한 포맷의 데이타를 수집할 수 있도록 해준다.
- Filter (optional)
  - 3가지 중간 처리를 할 수 있다.
  - 필터링, 데이터 필드 추가, 데이터 필드 삭제
- Output
  - 필터링된 데이터를 저장소에 저장한다.
  - 저장소는 mongodb, AWS S3, Google
