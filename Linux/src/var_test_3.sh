#!/usr/bin/env bash
# 1부터 5까지 반복문 외부의 변수(a,b)를 반복문 내부에서 증가 시켜 출력해보자.
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
