# bash 쉘 스크립트 특정 문자열이 포함되었는지 확인하는 방법


```python
# python 예시
str = "Hello world"
if "world" in str :
    print("Found 'world' string.")
else :
    print("Not Found 'world' string.")
```

쉘 스크립트에서는 어떤 문자열에 특정 문자열이 포함되어있는지 확인하고 싶을 때 어떻게 해야할까?

### 첫 번째 방법, 와일드카드(wildcard, asterisk(`*`)) 사용

`if [[ "$str1" == *str2* ]]; then ... else ... fi`

```bash
#!/bin/bash
str="Hello world"

if [[ "$str" == *world* ]]; then
    echo "str contains 'world'"
else
    echo "str does not contain 'world'"
fi
```

```
# Output
str contains 'world'
```

### 두 번째 방법, 정규 표현식 연산자(regex operator, `=~`) 사용

`if [[ "$str1" =~ str2 ]]; then ... else ... fi`

```bash
#!/bin/bash
str="Hello world"

if [[ "$str" =~ world ]]; then
    echo "str contains 'world'"
else
    echo "str does not contain 'world'"
fi
```

```
# Output
str contains 'world'
```

## 주의사항

if 문에 중괄호를 두 개 사용해야 한다. (`[[ ]]`)

하나(`[ ]`)만 사용하면 정상적으로 동작하지 않는다.

## 또 다른 방법들

- case 구문을 이용하는 방법
- grep 명령어를 이용하는 방법
- ...

등 여러 방법이 있다. 이 방법들에 대해서는 참고 자료 링크에 자세히 나와있다.


## 참고 자료

- [https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash](https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash)
- [https://linuxize.com/post/how-to-check-if-string-contains-substring-in-bash/](https://linuxize.com/post/how-to-check-if-string-contains-substring-in-bash/)