# bash 쉘 스크립트 무한 루프 반복문 돌리기 (for, while)

## 무한 루프 기본 원리

기본적으로, 무한루프는 반복문 안의 조건을 항상 참(true)으로 설정해서 무한정 반복문을 돌게 한다.

## for 반복문 예시
```bash
#!/usr/bin/env bash

for (( ; ; ))   # 항상 참
do
    echo "PRESS [Ctrl+c] TO STOP"
    sleep 1
done
```

## while 반복문 예시
```bash
#!/usr/bin/env bash

while true :   # 항상 참, true 는 생략해도 된다.
do
    echo "PRESS [Ctrl+c] TO STOP"
    sleep 1
done
```

## 주의 사항

무한 루프 내부에 `sleep`과 같은 지연 시간을 주지 않는다면 CPU 사용량이 엄청나게 치솟을 가능성이 있고,

`break`와 같은 탈출 조건이 없다면 원치 않은 동작을 하게 될 가능성이 높다.