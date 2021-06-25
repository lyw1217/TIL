#!/usr/bin/env bash
# 1 부터 5까지 반복문 외부의 변수(count)를 반복문 내부에서 증가시켜 출력해보자.
count=1
for i in {0..4}:
do
  echo "${count}"
  count=$((count+1))
done
