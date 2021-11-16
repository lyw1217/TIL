# `Go 언어` 문법의 특징

## 적은 문법, 많은 기능
---

golang에서 지원하는 키워드는 25개이다. ([참고](https://golang.org/ref/spec#Keywords))

| 키워드   | (Keywords)  |        |           |        |
| -------- | ----------- | ------ | --------- | ------ |
| break    | default     | func   | interface | select |
| case     | defer       | go     | map       | struct |
| chan     | else        | goto   | package   | switch |
| const    | fallthrough | if     | range     | type   |
| continue | for         | import | return    | var    |

`while` 문도 없고 `for` 문 만으로 반복을 표현한다.

`c언어`와는 다르게 `switch` 문 `case`에 조건식을 사용할 수 있다.

덕분에 코드가 간결해보인다.

## 정적 타입 언어
---

python 이랑은 다르게 자료형 체계에서 엄격하게 타입을 확인한다. (정적 타입)

그러나 동적 타입의 방식도 지원한다. (그러나 반드시 초기값을 대입해줘야 한다.)

- [[Go] Go 언어 정적타입(static type)](https://artist-developer.tistory.com/6)
- [[Go] Go 언어 강 타입(strongly-typed)](https://artist-developer.tistory.com/9)

## 세미콜론(`;`) 생략 가능
---

C언어처럼 Go에서도 세미콜론(`;`)으로 문자의 끝을 표시한다.

그런데 컴파일러가 컴파일 할 때 각 문장의 끝에 세미콜론을 넣어주므로 실제 코드를 작성할 때에는 세미콜론을 넣어주지 않아도 된다. (두 개 이상의 문장을 한 줄에 표현하고자 할때 세미콜론을 사용한다.)

이런 특징 때문에 함수나 제어문에서 중괄호의 위치가 고정되어서 사용된다.

```go
package main
import "fmt"
// 컴파일러가 func main(); 처럼 만들어버리기 때문에 컴파일 오류 발생
func main() 
{
    // 컴파일러가 for i := 0; i <= 10; i++; 처럼 만들어버리기 때문에 오류 발생
    for i := 0; i <= 10; i++ 
    {
        fmt.Print(i)
    }
}
```

```go
package main
import "fmt"
func main() {   // 올바른 위치
    for i := 0; i <= 10; i++ { // 올바른 위치
        fmt.Print(i)
    }
}
```

## 주석
---

C언어처럼 `//` 또는 `/**/` 를 사용한다.

- `//` 이후에 나타나는 문자는 모두 주석처리
- `/**/` 안의 모든 줄, 문자는 모두 주석처리

## 들여쓰기(소스 포맷)
---

개발자마다 소스의 포맷이 달라 알아보기 어려운 경우가 많다.

그런데 Go 언어는 gofmt로 스타일을 정돈해주는 툴을 기본적으로 제공한다.

콘솔에서 사용 가능하지만, VSCode 등의 에디터를 사용하면 기본적으로 적용해준다.

### 참고 자료

더 자세한 내용을 원한다면 아래 사이트에 들어가보자.

- [The Go Programming Language Specification](https://golang.org/ref/spec)
- [The Go Blog](https://go.dev/blog/all)
- [Go의 주요 특징들](https://golangkorea.github.io/post/go-start/feature/)
- [[프로그래밍 언어] Go언어 문법적 특징을 보자! -1](https://inspire12.tistory.com/12)
- [나무위키 - Go(프로그래밍 언어)](https://namu.wiki/w/Go(%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%20%EC%96%B8%EC%96%B4))
- [Go 언어 컨셉 이해하기](https://judo0179.tistory.com/80)