# UnicodeDecodeError: 'cp949' 에러 해결 방법

```bash
UnicodeDecodeError: 'cp949' codec can't decode byte 0xed in position 23: illegal multibyte sequence
```

파이썬에서 파일을 읽을 때, 위와 같은 에러가 발생할 수 있다.

이는 cp949 코덱으로 인코딩 된 파일을 읽어들일 때 발생할 수 있는 문제이며

아래와 같이 파일을 열어주면 에러가 발생하지 않고 정상적으로 파일을 읽어들일 수 있다.

```python
open('파일경로', 'rt', encoding='UTF8')
```


여기서 예시로 UTF8로 인코딩을 지정했으나, 실제 파일 인코딩에 맞추어서 사용하면 된다.