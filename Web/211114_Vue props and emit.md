# 211114 TIL

> Vue CLI를 구성하며 자연스러운 트리 구조로 모듈이 설계된다. 이때 데이터를 보내는 방법인 pass props와 emit event의 개념과 코드를 정리해본다.



## Pass Props (부모 -> 자식)

- 부모 컴포넌트에 존재하는 정보를 자식에게 전달하는 방법
- 자식은 props 옵션을 통해 정의하여 받을 수 있음
- 부모코드의 `template`부분에 케밥케이스로 작성하고, 자식 `props`부분에 카멜케이스로 정의한다.
- 만약 string이 아닌 숫자를 전달하려고 하면 v-bind를 이용해서 전달해야한다. (기본값은 무조건 string이다.)

### 코드

부모.vue

```vue
<template>
	<div id="app">
        <child-component my-message="This is text data"></child-component>
        <child-component2 :message2="varData"></child-component>
    </div>
</template>

<script>
	...
    data: function () {
        return {
            varData: '아무값'
        }
    }
</script>
```

자식.vue

```vue
<script>
	props: {
        myMessage: {
            type: String,
        },
        message2: {
            type: String,
        }
    }
</script>
```



## Emit Event (자식 -> 부모)

- 자식이 $emit을 통해 이벤트를 발생시키고, 부모가 v-on(@)을 통해 감지한다. 보낸 데이터는 이벤트에서 methods를 통해 인자로 받을 수 있다.

### 코드

자식.vue

```vue
<template>
  <div id="app">
    <input 
      type="text"
      @keyup.enter="childInputChange"
      v-model="childInputData" 
    >
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      childInputData: null,
    }
  },
  methods: {
    childInputChange: function () {
      this.$emit('child-input-change', this.childInputData)
    }
  }
}
</script>
```



부모.vue

```vue
<template>
  <div id="app">
    <child-component 
      @child-input-change="parentGetChange"
    >
    </child-component>
  </div>
</template>

<script>
export default {
  methods: {
    parentGetChange: function (inputData) {
      console.log(`받은거 ${inputData}`)
    }
  }
}
</script>
```

