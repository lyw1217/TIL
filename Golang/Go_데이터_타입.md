# `Go 언어` 데이터 타입

## Boolean 타입 (부울형, 불형)
---

`true` 또는 `false` 값을 갖는다.

Go 언어에서는 `0` 이나 `nil` 을 `false`로 변환하지 않는다.

즉, 조건문 등에 bool 타입 값을 꼭 명시해주어야 한다.

## Numeric 타입 (숫자형)
---

| Type       | 설명                                                                                | 범위                                          | 크기 |
| ---------- | ----------------------------------------------------------------------------------- | --------------------------------------------- | ---- |
| uint8      | the set of all unsigned  8-bit integers                                             | (0 to 255)                                    | 1    |
| uint16     | the set of all unsigned 16-bit integers                                             | (0 to 65535)                                  | 2    |
| uint32     | the set of all unsigned 32-bit integers                                             | (0 to 4294967295)                             | 4    |
| uint64     | the set of all unsigned 64-bit integers                                             | (0 to 18446744073709551615)                   | 8    |
| -          | -                                                                                   | -                                             | -    |
| int8       | the set of all signed  8-bit integers                                               | (-128 to 127)                                 | 1    |
| int16      | the set of all signed 16-bit integers                                               | (-32768 to 32767)                             | 2    |
| int32      | the set of all signed 32-bit integers                                               | (-2147483648 to 2147483647)                   | 4    |
| int64      | the set of all signed 64-bit integers                                               | (-9223372036854775808 to 9223372036854775807) | 8    |
| -          | -                                                                                   | -                                             | -    |
| float32    | the set of all IEEE-754 32-bit floating-point numbers                               | ±10^-453~±3.4 * 10^38 (소수점 7자리)          | 4    |
| float64    | the set of all IEEE-754 64-bit floating-point numbers                               | ±5 * 10^-324~±1.7 * 10^308 (소수점 15자리)    | 8    |
| -          | -                                                                                   | -                                             | -    |
| complex64  | the set of all complex numbers with float32 real and imaginary parts(복소수)        |                                               | 8    |
| complex128 | the set of all complex numbers with float64 real and imaginary parts(복소수)        |                                               | 16   |
| -          | -                                                                                   | -                                             | -    |
| byte       | alias for uint8                                                                     |                                               | 1    |
| rune       | alias for int32                                                                     |                                               | 4    |
| -          | -                                                                                   | -                                             | -    |
| uint       | 32bit 시스템에서는 uint32, 64bit 시스템에서는 uint64와 같음                         |                                               | -    |
| int        | same size as uint                                                                   |                                               | -    |
| uintptr    | an unsigned integer large enough to store the uninterpreted bits of a pointer value |                                               | -    |

### **8진수와 16진수의 표기**

따로 표기하지 않느다면 모든 정수는 10진수로 인식된다.

8진수는 숫자 앞에 `0` 을 붙이고

16진수는 숫자 앞에 `0x` 를 붙인다.

```go
package main

import "fmt"

func main() {
	dec := 1024   // 10진수
	oct := 02000  // 8진수
	hex := 0x0400 // 16진수
	fmt.Println(dec, oct, hex)        
}

// 출력 : 1024 1024 1024
```

### **아스키코드(ASCII) 또는 유니코드(UTF-8) 표기**

`byte` 또는 `rune` 타입으로 문자의 코드값을 저장하여 문자를 표기할 수 있다.

- `byte` : 1 byte를 표현할 수 있으므로 **아스키코드** 문자를 표기할 수 있다.
- `rune` : 4 bytes를 표현할 수 있으므로 **유니코드** 문자를 표기할 수 있다.

```go
// ASCII (dec)97 == 'a'
var b_dec byte = 97
var b_oct byte = 0141   // 8진수 
var b_hex byte = 0x61   // 16진수
var b_chr byte = 'a'
// Unicode 
var r_dec rune = 44032
var r_oct rune = 0126000    // 8진수
var r_hex rune = 0xAC00     // 16진수
var r_chr rune = '가'

fmt.Printf("%c %c %c %c\n", b_dec, b_oct, b_hex, b_chr)
fmt.Printf("%c %c %c %c\n", r_dec, r_oct, r_hex, r_chr)

/*
출력 결과
a a a a
가 가 가 가
*/
```

### **실수(부동소수점) 타입의 표기법**
- 소수 표기법
- 지수 표기법

```go
// 소수 표기법
var num1 float32 = 0.1
var num2 float32 = .12
var num3 float32 = 123.456

// 지수 표기법
var num4 float32 = 1e4          // 10000
var num5 float64 = .1234E+3     // 123.4
var num6 float64 = 1.2345e-4    // 0.00012345
```

### 복소수 타입의 표기법

complex64, complex128이 존재하지만 나는 많이 사용하지 않을 것 같아서 일단 PASS..

### **Numeric 타입 변수들의 연산**

Numeric 타입 변수들의 연산은 타입이 같은 변수들끼리만 가능하다.

타입이 다른 변수끼리 연산하려면 타입을 변환해주어야 한다.

```go
var i int16 = 1000
var j uint8 = 12
var k float32 = 12.3
fmt.Println(i + j)  // 컴파일 에러 발생
fmt.Println(i + k)  // 컴파일 에러 발생
fmt.Println(i > j)  // 컴파일 에러 발생
```

반드시 같은 타입으로 변환 후 연산해야 한다.

```go
var i int16 = 1000
var j uint8 = 12
var k float32 = 12.3
fmt.Println(i + int16(j))
fmt.Println(float32(i) + k)
fmt.Println(i > int16(j))
/*
출력 결과
1012
1012.3
true
*/
```

**범위가 큰 타입에서 작은 타입으로 변환 시에는 원래 값이 작은 타입의 범위 안에 포함되는지 확인해야한다.**

타입 변환으로 overflow 등이 발생하더라도 오류가 발생하지는 않는다.

### **증감 연산자**

증감 연산자는 후치 연산으로만 사용할 수 있다.

즉, `++i`, `if x++ > 0 {` 와 같은 연산은 수행할 수 없다.

또, 증감 연산은 반환 값이 없다. (다른 변수에 대입하려 하면 안된다)

그러므로 아래와 같은 코드는 Go 언어에서 사용할 수 없다.

```go
// 모두 컴파일 에러 발생
++x
x = y++
fmt.Println(x++)
fmt.Println(++x)
if x++ > 0 {
    ...
}
```

이런 식으로 사용해야 한다.

```go
var x int = 1
for i := 0; i < 3; i++ {
    x++
    fmt.Println(x)
}

/*
출력 결과
2
3
4
*/
```

## String 타입 (문자열)
---

문자열은 Back Quote(`) 또는 쌍따옴표(")로 묶어 사용한다. [go spec 참고](https://golang.org/ref/spec#String_literals)

- Back Quote(`) 로 묶인 문자열은 Raw String Literal 이라고 하는데, 말 그대로 Raw 한 String 값을 그대로 가진다.  
  - 이스케이프 문자(`\`) 를 무시한다.
  - 여러 줄에 걸쳐 쓸 수 있다.
- 쌍따옴표(") 로 묶인 문자열은 Interpreted String Literal 이라고 하는데, 이스케이프 문자열이 적용된다.
  - 여러 줄에 걸쳐 쓸 수 없고, `+` 연산자를 이용하여 결합해야 한다.

## Array 타입
---

## Slice 타입
---

## Struct 타입
---

## Pointer 타입
---

## Function 타입
---

## Interface 타입
---

## Map 타입
---

## Channel 타입
---


### 참고 자료
- [Go Spec](https://golang.org/ref/spec)