# Spring AOP

### AOP가 왜 필요한가

프로그램은 핵심 기능과 부가 기능이 있다. 핵심 기능이랑 서비스에서 중요한 비즈니스 로직을 수행하는것이다. 필수적인 기능이라고 생각한다. 부가 기능은 서비스를 보조하기 위한 기능이다. 부가기능이 멈추더라도 서비스가 돌아갈 수 있다고 생각한다.

프로그램이 돌아갈때 핵심 기능과 부가 기능을 분리하여 개발하면, 부가 기능을 재사용하기 유리하다. 또한 관심사를 분리하여 유지보수에 유리하다. 이러한 분리를 효율적으로 만드는 Spring 방법이 AOP이다.

### 에스팩트

에스팩트는 부가 기능과 해당 부가 기능을 어디에 적용할지 정의한 것이다. 에스팩트는 관점이란 뜻인데, 어플리케이션을 바라보는 관점을 하나하나의 기능에서 괌심사 관점으로 보겠다는 것이다. 이를 사용한 방법이 Aspect Oriented Programming (AOP) 이다.

AOP는 OOP를 대체하기 위한 것이 아니라 횡단 관심사 (공통 관심사)를 처리하기 어려운 OOP의 부족한 부분을 보조한다고 보는것에 좋다.

### AOP 적용 방식

- 컴파일 시점에 적용
  - `.java` 소스 코드를 컴파일러를 통해 `.class`를 만드는 시점에서 부가 기능 로직을 추가 할 수 있다.
  - 이는 AspectJ 프레임워크가 제공하는 특별한 컴파일러를 사용해야 한다. AspectJ가 부가 기능을 적용해야 하는 핵심 기능 코드인지 확인하고 맞다면 부가 기능을 적용해서 컴파일하는 방식이다.
  - 결국 핵심 기능이 있는 코드에 부가 기능의 코드가 섞여 들어간다고 생각할 수 있다.
  - 이러한 방식을 Weaving(워빙)이라고 부른다.
  - **단점**은 특별한 컴파일러가 필요하다는 불편으로 잘 사용하지 않는다.
- 클래스 로딩 시점에 적용
  - JVM이 .class 파일 내부 클래스 로더에 보관하다가 JVM 실행 환경으로 가는 시점에서 확인하고 조작해서 부가 기능을 넣어준다.
  - 이러한 방식을 로드 타임 위빙이라고 부른다.
  - **단점**은 자바를 실행할 때 특별한 옵션인 `java-javaagent`을 통해서 클래스 로더 조작기를 지정해야 하는데 이부분이 번거롭다.
- 런타임 시점에 적용 (프록시)
  - 런타임 시점이란 컴파일과 클래스 로딩이 완료된 후 진행된다. 이는 java의 `main`이 실행된 후이다. 따라서 java 자체 로직으로 부가 기능을 적용해야 한다.
  - 이는 빈 후처리기 (Bean postprocesser)을 통해서 프록시가 부가 기능을 적용해준다. 즉, Bean이 생성되어 컨테이너에 올라갈때 부가기능이 적용된 체로 올라가는 것이다.
  - 프록시를 사용하기 때문에 AOP 일부 기능을 사용하지 못한다. 하지만, 가장 단순하게 AOP 부가기능을 적용할 수 있어 편리하다. 또한 AspectJ를 사용하지 않아도 된다.



### AOP 적용지점 (Join point)

적용 지점: 생성자, 필드 값 접근, static 메서드 접근, 메서드 실행

- AspectJ는 위 모든 지점을 다 적용할 수 있다.
- 런타임 시점에 적용하는 프록시 방식은 메서드 실행 시점에서만 적용할 수 있다.
  - 프록시는 메서드 오버라이딩 개념으로 동작한다. 따라서 static과 필드값에는 접근할 수 없다.
  - 결국 스프링 빈에만 AOP를 적용할 수 있다.



### 주요 AOP 용어

#### 어드바이스

- 부가 기능을 저의한 코드이다.
- 코드 모듈이라고 생각할 수 있다.

#### 포인트컷

- 어드바이스를 적용할 타겟의 메서드를 알려주는 정규 표현식이다.
- 표현식은 execution으로 시작하고 메서드의 Signature을 비교하는 방식이 주로 사용된다. (AspectJ 표현식)

#### 에스펙트

- 위 어드바이스와 포인트컷을 합쳐서 부른다.
- AOP의 기본 모듈이며 싱글톤 형태로 있다.

#### Join point

- 어드바이저를 적용하는 위치이다.
- 추상적인 개념이며 AOP가 적용되는 부분을 생각할 수 있다.