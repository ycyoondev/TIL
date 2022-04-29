# Spring MSA - Eureka

### MSA란

모노리틱 구조의 서비스를 여러개의 서비스로 쪼개어 관리하는 아키텍쳐다.

### 개요

MSA 구조의 시스템에서 로드 밸런싱과 실패 처리 등을 유연하게 가져가기 위해 각 서비스들의 IP, Port, InstanceId를 가진 미들웨어 서버이다.

MSA 특성 상 Service의 IP와 Port가 일정하지 않고 지속적으로 변한다. 따라서 서비스를 호출할때 서비스의 위치를 찾아야 한다. 이러한 기능을 Service Discovery 라고 한다.

![img](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcRtMzj%2FbtqBLjccv9N%2F7bPaaBbFoPjf7zTKYl5v1K%2Fimg.png)

각 서버들은 Eureka에 자신의 IP, Port, InstanceId를 등록합니다. 그리고 이용하려는 서비스의 주소를 찾습니다. 이러한 통신은 REST 통신으로 진행되어 서버 언어에 상관없습니다.

### 구조

![img](https://t1.daumcdn.net/cfile/tistory/99D5AA3F5C5C265933)

- Eureka Client
  - 서비스가 시작될때 자신의 IP, Port, InstanceId를 Eureka server에 넘긴다. 이를 Fetch한다고 한다.
  - 등록된 이후 30초마다 Eureka server에 ping을 보낸다. Health check를 위함이다.
- Eureka Server
  - 클라이언트 정보를 저장하고 있다.
  - 클라이언트에게 저장된 서버와 주소 정보를 보내준다. 이는 30초마다 갱신된다.
  - 서버가 보내는 Ping을 통해서 서버 정상 동작을 확인한다. Ping이 날라오지 않으면 해당 서비스가 죽었다고 판단하고 레지스트리에서 제외한다.

### 적용 방법

Dependency 추가

```java
compile('org.springframework.cloud:spring-cloud-starter-netflix-eureka-server')
```

application.yml 설정 추가

```yaml
# -- Server Port
server:
  port: 8787

# -- Eureka
eureka:
  instance:
    hostname: 127.0.0.1
  client:
    serviceUrl:
      defaultZone: <http://$>{eureka.instance.hostname}:${server.port}/eureka/
    register-with-eureka: false
    fetch-registry: false
```

[Application.java](http://Application.java)에 어노테이션 추가

```java
@EnableEurekaServer
@SpringBootApplication

public class EurekaServerApplication {

  public static void main(String[] args) {
    SpringApplication.run(EurekaServerApplication.class, args);
  }
}
```

이후 http://127.0.0.1:8787에서 GUI를 사용할 수 있다.

