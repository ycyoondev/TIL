# ML 리서치 코드 품질 관리 자동화

> 코드의 품질관리는 개발 협업에 필수적이다. ML 개발자는 보통 개발 경험이 적기때문에 품질관리 자동화를 파이프라인에 넣어야 자동으로 관리가 가능하다.



### 발생되는 문제

#### 코드 중복

소프트웨어 취약점이 있는 코드가 복사될 때, 사본이 많은 경우에 취약점이 해소되지 못하고 계속 남아있게 된다. 이러한 인적 오류들을 많이 부를 수 있고, 수정 시 에너지 소모가 크다.

코드 실행 관점에서도 컴파일 시간이 늘어난다는 단점이 있다.

#### 코드 재사용 불가

소프트웨어는 재사용 가능한 지식 자산이다. 코드를 재사용하기 위해서는 빠르게 기능을 파악하고 쉽게 변경하여 적용할 수 있어야한다. 라이브러리 추상화가 좋은 예시이다. 코드 품질 관리가 되지 않을때, 이러한 재사용성이 떨어지게되어 비효율적이다. 이는 기술 부채로 적용되며 리팩토링을 요구받는다.

#### 전역 변수 충돌

전역변수는 지금은 동작하지만, 이후 충돌의 위험이 항상 있다. 이를 방지하기 위해서 복잡한 전역변수명을 사용시 인지에 어려움을 가져온다. 따라서 가능하면 환경변수를 사용하여 함수에서 파라미터로 사용되어야 한다.

#### 상대 경로를 이용한 import

참조 관계가 얽히게되면 나중에 코드 재사용에서 누락이 발생할 수 있다. pythonpath 환경변수를 활용하여 절대 경로로 import가 재사용에 유리하다. 



### Linter 

python은 PEP-8 스타일 가이드를 통해서 문법의 많은 부분을 표준화하였다. 하지만 이외에도 코드 동작에는 문제가 없으나 사람들간의 차이가 있는 스타일이 존재한다. 이러한 코드 스타일을 통일하기 위해서 다양한 라이브러리들이 있고, python에서 가장 유명한 라이브러리인 black을 추천한다. 이는 py파일 이외에 VS Code 등 IDE에 적용시켜 편하게 이용 가능하다.

black의 사용방법은 다음 링크를 참조하여 연습하였다.

https://www.daleseo.com/python-black/

이외에도 Flake8 등 다양한 라이브러리가 있다.

#### mypy

타입 힌트를 표시하는 라이브러리이다.

아래 링크를 참조하여 연습하였다.

https://www.daleseo.com/python-mypy/



## Continuous Integration (CI)

> 위에서 배운 내용을 바탕으로 지속적으로 코드 품질을 관리하는 파이프라인 만들기

### Github Actions

핫한 CI 툴 중 하나이다. github에 몇가지 파일을 추가하여 쉽게 설정이 가능하다.

### 실습 코드

> 코드 작성후에 black을 실행 후 push해도 되지만, 이를 자동으로 가능하게 만들 수 있다.
>
> 아래 코드를 이용해 push가 발생할때 lint체크를 한다. 

https://github.com/chris-chris/research-ci-tutorial





### Ref.

- https://www.daleseo.com/python-black/
- https://www.daleseo.com/python-mypy/