# C언어 구조체 비트 필드 (Bit Field)

## 구조체의 기능
**`정수형`** 데이터를 **`비트`** 단위로 나누어서 사용할 수 있다.
이를 구조체의 Bit Field 라고 한다.

~~~
struct 구조체명 {
    unsigned 정수형 이름1   :비트수 ;
    unsigned 정수형 이름2   :비트수 ;
    ...
};
~~~

사용 가능한 정수 자료형의 종류
> - char
> - short
> - int
> - long

double, float 과 같은 실수 자료형은 사용할 수 없다.


## 사용 예시
1. PLMN ID ( MCC + MNC )
    ~~~
    struct PlmnId {
        uint8_t     mcc1    :4;
        uint8_t     mcc2    :4;
        uint8_t     mcc3    :4;
        uint8_t     mnc3    :4;
        uint8_t     mnc1    :4;
        uint8_t     mnc2    :4;
    };
    ~~~
    이 Bit Field 구조체는 총 24bit를 관리할 수 있는 형태가 되며,

    데이터 타입의 크기인 8bit 보다 전체 bit field의 합이 더 크기 때문에,
    
    데이터 타입의 크기의 배수만큼 증가하여서 8 * 3 = 24 bit = 3 byte가 된다.

## 참고 자료

- [C언어 코딩 도장](https://dojang.io/mod/page/view.php?id=472)
- [IT 개발자 Note](https://www.it-note.kr/312)