# `Go 언어` 반복문

Go 언어에서 반복문은 `for` 문 뿐이다.

`while` 문은 제공하지 않는다.

## 기본 사용법

```go
for 초기식; 조건식; 증감식 {    // 소괄호 '(',')' 는 생략한다.
    ...
}

// 초기식, 증감식을 세미콜론(;)없이 생략이 가능하다. 덕분에 while 문처럼 사용할 수 있다.
for 조건식 {
    ...
}

// 무한루프를 만드려면 식을 전부 생략하면 된다.
for {
    ...
    // 반복문을 탈출하는 구문을 필수적으로 작성하자.
}
```

아래는 사용법별 간단한 예시이다.

```go
for i := 0; i < 5; i++ {    // 반복문의 초기식에서 선언된 변수는 반복문 내에서만 사용 가능하다.
    fmt.Println(i)
}

i := 0
for i < 5 {     // 세미콜론이 필요 없다.
    fmt.Println(i)
    i++
}

i = 0
for {
    fmt.Println(i)
    i++
    if i >= 5 {
        break
    }
}
/* 세 반복문 모두 같은 출력 결과를 보여준다. */
```
## `for ... range` 사용법

`for ... range` 문은 컬렉션(배열, 슬라이스, 맵)으로부터 요소를 하나씩 가져와서 순회하는 문장이다.

```go
for 인덱스, 값 := range 컬렉션 {
    ...
}
```

간단한 예로,

```go
names := []string{"이영우", "홍길동", "Go Lang"}
for idx, val := range names {
    fmt.Println(idx, val)
}
/*
출력 결과
0 이영우
1 홍길동
2 Go Lang
*/
```

인덱스를 사용하지 않을 때는 언더바(`_`)로 사용하지 않음을 표현할 수 있다. (Go언어는 사용하지 않는 변수를 에러처리하므로 언더바의 사용이 필요할 때가 있다.)

```go
names := []string{"이영우", "홍길동", "Go Lang"}
for _, val := range names {
    fmt.Println(val)
}
```

입력받는 변수를 하나만 설정하면, 인덱스를 반환받는다.

```go
names := []string{"이영우", "홍길동", "Go Lang"}
for i := range names {
    fmt.Println(i)
}
/*
출력 결과
0
1
2
*/
```

## `break`, `continue` 문 사용법

반복문에서, `break` 문을 만나면 그 지점에서부터 반복문을 탈출한다.

`continue` 문을 만나면, `continue` 뒤에 있는 구문은 건너 뛰고 다음 반복 작업을 수행한다.


### **`break 레이블` 사용법**

for 문 바로 앞에 콜론(:)으로 끝나는 레이블이 있으면 반복문에서 사용 가능한 레이블을 선언할 수 있다.

레이블은 `goto` 문에서 사용하는 것과 동일하다.

`break` 문 뒤에 레이블을 명시해주면, `break`가 속해있는 반복문을 탈출하여 레이블로 즉시 이동하여 해당 반복문 뒤에 있는 문장을 이어서 수행하게 된다.

(글로 이해할 수 있게 적기가 어렵다.. 직접 코드를 작성해보면 깨닫기 쉽다.)

`continue` 에도 사용 가능하다.

```go
// flag 변수를 사용하는 경우
data := [][]int{{1, 2, 3, 4}, {4, 5, 6}, {1, 3, 5, 7}}
target := 6
for i, numbers := range data {
    flag := 0
    for j, n := range numbers {
        if n == target {
            flag = 1
            fmt.Printf("taget is in [%d][%d]\n", i, j)
            break
        }
    }
    if flag == 1 {
        break
    }
}
/*
출력 결과
target is in [1][2]
*/
```

위와 같이 다중 반복문에서 특정 값을 찾고자 할 때, flag 변수를 사용하는 경우도 있다.

이런 경우에 `break 레이블`을 활용하면 좀 더 간단하게 표현할 수 있다.

```go
	data := [][]int{{1, 2, 3, 4}, {4, 5, 6}, {1, 3, 5, 7}}
	target := 6
LOOP:
	for i, numbers := range data {
		for j, n := range numbers {
			if n == target {
				fmt.Printf("target is in [%d][%d]\n", i, j)
				break LOOP
			}
		}
	}
/*
출력 결과
target is in [1][2]
*/
```

## 주의해야 할 점

- 중괄호는 필수이다. 내부 코드가 한 줄인 경우에도 중괄호를 생략하는 것은 안된다.
- 닫는 중괄호(`}`)는 `for` 와 같은 줄에 있어야 한다.
    ```go
    for 초기식; 조건식; 증감식 {
        ...
    }
    ```