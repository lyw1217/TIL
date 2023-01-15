# `Go 언어` 명령어 중 `...` 의미

go 언어를 공부하는 중 명령어 예시들 중 

```shell
$ go get -d -v ./... && go build -v ./...
```

와 같이 `...` 를 사용하는 경우가 있다.

여기서 `...` 의 의미는 뭘까?

## `go help packages` 를 참고

`go help packages` 를 수행하면 나오는 설명 중 아래 내용을 확인해보면 된다.

```
An import path is a pattern if it includes one or more "..." wildcards,
each of which can match any string, including the empty string and
strings containing slashes. Such a pattern expands to all package
directories found in the GOPATH trees with names matching the
patterns.
```

즉, 모든 하위 디렉토리를 재귀적으로 나타내는 와일드카드 개념인 것 같다.

예를 들어, `go get ./...` 를 수행하게 된다면 현재 디렉토리(`.`)의 패키지와 모든 하위 디렉토리(`...`)의 패키지를 가져오게 된다.

### 참고 자료
- [https://stackoverflow.com/questions/28031603/what-do-three-dots-mean-in-go-command-line-invocations](https://stackoverflow.com/questions/28031603/what-do-three-dots-mean-in-go-command-line-invocations)
- [https://stackoverflow.com/questions/73353538/the-meaning-of-in-make-file-is-not-clear?noredirect=1&lq=1](https://stackoverflow.com/questions/73353538/the-meaning-of-in-make-file-is-not-clear?noredirect=1&lq=1)