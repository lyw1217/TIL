# Makefile 에서 if else 문 사용하기

## Makefile 조건문
make 에서 조건문은 단순하고 은근히 까다롭다. 사용할 때 주의해서 사용하자.


## Makefile 조건문의 지시어
- ifeq : 조건을 시작하고 조건을 지정한다. 콤마로 분리되고 괄호로 둘러싸인 두 개의 매개변수를 가진다.
- else : 이전 조건이 실패하였다면 수행되도록 한다. else 지시어는 사용하지 않아도 된다.
- endif : 조건을 종료한다. 모든 조건은 반드시 endif로 종료해야 한다. 

## Makefile 조건문 예시
    libs_for_gcc = -lgnu
    normal_libs =

    foo: $(objects)
    ifeq ($(CC),gcc)
            $(CC) -o foo $(objects) $(libs_for_gcc)
    else
            $(CC) -o foo $(objects) $(normal_libs)
    endif

변수 'CC'가 'gcc' 일 때 조건이 참이므로, ifeq 아래의

    $(CC) -o foo $(objects) $(libs_for_gcc)

가 수행되며, 'gcc' 가 아닐 경우 조건이 거짓이므로, else 아래의
    
    $(CC) -o foo $(objects) $(normal_libs)

가 수행된다.

### Makefile 다중 조건문(중첩 조건)
기본적으로, make 에서 다중 조건문은 존재하지 않는다.
AND(&&) 또는 OR(||) 를 사용할 수 없는데, `filter` 를 활용해 어느 정도 변형하여 사용할 수 있는 듯하다. 

참고 : [Stackoverflow - makefile-ifeq-logical-or](https://stackoverflow.com/questions/7656425/makefile-ifeq-logical-or)

### 주의사항
조건문을 사용할 때 지시어들을 들여쓰기(indent) 하지 말자. `<syntax error near unexpected token>` 와 같은 에러가 날 수 있다.

### 참고 자료
- [GNU Manual Conditional Parts of Makefiles](http://web.mit.edu/gnu/doc/html/make_7.html#SEC68) (영문)
- [GNU 한글 번역 매뉴얼 Makefile의 조건 부분](http://korea.gnu.org/manual/release/make/make-sjp/make-ko_7.html#SEC71) (번역)