# Authentication (사용자 인증)

> Web에서 유저를 인증하는 몇가지 방법이 있다. 각 방법의 방식과 특징을 정리해본다.



## 사용자 인증이란?

서버는 나 하나를 위해서 서비스를 하지 않는다(HTTP는 stateless 성질이다). 따라서 매번 내가 로그인된 사용자임을 스스로 알려줘야 한다. 우리가 아이디 비밀번호를 이용해 로그인을 하면, 서버는 우리에게 인증 방식에 맞게 무언가를 주고, 우리는 그것을 통해서 서버에 지속적으로 우리가 이미 로그인된 사용자임을 알리는 것이다.

이러한 사용자 인증은 보안 문제에 안전해야 하며, 오류가 발생해서는 안된다. 또한 유저가 사용하는데 속도 등에서 편리해야한다. 이를 구현하는 대표적인 방법을 알아보자.



## 인증 방식

> 대표적인 인증방식만 정리하였다.

### 세션/쿠키

#### 세션이란

세션은 한명의 사용자가 특정 서비스에서 무언가를 하고있는 상태 단위이다. 사용자가 로그인을 하고 다시 로그인하지 않고 지속적으로 서비스를 이용하는 단위이다. 따라서 한번 사용자 인증이 성공했다면 세션 동안에 다시 인증이 요구되지 않아야 한다.

#### 쿠키란

위에서 설명한 세션을 유지하기 위해서 서버와 브라우저에서 주고받는 데이터이다. 

#### 동작방식

1. 브라우저에서 서버에게 아이디와 비밀번호를 보낸다.
2. 서버의 미들웨어에서 해시처리되어 서버 DB에 저장된 정보와 일치하는지 비교한다.
3. 서버 정보와 일치한다면, 서버는 사용자(브라우저)에게 쿠키를 준다. 이 쿠키는 인증서 역할을 한다.
4. 앞으로 브라우저는 서버에게 요청을 보낼때 쿠키를 같이 보내서 어떤 사용자인지 알리면서 재 로그인 없이 서비스를 이용한다. 
5. 서버는 요청에 쿠키가 함께 오면, 쿠키를 확인해서 사용자를 파악하고 알맞은 서비스를 제공한다.

#### 특징 (또는 장단점)

- 서버에서 인증을 확인하는 방식으로 클라이언트가 임의로 정보를 조작하더라도 서버는 안전하다.
- 서버가 쿠키를 계속 확인해야 하기때문에 성능면에서 불리하다. 또한 사용자가 많아지면 로드 밸런싱이 필요한데, 이때 세션 관리를 동기화해야한다. 
- 멀티 디바이스 환경에서 로그인 시 중복 로그인 처리를 자동으로 지원하지는 않는다.



### JWT

#### JWT(JSON Web Token)이란

HTTP 요청과 함께 전달되는 서명으로 유저 정보와 비밀키로 구성된다. JWT는 Header, Payload, Signature 3개로 구성되는데, Header에는 암호화 알고리즘정보를, Payload는 유저 정보를, Signature은 서버 정보를 포함한다. 여기서 Payload까지는 누구나 확인이 가능하므로 안전한 정보만 표시한다.

#### 동작방식

1. 브라우저에서 서버에게 아이디와 비밀번호를 보낸다.
2. 서버의 미들웨어에서 해시처리되어 서버 DB에 저장된 정보와 일치하는지 비교한다.
3. 서버 정보와 일치한다면, 서버는 사용자(브라우저)에게 JWT 토큰을 준다. JWT 토큰은 서버의 비밀키로 암호화된 상태이다. 이 토큰은 인증서 역할을 한다. 
4. 이후로 브라우저는 서버에 요청을 보낼때, HTTP 헤더에 JWT 토큰을 함께 보내며 서버는 DB 확이 없이 JWT 자체로 유저 정보와 로그인 여부를 알 수 있다.

#### 특징 (또는 장단점)

- JWT를 브라우저에 저장하므로 서버 입장에서 DB를 사용하지 않아 부담이 적다.
- 서버간의 동기화가 필요없어 로드 밸런싱을 이용한 확장이 좋다. 
- token이 유출되더라도 상관없으므로 안정성이 높다.
- Payload가 커지면 HTTP 요청이 무거워질 수 있다.



> ref.
>
> https://it-eldorado.tistory.com/164
>
> https://millo-l.github.io/JWT-%EA%B8%B0%EB%B0%98-%EC%9D%B8%EC%A6%9D%EB%B0%A9%EC%8B%9D/
>
> https://guiyum.tistory.com/57
>
> https://hororolol.tistory.com/420
