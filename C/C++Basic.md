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
- 모든 c++ 컴파일러에는 `__cplusplus`라는 매크로가 정의되어 있음
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

### 함수 template

- 구현이 동일한 함수가 여러 개 필요하면 함수를 생성하는 틀(template)을 만들자

```c++
// template<class T>
template<typename T> // class, typename 둘 다 뭘 써도 무관
T square(T a)
{
    return a * a;
}

int main()
{
    square<int>(3);
    square<double>(3.4);
    // 아래처럼 타입을 지정하지않고 생성할 수도 있음. 컴파일러가 인자를 보고 추론(type deduction)
    // square(3); -> int
    // square(3.4); -> double
    // square(3.4f); -> float
    // 너무 많은 인스턴스화로 인해 코드 메모리가 증가할 수 있음 (Code Bloat)
}
```

이렇게 template을 사용하면 컴파일러가 실제 함수를 아래와 같이 생성한다.

```c++
int square(T a)
{
    return a * a;
}

double square(T a)
{
    return a * a;
}

int main()
{
    square(3);
    square(3.4);
}
```

이 과정을 `template instantiation`, 템플릿 인스턴스화 라고 한다.

- 템플릿을 만들고 사용하지 않으면, 어셈블리 레벨에서 봤을 때 실제 함수는 생성되지 않는다. (인스턴스화(instantiation)되지 않는다.)

### linkage

inline, template는 다른 cpp파일에 있는 경우 링커가 그 함수의 구현을 알 수 없다.
> 함수의 구현을 header 파일에 넣으면 된다.

- internal linkage
- external linkage


### suffix return type (후위 반환 타입)

```c++
auto add(int a, int b) -> int
{
    return a + b;
}
```

- c++11에서 등장
- 함수의 반환 타입을 함수의 () 뒤쪽에 적는 표기법
- 복잡한 형태의 함수 템플릿(template), 람다 표현식(lambda expression)에서 필수적
- decltype( a + b ) : a + b의 결과로 나오는 값의 타입 
```c++
template<class T1, class T2>
auto add(T1 a, T2 b) -> decltype(a + b) // C++11
//auto add(T1 a, T2 b) // C++14, return 의 결과로 타입을 추론
{
    return a + b;
}

int main()
{
    add(1, 2.1);
}
```

### delete function

```c++
int gcd(int a, int b)
{
    return b != 0 ? gcd(b, a % b) : a;
}

double gcd(double a, double b); // 구현이 없다. 선언만 존재 --> 링커 에러가 난다. 컴파일만 한다면 에러 나지 않는다.

double gcd(double a, double b) = delete; // double 자료형이 인자를 넣으면 컴파일 단계에서 에러난다.

int main()
{
    gcd(10, 4);
    gcd(3.3, 4.4); // double -> int로 암시적 형변환 될 수 있다.
}
```

- class 문법에서 컴파일러가 자동으로 생성하는 함수들이 있는데, 그 때 자동으로 생성하는 함수를 만들지 못하게 하기 위해 주로 사용한다.

## C++ 제어문

### range for

```c++
int main()
{
    int x[10] = {1,2,3,4,5,6,7,8,9,10};

    for ( int i = 0; i < std::size(x); i++) // C++17부터 지원, 배열 뿐만 아니라 STL의 다양한 컨테이너(list, vector)도 가능
    {
        std::cout << x[i] << ", ";
    }
    std::cout << std::endl ;

    // for ( int e : x )
    for ( auto e : x )  // python의 in과 비슷한 개념
    {
        std::cout << e << ", ";
    }
}
```

### if with initializer

```c++
int foo()
{
    return 0;
}

int main()
{
    int ret = foo();

    if ( ret == 0 ) {}

    // C++17
    if ( int ret = foo(); ret == 0 ) {}

    switch ( int n = foo(); n )
    {
        case 1: break;
    }

    // C++20 : range - for 도 가능
    for ( int x[3] = {1,2,3}; auto n : x) {}

    // while 은 불가능
}
```

### new
- 동적 메모리 할당 방법
- malloc vs new
    | C         | malloc                 | new                                 |
    | --------- | ---------------------- | ----------------------------------- |
    | 정체      | 함수                   | 연산자(키워드)                      |
    | 인자      | 할당할 메모리의 사이즈 | 타입                                |
    | 반환 타입 | void* , 형변환 필요    | 전달한 타입의 포인터, 형변환 불필요 |
    | 해지 방법 | free                   | delete 또는 delete[]                |
    | 생성자    | 생성자 호출 안됨       | 생성자 호출됨                       |


### three way comparison (C++20)
- `auto ret = (n1 <=> n2)`
- 동작이 strcmp와 비슷함
- `<=>` 연산자의 반환 타입 : struct std::strong_ordering, weak_ordering, partial_ordering --> 0과 크기 비교만 가능함
```c++
int main()
{
    int n1 = 20, n2 = 20;

    bool b1 = (n1 < n2);

    auto ret = (n1 <=> n2); // C++20

    if ( ret == 0 )
        std::cout << "n1 == n2" << std::endl;   // 이게 출력됨
    else if ( ret > 0 )
        std::cout << "n1 > n2" << std::endl;
    else if ( ret <> 0 )
        std::cout << "n1 < n2" << std::endl;

    std::cout << typeid(ret).name() << std::endl;
}
```

## Reference

- 이미 존재하는 변수(메모리)에 대한 추가적인 별칭(alias)를 부여하는 문법
- `&` 연산자
  - 변수의 주소를 구할 때 사용
  - 레퍼런스 변수를 선언할 때 사용

```c++
void inc1(int   n) { ++n;   }   // call by value
void inc2(int*  p) { ++(*)p }   // 포인터 변수를 인자로 받음
void inc3(int&  r) { ++r;   }   // 레퍼런스 변수를 인자로 받음

int main()
{
    int a = 10, b = 10, c = 10;

    inc1(a);
    inc2(&b);
    inc3(c);    // 레퍼런스 변수가 인자의 타입이면 &c 처럼 주소값을 던져주는게 아님
    
    std::cout << a << std::endl; // 10
    std::cout << b << std::endl; // 11
    std::cout << c << std::endl; // 11
}
```

### swap 예시에서 활용
```c++
// C 언어에서의 swap 예시
void swap ( int* p1, int* p2)
{
    int temp = *p1;
    *p1 = *p2;
    *p2 = temp;
}

// C++에서 reference를 이용한 swap 예시
template<class T>
void swap ( T& r1, T& r2)
{
    T temp = r1;
    r1 = r2;
    r2 = temp;
}

int main()
{
    int x = 10, y = 20;

    swap(&x, &y);

    std::cout << x << std::endl;  // 20
    std::cout << y << std::endl;  // 10
}
```

### const reference
- 복사 오버헤드 없이 인자로 전달된 변수를 수정하는 것을 허용하지 않는 것

```c++
void foo ( const Rect& r )
{
    r.left = 100; // error
}
```