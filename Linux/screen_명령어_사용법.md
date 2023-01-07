# `screen` 명령어 사용법

## `screen` 명령어란?

해당 서비스 또는 프로그램을 백그라운드로 실행시키고자 할 때 사용한다. (ssh 접속을 끊어도 프로그램을 구동시키고 싶을 때 사용)

실제 기능은 *virtual terminal emulation*, 즉, 터미널을 가상화해서 다중 사용할 수 있게 만들어주는 명령어.

`nohup`이나 `&` 를 이용한 백그라운드 실행으로는 로그나 현재 상태 등을 확인할 수 없기 때문에 이를 해결할 수 있는 명령어이다.

터미널을 가상화해서 띄워놓기 때문에, 서버가 죽지 않는 한 어디서든, 누구든 작업을 이어서 할 수 있는 장점이 있다.

## `screen` 명령어 설치 방법

기본적으로 설치되어있는 경우도 있지만, 설치되어 있지 않다면 배포판에 따라 아래와 같은 명령어로 설치하면 된다.

```shell
# RedHat 계열
yum install screen

# Debian 계열
apt install screen
```

## `screen` 명령어 사용법

screen 명령어는 실행 전 옵션(command-line options), 실행 후 커맨드(default key bindings) 로 구분 지어 사용할 수 있다.

실행 후 커맨드는 screen에 진입한 상태에서 단축키 누르듯 커맨드를 동시에 입력하면 수행된다.

```shell
실행 전 옵션(command-line options)
screen [ -options ] [ cmd [ args ] ]
    -ls and -list
        실행 중인 screen 리스트를 보여준다. 
        'detached' : 세션에 아무도 attach하지 않은 상태(-r 옵션으로 접근 가능)
        'attached' : 해당 세션에 attach하여 터미널을 컨트롤 중인 경우
        'multi'    : multiuser mode로 세션이 동작 중인 경우(여러 명이 세션에 attach 중인 경우)
    -S [sessionname]
        새로운 세션을 생성할 때, 세션의 이름을 지정한다.
    -R [sessionname]
        'detached' 상태인 세션으로 재진입하기 위해 사용하는 옵션으로, sessionname에 해당하는 세션이 없다면 새로 생성한다.
        세션을 새로 생성하고 싶지 않으면 -r 옵션을 사용
    -x [sessionname]
        'attached' 상태인 세션으로 진입하기 위해 사용하는 옵션 (Multi display mode)

실행 후 커맨드(default key bindings)
    기본적으로 screen 의 커맨드는 'Ctrl + a' 의 조합으로 시작된다. 'Ctrl + a' 는 줄여서 'C-a'로 작성하겠다.
    C-a a
        바로 전 창으로 이동
    C-a c   (create)
        새로운 창을 생성하고 그 창으로 이동한다.
    C-a d   (detach)
        현재 터미널로부터 detach 한다. (현재 터미널에서 진행 중인 작업은 유지하면서, screen에서만 빠져나온다.)
    C-a n   (next)
        다음 창으로 이동
    C-a p   (previous)
        이전 창으로 이동
    C-a k   (kill)
        현재 터미널을 종료(terminate)하면서 screen에서 빠져나간다.
    
screen에 진입한 상태에서 쉘에 `exit` 명령어를 수행하면 screen 세션을 종료하고 완전히 빠져나오게 된다.
```

다른 옵션은 screen의 man page를 참고.

screen 명령어의 옵션과 커맨드는 꽤나 많고 복잡하다. 그래도 잘 쓰면 엄청 유용할 것 같다.

## `screen` 명령어 사용 예시

스크린 명령어를 아래와 같이 수행하면 `simulator1` 이라는 가상의 터미널이 생성되는데,

![스크린 명령어 실행](images/screen_1.png)

이렇게 처음 로그인 했을 때와 같은 화면이 나온다.

![스크린 진입](images/screen_2.png)

이 터미널에서 1초에 한 번씩 echo 하는 스크립트를 실행한 다음 `C-a d` 커맨드로 현재 screen에서 detach 해보겠다.

![스크린 detach 커맨드 실행](images/screen_3.png)

그럼 아래와 같은 화면이 나오는데, 여기서 `screen -ls` 명령어로 빠져나왔던 `simulator1` 터미널이 살아있는지 확인해보자.

![스크린 명령어 실행](images/screen_4.png)

pid 가 '64999' 이고 이름이 `simulator1` 인 screen 이 `Detached` 된 상태로 남아있음을 알 수 있다.

![스크린 명령어 실행](images/screen_5.png)

여기서 다시 `screen -r simulator1` 명령어로 `Attach` 해보면

![스크린 명령어 실행](images/screen_6.png)

이렇게 열심히 스크립트가 돌고 있었음을 확인할 수 있다.

빠져나올 땐 `exit` 로 빠져나오자.


## 주의사항

screen 명령어를 통해 새로운 세션으로 들어가면, 로그인 쉘(`.bash_profile`)이 적용되지 않았다.

그래서, 세션 진입 후 `source ~/.bash_profile` 명령어를 통해 로그인 쉘을 적용하고 작업하자.

## 참고 자료

- [IT는 검색이 힘이다 - 리눅스 Screen 명령어 모음](https://helloitstory.tistory.com/132)
- [人CoDOM - Linux > 기본명령어 > screen](http://www.incodom.kr/Linux/%EA%B8%B0%EB%B3%B8%EB%AA%85%EB%A0%B9%EC%96%B4/screen)
- [Sysops Notepad - [Linux] screen 사용 방법](https://sysops.tistory.com/44)
- [die.net screen(1) - Linux man page](https://linux.die.net/man/1/screen)
https://github.com/lyw1217/TIL/blob/main/Linux/images/images/screen_1.png?raw=true