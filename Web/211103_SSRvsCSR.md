# 211103 TIL

> 웹의 다양한 Framework를 비교하면서 프론트에서 출력 방식을 어떻게 정할것인지 궁금증이 생겼다. 연산은 서버에서 하는게 좋을지 클라이언트에서 하는게 좋을지 속도와 자원 효율 면에서 고민은 프론트엔드에서도 비슷하게 나타난다. 가장 큰 접근법이고 적절하게 사용되어야하는 SSR과 CSR의 방식을 정리해본다.



### SSR (Server Side Rendering)

- 가장 기본적인(전통적인) 웹 페이지 방식이다. 페이지를 이동할때 모든 데이터가 서버에서 렌더링되어 HTML파일이 클라이언트에게 전달된다. 이는 불필요한 부분까지 렌더링한다는 단점을 가진다. 또한 서버에서 처리되는 연산이 많아 서버 자원 활용에는 불리하다.
- 페이지 렌더링이 동적으로 진행되어 속도 면에서 CSR보다 빠르게 클라이언트가 정보를 볼 수 있다.
- 초기 렌더링 이후에 큰 변경사항이 없는 경우 주로 채택된다.

### CSR (Client Side Rendering)

- 서버에서 큰 틀을 받아오고, 렌더링은 클라이언트에서 진행된다. 주로 JS가 사용된다.
- 렌더링이 완료된 후 클라이언트에 출력되기에 초기 속도면에서 SSR보다 불리하다. 
- 이후 다른페이지로 이동하는 경우 변경되는 부분만 JS를 통해 변환되어 더 빠른 사용자 경험을 준다.
- 초기에 html 데이터가 없다보니 검색 봇이 해당 페이지를 빈페이지로 착각하여 SEO 검색엔진 최적화에 취약할 수 있는 단점이 존재한다. (구글은 이것도 해결했다고 한다.)
- 쿠키 등 사용자의 정보를 저장하게 되어 XSS 공격에 취약하다.

### SSR vs CSR 비교

- 위에 서로 반대되는 렌더링 위치때문에 발생하는 특징이 있다.
- 극단적으로 하나를 선택해서 웹 페이지를 구성하는것이 아니라 적절한 수준을 고려하여 중간 쯔음의 개념으로 구성하게 된다. 또한, 페이지마다 다르게 구성할 수 있다.

### SEO (Search Engine Optimization) 문제

- 검색 엔진은 웹 페이지 자료를 수집하고 순위를 매기는 방식에 맞게 웹 페이지를 구성해 검색 결과에 나올 수 있게 만든다.
- 각 사이트마다 우선순위 방식은 다르게 적용된다. 구글은 인용 회수 등이 중요하고, 네이버는 사이트가 가진 평점과 키워드 우선순위 등이 중요하다.
- CSR방식의 웹 사이트의 경우에 초기에 html정보가 없는 빈 페이지라면 검색 엔진에 우선순위를 받지 못하게 되는데 이를 SEO 문제라고 한다. 최근에는 이를 해결하기위한 Next.js 등 라이브러리가 등장하고 있다.





> ref.
>
> https://velog.io/@ru_bryunak/SPA-%EC%82%AC%EC%9A%A9%EC%97%90%EC%84%9C%EC%9D%98-SSR%EA%B3%BC-CSR
>
> https://www.sarah-note.com/%ED%81%B4%EB%A1%A0%EC%BD%94%EB%94%A9/posting2/
>
> https://bbbyung2.tistory.com/65
>
> https://ko.wikipedia.org/wiki/%EA%B2%80%EC%83%89_%EC%97%94%EC%A7%84_%EC%B5%9C%EC%A0%81%ED%99%94
>
> 

