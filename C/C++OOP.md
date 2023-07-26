# C++ Object Oriented Programming

- 멤버 데이터 : class 내부 변수, 필드
- 멤버 함수 : class 내부 함수, 메소드

### 객체를 지역변수로 생성하면

- 스택에는 멤버 데이터만 객체당 한 개 씩 생성됨
- 멤버 함수는 객체의 개수에 상관 없이 코드 메모리에 한 개만 생성됨(일반 함수와 동일)

## 접근 지정자
- private : 멤버 함수에서만 접근 가능
- public : 모든 함수에서 접근 가능
- protected : 멤버 함수와 파생 클래스 멤버 함수에서 접근 가능(상속)

```c++
class Person
{
private:
    std::string name;
    int         age;

public:
    void setAge(int value)
    {
        if ( value >= 1 && value < 150 )
            age = value ;
    }
}

int main()
{
    Person p;
//  p.age = -10; // error
    p.setAge(-10);
}
```

- 캡슐화(Encapsulation)
  - 멤버 데이터는 private 영역에 놓고 외부의 잘못된 사용으로부터 보호
  - 멤버 데이터의 변경은 잘 정의된 규칙을 가진 멤버 함수를 통해서만 변경

## `struct` vs `class`
- struct : 접근 지정자 생략 시 디폴트가 public
- class : 접근 지정자 생략 시 디폴트가 private

c++은 다른 객체지향 언어에 비해 struct와 class간 차이가 크지 않다.


## 생성자와 소멸자(Constructor/Destructor)

```c++
class Person
{
private:
    std::string name;
    int         age;

public:
    Person() {
        name = "kim";
        age = 20;
    }

    ~Person() {

    }
}

int main()
{
    Person p;
}
```

- 생성자 : `클래스이름()`과 같은 모양의 함수
  - 객체를 생성할 때 자동으로 호출
  - 반환 타입을 표기하지 않고, 값을 반환하지 않음
  - 유저가 생성자를 한 개도 만들지 않으면 컴파일러가 디폴트 생성자를 제공

- 소멸자 : `~클래스이름()`과 같은 모양의 함수
  - 객체가 파괴될 때 자동으로 호출



## 멤버 데이터 초기화

```c++
class Point
{
    // default member initializer (C++11)
    int x{0};
    int y{0};

public:
    Point(int a, int b) : x{a}, y{b}    // member initializer list (C++98)
    {
        // 대입 방법
        x = a;
        y = b;
    }
}
```

- member initializer list를 사용해야하는 경우
  - 멤버 데이터로 상수나 참조가 있는 경우
    - 상수나 참조는 반드시 초기화 되어야 하기 때문에 대입 방법을 사용할 수 없다.
  - 디폴트 생성자가 없는 타입이 멤버로 있는 경우

멤버 초기화 리스트의 실행 순서는 멤버 데이터가 선언된 순서대로 초기화된다.

멤버 데이터가 선언된 순서대로 초기화 코드를 작성해야 한다.

선언과 구현 파일을 나누어 클래스를 작성할 때 멤버 초기화 리스트는 구현 파일에 작성해야 한다.(.cpp)

함수의 인자와 멤버 데이터의 이름이 동일한 경우, 생성자 블록에서 멤버 데이터에 접근하려면 `this->멤버이름` 사용


## explicit 생성자
- Direct Initialization만 가능하고 Copy Initialization은 사용할 수 없다.
- 암시적 변환의 용도로 사용될 수 없고 명시적 변환만 가능하다.



## static member data

멤버 데이터 앞에 `static`

```c++
class Car
{
    int speed{0};
public:
    static int count;

    Car()    {++count;}
    ~Car()   {--count;}
};
int Car::count{0};  // 반드시 클래스 외부에서 선언되어야 함
```

- 특징
  - 객체를 생성하지 않아도 메모리에 놓임(전역변수처럼)
  - 객체 생성 시 static member data는 객체의 메모리에 포함되지 않음
  - 모든 `Car` 객체가 `Car::count` 변수를 공유하게 됨
    - class field / static field
  - static 멤버 데이터는 `클래스이름::static멤버변수이름` 으로 접근
    - 객체 이름으로도 접근 가능하지만 static 멤버인지 구분이 어렵다.

- static 멤버 변수의 외부 선언은 구현파일(.cpp)에 있어야 함
- `static const`, `static constexpr`, `inline static` 은 외부 선언 없이도 클래스 내부에서 초기화 가능



## static member function

- 객체 없이 호출 가능한 멤버 함수
- 객체 이름 `c1.get_count()` 또는 클래스 이름 `Car::get_count()`(권장) 로 접근 가능

```c++
class Car
{
    int speed{0};
    static int count;
public:
    Car()    {++count;}
    ~Car()   {--count;}

    static int get_count() { return count; }    // 객체를 선언하지 않아도 접근 가능
};
int Car::count{0};

int main()
{
    std::cout << Car::get_count() << std::endl; // '0' 출력

    Car c1;
    Car c2;
    std::cout << Car::get_count() << std::endl; // '2' 출력
}
```
- static member data
  - 외부 정의는 구현 파일(.cpp)에 생성
- static member function
  - static 키워드는 함수 선언부에만 표기
 
```c++
/* Object.h */
class Object
{
    int idata{0};
    static int sdata;
public:
    void ifunc();
    static void sfunc();
};
```
```c++
/* Object.cpp */
#include "Object.h"
int Object::sdata{0};
void Object::ifunc() {}
void Object::sfunc() {}
// static void Object::sfunc() {}   // 선언부(.h)에 static을 붙이고 구현부(.cpp)에는 static을 붙이지 않는다.
```


## this
- 멤버 함수 안에서 사용 가능한 키워드
- 해당 멤버 함수를 호출할 때 사용한 **객체의 주소**
- static 멤버 함수에서는 사용 불가

```c++
class Counter
{
    int count{0};
public:
    void reset(int count = 0)
    {
        this->count = count;    // 멤버 데이터임을 명확히 하고 싶을 때
    }

    // 멤버 함수가 this 또는 *this를 반환하면 멤버 함수를 연속적으로 호출할 수 있다.
    Counter* increment()
    {
        ++count;
        return this;
    }
    Counter& decrement()    // *this로 반환하는 경우 참조(reference)로 반환해야 함
    {
        --count;
        return *this;
    }
};
int main()
{
    Counter c;
    // 멤버 함수가 this 또는 *this를 반환하면 멤버 함수를 연속적으로 호출할 수 있다.
    c.increment()->increment()->increment();
    c.decrement().decrement().decrement();
}
```


## 상수 멤버 함수
- 멤버 함수의 괄호`()` 뒤에 const를 붙이는 문법
- 선언부, 구현부 양쪽에 모두 붙여야 함
- 상수 멤버 함수에서는 멤버의 값을 변경하지 않아야함.
- 상수 객체는 상수 멤버 함수만 호출 가능, const가 붙지 않은 멤버 함수는 호출 불가능


## 상속

```c++
class Person
{
    std::string name;
    int         age ;
};
class Student : public Person
{
    int id;
};
class Professor : public Person
{
    int major;
};
```
- Base class(기반 클래스, Super class, Parent class) : 여기서는 `Person`
- Derived class(파생 클래스, Sub class, Child class) : 여기서는 `Student`, `Professor`

`Student`, `Professor` 클래스는 기반 클래스인 `Person`으로부터 `name`, `age` 멤버 변수를 상속받음

코드의 중복을 줄일 수 있다.

| 언어   | 표현방식                        |
| ------ | ------------------------------- |
| C++    | `class Student : public Person` |
| C#     | `class Student : Person`        |
| Java   | `class Student extends Person`  |
| Python | `class Student(Person)`         |

## 상속 관계에서 생성자/소멸자 호출

- Base class의 생성자가 먼저 실행되고 Derived class의 생성자가 그 다음 실행된다.
  - Base 생성자는 기본적으로 인자가 없는 디폴트 생성자가 호출된다.
    - 생성자가 없다면 에러, 반드시 작성해야한다.
  - 다른 버전의 생성자를 호출하려면 Base 클래스 다른 버전의 생성자를 호출하는 코드를 직접 작성해야 한다.
- 소멸자의 경우는 반대로 Derived class의 소멸자가 먼저, Base class의 소멸자가 그 이후에 실행된다.


## upcasting

- 기반 클래스 포인터로 파생 클래스 객체를 가리킬 수 있다. -> 이걸 Upcasting 이라고 함
- 기반 클래스 포인터로는 기반 클래스의 멤버만 접근 가능, 파생 클래스의 고유 멤버는 접근 불가능
- 파생 클래스 고유 멤버에 접근하려면 명시적 캐스팅(static_cast)해야 한다.

```c++
class Animal
{
public:
    int age = 0;
}
class Dog : public Animal {};
class Cat : public Animal {};

void NewYear(Animal* p)
{
    ++(p->age);
}

int main()
{
    Dog dog;
    NewYear(&dog);

    Cat cat;
    NewYear(&cat);
}
```