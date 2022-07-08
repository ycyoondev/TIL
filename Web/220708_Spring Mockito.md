# Mockito

## 개요

Mock을 만드는 라이브러리이다. 그렇다면 Mock이란 무엇인가. Mock은 진짜 객체와 비슷하게 동작하지만 사실은 프로그래머가 직접 그 행동을 관리하는 객체를 말한다. 우리가 단위테스트를 할때 참조되는 다른 객체나 API를 전부 불러와서 테스트하기는 어렵다. 따라서 외부의 객체는 약속된 동작을 한다고 주어지고 테스트를 하게 도와주는 객체이다. 인스턴스만 있고 구현체가 없는 경우에 사용할 수 있다.

Mockito는 Mock을 쉽게 만들고 관리하고 검증하는 방법을 제공하는 라이브러리이다.

- 단위테스트: 단위를 정의하는 범위는 다양하다. 단위를 객체로 줄였을 때, Mock을 적용할 수 있는데 Mock을 정하는 범위가 어떻게 할지는 팀에서 정해야한다.

## 환경설정

spring-boot-starter-test에 라이브러리가 포함된다.

## Mock 객체 만들기

```java
@ExtendWith(MockitoExtension.class)
public class ServiceTest {
		
	@Mock
	MemberService memberService;

	@Test
	void createServiceTest() {
		// 테스트 내용
	}
}
```

Extendwith로 확장하고, Mock 어노테이션을 이용해서 만들 수 있다.

## Mock 객체 행동 정의 (Stubbing)

- `when(실행 행동).thenReturn(반환값)` 해당 메소드가 실행될때 이 값을 반환해라.
- 실행 행동을 정할때 `any()`를 사용하여 입력값을 정할 수 있다.
- `thenThrow()`를 통해서 에러를 던질 수 있다.
- `.thenXXX()`을 연속적으로 사용해서 호출되는 순서에 따라서 다른 객체를 반환할 수 있다.

## Mock 행동 확인

- `verify(Mock인스턴스, times(2)).notify(any())` 매개변수 뭐든 상관없이 인스턴스는 2번 호출되어야 한다. 호출되지 않는것을 확인하려면 `never()`를 사용하면 된다.
- `inOrder`를 이용하면 호출되는 순서를 검증할 수 있다.

## Mockito DBB 스타일

TDD 개념에 입각해서 테스트하는 방법이다. 객체의 행동을 어떻게 진행할지 정의하고 개발하는 것이다. given, when, then 구조로 개발한다. 이는 같은 기능을 하는데 관점의 차이

- 위에 `when().thenReturn()`과 동일한 기능을 하는 `given().willReturn()`으로 만들 수 있다.
- verify()와 통일하게 `then(Mock인스턴스).should(times(2)).notify(any())`로 만들 수 있다.
