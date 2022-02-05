# bash 쉘 스크립트 정수형 변수 증가/감소시키기 (++ 연산하기)

## bash 쉘 스크립트 변수 선언
쉘 스크립트의 경우, 특별한 변수 타입을 지정해주지 않아도 된다.

나중에 기본 문법을 정리할 때 다시 설명하겠지만 선언하는 방법은 아래와 같다.

    변수명=값

    (o)올바른 예시
    encoding="UTF-8"
    
    -> encoding 이라는 변수에 UTF-8 이라는 값이 지정됨     

여기서 *주의*해야 할 사항은 다른 프로그래밍 언어처럼 간격 조절을 위해 *공백*을 사이에 두면 변수 선언이 정상적으로 되지 않는다.

    (x) 틀린 예시, 공백이 있으면 안 됨
    encoding = "UTF-8"

이런 식으로 선언하면 안 된다.

## 정수형 변수 **증가/감소**시키는 방법

기본적인 정수 계산의 형태는 아래와 같다.

    $((계산식))

    이중 괄호를 활용해야 한다.
    $(( 3-1 )) 과 같이 이중 괄호와 계산식 사이에 공백을 두어도 괜찮다.

변수에 할당하거나 단순 계산 시 `$` 가 필요하지만

증가/감소 연산을 할 때는 `$` 가 필요 없다..

정확한 사용 방법은 아래 예시를 보자.
    
## 정수형 변수 증가/감소 활용 예시

### 계산 결과를 출력(`echo`)

    # var_test_1.sh

    #!/usr/bin/env bash
    echo $((3-1))   # 예상 결과 : 2

위 코드를 실행한 결과는 예상 결과와 같이 '3-1'을 한 '2'가 출력되었다.

![결과 확인](images/bash_integer_1.png)

### 계산 결과를 변수에 저장

보통의 프로그래밍 언어처럼 `count++` 또는 `count+=1`과 같은 방법이 쉘 스크립트에서는 먹히지 않았다.

쉘 스크립트에서는 위에서 설명한 것과 같이 이중 괄호를 활용해서 정수형 변수를 다루어야 하는데, 방법은 아래와 같다.

    # var_test_2.sh

    #!/usr/bin/env bash
    # 1부터 5까지 반복문 외부의 변수(count)를 반복문 내부에서 증가시켜 출력해보자.
    count=1
    for i in {0..4}:
    do
        echo "${count}"
        count=$((count+1))
    done

![결과 확인](images/bash_integer_2.png)

또는 아래와 같은 방법들로도 사용할 수 있으니 편한 방법으로 사용하면 된다.

    # var_test_3.sh

    #!/usr/bin/env bash
    # 1부터 5까지 반복문 외부의 변수(a,b)를 반복문 내부에서 증가시켜 출력해보자.
    a=1
    b=1
    for i in {0..4}:
    do
        echo "a = ${a}"
        echo "b = ${b}"
        ((a++))    # 방법 1
        ((b+=1))   # 방법 2
        echo ""
    done

![결과 확인](images/bash_integer_3.png)


## 참고 자료
- [DelftStack - Bash에서 증가 및 감소 작업을 수행하는 방법](https://www.delftstack.com/ko/howto/linux/how-to-perform-increment-and-decrement-operation-in-bash/)
- [\[bash\] 정수 계산 및 변수값 증가\/감소](https://sojinhwan0207.tistory.com/64?category=957226)
- [반달가면 - \[bash: ((\] 정수 계산 및 변수값 증가\/감소](http://xbahndal.egloos.com/580762)