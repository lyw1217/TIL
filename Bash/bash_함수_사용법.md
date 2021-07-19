# bash 쉘 스크립트 함수 사용법

## 함수 선언 및 사용

    #!/bin/bash
    
    # 함수 선언
    function 함수명()
    {
        함수 내용
    }

    # 함수 사용
    함수명

### 주의 사항

- function은 생략해도 된다.
- 함수명을 쓰는 것만으로 함수 호출이 된다. 소괄호`()`를 쓰지 않아도 된다.
- 함수 선언보다 함수를 먼저 호출하면 안된다.

### 예시

    #!/bin/bash
    func_echo()
    {
        echo "Test function"
    }

    func_echo

    [출력 결과]
    Test function

## 지역변수 사용 방법

쉘 스크립트에서 변수는 기본적으로 전역 변수이다.
하지만 변수명 앞에 `local`을 붙여주면 해당 함수에서만 사용 가능한 지역 변수가 선언된다.

### 예시

    #!/bin/bash
    
    var="abc"
    echo ${var}

    func_local_var()
    {
        local var="def"
        echo ${var}
    }

    func_local_var
    echo ${var}

    [출력 결과]
    abc
    def
    abc

## 함수 인자 전달 방법

    #!/bin/bash
    
    # 함수 선언
    function 함수명()
    {
        함수 내용
        # $1 : 인자1, $2 : 인자2 ...
    }

    # 함수 사용
    함수명 인자1 인자2 ...

함수명 뒤에 인자들을 공백으로 구분하여 나열하면 인자를 전달할 수 있다.

`$1`, `$2`, `$3`... 순서대로 번호가 부여되며 `${10}` 부터는 `{}` 중괄호로 감싸주어야 한다.

### 예시

    #!/bin/bash

    func_param_test()
    {
        echo "first parameter : "$1
        echo "second parameter : "$2
        echo "third parameter : "$3
    }

    func_param_test "abc" "def" "ghi"

    [출력 결과]
    first parameter : abc
    second parameter : def
    third parameter : ghi

## 함수 결과값(반환값) 전달 방법

[여기](https://github.com/lyw1217/TIL/blob/main/Bash/bash_%ED%95%A8%EC%88%98_%EB%B0%98%ED%99%98%EA%B0%92(%EB%A6%AC%ED%84%B4).md)를 참고바란다.


## 참고 자료
- [RedJini Blog - [shell script] 함수(Function) 사용하기](http://blog.redjini.com/281)
- [시골청년 - [Shell Script] 함수(function)](https://palyoung.tistory.com/131)
- [개발자스럽다 - Bash 입문자를 위한 핵심 요약 정리 (Shell Script)](https://blog.gaerae.com/2015/01/bash-hello-world.html)