# bash 쉘 스크립트 함수 반환값 전달(return)

[![개발바닥 유투브](https://img.youtube.com/vi/3ArYMq5AomI/0.jpg)](https://youtube.com/watch?v=3ArYMq5AomI&feature=share)

개발바닥 유투브에서 기술면접 질문에 대한 영상에서 향로님이 쉘 스크립트에서의 리턴은 일반 프로그래밍 언어와 다르다고 하는데,

질문을 듣고 '어? 어떻게 다르더라?' 라는 생각부터 들었다.

그래서 찾아보고 정리해보기로 했다.


## 쉘 스크립트에서 반환값
- 쉘 스크립트에서는 일반적인 프로그래밍 언어에서의 `return` 반환값이 없다.
- 쉘 스크립트에서는 함수의 `return`값이 EXIT_STATUS로 전달되며 `$?`로 확인할 수 있다.
- EXIT_STATUS는 일반적으로 `0` 은 성공을 의미하며 `1~255`는 에러를 의미한다.


- `$`와 `()` 안에 [명령어 or 쉘 스크립트 or 쉘 스크립트 함수]를 넣으면 subshell이 호출되어 [명령어 or 쉘 스크립트 or 쉘 스크립트 함수]가 실행된다.
- subshell은 부모 shell의 변수나 값들을 가져오기 때문에 함수나 변수를 모두 사용 가능하다. 그러나 subshell의 결과가 부모 shell에 영향을 주지는 않는다.


## 방법 1. `echo` 로 전달하기

가장 일반적인 방법으로 사용된다고 한다.

    #/bin/bash
    
    foo()
    {
        val="test"
        echo ${val}
    }
    
    # 함수 foo 호출의 결과를 변수에 넣는다.
    retval=$(foo)           # retval=`foo` 도 사용 가능
    
    echo ${retval}

스크립트 실행 결과는 "test" 가 출력된다.

여기서, 함수 내부의 `${val}` 변수를 부모 shell 에서 출력해보면, 공백이 출력된다.

즉, subshell의 결과가 부모 shell에 영향을 주지 않는 것을 알 수 있다.


## 방법 2. 전역 변수 공유하기

나는 이 방법밖에 모르고 살았다.

    #/bin/bash
    
    retval=""

    foo()
    {
        retval="test"
    }
    
    foo
    
    echo ${retval}

스크립트 실행 결과는 [방법 1](#방법-1-echo-로-전달하기)과 동일하게 "test" 가 출력된다.

기본적으로 쉘 스크립트의 변수는 전역 변수이기에 가능한 방법이다.

## 방법 3. `return` 으로 전달하기 (exit status)

이 방법은 정수(0~255)만 전달 가능하다. (사실상 에러코드를 반환하는 것이다.)

    #/bin/bash
    
    foo()
    {
        return 123
    }
    
    foo
    
    echo $?

스크립트 실행 결과는 "123" 이 출력된다.

만약 문자열을 `return` 하면 어떻게 될까?

![결과](images/함수_반환값_1.png)

`numeric argument required` 라는 에러 메시지를 출력하며 `$?`(종료 스테이터스) 에는 "2" 가 출력되는 것을 확인할 수 있다. 

[Exit Status 2는 뭐지?](https://unix.stackexchange.com/questions/102201/what-is-exit-2-from-finished-background-job-status)


## 참고 자료
- [TWpower's Tech Blog - [Shell Script] 쉘 스크립트 함수나 실행에서 반환값(Return Value) 얻기](https://twpower.github.io/134-how-to-return-shell-scipt-value)
- [제타위키 - Bash 함수 반환 값 받기](https://zetawiki.com/wiki/Bash_%ED%95%A8%EC%88%98_%EB%B0%98%ED%99%98_%EA%B0%92_%EB%B0%9B%EA%B8%B0)