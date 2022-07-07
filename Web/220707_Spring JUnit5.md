# JUnit5

> JUnit5를 사용하기 위해 전반적인 원리와 사용법을 정리한다.
>
> Junit 설치가 된 상황으로 시작한다. (각 환경에 맞게 라이브러리 추가)

## 실행 환경

JUnit에서 각 메소드를 실행하기 위해서 클래스는 인스턴스를 생성해야한다. 이때 `@Test` 어노테이션이 붙은 메소드 별로 각각의 인스턴스를 생성한다. 따라서 클래스 내부에 전역변수가 있다고 하더라도 각 메소드는 서로 영향을 받지 않는다.

이는 테스트간의 의존성을 없에기 위해 기본 전략으로 채택된다. 이 전략은 변경 가능하다.

## 설정 파일

보통 src/test/resources/junit-platform.properties 에 만든다.

이렇게 생성한 뒤 IDE툴이 인식하도록 설정해줘야한다. 인텔리제이 경우에는 Project Structure에서 설정 가능하다.

여기서 테스트 클래스 인스턴스의 라이프사이클을 변경할 수 있다.

또한, 확장팩 자동감지, Disabled 작용여부 등등 설정을 할 수 있다.

## 작성 기본

```java
@Test
void func() {
	// 테스트 내용
}
```

## 라이프 사이클 함수

```java
@BeforAll
static void func1() {
	// 내용 입력
}

@BeforEach
void func1() {
	// 내용 입력
}
```

BeforeAll, AfterAll 함수는 static 이어야 하며, void 리턴만 가능하다.

BeforeEach, AfterEach는 static일 필요가 없으며, void 리턴만 가능하다.

## 특수함수

### 실행 조절

- `@Disabled` 실행 시키지 않는다
- `@EnabledOnJre(JRE.JAVA_11)` 자바 11에서만 실행한다.

### 이름 표시

> 이름 작성하지 않을 시 함수 이름이 출력됨 클래스와 메소드에 사용할 수 있다.

`@DisplayNameGeneration(class)` 출력할 이름에 대한 전략을 만든다.

`@DisplayName(”string”)` 문자열을 이름으로 사용한다.

## Assertion

> 기본적으로 junit.jupiter.api.Assertions.*이 static import되어있다.

- `assertNotNull(객체)` 객체가 null이 아니길 기대한다.
- `assertEquals(기대값, 실행값, 메세지)` 기대값과 실행값이 같기를 기대한다. 테스트가 실패하면 작성된 메세지를 확인하려는 목적으로 작성한다. 메시지는 `() -> "String"` 으로 작성하면 좋다. 그 이유는 여기에 일반 텍스트를 넣으면 문자열 연산이 발생하는데, 람다 표현식으로 넣으면 필요한 경우에만 문자열 연산을 하기때문에 성능에 유익하다.
- `assertTrue(실행값, 메세지)` 실행 조건문이 True가 나오기 기대한다. 부등호 등 if 뒤에 처럼 사용할 수 있다.
- `assetThrows(기대에러, 실행함수)` 실행시 기대 에러 발생을 기대한다. 실행 함수는 `() → new Func()` 형식으로 넣을 수 있다.
- `assetTimeout(기대시간, 실행함수)` 실행시 기대 시간 이내에 끝나기를 기대한다. 기대 시간은 `Duration.ofMillis()` 등 넣을 수 있다. 실행 함수는 `() → new Func()` 형식으로 넣을 수 있다. 이 함수는 실행함수가 완전히 끝나고 시간을 비교한다. 만약 실행함수가 끝나기전에 기대 시간을 초과하면 바로 종료시키기 원한다면 `assertTimeoutPreemptively` 를 사용하면 된다. 이 함수는 스레드로컬을 사용하기때문에 주위가 필요하다. 예를들면 트랜젝션이 묶여있는 코드에서 이 함수를 실행할때 스레드로컬로 빠져나와서 트랜젝션 롤백이 진행되지 않을 수 있다.

## 태그

`@Tag()` 를 클래스나 매소드에 붙여서 특정 태그만 실행시킬 수 있다. 이는 인텔리제이 설정에서 선택할 수 있다.

Tag는 다양한 범주로 설정할 수 있는데, 예를들면 fast와 slow를 나눠서 로컬에서는 fast 테스트만 실행하도록 하거나, 중요도를 나눠서 테스트를 할 수 있다.

## 반복 테스트

`RepeatedTest(숫자)`를 이용해서 반복시킬 수 있다.

테스트 함수 인자로 `RepetitionInfo repetitionInfo` 인자를 통해 몇번째 반복인지 확인 가능하다.

아래와같이 반복적인 인자를 받게 할 수 있다.

```java
@ParameterizedTest
@ValueSource(strings = {"s1", "s2", "s3", "s4"})
void parameterizedTest(String message) {
	// 테스트 내용
}
```

문자열 이외에도 다양한 타입의 값을 넘길 수 있다.

## 확장 모델

JUnit4같은 경우엔 Runwith 등을 사용했다. JUnit5에서는 Extension만 사용한다.

확장 모델은 직접 구현하여 사용할 수 있다.
