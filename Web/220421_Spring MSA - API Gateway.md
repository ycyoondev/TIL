# Spring MSA - API Gateway

### MSA란

모노리틱 구조의 서비스를 여러개의 서비스로 쪼개어 관리하는 아키텍쳐다.



### API Gateway 필요성과 역할

MSA 구조 특성상 사용자의 요청을 알맞는 서버에 전달해야 한다. 따라서 클라이언트의 요청을 받는 로직이 필요하다. 또한, 보안과 같이 모든 서버에 공통적으로 필요한 로직들이 있다면, 맨 앞의 서버가 처리하는게 효과적이다.



### API Gateway 특징

- API gateway는 가장 앞에서 request 엔드포인트를 담당합니다.
- 모든 요청을 처리하는 통로이기에 인증/인가 처리에 유리하며, 트래픽 모니터링이 가능합니다.
- URI에 따라서 알맞는 서버로 보내주는 동적 라우팅이 가능합니다.
- 트래픽이 급증할때 scale-out 처리가 되지 않는다면 병목현상을 유발 할 수 있습니다.



### API Gateway 이점

- 단일 인터페이스 접근 방식을 통해 API 및 백엔드 시스템을 더욱 안전하게 보장
- 보안 및 액세스 제어, 조절, 라우팅, 중개 및 SLA 관리를 위한 확장 가능한 정책을 사용하여 API 실행 환경을 완전히 제어할 수 있습니다.
- 서비스와 애플리케이션 사용자 모두를 위한 간단한 코드 작성
- 더 적은 왕복 호출로 인해 시간이 지남에 따라 지연 시간 감소
- 모든 마이크로서비스에 더 빠르고 쉽게 액세스
- 각 개별 마이크로서비스 또는로드 밸런싱에 대한 워크로드 감소
- 포괄적인 메트릭 수집



### 대표적인 툴

#### Netflix Zuul

MSA의 대표 주자인 Netflix에서 만든 오픈소스이다.

#### Spring Cloud Gateway

Spring의 개발 철학을 바탕으로 이후에 등장한 기능이다. Netty 기반으로 동작하기 때문에 servlet, war로 빌드 된 경우에는 동작하지 않는다.



### 주요 기능

#### 인증/인가

> https://bcho.tistory.com/1005
