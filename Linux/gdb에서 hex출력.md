# gdb 에서 hex 값 출력하는 방법

gdb에서 core 파일을 분석할 때 16진수를 저장하는 변수는 윈도우 계산기를 함께 켜놓고 10진수로 출력된 값을 16진수로 변환하여 확인하고 있었다.

근데 이게 귀찮아서 찾아보니까 아주 쉬운 방법이 있었다.

기본적으로, gdb에서 변수 print를 수행하면 해당 변수의 데이터 유형에 따라 출력된다.

```
x
    Regard the bits of the value as an integer, and print the integer in hexadecimal.
d
    Print as integer in signed decimal.
u
    Print as integer in unsigned decimal.
o
    Print as integer in octal.
t
    Print as integer in binary. The letter `t' stands for "two". (2)
a
    Print as an address, both absolute in hexadecimal and as an offset from the nearest preceding symbol. You can use this format used to discover where (in what function) an unknown address is located:
    (gdb) p/a 0x54320
    $3 = 0x54320 <_initialize_vx+396>
    The command info symbol 0x54320 yields similar results. See section Examining the Symbol Table.
c
    Regard as an integer and print it as a character constant.
f
    Regard the bits of the value as a floating point number and print using typical floating point syntax.
```

### 16진수 표기 Hexadecimal 출력 방법
```
p/x variable
```

### 2진표기 Binary 출력 방법
```
p/t variable
```

### 참고자료
- https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_54.html
- https://stackoverflow.com/questions/9671820/print-variables-in-hexadecimal-or-decimal-format