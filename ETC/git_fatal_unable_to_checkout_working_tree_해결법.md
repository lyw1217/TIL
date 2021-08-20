# git clone 중에 'fatal: unable to checkout working tree' 에러 해결 방법

## 문제 확인

`Windows` 기반 vscode에서 github repository를 git clone 하는 중에 아래와 같은 에러 메시지가 나왔다.

![fatal: unable to checkout working tree](images/fatal%20unable%20to%20checkout%20working%20tree.png)

`fatal: unable to checkout working tree`
`warning: Clone succeeded, but checkout failed.`

`.git` 디렉토리는 생성되며 Clone은 성공했지만, checkout은 실패하여 레파지토리 내 파일들이 하나도 복사되지 않은 상태였다.

## 문제 원인

경고 메시지를 읽어보면 해답을 찾을 수 있는데, 

`error: invalid path '입출력과 사칙연산/10998(A*B).py`

'입출력과 사칙연산/10998(A*B).py' 의 경로가 유효하지 않다고 나와있다.

이유가 뭘까?

이 파일은 내가 `MacOS`에서 작업 후 git push 한 파일로, 유닉스 기반인 `MacOS`에서는 파일의 이름에 `*` 문자를 사용할 수 있다.

그러나 `Windows`에서는 아래와 같은 9개 문자는 파일명으로 사용할 수 없다. 그래서 git clone으로 파일을 가져오지 못한 것 같다.

    파일 이름에는 다음 문자를 사용할 수 없습니다.
    \ / : * ? " < > |

![cannot contain any of the following characters.png](images/cannot%20contain%20any%20of%20the%20following%20characters.png)

| 기호 | 이름      | 용도                          |
| ---- | --------- | ----------------------------- |
| \    | 역슬래시  | 파일 구분자(Windows 파일경로) |
| /    | 슬래시    | 파일 구분자(Unix 파일경로)    |
| :    | 콜론      |                               |
| *    | 별표      | Wildcard 문자                 |
| ?    | 물음표    | Wildcard 문자                 |
| "    | 큰따옴표  |                               |
| <    | 보다 작음 | 입력 전달(redirect)           |
| >    | 보다 큼   | 출력 전달(redirect)           |
| \|   | 세로줄    | 파이프                        |

## 해결 방법

`Windows`에서 파일명에 사용할 수 없는 `*` 문자를 다른 문자로 바꾸어주면 된다.

나는 repository에 있는 파일명 `입출력과 사칙연산/10998(A*B).py` 을 `입출력과 사칙연산/10998(AxB).py` 로 rename 해주었다.

여러 OS를 동시에 사용하는 경우에는 파일명을 지정하는데 신경을 써야겠다.

## 참고 자료

[제타 위키 - 파일 이름에는 다음 문자를 사용할 수 없습니다](https://zetawiki.com/wiki/%ED%8C%8C%EC%9D%BC_%EC%9D%B4%EB%A6%84%EC%97%90%EB%8A%94_%EB%8B%A4%EC%9D%8C_%EB%AC%B8%EC%9E%90%EB%A5%BC_%EC%82%AC%EC%9A%A9%ED%95%A0_%EC%88%98_%EC%97%86%EC%8A%B5%EB%8B%88%EB%8B%A4)