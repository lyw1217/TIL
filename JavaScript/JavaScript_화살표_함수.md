# 자바스크립트 화살표 함수

함수 표현식보다 단순하고 간결하게 함수를 만들 수 있는 방법

```javascript
// 함수 표현식
function hello(name) {
    return "Hello" + name;
}
```

기존의 함수 표현식에서 `function` 키워드를 삭제하고 인자로 받는 매개변수의 괄호`()`와 코드블록`{}` 사이에 화살표`=>`를 넣어주면 화살표 함수를 정의할 수 있다.

```javascript
// 화살표 함수
const hello = (name) => {return "Hello" + name};

// 파라미터가 하나만 있을 때는 괄호 생략 가능
const hello = name => {return "Hello" + name};
```