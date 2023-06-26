# C++ 기초 개념 정리

## namespace 요소에 접근하는 방법

1. 완전한 이름 사용 (권장)
    ```c++
    Audio::init();
    ```

2. 선언 사용
    ```c++
    using Audio::init;
    init();
    ```

3. 지시어 사용
    ```c++
    using namespace Audio;
    init();
    ```

## C++ 표준 입출력

### io manipulator

- 입출력시 다양한 출력(입력)형태를 지정하는 것
- `<iostream>`, `<iomanip>` 헤더 필요
- 일부 예시
    |              | 내용                  | 예시                                                           | 비고                          |
    | ------------ | --------------------- | -------------------------------------------------------------- | ----------------------------- |
    | std::dec     | 10진수로 출력         | std::cout << std::dec << n << std::endl;                       | `%d`, 이후 모든 출력에 적용됨 |
    | std::hex     | 16진수로 출력         | std::cout << std::hex << n << std::endl;                       | `%x`, 이후 모든 출력에 적용됨 |
    | std::setw    | 문자열 출력 개수 지정 | std::cout << std::setw(10) << n << std::endl;                  | `%10d`                        |
    | std::setfill | 공백을 채울 문자 지정 | std::cout << std::setfill('*') << n << std::endl;              |                               |
    | std::left    | 왼쪽 정렬             | std::cout << std::setfill('*') << std::left << n << std::endl; |                               |
    

## C++ 변수

### auto
- 변수 선언시, 컴파일러가 우변을 보고 타입을 결정
- 연관된 변수의 자료형이 변경되면 자동으로 변경됨
- 데이터 타입이 복잡한 경우 이점
- 가독성 떨어짐

### decltype
- `()` 안의 표현식으로 타입을 결정
- 탬플릿 만들 때 주로 사용

### using
- C에서 typedef와 비슷한 개념
```c++
typedef int DWORD; // 두개가 비슷한 개념
using DWORD = int;
```
- using은 type에 대한 별칭 + template에 대한 별칭 사용 가능

### uniform initialization
- C++11
- 모든 종류의 변수를 똑같은 방식으로 초기화하는 방법 (중괄호 초기화(brace-init) 이라고도 함)
    ```c++
    int     n1 = 0;
    Point   p1 = {0, 0};
    int     x1[3] = {1,2,3};

    // uniform initialization, 복사 초기화
    int     n2 = {0};
    Point   p2 = {0, 0};
    int     x2[3] = {1,2,3};

    // uniform initialization, 직접 초기화
    int     n3{0};
    Point   p3{0, 0};
    int     x3[3] = {1,2,3};
    ```
- prevent narrow 가능
- 직접 초기화와 복사 초기화
    | 구분        | 내용                  | 예시         |
    | ----------- | --------------------- | ------------ |
    | 직접 초기화 | `=` 없이 초기화       | int n{0};    |
    | 복사 초기화 | `=`를 이용해서 초기화 | int n = {0}; |

### struct
- C와 다른 점
  - 선언 시 `struct` 없이 선언 가능
  - 내부 변수에 초기값 지정 가능


### 문자열
- `std::string`
- `<string>` 헤더 파일 필요

### 기타
- `bool` : 0, 1, C++98
- `long long` : 64bit 정수, C++11
- 2진수 표기법
  ```c++
  int n1 = 0x10000000;
  int n2 = 0b10000000;  // b로 표현 가능
  // digit separator, 큰 수나 비트 표현 시 보기 쉽게 구분자, 정수 리터럴 사이에서 싱글 따옴표(')가 있으면 컴파일 시 무시됨
  int n3 = 0b1000'0000;
  int n4 = 1'000'000'000;
  ```
- `nullptr`
    ```c++
    int* p = 0;
    int* p = nullptr; // 권장
    ```

## C++ 함수의 특징

### default parameter
- 함수 호출 시 인자를 전달하지 않으면 미리 지정된 인자값 사용
    ```c++
    void f1(int a, int b = 0, int c = 0) {}
    int main()
    {
        f1(1, 0, 0);
        f1(1); // a=1, b=0, c=0
        // 컴파일 단계에서 f1(1) -> f1(1, 0, 0) 으로 변환됨, 즉, 위 두 개는 완전 동일한 코드
    }
    ```

### function overloading
- 인자의 타입이나 개수가 다르면 같은 이름의 함수를 여러 개 선언 가능
- 함수 반환 타입만 다른 경우는 overloading 안됨
- 컴파일러가 컴파일 시간에 함수의 이름을 인자의 타입과 개수를 보고 다른 함수인 것 처럼 변경하는 것, name mangling

### C/C++ 호환성
- C언어로 작성된 소스코드/헤더를 C++에서 읽으려면 헤더에 `extern "C"` 추가
- 모든 c++ 컴파일러에는 "__cplusplus"라는 매크로가 정의되어 있음
- C로 작성된 소스코드를 C와 C++ 모두 문제없이 읽히게 하려면 아래와 같이 사용
```c++
#ifdef __cplusplus
extern "C" {
#endif
...

#ifdef __cplusplus
}
#endif
```
