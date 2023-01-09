# bash 쉘 스크립트 배열(Array) 사용법

## 배열 선언하는 방법
```bash
#!/bin/bash

arr_1=("abc" "123" "456" )
arr_2=(1 2 3)
arr_3[0]=1
arr_3[1]=2

echo ${arr_1[0]}
# abc
echo ${arr_2[1]}
# 2
echo ${arr_3[1]}
# 2
```

이외에, 아래와 같이 빈 배열을 선언하고 요소를 하나씩 추가하는 방법도 있다.

```bash
#!/bin/bash

arr=()
arr+=("abc")
arr+=("123")
arr+=("456")
```

## 배열 참조하는 방법

```bash
#!/bin/bash

arr=("Lee YW" "Array" "Test")

# - 개별 요소 참조
echo "arr[0] = ${arr[0]}"

# - 전체 요소 참조
echo "arr[*] = ${arr[*]}"
echo "arr[@] = ${arr[@]}"

# - 인덱스의 개수
echo "arr index = ${!arr[@]}"

# - 개별 요소의 크기
echo "arr[0] size = ${#arr[0]}"
```

출력 결과는 아래와 같다.

```
arr[0] = Lee YW
arr[*] = Lee YW Array Test
arr[@] = Lee YW Array Test
arr index = 0 1 2
arr[0] size = 6
```

## 주의 사항
- 배열의 요소들이 인접해있거나 연속적이지 않아도 된다.
- 배열의 요소를 초기화하지 않아도 된다. (빈칸으로 찍힌다)
- 배열의 중간이 비어있어도 괜찮다.
- 당연하지만, 다른 자료형끼리의 연산은 안 된다. (문자열에 정수를 더한다던가..)
- 빈 배열과 빈 요소를 가진 배열은 다르다.

## 참고 자료
- [제타위키 - bash 배열](https://zetawiki.com/wiki/Bash_%EB%B0%B0%EC%97%B4)
- [juner84 - [Linux-shell] bash shell에서 배열 선언 및 배열 크기 확인](https://blog.naver.com/juner84/100191014657)
- [RedJini Wiki](http://wiki.redjini.com/linux/script/array)
- [RedJini Blog - [shell script] 배열(Array) 사용하기](http://blog.redjini.com/282)
- [고급 Bash 스크립팅 가이드: Bash를 이용한 쉘 스크립팅 완전 가이드 26장. 배열](http://coffeenix.net/doc/HOWTOs/html/Adv-Bash-Scr-HOWTO/arrays.html)