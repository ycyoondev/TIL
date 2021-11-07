# 211107 TIL

> Javascrit 문법 중 헷갈리는 쉬운 규칙들을 정리해둔다. 자주 보면서 자연스럽게 익숙해지고 싶다.



### DOM 조작

- 요소 생성
  - `const ulTag = Document.create('ul')` 
    - 빈요소 생성
- 요소 선택
  - `const aa = Document.querySelector('css 선택자와 유사')`
    - 해당되는 가장 위 요소 하나를 선택
    - 없으면 null 반환
  - `const aas = Document.querySelectorAll('css 선택자와 유사')`
    - 전체 요소를 NodeList로 반환 (forEach로 풀어서 사용)
- 요소 삽입
  - `ulTag.append(aa, bb, cc)` 
    - 반환값 없음
    - 문자열 추가 가능
  - `const aaa = ulTag.appendChild(aa)`
    - 문자열은 추가 불가
    - 하나의 Node 객체만 허용
    - 추가된 객체 반환
- 내용 변경
  - `liTag.innerText = '변경'`
  - `liTag.innerHTML = '<a>링크<a>'`
    - XSS 공격에 취약
- 요소 삭제
  - `liTag.remove()`
  - `const aaaa = liTag.removeChild()`
    - 자식 노드 삭제 후 반환함
- 속성 변경
  - `liTag.setAttribute('class', 'text-black')`
    - 속성값이 없이면 생성, 이미 존재하면 갱신
  - `const abc = liTag.getAttribute('class')`
    - 해당 속성 반환



### Event 이벤트

- 이벤트 발생 대상 선택
  - `const btnTag = Document.querySelector('button')` 
- 이벤트 트리거 지정
  - `btn.addEventListener('click', 콜백함수)`
    - 콜백함수는 event 인자를 받을 수 있음.
  - `event.preventDefault()`
    - 이벤트 기본 동작을 정지
    - `scroll`과같이 취소할 수 없는 이벤트가 있으며, `event.cancelable`로 확인

