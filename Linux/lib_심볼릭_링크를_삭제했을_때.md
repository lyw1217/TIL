# /lib, /lib64 의 심볼릭 링크를 삭제했을 때 해결 방법

## 급하다면

https://code-examples.net/ko/q/bae9cb

여기를 참고해서 문제를 해결해보자.

### 참고 : /lib, /lib64 는 무슨 디렉토리?

시스템 부팅이나 /bin, /sbin 에 있는 바이너리 파일들의 실행에 필요한 공유 라이브러리 디렉토리이다.

## 문제 상황

`/lib64/libc.so.6` (심볼릭링크) 가 `/lib64/libc-2.12.so` 를 바라보고 있었다.

`libc-2.17.so` 로 버전을 변경해보고자 루트 계정에서 `libc.so.6` 심볼릭링크를 `rm -rf` 명령어로 삭제했다.

그리고 `ln` 명령어로 다시 심볼릭 링크를 생성하려고 하니까

    [test:/lib64] rm -rf libc.so.6
    [test:/lib64] ln -s libc-2.17.so libc.so.6
    ln: error while loading shared libraries: libc.so.6: wrong ELF class: ELFCLASS32

이런 에러가 발생했다.
 
게다가 현재 접속 중인 터미널을 제외하고 다른 터미널에서 접속도 할 수 없을 뿐만 아니라 해당 라이브러리와 연관된 프로세스들도 동작하지 않는 듯 했다.

`ln` 뿐만 아니라 `cd`, `rm` 등 몇몇 명령어를 제외하고 아무것도 동작하지 않았다.

## 해결 방법

    [test:/lib64] ldconfig -l -v /lib64/libc-2.12.so
	libc.so.6 -> libc-2.12.so (changed)

    [test:/lib64]ls -al | grep libc.so.6
    lrwxrwxrwx   1 root root      12 Apr 12 15:01 libc.so.6 -> libc-2.12.so

`ldconfig` 명령어를 이용하여 라이브러리 링크를 다시 설정해주었다.

`ldconfig` 명령어는 동적 라이브러리를 연결해주는 링커를 설정하는 명령어이다.

여기서 `-l` 옵션을 이용하여 수동으로 라이브러리를 링크해주고, `-v` 옵션으로 상세 출력을 확인하여 위와 같은 결과가 나왔다.


## 최악의 상황?

라이브러리 심볼릭 링크를 날리고 터미널 접속도 끊어진 상태라면 정말 아무것도 할 수 없었을 것이다.

https://kldp.org/node/99655

시도해보진 않았지만 복구 CD를 이용하여 복구할 수 있는 방법이 있는 듯 하다.
