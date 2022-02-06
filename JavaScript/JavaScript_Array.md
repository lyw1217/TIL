# 자바스크립트 Array 함수

## `sort()`

배열 안에 문자형 데이터가 있는 경우 오름차순으로 정렬

```javascript
let fruits = ["Banana", "Apple", "Pineapple", "Strawberry"];
fruits.sort();
```

배열 안에 숫자형 데이터가 있더라도 문자열로 인식하기 때문에 숫자형으로 정렬하려면 sort함수를 정의해서 사용해야 한다.

```javascript
let score = [4, 5, 1, 3, 2];
// 오름차순 정렬
score.sort(function(a, b){return a - b});
// 내림차순 정렬
score.sort(function(a, b){return b - a});
```

정렬되어 있는 배열을 역순으로 정렬하려면 `reverse()` 함수를 이용한다.

```javascript
let fruits = ["Banana", "Apple", "Pineapple", "Strawberry"];
fruits.sort();
fruits.reverse();
```

### 참고 자료

https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Array/sort

## `filter()`

배열에서 특정 조건을 만족하는 요소만 찾아서 새로운 배열로 반환

```javascript
arr.filter(callback(element[, index[, array]])[, thisArg])
```

`callback()` 함수를 매개변수로 전달하며, true인 요소만을 찾아냄

매개변수
- element : 처리할 현재 요소.
- index Optional : 처리할 현재 요소의 인덱스.
- array Optional : filter를 호출한 배열.
- thisArg Optional : callback을 실행할 때 this로 사용하는 값.

```javascript
/* 10보다 작은 값 걸러내기 */
function isBigEnough(value) {
  return value >= 10;
}

var filtered = [12, 5, 8, 130, 44].filter(isBigEnough);
// filtered 는 [12, 130, 44]
```

### 참고 자료

https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Array/filter

## `map()`

배열의 데이터가 Object형일 때, 배열에 담긴 Object를 새로운 형태의 Object로 변환해서 배열로 반환함

```javascript
arr.map(callback(currentValue[, index[, array]])[, thisArg])
```

callback 함수
새로운 배열 요소를 생성하는 함수. 다음 세 가지 인수를 가집니다.
- currentValue : 처리할 현재 요소.
- index Optional : 처리할 현재 요소의 인덱스.
- array Optional : map()을 호출한 배열.
- thisArg Optional : callback을 실행할 때 this로 사용되는 값.

```javascript
/* 배열 속 객체를 재구성하기 */
var kvArray = [{key:1, value:10},
               {key:2, value:20},
               {key:3, value: 30}];

var reformattedArray = kvArray.map(function(obj){
   var rObj = {};
   rObj[obj.key] = obj.value;
   return rObj;
});
// reformattedArray는 [{1:10}, {2:20}, {3:30}]

// kvArray는 그대로
// [{key:1, value:10},
//  {key:2, value:20},
//  {key:3, value: 30}]

```

### 참고 자료

https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Array/map

## `reduce()`

배열에 담긴 데이터를 순회하며 callback() 함수의 실행 값을 누적하여 결과를 반환

누적 결과 값은 숫자, 문자, 객체 모두 가능하다.

데이터의 합계를 구할 때 많이 사용

```javascript
const array1 = [1, 2, 3, 4];
const reducer = (previousValue, currentValue) => previousValue + currentValue;

// 1 + 2 + 3 + 4
console.log(array1.reduce(reducer));
// expected output: 10

// 5 + 1 + 2 + 3 + 4
console.log(array1.reduce(reducer, 5));
// expected output: 15
```

### 참고 자료

https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce