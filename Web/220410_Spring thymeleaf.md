# Spring Thymeleaf

> 타임리프는 Django HTML, Spring jsp와 유사한 view 템플릿 입니다. 이는 개발자가 편리하게 서버 사이드 렌더링(SSR) 페이지를 개발할 수 있게 도와줍니다. 
>
> JSP를 사용하다가 앞으로 효율성이 더 좋은 Thymeleaf가 대세가 되는것 같아 사용법 위주로 정리해보았습니다. SSR 개발 경험이 있으면 어렵지 않을 것 같습니다.



### **타임리프 설정**

```
<html xmlns:th="<http://www.thymeleaf.org>">
```

`<!DOCTYPE html>`아래 위치에 설정

### **텍스트**

**태그 내부에서 출력**

```
<span th:text="${data}"></span>
```

**컨텐츠 안에서 직접 출력**

```
[[${data}]]
```

data는 변수가 될수도 있고, list.getName(), map[] 등의 방법으로도 꺼낼 수 있다.

### **변수**

**일반적**

변수 표현식 : `${...}`

**지역변수**

```
<h1>지역 변수 - (th:with)</h1>
<div th:with="localData=${data}">
    <p>지역변수는 <span th:text="${localData}"></span></p>
</div>
```

지역변수는 선언한 테그 내부서에서만 효과가 있다.

### **기본객체**

**기본객체** 목록

- ${#request}
  - HttpServletRequest 객체가 제공된다고 생각하면 된다.
  - request.getParameter("data") 같이 사용 가능하다.
- ${#response}
- ${#session}
- ${#servletContext}
- ${#locale}

**편의객체** 목록

- HTTP 요청 파라미터 접근: param
  - ${param.paramData}
- HTTP 세션 접근: session
  - ${session.sessionData}
- 스프링 빈 접근: @
  - ${@helloBean.hello('Spring!')}

### **유틸리티 객체와 날씨**

> 공식 문서에 정리가 잘되어있다.

- 타임리프 유틸리티 객체: https://www.thymeleaf.org/doc/tutorials/3.0/usingthymeleaf.html#expression-utilityobjects

- 유틸리티 객체 예시: https://www.thymeleaf.org/doc/tutorials/3.0/usingthymeleaf.html#appendix-b-expressionutility-objects

### **URL 링크**

> 공식문서: https://www.thymeleaf.org/doc/tutorials/3.0/usingthymeleaf.html#link-urls

**일반적**

링크 표현식 : `@{...}`

하이퍼링크로 렌더링됨

**파라미터**

```
@{/hello(param1=${param1}, param2=${param2})}` -> `/hello?param1=data1&param2=data2
```

**경로변수**

```
@{/hello/{param1}/{param2}(param1=${param1}, param2=${param2})}` -> `/hello/data1/data2
```

**상대경로/절대경로**

상대경로: `/hello`

절대경로: `hello`

### **리터럴**

> 같은 리터럴이나 띄어쓰기로 인해 파싱을 못한다는 오류가 많이 발생한다. 아래 방법을 생각해야 이를 해결할 수 있다.

**일반적 표현**

```
<span th:text="'hello'">
```

**리터럴 대체**

```
<span th:text="|hello ${data}|">
```

### **연산**

> 연산은 자바의 조건과 유사하다.

`>`(gt), `<`(lt), `>=` (ge), `<=`(le), `!` (not), `==` (eq), `!=` (neq, ne)

### **속성 값 설정**

**개념**

타임리프는 주로 HTML 태그에 `th:*` 속성을 지정하는 방식으로 동작한다. `th:*` 로 속성을 적용하면 기존 속성을 대체한다.

기존 속성이 없으면 새로 만든다.

**속성 추가**

- ```
  th:attrappend
  ```

   : 속성 값의 뒤에 값을 추가한다.

  - `th:attrappend="class=' large'"` 처럼 사용

- `th:attrprepend` : 속성 값의 앞에 값을 추가한다.

- `th:classappend` : class 속성에 자연스럽게 추가한다.

**논리 처리 (checked)**

```
<input type="checkbox" name="active" th:checked="false" />` -> `<input type="checkbox" name="active" />
```

### **반복**

**예시**

```
<tr th:each="user : ${users}">
    <td th:text="${user.username}">username</td>
    <td th:text="${user.age}">0</td>
</tr>
```

### **조건부 평가**

조건식: `if`, `unless` (if의 반대)

조건에 해당되지 않으면 태그 자체를 렌더링하지 않는다.

Vue의 if와 기능이 유사하다.

### **블록**

**일반**

```
<th:block>
```

속성이 아닌 태그이다.

HTML 태그안에 속성으로 기능을 정의해서 사용하는데, 위 예처럼 이렇게 사용하기 애매한 경우에 사용하면 된다. `<th:block>`은 렌더링시 제거된다.

### **자바스크립트 인라인**

**일반**

```
<script th:inline="javascript">
    var username = [[${user.username}]];
</script>
```

### **템플릿 조각**

> 컴포넌트와 비슷한 개념이다

**복사하려는 조각 대상**

```
th:fragment
```

**사용예시**

`template/fragment/footer :: copy : template/fragment/footer.html` 템플릿에 있는 `th:fragment="copy"` 라는 부분을 템플릿 조각으로 가져와서 사용한다는 의미이다.
