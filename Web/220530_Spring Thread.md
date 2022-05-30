# Spring Thread

> Spring에서 Thread를 어떻게 처리하는지 궁금증이 들었습니다. 동시에 많은 요청이 들어올때 Thread safe하게 처리되는것 같은데, 정말 safe한지? 그렇다면 어떻게 safe하게 하는지 공부한다.

## Spring 여러 요청 처리

MVC Flow는 스프링이 어떻게 하나의 요청을 처리하는지 알려준다. 본 글은 여러 요청이 동시에 왔을때 Spring이 어떻게 처리하는지 확인한다.

![img](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F3856fd0e-85c0-4670-8476-39bad53368b3%2FUntitled.png?table=block&id=5f5eab91-af92-40e6-bb3e-59786eef62bb&spaceId=d63fd706-3d84-46de-bed5-a315277ec10a&width=1920&userId=878ba2cc-ea9d-4360-af76-79b5c3031b62&cache=v2)정확하게 말하면 Spring이 다중 요청을 처리하는것이 아니라 Tomcat에서 다중 요청을 처리한다. 이러한 서비스를 서블릿 컨테이너라고 한다.

서블릿 컨테이너는 서블릿의 생성, 실행, 파괴 (life cycle) 를 담당한다. 서버에 요청이 들어오면 서블릿 컨테이너로 전달되어 서블릿을 생성하는 것이다.

## 내장 톰캣 Thread 설정

```yaml
# application.yml (적어놓은 값은 default)
server:
  tomcat:
    threads:
      max: 200 # 생성할 수 있는 thread의 총 개수
      min-spare: 10 # 항상 활성화 되어있는(idle) thread의 개수
    max-connections: 8192 # 수립가능한 connection의 총 개수
    accept-count: 100 # 작업큐의 사이즈
    connection-timeout: 20000 # timeout 판단 기준 시간, 20초
  port: 8080 # 서버를 띄울 포트번호
```

### Thread pool

![img](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fa48cb11b-9783-4a7f-aeeb-647975788311%2FUntitled.png?table=block&id=99fafcd6-c377-4ffc-9e08-df542954bb6b&spaceId=d63fd706-3d84-46de-bed5-a315277ec10a&width=1920&userId=878ba2cc-ea9d-4360-af76-79b5c3031b62&cache=v2)Spring은 톰캣 서버가 올라가는 시점에 정해진 수의 Thread를 미리 생성한다. 그리고 클라이언트로부터 오는 Task를 큐에 저장하고, 순차적으로 Thread에 배정하여 로직을 처리한다.

만약 작업가능한 Thread가 없다면 큐에 대기한다. 큐가 꽉찬다면 Thread를 더 생성할 수 있고, connection-refused 오류를 반환할 수 있다.

그렇다면 생성 한계까지 Thread가 있고, 모든 Thread가 작업중이며, Queue가 꽉찼다면 에러가 발생해야 할것이다. 하지만, 톰켓 8.0부터는 이러한 상황에서 대응해준다. 이러한 동작은 NIO Connector에서 수행된다.

### NIO Connector

![img](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Feb254143-5967-48e8-91d2-f48f5c96a564%2FUntitled.png?table=block&id=b0c9cab3-df6e-4dcf-87f6-cab575a8663a&spaceId=d63fd706-3d84-46de-bed5-a315277ec10a&width=1920&userId=878ba2cc-ea9d-4360-af76-79b5c3031b62&cache=v2)NIO Connector에선 Poller라고 하는 별도의 스레드가 커넥션을 처리한다. Poller는 Socket들을 캐시로 들고 있다가 해당 Socket에서 data에 대한 처리가 가능한 순간에만 thread를 할당하는 방식을 사용해서 thread이 idle 상태로 낭비되는 시간을 줄여준다.

![img](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F213eea46-8241-4e8d-ab85-c60a84244e99%2FUntitled.png?table=block&id=6323c7ff-8843-4844-a598-8e7064828ed7&spaceId=d63fd706-3d84-46de-bed5-a315277ec10a&width=1920&userId=878ba2cc-ea9d-4360-af76-79b5c3031b62&cache=v2)
