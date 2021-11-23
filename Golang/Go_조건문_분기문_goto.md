# `Go 언어` 조건문(`if`), 분기문(`switch case`), `goto` 문

# 조건문(`if`)

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


# 분기문(`switch case`)

`switch case` 문은 `if`, `else if` 문으로 조건을 나열하는 것보다 더 가독성 있게 조건을 표현할 수 있다.

변수가 각 조건(case)에 일치하면 해당 코드를 실행한 뒤 분기문을 빠져나간다.

C/C++ 과 비슷하지만, 각 case 마다 필요했던 `break` 문을 생략 가능하다는 차이점이 있다. (물론 case 중간에 break문으로 switch문을 탈출할 수도 있다.)

또, 값을 판단하는 조건으로 문자열도 사용이 가능하다.

## 사용법

```go
i := 3

switch i {
case 0:
    fmt.Println(0)
case 1:
    fmt.Println(1)
case 2:
    fmt.Println(2)
case 3: // i = 3 이므로 case 3: 에 해당하는 구문이 실행된다.
    fmt.Println(3)
default:
    fmt.Println(99)
}
/*
출력 결과
3
*/

// 문자열도 사용 가능하다.
s := "foo"

switch s {
case "foo":
    fmt.Println("foo")
    // break 문이 없더라도 case "foo": 에 해당하는 구문만 실행된다. 
case "bar":
    fmt.Println("bar")
default:
    fmt.Println("baz")
}
/*
출력 결과
foo
*/
```

### **여러 조건을 하나의 `case` 에서 처리할 수 있다.**

여러 조건을 한꺼번에 처리할 때는, case에 조건을 여러 개 넣을 수 있다.

```go
i := 3

switch i {
case 0, 1:
    fmt.Println(0)
case 2, 3:
    fmt.Println(1)
default:
    fmt.Println(99)
}
/*
출력 결과
1
*/
```

### **case에 조건식을 넣을 수 있다.**

case 의 조건에, C/C++ 처럼 숫자나 열거형만 넣는 것이 아니라 조건식을 넣어서 `if ... else` 문처럼 분기할 수 있다.

```go
i := 3

switch i {
case i < 0:
    fmt.Println("음수")
case i > 0:
    fmt.Println("양수")
default:
    fmt.Println("0")
}
/*
출력 결과
양수
*/
```

### **switch에 초기화 구문을 넣을 수 있다.**

`if` 문과 [마찬가지](#조건식-전에-초기화-문장-사용-가능)로, 초기화 구문을 사용할 수 있다.

switch 문에서 선언된 변수는 switch 문에서만 사용 가능하다.

```go
a_score := []int{10, 20, 30}
b_score := []int{5, 25, 35}

for i := 0; i < len(a_score); i++ {
    switch a, b := a_score[i], b_score[i]; {    // 세미콜론을 넣어주어야 한다.
    case a > b:
        fmt.Println("a가 더 큼")
    case a < b:
        fmt.Println("b가 더 큼")
    default:
        fmt.Println("동점")
    }
}
/*
출력 결과
a가 더 큼
b가 더 큼
b가 더 큼
*/
```


### **`fallthrough`**

기존 C/C++ 에서 `break`를 생략한 것처럼 동작하게 하려면, `fallthrough` 키워드를 사용하면 된다.

단, 마지막 case 에서는 fallthrough 키워드를 사용할 수 없다.

이는 어떤 작업을 계층적으로 수행해야 할 때 유용하다.

```go
switch level {
case 1:
    DoFirst()
    fallthrough
case 2:
    DoSecond()
    fallthrough
case 3:
    DoThird()
    // 마지막 case에는 fallthrough 를 사용할 수 없다.
}
// level 1에는 DoFirst(), DoSecond(), DoThird()가 모두 실행된다.
// level 2에는 DoSecond(), DoThird() 만 실행된다.
// level 3에는 DoThird() 만 실행된다.
```

# `goto` 문

`goto` 문은 지정된 레이블로 곧바로 이동한다.

레이블은 변수 이름을 짓는 규칙과 동일하게 이름 짓는다.

## 사용법

```go
goto LABEL  // 이동할 레이블 지정

LABEL:
    ...
```

`goto` 문의 오남용은 코드에 해로우니 적절하게 사용하자.