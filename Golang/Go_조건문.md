# `Go 언어` 조건문

조건식을 판단하여 true 면 내부에 있는 구문을 수행한다.

## 사용법

```go
if 조건식1 {
    ...
} else if 조건식2 {
    ...
} else {
    ...
}
```

### **조건식 전에 초기화 문장 사용 가능**

if 문에서 정의된 변수는 if문 안에서만 사용 가능하다.

그러므로 if 문에서만 사용하는 변수는 이 방식으로 선언하는 것이 가독성을 높이는데 도움이 된다.

```go
if 초기화 문장; 조건식1 {
    ...
}

i := 1
if j := i * 2; j >= 2 {
    fmt.Println(j)
} else {
    fmt.Println(J)
}
// 이 아래서부터는 j 변수를 사용할 수 없다
j++ // 에러 발생
```

아래처럼 함수를 실행하고 리턴값을 조건식에 활용하는 방식도 가능하다.

이 경우에서도 조건문에서 선언된 변수는 조건문 안에서만 사용 가능하다.
```go
func ChkMax(max int, n int) (bool, int) {
	if n > max {
		return true, n
	}
	return false, n + 1
}

func main() {
	max := 5
	n := 4
	if err, n := ChkMax(max, n); err == true {
		fmt.Println(n, err) 
	} else {
		fmt.Println(n, err)
	}
    // 이 아래서부터는 err 변수를 사용할 수 없다.
    err = false // 에러 발생
}
```

## 주의해야 할 점

- Go언어에서, 조건식의 결과는 반드시 Boolean 식으로 표현되어야 한다. 즉, 다른 언어들처럼 0, 1을 조건식에 단독으로 사용할 수 없다.

    ```go
    i := 1
    if i {  // bool 타입이 아니므로 사용 불가
        ...
    }
    ```

- 중괄호는 필수이다. 내부 코드가 한 줄인 경우에도 중괄호를 생략하는 것은 안된다.
- 닫는 중괄호(`}`)는 `else if`, `else` 와 같은 줄에 있어야 한다.
    ```go
    if 조건식 {
        ...
    }   // 닫는 괄호 뒤에 else if, else가 없고 다른 줄에 있으면 컴파일 오류가 발생
    else {
        ...
    }
    ```