# 211115 TIL

> 사용자의 만족을 높이기 위해서 SPA는 url을 다르게 보여줘야 한다. Vue에서 이러한 기능을 제공하는 router의 개념과 코드를 정리하였다. 나중에 참고 가능하도록 router 이용 방법에 초점을 두어 작성한다.



## Vue Router는 왜 사용할까

- SPA 등장 이전에는 서버가 모든 라우팅을 담당하였다. 따라서 자연스럽게 요청에 맞는 html을 전달할 수 있었다. 하지만 SPA등장 이후에 서버는 index.html 단일 파일만 제공한다. 모든 처리는 JS가 담당하게 되고, 더이상 url을 바꾸지 않고 동작할 수 있다.
- url이 변하지 않는다면 사용자에게 불편함을 준다. 따라서 서버랑 관련없이 클라이언트에서 라우팅에 대한 결정권을 통한 url을 사용가능하게 해야한다. 이를 제공하는 툴이 vue router이다.



## 코드 사용법

### 시작하기

```bash
$ vue create myapp
$ cd myapp
$ vue add router
```

- 커밋 여부를 확인해야 한다
- History 모드 선택여부를 물어본다.



### 경로 설정하기

@ router/index.js

```javascript
import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import TheLotto from '../views/TheLotto.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/lotto/:lottoNum',
    name: 'TheLotto',
    component: TheLotto,
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
```

- views 파일이나 componets를 사용할 수 있다.
- import 시 주소는 `../`을 사용하거나 `@/`(=`src/`)를 사용할 수 있다. 
- path를 통해 url을 정의하며, 동적 url은 `:변수`로 표시한다.
- `name`을 이용해 추후 하이퍼링크를 정의할 수 있다.



### 링크 만들기

#### method 이용

```vue
<template>
  <div class="about">
    <button @click="moveToHome">Home으로</button>
  </div>
</template>

<script>
export default {
  name: 'About',
  methods: {
    moveToHome: function () {
      // this.$router.push('/') 기능
      this.$router.push({name:'Home'})
    }
  }
}
</script>
```

- 클릭 이벤트로 이동 method를 실행한다. 
- 이때 주소를 이용하거나, 객체 형태로 이용한다.
- 동적 url일 경우 `{name: 'urlname', params: {lottoNum: 6}}`과 같은 객체를 이용한다.



#### router-view 이용

```vue
<router-link to="/about">About</router-link> |
<router-link :to="{ name: 'TheLotto', params: { lottoNum: 6 } }">TheLotto</router-link>

```

- DOM에서 링크가 보여질 위치에 다음과같이 만든다. 
- 객체를 사용할 경우 v-bind를 이용한다.

